/**
 * Covers the ticketing side: the WooCommerce order endpoint, the public
 * participant registration page, the event invitation token and link
 * refresh, and the bundle tranche template editor.
 */
@isTest
private class TicketingTest {
  // ------------------------------------------------------------ WooCommerce

  private static Map<String, Object> wooPayload(
    String orderKey,
    String sku,
    Id opportunityId
  ) {
    return new Map<String, Object>{
      'event' => 'order.paid',
      'sf_opportunity_id' => opportunityId == null
        ? null
        : String.valueOf(opportunityId),
      'order' => new Map<String, Object>{
        'id' => 9001,
        'order_key' => orderKey,
        'status' => 'processing',
        'date_paid' => '2026-09-20T10:00:00',
        'date_created' => 'bad'
      },
      'billing' => new Map<String, Object>{
        'first_name' => 'Giulia',
        'last_name' => 'Neri',
        'company' => 'Bar Woo',
        'email' => ' Giulia@Example.com ',
        'phone' => '3330000000',
        'address_1' => 'Via Shop 1',
        'address_2' => 'Scala B',
        'city' => 'Bologna',
        'state' => 'BO',
        'postcode' => '40100',
        'country' => 'IT'
      },
      'fiscal' => new Map<String, Object>{
        'company_name' => TestDataFactory.unique('Bar Woo Srl'),
        'venue_name' => 'Bar Woo Centro',
        'vat_number' => 'IT09090909090'
      },
      'line_items' => new List<Object>{
        new Map<String, Object>{
          'sku' => sku,
          'name' => 'Corso online',
          'quantity' => 2,
          'total' => '198.00'
        }
      }
    };
  }

  private static void callWoo(Object payload) {
    RestRequest request = new RestRequest();
    request.requestURI = '/services/apexrest/woocommerce/orders/';
    request.httpMethod = 'POST';
    request.addHeader('X-Source', 'woo');
    request.requestBody = payload == null
      ? null
      : Blob.valueOf(
          payload instanceof String ? (String) payload : JSON.serialize(payload)
        );
    RestContext.request = request;
    RestContext.response = new RestResponse();
    WoocommerceOrderService.createOrder();
  }

  private static Map<String, Object> wooResponse() {
    return (Map<String, Object>) JSON.deserializeUntyped(
      RestContext.response.responseBody.toString()
    );
  }

  @isTest
  static void wooOrderCreatesCustomerOrderAndCollectsIt() {
    System.runAs(TestDataFactory.runner()) {
      TestDataFactory.activateStandardPricebook();
      Product2 product = TestDataFactory.item('Corso online', 'SC-0001');
      TestDataFactory.standardEntry(product.Id, 99);

      Test.startTest();
      callWoo(wooPayload('wc_order_A1', 'SC-0001', null));
      Test.stopTest();

      System.assertEquals(200, RestContext.response.statusCode);
      Map<String, Object> body = wooResponse();
      System.assertEquals(true, body.get('success'));
      Order created = [
        SELECT
          Status,
          Origine__c,
          AccountId,
          (SELECT UnitPrice, Quantity FROM OrderItems)
        FROM Order
        WHERE WooCommerce_Order_Key__c = 'wc_order_A1'
      ];
      System.assertEquals('Incassato', created.Status);
      System.assertEquals('WooCommerce', created.Origine__c);
      System.assertEquals(99, created.OrderItems[0].UnitPrice);
      Account customer = [
        SELECT
          Partita_IVA__c,
          Lead_Email__c,
          BillingStreet,
          (SELECT LastName FROM Contacts)
        FROM Account
        WHERE Id = :created.AccountId
      ];
      System.assertEquals('IT09090909090', customer.Partita_IVA__c);
      System.assertEquals('giulia@example.com', customer.Lead_Email__c);
      System.assertEquals('Via Shop 1\nScala B', customer.BillingStreet);
      System.assertEquals('Neri', customer.Contacts[0].LastName);
      Integration_Log__c logRow = [
        SELECT Is_Error__c, Request_Headers__c
        FROM Integration_Log__c
        WHERE Flow_Name__c = 'WoocommerceOrderService.createOrder'
      ];
      System.assertEquals(false, logRow.Is_Error__c);
      System.assert(logRow.Request_Headers__c.contains('X-Source'));

      // The same order key again is reported as a duplicate, not re-created.
      callWoo(wooPayload('wc_order_A1', 'SC-0001', null));
      System.assertEquals(409, RestContext.response.statusCode);
    }
  }

