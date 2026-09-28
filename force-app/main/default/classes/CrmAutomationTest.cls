/**
 * Covers the CRM-side automation: Lead duplicate and conflict checks, the
 * Non Risponde follow-up task, the queued Lead conversion onto an existing or
 * new Azienda, the principal-contact invariant on Contact, and the edition
 * mapping overlap rules on Mappatura_Edizione__c.
 *
 * Leads are saved with duplicate rules allowed: production runs a Lead
 * duplicate rule, and these tests exercise the trigger's own checks.
 */
@isTest
private class CrmAutomationTest {
  private static Database.DMLOptions allowDuplicates() {
    Database.DMLOptions options = new Database.DMLOptions();
    options.DuplicateRuleHeader.AllowSave = true;
    return options;
  }

  private static Lead buildLead(String company, String email, String vat) {
    return new Lead(
      FirstName = 'Luca',
      LastName = TestDataFactory.unique('Verdi'),
      Company = company,
      Email = email,
      Phone = '+39 02 555 0101',
      Partita_IVA__c = vat,
      Status = 'New',
      RecordTypeId = TestDataFactory.recordTypeId('Lead', 'Standard')
    );
  }

  private static Database.SaveResult save(Lead leadRecord) {
    return leadRecord.Id == null
      ? Database.insert(leadRecord, allowDuplicates())
      : Database.update(leadRecord, allowDuplicates());
  }

  private static void qualify(Lead leadRecord, String opportunityType) {
    leadRecord.Status = 'Qualificato';
    leadRecord.Agente__c = UserInfo.getUserId();
    leadRecord.Tipo_Opportunita__c = opportunityType;
  }

  // ------------------------------------------------------------ Lead rules

  @isTest
  static void duplicateOpenLeadIsRefused() {
    System.runAs(TestDataFactory.runner()) {
      Lead first = buildLead('Bar Uno', 'uno@example.com', 'IT01010101010');
      System.assert(save(first).isSuccess());

      Lead twin = buildLead(
        'Bar Uno bis',
        ' UNO@example.com ',
        'it01010101010'
      );
      twin.Phone = '+39-02-555-0101';
      Database.SaveResult result = save(twin);
      System.assertEquals(false, result.isSuccess());

      List<Lead> batch = new List<Lead>{
        buildLead('Bar Due', 'due@example.com', 'IT02020202020'),
        buildLead('Bar Due', 'due@example.com', 'IT02020202020')
      };
      List<Database.SaveResult> batchResults = Database.insert(
        batch,
        allowDuplicates()
      );
      System.assertEquals(false, batchResults[0].isSuccess());
      System.assertEquals(false, batchResults[1].isSuccess());
    }
  }

  @isTest
  static void qualifyingALeadWhoseContactBelongsToAnotherAziendaIsRefused() {
    System.runAs(TestDataFactory.runner()) {
      Account vatOwner = TestDataFactory.buildAzienda('Titolare IVA');
      vatOwner.Partita_IVA__c = 'IT03030303030';
      Account contactOwner = TestDataFactory.azienda('Altra Azienda');
      TestDataFactory.insertAllowingDuplicates(vatOwner);
      Contact existing = TestDataFactory.contact(
        contactOwner.Id,
        'conflitto@example.com',
        false
      );
      existing.Phone = '+39 02 555 0101';
      update existing;

      Lead leadRecord = buildLead(
        'Conflitto',
        'conflitto@example.com',
        'IT03030303030'
      );
      System.assert(save(leadRecord).isSuccess());
      qualify(leadRecord, 'Vendita da tutor');

      Database.SaveResult result = save(leadRecord);
      System.assertEquals(false, result.isSuccess());
    }
  }

  @isTest
  static void nonRispondeCreatesAFollowUpTask() {
    System.runAs(TestDataFactory.runner()) {
      Lead leadRecord = buildLead('Silenzio', 'muto@example.com', null);
      save(leadRecord);

      leadRecord.Status = 'Non Risponde';
      save(leadRecord);

      Task followUp = [
        SELECT Subject, ActivityDate, IsReminderSet
        FROM Task
        WHERE WhoId = :leadRecord.Id
      ];
      System.assertEquals('Ricontattare Lead - Non Risponde', followUp.Subject);
      System.assertEquals(Date.today().addDays(2), followUp.ActivityDate);
      System.assertEquals(true, followUp.IsReminderSet);
    }
  }

  // ------------------------------------------------------- Lead conversion

