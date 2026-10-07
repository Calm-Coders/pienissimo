/**
 * Covers participant document generation: the request event published by the
 * registration, the one-ticket-per-job chain, ten tickets producing ten
 * documents, and the PDF page refusing the site guest user.
 */
@isTest
private class ParticipantTicketDocumentTest {
  private static final String DOCUMENT_TITLE = 'Documenti partecipazione%';

  private static List<Asset> tickets(Integer ticketCount) {
    Account accountRecord = TestDataFactory.azienda('Cliente Documenti');
    Campaign parent = TestDataFactory.parentCampaign('Tour Documenti');
    Campaign campaign = TestDataFactory.childCampaign('Tappa Roma', parent.Id);
    Product2 product = TestDataFactory.item(
      'Ingresso',
      TestDataFactory.unique('ART-DOC')
    );
    List<Asset> result = new List<Asset>();
    for (Integer i = 1; i <= ticketCount; i++) {
      result.add(
        new Asset(
          Name = 'Biglietto ' + i,
          AccountId = accountRecord.Id,
          Product2Id = product.Id,
          Campaign__c = campaign.Id,
          Status = 'Ordinato',
          RecordTypeId = TestDataFactory.recordTypeId('Asset', 'Ticket')
        )
      );
    }
    insert result;
    return result;
  }

  private static Set<Id> ids(List<Asset> records) {
    return new Map<Id, Asset>(records).keySet();
  }

  // Through the Asset's links: the job may file documents as another user,
  // whose ContentVersions the test user cannot query directly.
  private static Integer documentCount(Set<Id> assetIds) {
    return [
      SELECT COUNT()
      FROM ContentDocumentLink
      WHERE
        LinkedEntityId IN :assetIds
        AND ContentDocument.Title LIKE :DOCUMENT_TITLE
    ];
  }

  @isTest
  static void tenTicketsGetTenDocuments() {
    System.runAs(TestDataFactory.runner()) {
      Set<Id> assetIds = ids(tickets(10));

      ParticipantTicketDocumentJob.generate(assetIds);
      System.assertEquals(10, documentCount(assetIds));

      // Running again files nothing new.
      ParticipantTicketDocumentJob.generate(assetIds);
      System.assertEquals(10, documentCount(assetIds));
    }
  }

  @isTest
  static void eachJobRendersOneTicketAndChainsTheRest() {
    System.runAs(TestDataFactory.runner()) {
      List<Asset> records = tickets(10);
      Set<Id> assetIds = ids(records);

      Test.startTest();
      System.enqueueJob(new ParticipantTicketDocumentJob(assetIds));
      Test.stopTest();

      System.assertEquals(
        ParticipantTicketDocumentJob.DOCUMENTS_PER_JOB,
        documentCount(assetIds)
      );
      System.assertEquals(
        10 - ParticipantTicketDocumentJob.DOCUMENTS_PER_JOB,
        ParticipantTicketDocumentJob.chainedAssetIds.size()
      );
      System.assert(
        assetIds.containsAll(ParticipantTicketDocumentJob.chainedAssetIds)
      );
    }
  }

  @isTest
  static void chainedJobsCoverEveryTicket() {
    System.runAs(TestDataFactory.runner()) {
      Set<Id> assetIds = ids(tickets(10));

      // What the finalizers would queue one after the other.
      ParticipantTicketDocumentJob.NextDocuments next = new ParticipantTicketDocumentJob.NextDocuments(
        assetIds
      );
      next.execute(null);
      System.assertEquals(
        assetIds,
        ParticipantTicketDocumentJob.chainedAssetIds
      );
      for (Id assetId : assetIds) {
        ParticipantTicketDocumentJob.generate(new Set<Id>{ assetId });
      }
      System.assertEquals(10, documentCount(assetIds));
    }
  }

  @isTest
  static void requestsArePublishedAndQueueTheJob() {
    System.runAs(TestDataFactory.runner()) {
      Set<Id> assetIds = ids(tickets(3));

      Test.startTest();
      ParticipantTicketDocumentRequests.publish(assetIds);
      Test.getEventBus().deliver();
      Test.stopTest();

      System.assertEquals(
        1,
        [
          SELECT COUNT()
          FROM AsyncApexJob
          WHERE ApexClass.Name = 'ParticipantTicketDocumentJob'
        ]
      );
      System.assertEquals(1, documentCount(assetIds));
      System.assertEquals(
        2,
        ParticipantTicketDocumentJob.chainedAssetIds.size()
      );
    }
  }