  @isTest
  static void wooOrderLinkedToAnOpportunityUsesItsAccount() {
    System.runAs(TestDataFactory.runner()) {
      TestDataFactory.activateStandardPricebook();
      Product2 product = TestDataFactory.item('Corso link', 'SC-0002');
      TestDataFactory.standardEntry(product.Id, 50);
      Account accountRecord = TestDataFactory.azienda('Cliente Link');
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        accountRecord.Id
      );

      Test.startTest();
      callWoo(wooPayload('wc_order_B2', 'SC-0002', opportunityRecord.Id));
      Test.stopTest();

      System.assertEquals(200, RestContext.response.statusCode);
      Opportunity updated = [
        SELECT WooCommerce_Order_Id__c, StageName
        FROM Opportunity
        WHERE Id = :opportunityRecord.Id
      ];
      System.assertEquals('9001', updated.WooCommerce_Order_Id__c);
      System.assertEquals('Chiusa/Vinta', updated.StageName);
      System.assertEquals(
        accountRecord.Id,
        [
          SELECT AccountId
          FROM Order
          WHERE WooCommerce_Order_Key__c = 'wc_order_B2'
        ]
        .AccountId
      );
    }
  }

  @isTest
  static void wooOrderReusesTheAccountMatchedByEmailAndVat() {
    System.runAs(TestDataFactory.runner()) {
      TestDataFactory.activateStandardPricebook();
      Product2 product = TestDataFactory.item('Corso match', 'SC-0003');
      TestDataFactory.standardEntry(product.Id, 10);
      Account existing = TestDataFactory.buildAzienda('Gia cliente');
      existing.Lead_Email__c = 'giulia@example.com';
      existing.Partita_IVA__c = 'IT09090909090';
      TestDataFactory.insertAllowingDuplicates(existing);

      callWoo(wooPayload('wc_order_C3', 'SC-0003', null));

      System.assertEquals(
        existing.Id,
        [
          SELECT AccountId
          FROM Order
          WHERE WooCommerce_Order_Key__c = 'wc_order_C3'
        ]
        .AccountId
      );
    }
  }

  @isTest
  static void wooOrderRollsBackWhenTicketMappingIsMissing() {
    System.runAs(TestDataFactory.runner()) {
      TestDataFactory.activateStandardPricebook();
      Product2 product = TestDataFactory.item(
        'Ticket senza mappatura',
        'SC-NOMAP'
      );
      product.Genera_Biglietto__c = true;
      update product;
      TestDataFactory.standardEntry(product.Id, 75);
      Account accountRecord = TestDataFactory.azienda('Cliente No Map');
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        accountRecord.Id
      );

      Test.startTest();
      callWoo(wooPayload('wc_order_nomap', 'SC-NOMAP', opportunityRecord.Id));
      Test.stopTest();

      System.assertEquals(
        500,
        RestContext.response.statusCode,
        'Missing ticket mapping should return an integration error.'
      );
      System.assertEquals(
        0,
        [
          SELECT COUNT()
          FROM Order
          WHERE WooCommerce_Order_Key__c = 'wc_order_nomap'
        ],
        'Failed WooCommerce order creation must roll back the parent Order.'
      );
      System.assertEquals(
        1,
        [
          SELECT COUNT()
          FROM Integration_Log__c
          WHERE
            Flow_Name__c = 'WoocommerceOrderService.createOrder'
            AND Is_Error__c = TRUE
        ],
        'The rollback must not remove the error integration log.'
      );
      Integration_Log__c logRow = [
        SELECT Is_Error__c, Exception_Message__c
        FROM Integration_Log__c
        WHERE Flow_Name__c = 'WoocommerceOrderService.createOrder'
        LIMIT 1
      ];
      System.assertEquals(
        true,
        logRow.Is_Error__c,
        'The saved integration log should be marked as an error.'
      );
      System.assert(
        logRow.Exception_Message__c.contains(
          'Nessuna mappatura edizione trovata'
        ),
        'The integration log should keep the ticket-mapping failure reason.'
      );
    }
  }

  @isTest
  static void wooOrderRejectsInvalidPayloads() {
    System.runAs(TestDataFactory.runner()) {
      TestDataFactory.activateStandardPricebook();
      Product2 noEntry = TestDataFactory.item('Senza listino', 'SC-NOPB');
      PricebookEntry entry = [
        SELECT Id
        FROM PricebookEntry
        WHERE Product2Id = :noEntry.Id
      ];
      entry.IsActive = false;
      update entry;
      Account accountRecord = TestDataFactory.azienda('Cliente Errori');

      Map<String, Object> noKey = wooPayload(null, 'SC-X', null);
      Map<String, Object> longKey = wooPayload('k'.repeat(81), 'SC-X', null);
      Map<String, Object> noLines = wooPayload('wc_err_1', 'SC-X', null);
      noLines.put('line_items', new List<Object>());
      Map<String, Object> noSku = wooPayload('wc_err_2', ' ', null);
      Map<String, Object> zeroQty = wooPayload('wc_err_3', 'SC-X', null);
      ((Map<String, Object>) ((List<Object>) zeroQty.get('line_items'))[0])
        .put('quantity', 0);
      Map<String, Object> noPrice = wooPayload('wc_err_4', 'SC-X', null);
      ((Map<String, Object>) ((List<Object>) noPrice.get('line_items'))[0])
        .put('total', null);
      Map<String, Object> unknownSku = wooPayload(
        'wc_err_5',
        'SC-UNKNOWN',
        null
      );
      Map<String, Object> inactiveEntry = wooPayload(
        'wc_err_6',
        'SC-NOPB',
        null
      );
      Map<String, Object> badOpportunity = wooPayload(
        'wc_err_7',
        'SC-NOPB',
        null
      );
      badOpportunity.put('sf_opportunity_id', 'not-an-id');
      Map<String, Object> missingOpportunity = wooPayload(
        'wc_err_8',
        'SC-NOPB',
        null
      );
      Opportunity deleted = TestDataFactory.opportunity(accountRecord.Id);
      delete deleted;
      missingOpportunity.put('sf_opportunity_id', String.valueOf(deleted.Id));

      List<Object> payloads = new List<Object>{
        null,
        'not json',
        noKey,
        longKey,
        noLines,
        noSku,
        zeroQty,
        noPrice,
        unknownSku,
        inactiveEntry,
        badOpportunity,
        missingOpportunity
      };
      Integer failures = 0;
      for (Object payload : payloads) {
        callWoo(payload);
        if (RestContext.response.statusCode == 500) {
          failures++;
        }
      }
      System.assertEquals(payloads.size(), failures);
      System.assertEquals(
        payloads.size(),
        [
          SELECT COUNT()
          FROM Integration_Log__c
          WHERE
            Flow_Name__c = 'WoocommerceOrderService.createOrder'
            AND Is_Error__c = TRUE
        ]
      );
    }
  }

  // ---------------------------------------------------- participant page

  private class Invitation {
    Account accountRecord;
    Campaign campaign;
    String token;
    List<Asset> tickets;
  }

  private static Invitation invitation(Integer ticketCount) {
    Invitation result = new Invitation();
    result.accountRecord = TestDataFactory.azienda('Cliente Evento');
    Campaign parent = TestDataFactory.parentCampaign('Tour Eventi');
    result.campaign = TestDataFactory.childCampaign('Tappa Milano', parent.Id);
    Product2 product = TestDataFactory.item(
      'Ingresso',
      TestDataFactory.unique('ART-TKT')
    );
    // Event Links are created per Order-Campaign pair, so every ticket needs
    // an order line.
    Order orderRecord = TestDataFactory.order(result.accountRecord.Id);
    OrderItem line = TestDataFactory.orderItem(
      orderRecord.Id,
      TestDataFactory.standardEntry(product.Id, 100),
      Math.max(ticketCount, 1)
    );
    result.tickets = new List<Asset>();
    for (Integer i = 1; i <= ticketCount; i++) {
      result.tickets.add(
        new Asset(
          Name = 'Biglietto ' + i,
          AccountId = result.accountRecord.Id,
          Product2Id = product.Id,
          Order_Product__c = line.Id,
          Campaign__c = result.campaign.Id,
          Status = 'Disponibile',
          RecordTypeId = TestDataFactory.recordTypeId('Asset', 'Ticket')
        )
      );
    }
    insert result.tickets;
    EventInvitationService.ensureForAssets(result.tickets);
    result.token = [
      SELECT Token__c
      FROM Event_Invitation__c
      WHERE
        Account__c = :result.accountRecord.Id
        AND Campaign__c = :result.campaign.Id
    ]
    .Token__c;
    return result;
  }

  private static ParticipantRegistrationController.ParticipantInput participant(
    Id assetId,
    String email
  ) {
    ParticipantRegistrationController.ParticipantInput input = new ParticipantRegistrationController.ParticipantInput();
    input.assetId = assetId;
    input.firstName = 'Paolo';
    input.lastName = 'Gialli';
    input.email = email;
    input.phone = '3471234567';
    return input;
  }

  @isTest
  static void participantsAreRegisteredOnTheirTickets() {
    System.runAs(TestDataFactory.runner()) {
      Invitation inv = invitation(2);
      Contact known = TestDataFactory.contact(
        inv.accountRecord.Id,
        'noto@example.com',
        false
      );

      ParticipantRegistrationController.PageResponse page = ParticipantRegistrationController.loadPage(
        inv.token.toUpperCase()
      );
      System.assertEquals('READY', page.state);
      System.assertEquals(2, page.tickets.size());
      System.assertEquals(true, page.tickets[0].canRinuncia);

      ParticipantRegistrationController.ContactResponse found = ParticipantRegistrationController.findContact(
        inv.token,
        ' NOTO@example.com '
      );
      System.assertEquals(true, found.found);
      System.assertEquals(
        false,
        ParticipantRegistrationController.findContact(inv.token, 'x@y.it').found
      );

      Test.startTest();
      ParticipantRegistrationController.PageResponse partiallySaved = ParticipantRegistrationController.savePage(
        inv.token,
        new List<ParticipantRegistrationController.ParticipantInput>{
          participant(inv.tickets[0].Id, 'noto@example.com')
        }
      );
      System.assertEquals('READY', partiallySaved.state);
      System.assertEquals(2, partiallySaved.tickets.size());
      System.assertEquals(
        'Assegnato',
        [SELECT Status FROM Asset WHERE Id = :inv.tickets[0].Id].Status
      );
      System.assertEquals(
        'Disponibile',
        [SELECT Status FROM Asset WHERE Id = :inv.tickets[1].Id].Status
      );

      ParticipantRegistrationController.PageResponse saved = ParticipantRegistrationController.savePage(
        inv.token,
        new List<ParticipantRegistrationController.ParticipantInput>{
          participant(inv.tickets[1].Id, 'nuovo.partecipante@example.com')
        }
      );
      // Delivers the document requests; their trigger queues the first job.
      Test.getEventBus().deliver();
      Test.stopTest();
      Set<Id> ticketIds = new Set<Id>();
      for (Asset ticket : inv.tickets) {
        ticketIds.add(ticket.Id);
      }

      System.assertEquals('COMPLETED', saved.state);
      System.assertEquals(
        known.Id,
        [SELECT ContactId FROM Asset WHERE Id = :inv.tickets[0].Id].ContactId
      );
      System.assertEquals(
        'Assegnato',
        [SELECT Status FROM Asset WHERE Id = :inv.tickets[1].Id].Status
      );
      System.assertEquals(
        2,
        [SELECT COUNT() FROM CampaignMember WHERE CampaignId = :inv.campaign.Id]
      );
      System.assertEquals(
        2,
        [
          SELECT COUNT()
          FROM ContentVersion
          WHERE FirstPublishLocationId IN :ticketIds AND Title LIKE 'Ticket QR%'
        ]
      );
      // One document per job: the first job files one, the next is chained.
      System.assertEquals(
        1,
        [
          SELECT COUNT()
          FROM ContentDocumentLink
          WHERE
            LinkedEntityId IN :ticketIds
            AND ContentDocument.Title LIKE 'Documenti partecipazione%'
        ]
      );

      PageReference participantDocumentPage = new PageReference(
        '/apex/ParticipantTicketPdf'
      );
      participantDocumentPage.getParameters()
        .put('id', String.valueOf(inv.tickets[1].Id));
      Test.setCurrentPage(participantDocumentPage);
      ParticipantTicketPdfController pdfController = new ParticipantTicketPdfController();
      System.assertEquals('Tappa Milano', pdfController.getEventName());
      System.assertEquals('Paolo Gialli', pdfController.getParticipantName());
      System.assertEquals(
        inv.accountRecord.Name,
        pdfController.getAccountName()
      );
      System.assertEquals('Biglietto 2', pdfController.getTicketName());

      ParticipantTicketDocumentJob.generate(ticketIds);
      System.assertEquals(
        2,
        [
          SELECT COUNT()
          FROM ContentDocumentLink
          WHERE
            LinkedEntityId IN :ticketIds
            AND ContentDocument.Title LIKE 'Documenti partecipazione%'
        ]
      );
    }
  }

  @isTest
  static void participantPageRefusesBadInput() {
    System.runAs(TestDataFactory.runner()) {
      Invitation inv = invitation(2);
      Invitation other = invitation(1);
      Integer failures = 0;

      List<List<ParticipantRegistrationController.ParticipantInput>> invalid = new List<List<ParticipantRegistrationController.ParticipantInput>>{
        null,
        new List<ParticipantRegistrationController.ParticipantInput>{
          participant(inv.tickets[0].Id, 'a@example.com'),
          participant(inv.tickets[0].Id, 'b@example.com')
        },
        new List<ParticipantRegistrationController.ParticipantInput>{
          participant(inv.tickets[0].Id, 'a@example.com'),
          participant(other.tickets[0].Id, 'b@example.com')
        },
        new List<ParticipantRegistrationController.ParticipantInput>{
          participant(inv.tickets[0].Id, 'non-valida'),
          participant(inv.tickets[1].Id, 'b@example.com')
        },
        new List<ParticipantRegistrationController.ParticipantInput>{
          participant(inv.tickets[0].Id, 'stessa@example.com'),
          null
        }
      };
      ParticipantRegistrationController.ParticipantInput conflicting = participant(
        inv.tickets[1].Id,
        'stessa@example.com'
      );
      conflicting.firstName = 'Diverso';
      invalid.add(
        new List<ParticipantRegistrationController.ParticipantInput>{
          participant(inv.tickets[0].Id, 'stessa@example.com'),
          conflicting
        }
      );
      ParticipantRegistrationController.ParticipantInput invalidPhone = participant(
        inv.tickets[0].Id,
        'telefono@example.com'
      );
      invalidPhone.phone = 'non-un-numero';
      invalid.add(
        new List<ParticipantRegistrationController.ParticipantInput>{
          invalidPhone
        }
      );
      for (
        List<ParticipantRegistrationController.ParticipantInput> inputs : invalid
      ) {
        try {
          ParticipantRegistrationController.savePage(inv.token, inputs);
        } catch (AuraHandledException e) {
          failures++;
        }
      }
      for (String badToken : new List<String>{ null, 'abc', '0'.repeat(64) }) {
        try {
          ParticipantRegistrationController.loadPage(badToken);
        } catch (AuraHandledException e) {
          failures++;
        }
      }
      try {
        ParticipantRegistrationController.findContact(inv.token, 'nope');
      } catch (AuraHandledException e) {
        failures++;
      }
      System.assertEquals(11, failures);
    }
  }

  @isTest
  static void participantCanWaiveTheWholeInvitation() {
    System.runAs(TestDataFactory.runner()) {
      Invitation inv = invitation(2);

      ParticipantRegistrationController.PageResponse page = ParticipantRegistrationController.markTicketRinuncia(
        inv.token,
        inv.tickets[0].Id
      );

      System.assertEquals('Rinuncia registrata.', page.message);
      System.assertEquals(
        2,
        [
          SELECT COUNT()
          FROM Asset
          WHERE Campaign__c = :inv.campaign.Id AND Status = 'Rinuncia'
        ]
      );
      Integer failures = 0;
      for (String assetId : new List<String>{ null, inv.tickets[0].Id }) {
        try {
          ParticipantRegistrationController.markTicketRinuncia(
            inv.token,
            assetId
          );
        } catch (AuraHandledException e) {
          failures++;
        }
      }
      System.assertEquals(2, failures);
    }
  }

  @isTest
  static void invitationWithoutTicketsShowsNoTickets() {
    System.runAs(TestDataFactory.runner()) {
      Invitation inv = invitation(1);
      update new Asset(Id = inv.tickets[0].Id, Status = 'Annullato');

      System.assertEquals(
        'NO_TICKETS',
        ParticipantRegistrationController.loadPage(inv.token).state
      );
    }
  }

  // ---------------------------------------------------- invitation links

  @isTest
  static void invitationTokenIsRegeneratedAndLinksRefreshed() {
    System.runAs(TestDataFactory.runner()) {
      Invitation inv = invitation(1);
      Event_Invitation__c invitationRecord = [
        SELECT Id, Token__c, Status__c, URL_Status__c
        FROM Event_Invitation__c
        WHERE Token__c = :inv.token
      ];
      System.assertEquals(64, invitationRecord.Token__c.length());
      System.assertEquals('Pending', invitationRecord.Status__c);

      invitationRecord.Token__c = null;
      update invitationRecord;
      System.assertNotEquals(
        inv.token,
        [
          SELECT Token__c
          FROM Event_Invitation__c
          WHERE Id = :invitationRecord.Id
        ]
        .Token__c
      );

      Test.startTest();
      List<EventInvitationUrlJob.RefreshResult> results = EventInvitationUrlJob.refresh(
        new List<Id>{ invitationRecord.Id, null }
      );
      System.enqueueJob(
        new EventInvitationUrlJob(new List<Id>{ invitationRecord.Id })
      );
      Test.stopTest();

      System.assertEquals(2, results.size());
      System.assertNotEquals(
        null,
        [
          SELECT URL_Refreshed_At__c
          FROM Event_Invitation__c
          WHERE Id = :invitationRecord.Id
        ]
        .URL_Refreshed_At__c
      );
      System.assert(EventInvitationUrlJob.refresh(null).isEmpty());
      Exception error;
      try {
        ParticipantCommunityUrl.registrationUrl(' ');
      } catch (ParticipantCommunityUrl.ResolutionException e) {
        error = e;
      }
      System.assertNotEquals(null, error);
    }
  }

  // ------------------------------------------------ bundle tranche editor

  private static Map<String, Object> tranch(
    Id tranchId,
    String name,
    Integer sequence,
    List<Id> componentIds
  ) {
    return new Map<String, Object>{
      'tranchId' => tranchId == null ? null : String.valueOf(tranchId),
      'name' => name,
      'dueDate' => Date.today().addMonths(sequence),
      'sequence' => sequence,
      'componentIds' => componentIds
    };
  }

  private static String tranchError(
    Id bundleId,
    String inputs,
    String deleted
  ) {
    try {
      BundleTranchController.saveTranches(bundleId, inputs, deleted);
    } catch (AuraHandledException e) {
      return e.getMessage();
    }
    System.assert(false, 'saveTranches should have refused the input');
    return null;
  }

  @isTest
  static void bundleTranchesAreSavedMergedAndValidated() {
    System.runAs(TestDataFactory.runner()) {
      Product2 bundle = TestDataFactory.bundle('Bundle Rate', 'BND-RATE', 1200);
      BundleComponent__c a = TestDataFactory.bundleComponent(
        bundle.Id,
        TestDataFactory.item('Rata A', 'ART-RATE-A').Id,
        700
      );
      BundleComponent__c b = TestDataFactory.bundleComponent(
        bundle.Id,
        TestDataFactory.item('Rata B', 'ART-RATE-B').Id,
        500
      );
      Product2 otherBundle = TestDataFactory.bundle('Altro', 'BND-ALTRO', 100);
      Bundle_Tranch__c foreign = new Bundle_Tranch__c(
        Name = 'Estranea',
        Bundle__c = otherBundle.Id,
        Sequenza__c = 1,
        Data_Scadenza__c = Date.today()
      );
      insert foreign;

      BundleTranchController.BundleTranchContext created = BundleTranchController.saveTranches(
        bundle.Id,
        JSON.serialize(
          new List<Object>{
            tranch(null, 'Acconto', 1, new List<Id>{ a.Id }),
            tranch(null, 'Saldo', 2, new List<Id>{ b.Id })
          }
        ),
        null
      );
      System.assertEquals(2, created.tranches.size());
      System.assertEquals(
        created.tranches[0].tranchId,
        created.components[0].bundleTranchId
      );

      BundleTranchController.BundleTranchContext merged = BundleTranchController.saveTranches(
        bundle.Id,
        JSON.serialize(
          new List<Object>{
            tranch(
              created.tranches[0].tranchId,
              'Unica',
              1,
              new List<Id>{ a.Id, b.Id }
            )
          }
        ),
        JSON.serialize(new List<String>{ created.tranches[1].tranchId, '' })
      );
      System.assertEquals(1, merged.tranches.size());
      System.assertEquals('Unica', merged.tranches[0].tranchName);

      List<Id> both = new List<Id>{ a.Id, b.Id };
      List<String> errors = new List<String>{
        tranchError(a.Id, '[]', null),
        tranchError(bundle.Id, '', null),
        tranchError(bundle.Id, '{bad', null),
        tranchError(bundle.Id, '[]', '{bad'),
        tranchError(bundle.Id, '[]', '["not-an-id"]'),
        tranchError(
          bundle.Id,
          JSON.serialize(
            new List<Object>{
              tranch(null, 'X', 1, both),
              tranch(null, 'Y', 1, both)
            }
          ),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ tranch(null, ' ', 5, both) }),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ tranch(null, 'X', 0, both) }),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(
            new List<Object>{ tranch(null, 'X', 5, new List<Id>()) }
          ),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(
            new List<Object>{ tranch(null, 'X', 5, new List<Id>{ a.Id }) }
          ),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(
            new List<Object>{
              tranch(null, 'X', 5, new List<Id>{ a.Id }),
              tranch(null, 'Y', 6, both)
            }
          ),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ tranch(foreign.Id, 'X', 5, both) }),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ tranch(null, 'X', 5, both) }),
          JSON.serialize(new List<String>{ foreign.Id })
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ tranch(null, 'X', 5, both) }),
          null
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ tranch(null, 'X', 1, both) }),
          JSON.serialize(new List<String>())
        ),
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ tranch(bundle.Id, 'X', 5, both) }),
          null
        )
      };
      System.assertEquals(16, errors.size());

      Map<String, Object> noDate = tranch(null, 'X', 5, both);
      noDate.put('dueDate', null);
      TestDataFactory.assertContains(
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ noDate }),
          null
        ),
        'scadenza'
      );
      Map<String, Object> badComponent = tranch(null, 'X', 5, both);
      badComponent.put('componentIds', new List<String>{ bundle.Id });
      TestDataFactory.assertContains(
        tranchError(
          bundle.Id,
          JSON.serialize(new List<Object>{ badComponent }),
          null
        ),
        'non valido'
      );
      List<Object> tooMany = new List<Object>();
      for (Integer i = 1; i <= 21; i++) {
        tooMany.add(tranch(null, 'T' + i, i, both));
      }
      TestDataFactory.assertContains(
        tranchError(bundle.Id, JSON.serialize(tooMany), null),
        '20'
      );
      System.assertEquals(
        'Bundle Rate',
        BundleTranchController.getContext(bundle.Id).bundleName
      );
    }
  }
}