  @isTest
  static void qualifiedLeadConvertsIntoANewAziendaWithPrincipalContact() {
    System.runAs(TestDataFactory.runner()) {
      Lead leadRecord = buildLead(
        'Ristorante Nuovo',
        'nuovo@example.com',
        'IT04040404040'
      );
      save(leadRecord);

      Test.startTest();
      qualify(leadRecord, 'Recall tutor');
      System.assert(save(leadRecord).isSuccess());
      Test.stopTest();

      Lead converted = [
        SELECT
          IsConverted,
          ConvertedAccountId,
          ConvertedContactId,
          ConvertedOpportunityId
        FROM Lead
        WHERE Id = :leadRecord.Id
      ];
      System.assertEquals(true, converted.IsConverted);
      Account aziendaRecord = [
        SELECT
          RecordType.DeveloperName,
          Partita_IVA__c,
          Lead_Email__c,
          Agente__c
        FROM Account
        WHERE Id = :converted.ConvertedAccountId
      ];
      System.assertEquals('Azienda', aziendaRecord.RecordType.DeveloperName);
      System.assertEquals('IT04040404040', aziendaRecord.Partita_IVA__c);
      System.assertEquals('nuovo@example.com', aziendaRecord.Lead_Email__c);
      System.assertEquals(UserInfo.getUserId(), aziendaRecord.Agente__c);
      System.assertEquals(
        true,
        [
          SELECT Contatto_Principale__c
          FROM Contact
          WHERE Id = :converted.ConvertedContactId
        ]
        .Contatto_Principale__c
      );
      Opportunity opportunityRecord = [
        SELECT RecordType.DeveloperName, Tipo_Opportunita__c
        FROM Opportunity
        WHERE Id = :converted.ConvertedOpportunityId
      ];
      System.assertEquals(
        'Recall_Tutor',
        opportunityRecord.RecordType.DeveloperName
      );
      System.assertEquals(
        'Recall tutor',
        opportunityRecord.Tipo_Opportunita__c
      );
    }
  }

  @isTest
  static void qualifiedLeadReusesTheAziendaAndContactOfItsVat() {
    System.runAs(TestDataFactory.runner()) {
      Account existingAzienda = TestDataFactory.buildAzienda(
        'Cliente Esistente'
      );
      existingAzienda.Partita_IVA__c = 'IT05050505050';
      TestDataFactory.insertAllowingDuplicates(existingAzienda);
      Account locale = TestDataFactory.locale('Sede', existingAzienda.Id);
      Contact existingContact = TestDataFactory.contact(
        existingAzienda.Id,
        'esistente@example.com',
        false
      );
      existingContact.Phone = '+39 02 555 0101';
      update existingContact;
      Lead leadRecord = buildLead('', 'esistente@example.com', 'IT05050505050');
      leadRecord.Company = 'Cliente Esistente';
      save(leadRecord);

      Test.startTest();
      qualify(leadRecord, 'Performance Plus - Attivazione');
      save(leadRecord);
      Test.stopTest();

      Lead converted = [
        SELECT
          IsConverted,
          ConvertedAccountId,
          ConvertedContactId,
          ConvertedOpportunityId
        FROM Lead
        WHERE Id = :leadRecord.Id
      ];
      System.assertEquals(true, converted.IsConverted);
      System.assertEquals(existingAzienda.Id, converted.ConvertedAccountId);
      System.assertEquals(existingContact.Id, converted.ConvertedContactId);
      System.assertEquals(
        'Plus_Attivazione_Rinnovo',
        [
          SELECT RecordType.DeveloperName
          FROM Opportunity
          WHERE Id = :converted.ConvertedOpportunityId
        ]
        .RecordType.DeveloperName
      );
      System.assertNotEquals(null, locale.Id);
    }
  }

  @isTest
  static void conversionQueueSkipsUnqualifiedAndEmptyInput() {
    System.runAs(TestDataFactory.runner()) {
      Lead leadRecord = buildLead('In attesa', 'attesa@example.com', null);
      save(leadRecord);

      Test.startTest();
      System.enqueueJob(
        new LeadConversionQueueable(new List<Id>{ leadRecord.Id })
      );
      System.enqueueJob(new LeadConversionQueueable(null));
      Test.stopTest();

      System.assertEquals(
        false,
        [SELECT IsConverted FROM Lead WHERE Id = :leadRecord.Id].IsConverted
      );
    }
  }

  @isTest
  static void queueConvertsALeadWithoutCompanyOrVat() {
    System.runAs(TestDataFactory.runner()) {
      Lead leadRecord = buildLead(null, 'privato@example.com', null);
      leadRecord.Company = TestDataFactory.unique('Privato');
      save(leadRecord);
      leadRecord.Status = 'Qualificato';
      leadRecord.Agente__c = UserInfo.getUserId();
      leadRecord.Tipo_Opportunita__c = 'Vendita da tutor';

      Test.startTest();
      save(leadRecord);
      Test.stopTest();

      System.assertEquals(
        true,
        [SELECT IsConverted FROM Lead WHERE Id = :leadRecord.Id].IsConverted
      );
    }
  }

  // The queueable converts with allOrNone=false and only logs failures; this
  // runs the same conversion synchronously so a failure reports its reason.
  @isTest
  static void conversionRequestSucceedsForAQualifiedLead() {
    System.runAs(TestDataFactory.runner()) {
      Lead leadRecord = buildLead(
        TestDataFactory.unique('Diagnosi'),
        'diagnosi@example.com',
        'IT07070707070'
      );
      save(leadRecord);
      Database.LeadConvert request = new Database.LeadConvert();
      request.setLeadId(leadRecord.Id);
      request.setConvertedStatus('Convertito');
      request.setOpportunityName('Diagnosi');
      request.setSendNotificationEmail(false);

      Database.LeadConvertResult result = Database.convertLead(request, false);

      System.assert(result.isSuccess(), String.valueOf(result.getErrors()));
    }
  }