  @isTest
  static void registeringParticipantsRequestsTheirDocuments() {
    System.runAs(TestDataFactory.runner()) {
      List<Asset> records = tickets(2);
      records = [
        SELECT Id, AccountId, Campaign__c
        FROM Asset
        WHERE Id IN :ids(records)
      ];
      List<CampaignMember> members = new List<CampaignMember>();
      for (Asset ticket : records) {
        Contact participant = TestDataFactory.contact(
          ticket.AccountId,
          TestDataFactory.unique('p') + '@example.com',
          false
        );
        ticket.ContactId = participant.Id;
        members.add(
          new CampaignMember(
            CampaignId = ticket.Campaign__c,
            ContactId = participant.Id
          )
        );
      }
      update records;
      Set<Id> assetIds = ids(records);

      Test.startTest();
      insert members;
      Test.getEventBus().deliver();
      Test.stopTest();

      System.assertEquals(
        2,
        [
          SELECT COUNT()
          FROM ContentDocumentLink
          WHERE
            LinkedEntityId IN :assetIds
            AND ContentDocument.Title LIKE 'Ticket QR%'
        ]
      );
      // The guest's transaction only publishes; the job files the documents.
      System.assertEquals(1, documentCount(assetIds));
      System.assertEquals(
        1,
        ParticipantTicketDocumentJob.chainedAssetIds.size()
      );
    }
  }

  @isTest
  static void requestsWithoutUsableIdsQueueNothing() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Non un biglietto');

      ParticipantTicketDocumentRequests.publish(null);
      ParticipantTicketDocumentRequests.publish(new Set<Id>());
      ParticipantTicketDocumentRequests.handle(
        new List<Participant_Document_Request__e>{
          new Participant_Document_Request__e(Asset_Id__c = 'not-an-id'),
          new Participant_Document_Request__e(
            Asset_Id__c = String.valueOf(accountRecord.Id)
          ),
          new Participant_Document_Request__e()
        }
      );

      System.assertEquals(0, Limits.getQueueableJobs());
    }
  }

  @isTest
  static void jobWithoutTicketsFails() {
    System.runAs(TestDataFactory.runner()) {
      Exception error;
      try {
        ParticipantTicketDocumentJob.generate(new Set<Id>());
      } catch (ParticipantTicketDocumentJob.ParticipantTicketDocumentException e) {
        error = e;
      }
      System.assertNotEquals(null, error);
    }
  }

  @isTest
  static void jobWithDeletedTicketsFails() {
    System.runAs(TestDataFactory.runner()) {
      List<Asset> records = tickets(2);
      Set<Id> assetIds = ids(records);
      delete records;

      Exception error;
      try {
        ParticipantTicketDocumentJob.generate(assetIds);
      } catch (ParticipantTicketDocumentJob.ParticipantTicketDocumentException e) {
        error = e;
      }
      System.assertNotEquals(null, error);
      TestDataFactory.assertContains(error.getMessage(), 'No readable Asset');
    }
  }

  private static ParticipantTicketPdfController openDocumentPage(
    String assetId
  ) {
    PageReference documentPage = Page.ParticipantTicketPdf;
    documentPage.getParameters().put('id', assetId);
    Test.setCurrentPage(documentPage);
    return new ParticipantTicketPdfController();
  }

  @isTest
  static void documentPageShowsTheTicketCampaignAndParticipant() {
    System.runAs(TestDataFactory.runner()) {
      Asset ticket = tickets(1)[0];
      ticket = [
        SELECT Id, AccountId, Campaign__c, Product2Id
        FROM Asset
        WHERE Id = :ticket.Id
      ];
      Contact participant = TestDataFactory.contact(
        ticket.AccountId,
        'partecipante@example.com',
        false
      );
      update new Campaign(
        Id = ticket.Campaign__c,
        Data_Evento__c = Date.newInstance(2026, 10, 12),
        Luogo__c = 'Palazzo Congressi',
        Indirizzo__c = 'Via Roma 1',
        Orario_Inizio__c = Time.newInstance(9, 5, 0, 0),
        Parcheggio__c = 'Parcheggio interno'
      );
      update new Product2(Id = ticket.Product2Id, Tipo_Biglietto__c = 'Gold');
      update new Asset(Id = ticket.Id, ContactId = participant.Id);

      ParticipantTicketPdfController controller = openDocumentPage(
        String.valueOf(ticket.Id)
      );

      System.assertEquals('Tappa Roma', controller.getEventName());
      System.assertEquals('12/10/2026', controller.getEventDate());
      participant = [
        SELECT FirstName, LastName, Email, Phone
        FROM Contact
        WHERE Id = :participant.Id
      ];
      System.assertEquals(
        participant.FirstName + ' ' + participant.LastName,
        controller.getParticipantName()
      );
      System.assertEquals(participant.Email, controller.getParticipantEmail());
      System.assertEquals(participant.Phone, controller.getParticipantPhone());
      System.assertNotEquals(null, controller.getAccountName());
      System.assertEquals('Biglietto 1', controller.getTicketName());
      System.assertEquals('Gold', controller.getTicketType());
      System.assertEquals('09:05', controller.getCheckInTime());
      System.assertEquals('Parcheggio interno', controller.getParking());
      System.assertEquals(
        'Palazzo Congressi - Via Roma 1',
        controller.getEventLocationLine()
      );
      System.assertNotEquals('', controller.getGeneratedDate());
      System.assertEquals(true, controller.getHasQrCode());
      System.assert(!controller.getQrRows()[0].modules.isEmpty());
    }
  }

  @isTest
  static void documentPageFallsBackWhenDetailsAreMissing() {
    System.runAs(TestDataFactory.runner()) {
      Asset ticket = tickets(1)[0];
      ParticipantTicketPdfController controller = openDocumentPage(
        String.valueOf(ticket.Id)
      );

      System.assertEquals('', controller.getParticipantName());
      System.assertEquals('', controller.getParticipantEmail());
      System.assertEquals('', controller.getParticipantPhone());
      System.assertEquals('Ingresso', controller.getTicketType());
      System.assertEquals('', controller.getCheckInTime());
      System.assertEquals(true, controller.getHasQrCode());
    }
  }

  @isTest
  static void documentPageRefusesBadIds() {
    System.runAs(TestDataFactory.runner()) {
      Asset deleted = tickets(1)[0];
      delete deleted;
      Account notATicket = TestDataFactory.azienda('Non un biglietto');
      List<String> expected = new List<String>();
      for (
        String rawId : new List<String>{
          null,
          'not-an-id',
          String.valueOf(notATicket.Id),
          String.valueOf(deleted.Id)
        }
      ) {
        try {
          openDocumentPage(rawId);
        } catch (ParticipantTicketPdfController.ParticipantTicketPdfException e) {
          expected.add(e.getMessage());
        }
      }
      System.assertEquals(
        new List<String>{
          'Biglietto non valido.',
          'Biglietto non valido.',
          'Biglietto non valido.',
          'Biglietto non trovato.'
        },
        expected
      );
    }
  }

  @isTest
  static void guestUserCannotOpenTheDocumentPage() {
    List<Asset> records;
    System.runAs(TestDataFactory.runner()) {
      records = tickets(1);
    }
    List<User> guests = [
      SELECT Id
      FROM User
      WHERE UserType = 'Guest' AND IsActive = TRUE
      LIMIT 1
    ];
    if (guests.isEmpty()) {
      return;
    }

    PageReference documentPage = Page.ParticipantTicketPdf;
    documentPage.getParameters().put('id', String.valueOf(records[0].Id));
    Test.setCurrentPage(documentPage);
    Exception error;
    System.runAs(guests[0]) {
      try {
        new ParticipantTicketPdfController();
      } catch (ParticipantTicketPdfController.ParticipantTicketPdfException e) {
        error = e;
      }
    }
    System.assertNotEquals(null, error);
    System.assertEquals('Biglietto non valido.', error.getMessage());
  }
}