  // ------------------------------------------------------ principal contact

  @isTest
  static void onlyOnePrincipalContactPerAccountAndItsEmailIsMirrored() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Principale');
      Contact first = TestDataFactory.contact(
        accountRecord.Id,
        'primo@example.com',
        true
      );
      System.assertEquals(
        'primo@example.com',
        [
          SELECT Email_Contatto_Principale__c
          FROM Account
          WHERE Id = :accountRecord.Id
        ]
        .Email_Contatto_Principale__c
      );

      Contact second = TestDataFactory.contact(
        accountRecord.Id,
        'secondo@example.com',
        true
      );
      System.assertEquals(
        false,
        [SELECT Contatto_Principale__c FROM Contact WHERE Id = :first.Id]
        .Contatto_Principale__c
      );
      System.assertEquals(
        'secondo@example.com',
        [
          SELECT Email_Contatto_Principale__c
          FROM Account
          WHERE Id = :accountRecord.Id
        ]
        .Email_Contatto_Principale__c
      );

      second.Email = 'cambiato@example.com';
      update second;
      System.assertEquals(
        'cambiato@example.com',
        [
          SELECT Email_Contatto_Principale__c
          FROM Account
          WHERE Id = :accountRecord.Id
        ]
        .Email_Contatto_Principale__c
      );

      first.Contatto_Principale__c = true;
      update first;
      System.assertEquals(
        false,
        [SELECT Contatto_Principale__c FROM Contact WHERE Id = :second.Id]
        .Contatto_Principale__c
      );

      delete first;
      System.assertEquals(
        null,
        [
          SELECT Email_Contatto_Principale__c
          FROM Account
          WHERE Id = :accountRecord.Id
        ]
        .Email_Contatto_Principale__c
      );
      undelete first;
      System.assertEquals(
        'primo@example.com',
        [
          SELECT Email_Contatto_Principale__c
          FROM Account
          WHERE Id = :accountRecord.Id
        ]
        .Email_Contatto_Principale__c
      );
    }
  }

  // --------------------------------------------------------- edition mapping

  @isTest
  static void overlappingActiveMappingsForAProductAreRefused() {
    System.runAs(TestDataFactory.runner()) {
      Product2 product = TestDataFactory.item('Evento Mappato', 'ART-MAP');
      Campaign parent = TestDataFactory.parentCampaign('Tour 2026');
      Campaign first = TestDataFactory.childCampaign('Milano', parent.Id);
      Campaign overlapping = TestDataFactory.childCampaign('Torino', parent.Id);
      Campaign later = TestDataFactory.childCampaign('Roma', parent.Id);
      later.StartDate = Date.today().addDays(30);
      later.EndDate = Date.today().addDays(40);
      later.Data_Evento__c = Date.today().addDays(40);
      update later;

      Mappatura_Edizione__c mapping = TestDataFactory.mapping(
        product.Id,
        first.Id
      );
      Mappatura_Edizione__c saved = [
        SELECT Data_Inizio__c, Data_Fine__c, Data_Evento__c
        FROM Mappatura_Edizione__c
        WHERE Id = :mapping.Id
      ];
      System.assertEquals(first.StartDate, saved.Data_Inizio__c);
      System.assertEquals(first.EndDate, saved.Data_Fine__c);

      Mappatura_Edizione__c clash = new Mappatura_Edizione__c(
        Prodotto__c = product.Id,
        Campagna__c = overlapping.Id,
        Attiva__c = true
      );
      System.assertEquals(false, Database.insert(clash, false).isSuccess());

      List<Mappatura_Edizione__c> sameBatch = new List<Mappatura_Edizione__c>{
        new Mappatura_Edizione__c(
          Prodotto__c = TestDataFactory.item('Altro', 'ART-MAP-2').Id,
          Campagna__c = first.Id,
          Attiva__c = true
        )
      };
      sameBatch.add(sameBatch[0].clone());
      List<Database.SaveResult> batchResults = Database.insert(
        sameBatch,
        false
      );
      System.assertEquals(false, batchResults[0].isSuccess());

      Mappatura_Edizione__c separate = TestDataFactory.mapping(
        product.Id,
        later.Id
      );
      separate.Campagna__c = overlapping.Id;
      System.assertEquals(false, Database.update(separate, false).isSuccess());

      Mappatura_Edizione__c onParent = new Mappatura_Edizione__c(
        Prodotto__c = product.Id,
        Campagna__c = parent.Id,
        Attiva__c = true
      );
      System.assertEquals(false, Database.insert(onParent, false).isSuccess());

      Mappatura_Edizione__c inactive = new Mappatura_Edizione__c(
        Prodotto__c = product.Id,
        Campagna__c = overlapping.Id,
        Attiva__c = false
      );
      System.assertEquals(true, Database.insert(inactive, false).isSuccess());
    }
  }
}
