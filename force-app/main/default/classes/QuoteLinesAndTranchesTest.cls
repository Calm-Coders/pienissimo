/**
 * Covers the quote-side Lightning controllers: the tranche editor
 * (QuoteTrancheController), the line viewer with bundle expansion and delete
 * actions (QuoteLineItemsController) and the new-quote defaults
 * (OpportunityQuoteDefaultsController).
 */
@isTest
private class QuoteLinesAndTranchesTest {
  private class Fixture {
    Opportunity opportunityRecord;
    Quote quoteRecord;
    QuoteLineItem first;
    QuoteLineItem second;
  }

  private static Fixture fixture() {
    Fixture f = new Fixture();
    f.opportunityRecord = TestDataFactory.opportunity(
      TestDataFactory.azienda('Cliente Tranche').Id
    );
    f.quoteRecord = TestDataFactory.quote(f.opportunityRecord.Id);
    Product2 a = TestDataFactory.item(
      'Modulo Uno',
      TestDataFactory.unique('ART-TR-1')
    );
    Product2 b = TestDataFactory.item(
      'Modulo Due',
      TestDataFactory.unique('ART-TR-2')
    );
    f.first = TestDataFactory.quoteLine(
      f.quoteRecord.Id,
      TestDataFactory.standardEntry(a.Id, 100),
      1,
      100
    );
    f.second = TestDataFactory.quoteLine(
      f.quoteRecord.Id,
      TestDataFactory.standardEntry(b.Id, 50),
      2,
      50
    );
    return f;
  }

  private static Map<String, Object> input(
    Id trancheId,
    String name,
    Integer sequence,
    List<Id> lineIds
  ) {
    return new Map<String, Object>{
      'trancheId' => trancheId == null ? null : String.valueOf(trancheId),
      'name' => name,
      'dueDate' => Date.today().addMonths(sequence),
      'sequence' => sequence,
      'quoteLineItemIds' => lineIds
    };
  }

  private static String json(List<Map<String, Object>> inputs) {
    return JSON.serialize(inputs);
  }

  private static String trancheError(
    Id quoteId,
    String inputsJson,
    String deletedJson
  ) {
    try {
      QuoteTrancheController.createTranches(quoteId, inputsJson, deletedJson);
    } catch (AuraHandledException e) {
      return e.getMessage();
    }
    System.assert(false, 'createTranches should have refused the input');
    return null;
  }

  // -------------------------------------------------------- tranche editor

  @isTest
  static void tranchesAreCreatedEditedAndDeleted() {
    System.runAs(TestDataFactory.runner()) {
      Fixture f = fixture();

      Test.startTest();
      QuoteTrancheController.QuoteTrancheContext created = QuoteTrancheController.createTranches(
        f.quoteRecord.Id,
        json(
          new List<Map<String, Object>>{
            input(null, 'Acconto', 1, new List<Id>{ f.first.Id }),
            input(null, 'Saldo', 2, new List<Id>{ f.second.Id })
          }
        ),
        null
      );
      System.assertEquals(2, created.tranches.size());
      System.assertEquals(true, created.isEditable);
      Id accontoId = created.tranches[0].trancheId;
      Id saldoId = created.tranches[1].trancheId;
      System.assertEquals(
        100,
        [SELECT Importo_Previsto__c FROM Tranche__c WHERE Id = :accontoId]
        .Importo_Previsto__c
      );

      // Merge both lines into the first tranche and drop the second.
      QuoteTrancheController.QuoteTrancheContext merged = QuoteTrancheController.createTranches(
        f.quoteRecord.Id,
        json(
          new List<Map<String, Object>>{
            input(
              accontoId,
              'Unica',
              1,
              new List<Id>{ f.first.Id, f.second.Id }
            )
          }
        ),
        JSON.serialize(new List<String>{ String.valueOf(saldoId), '' })
      );
      Test.stopTest();

      System.assertEquals(1, merged.tranches.size());
      System.assertEquals('Unica', merged.tranches[0].trancheName);
      System.assertEquals(
        200,
        [SELECT Importo_Previsto__c FROM Tranche__c WHERE Id = :accontoId]
        .Importo_Previsto__c
      );
      for (QuoteTrancheController.QuoteLineRow row : merged.lines) {
        System.assertEquals(accontoId, row.trancheId);
        System.assertNotEquals(null, row.dueDate);
      }

      QuoteTrancheController.QuoteTrancheContext afterDelete = QuoteTrancheController.deleteTranche(
        f.quoteRecord.Id,
        accontoId
      );
      System.assertEquals(0, afterDelete.tranches.size());
      for (QuoteTrancheController.QuoteLineRow row : afterDelete.lines) {
        System.assertEquals(null, row.trancheId);
      }
    }
  }

  @isTest
  static void trancheEditorRefusesInvalidInput() {
    System.runAs(TestDataFactory.runner()) {
      Fixture f = fixture();
      List<Id> both = new List<Id>{ f.first.Id, f.second.Id };
      List<String> errors = new List<String>{
        trancheError(f.opportunityRecord.Id, '[]', null),
        trancheError(f.quoteRecord.Id, '', null),
        trancheError(f.quoteRecord.Id, '{bad', null),
        trancheError(f.quoteRecord.Id, '[]', null),
        trancheError(f.quoteRecord.Id, '[]', '{bad'),
        trancheError(f.quoteRecord.Id, '[]', '["not-an-id"]'),
        trancheError(
          f.quoteRecord.Id,
          json(
            new List<Map<String, Object>>{
              input(null, 'A', 1, new List<Id>{ f.first.Id }),
              input(null, 'B', 1, new List<Id>{ f.second.Id })
            }
          ),
          null
        ),
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ input(null, ' ', 1, both) }),
          null
        ),
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ input(null, 'A', 0, both) }),
          null
        ),
        trancheError(
          f.quoteRecord.Id,
          json(
            new List<Map<String, Object>>{ input(null, 'A', 1, new List<Id>()) }
          ),
          null
        ),
        trancheError(
          f.quoteRecord.Id,
          json(
            new List<Map<String, Object>>{
              input(null, 'A', 1, new List<Id>{ f.first.Id })
            }
          ),
          null
        ),
        trancheError(
          f.quoteRecord.Id,
          json(
            new List<Map<String, Object>>{
              input(null, 'A', 1, new List<Id>{ f.first.Id }),
              input(null, 'B', 2, new List<Id>{ f.first.Id, f.second.Id })
            }
          ),
          null
        ),
        trancheError(
          f.quoteRecord.Id,
          json(
            new List<Map<String, Object>>{
              input(f.opportunityRecord.Id, 'A', 1, both)
            }
          ),
          null
        )
      };
      System.assertEquals(13, errors.size());

      Map<String, Object> noDate = input(null, 'A', 1, both);
      noDate.put('dueDate', null);
      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ noDate }),
          null
        ),
        'due date'
      );
      Map<String, Object> badLine = input(null, 'A', 1, both);
      badLine.put('quoteLineItemIds', new List<String>{ f.quoteRecord.Id });
      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ badLine }),
          null
        ),
        'invalid line'
      );
      List<Map<String, Object>> tooMany = new List<Map<String, Object>>();
      for (Integer i = 1; i <= 21; i++) {
        tooMany.add(input(null, 'T' + i, i, both));
      }
      TestDataFactory.assertContains(
        trancheError(f.quoteRecord.Id, json(tooMany), null),
        '20'
      );
    }
  }

  @isTest
  static void tranchesOnAnotherQuoteOrAClosedQuoteAreRefused() {
    System.runAs(TestDataFactory.runner()) {
      Fixture f = fixture();
      Fixture other = fixture();
      Tranche__c foreign = TestDataFactory.tranche(other.quoteRecord.Id, 1);
      List<Id> both = new List<Id>{ f.first.Id, f.second.Id };

      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(
            new List<Map<String, Object>>{ input(foreign.Id, 'A', 1, both) }
          ),
          null
        ),
        'do not belong'
      );
      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ input(null, 'A', 1, both) }),
          JSON.serialize(new List<String>{ foreign.Id })
        ),
        'do not belong'
      );
      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(
            new List<Map<String, Object>>{
              input(null, 'A', 1, new List<Id>{ other.first.Id, f.first.Id })
            }
          ),
          null
        ),
        'do not belong'
      );

      Tranche__c existing = TestDataFactory.tranche(f.quoteRecord.Id, 1);
      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ input(null, 'A', 1, both) }),
          null
        ),
        'already exists'
      );
      update new QuoteLineItem(Id = f.first.Id, Tranche__c = existing.Id);
      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ input(null, 'A', 2, both) }),
          null
        ),
        'gia assegnate'
      );

      String deleteError;
      try {
        QuoteTrancheController.deleteTranche(f.quoteRecord.Id, foreign.Id);
      } catch (AuraHandledException e) {
        deleteError = e.getMessage();
      }
      TestDataFactory.assertContains(deleteError, 'does not belong');
      deleteError = null;
      try {
        QuoteTrancheController.deleteTranche(
          f.quoteRecord.Id,
          f.quoteRecord.Id
        );
      } catch (AuraHandledException e) {
        deleteError = e.getMessage();
      }
      TestDataFactory.assertContains(deleteError, 'valid tranche');
      deleteError = null;

      update new Quote(Id = f.quoteRecord.Id, Status = 'Accettato');
      System.assertEquals(
        false,
        QuoteTrancheController.getContext(f.quoteRecord.Id).isEditable
      );
      TestDataFactory.assertContains(
        trancheError(
          f.quoteRecord.Id,
          json(new List<Map<String, Object>>{ input(null, 'A', 3, both) }),
          null
        ),
        'Draft'
      );
      try {
        QuoteTrancheController.deleteTranche(f.quoteRecord.Id, existing.Id);
      } catch (AuraHandledException e) {
        deleteError = e.getMessage();
      }
      TestDataFactory.assertContains(deleteError, 'Draft');
      deleteError = null;
    }
  }

  // ------------------------------------------------------------ line viewer

  @isTest
  static void lineViewerExpandsBundlesAndDeletesLines() {
    System.runAs(TestDataFactory.runner()) {
      Fixture f = fixture();
      Product2 bundle = TestDataFactory.bundle(
        'Bundle Viewer',
        'BND-VIEW',
        900
      );
      PricebookEntry bundleEntry = TestDataFactory.standardEntry(bundle.Id, 0);
      Product2 component = TestDataFactory.item('Componente', 'ART-VIEW-C');
      TestDataFactory.bundleComponent(bundle.Id, component.Id, 300);
      Quote bundleQuote = TestDataFactory.quote(f.opportunityRecord.Id);
      TestDataFactory.quoteLine(bundleQuote.Id, bundleEntry, 1, 900);
      QuoteLineItem exploded = new QuoteLineItem(
        QuoteId = bundleQuote.Id,
        PricebookEntryId = TestDataFactory.standardEntry(component.Id, 300).Id,
        Quantity = 1,
        UnitPrice = 300,
        Description = 'Bundle: Bundle Viewer'
      );
      // A plain component line on its own quote, as the configurator writes it.
      Quote explodedQuote = TestDataFactory.quote(f.opportunityRecord.Id);
      exploded.QuoteId = explodedQuote.Id;
      insert exploded;

      Test.startTest();
      QuoteLineItemsController.QuoteLinesContext bundleContext = QuoteLineItemsController.getContext(
        bundleQuote.Id
      );
      QuoteLineItemsController.QuoteLinesContext explodedContext = QuoteLineItemsController.getContext(
        explodedQuote.Id
      );
      QuoteLineItemsController.QuoteLinesContext afterDelete = QuoteLineItemsController.deleteLine(
        f.quoteRecord.Id,
        f.first.Id
      );
      String lineError;
      try {
        QuoteLineItemsController.deleteLine(explodedQuote.Id, exploded.Id);
      } catch (AuraHandledException e) {
        lineError = e.getMessage();
      }
      QuoteLineItemsController.QuoteLinesContext bundleDeleted = QuoteLineItemsController.deleteBundle(
        explodedQuote.Id,
        'Bundle Viewer'
      );
      Test.stopTest();

      System.assertEquals(
        2,
        bundleContext.rows.size(),
        'Bundle line + component'
      );
      System.assertEquals(
        300,
        bundleContext.rows[0].unitPrice,
        JSON.serialize(bundleContext.rows)
      );
      System.assertEquals(
        true,
        bundleContext.rows[1].isComponent,
        JSON.serialize(bundleContext.rows)
      );
      System.assertEquals(
        bundle.Id,
        explodedContext.rows[0].bundleId,
        JSON.serialize(explodedContext.rows)
      );
      System.assertEquals(true, explodedContext.canDeleteLines);
      System.assertEquals(1, afterDelete.rows.size());
      TestDataFactory.assertContains(lineError, 'bundle completo');
      System.assertEquals(0, bundleDeleted.rows.size());
    }
  }

  @isTest
  static void lineViewerGuardsItsInputs() {
    System.runAs(TestDataFactory.runner()) {
      Fixture f = fixture();
      Fixture other = fixture();
      List<String> errors = new List<String>();
      try {
        QuoteLineItemsController.getContext(f.opportunityRecord.Id);
      } catch (AuraHandledException e) {
        errors.add(e.getMessage());
      }
      try {
        QuoteLineItemsController.deleteLine(f.quoteRecord.Id, f.quoteRecord.Id);
      } catch (AuraHandledException e) {
        errors.add(e.getMessage());
      }
      try {
        QuoteLineItemsController.deleteLine(f.quoteRecord.Id, other.first.Id);
      } catch (AuraHandledException e) {
        errors.add(e.getMessage());
      }
      try {
        QuoteLineItemsController.deleteBundle(f.quoteRecord.Id, ' ');
      } catch (AuraHandledException e) {
        errors.add(e.getMessage());
      }
      try {
        QuoteLineItemsController.deleteBundle(f.quoteRecord.Id, 'Assente');
      } catch (AuraHandledException e) {
        errors.add(e.getMessage());
      }
      update new Quote(Id = f.quoteRecord.Id, Status = 'Accettato');
      try {
        QuoteLineItemsController.deleteLine(f.quoteRecord.Id, f.first.Id);
      } catch (AuraHandledException e) {
        errors.add(e.getMessage());
      }
      System.assertEquals(6, errors.size());
      System.assertEquals(
        false,
        QuoteLineItemsController.getContext(f.quoteRecord.Id).canDeleteLines
      );
    }
  }

  // -------------------------------------------------------- quote defaults

  @isTest
  static void defaultsComeFromTheOpportunityAccountAndPrincipalContact() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Cliente Default');
      Contact principal = TestDataFactory.contact(
        accountRecord.Id,
        'principale@example.com',
        true
      );
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        accountRecord.Id
      );

      OpportunityQuoteDefaultsController.QuoteDefaults defaults = OpportunityQuoteDefaultsController.getDefaults(
        opportunityRecord.Id
      );
      System.assertEquals(principal.Id, defaults.contactId);
      System.assertEquals('Milano', defaults.billingCity);
      System.assertEquals('Milano', defaults.shippingCity);
      System.assertEquals(true, defaults.isPrimary);
      System.assertEquals('Bozza', defaults.status);

      OpportunityQuoteDefaultsController.QuoteInput input = new OpportunityQuoteDefaultsController.QuoteInput();
      input.quoteName = '  Preventivo di prova ';
      input.expirationDate = Date.today().addDays(30);
      input.isPrimary = true;
      input.contactId = defaults.contactId;
      input.email = defaults.email;
      input.accountName = defaults.accountName;
      input.billingCity = defaults.billingCity;
      Id quoteId = OpportunityQuoteDefaultsController.createQuote(
        opportunityRecord.Id,
        input
      );
      Quote created = [
        SELECT Name, Status, ContactId, Is_Primary__c
        FROM Quote
        WHERE Id = :quoteId
      ];
      System.assertEquals('Preventivo di prova', created.Name);
      System.assertEquals('Bozza', created.Status);
      System.assertEquals(principal.Id, created.ContactId);
      System.assertEquals(
        false,
        OpportunityQuoteDefaultsController.getDefaults(opportunityRecord.Id)
          .isPrimary
      );
    }
  }

  @isTest
  static void defaultsPreferThePrimaryContactRole() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Cliente Ruolo');
      Contact roleContact = TestDataFactory.contact(
        accountRecord.Id,
        'ruolo@example.com',
        false
      );
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        accountRecord.Id
      );
      insert new OpportunityContactRole(
        OpportunityId = opportunityRecord.Id,
        ContactId = roleContact.Id,
        IsPrimary = true
      );

      System.assertEquals(
        roleContact.Id,
        OpportunityQuoteDefaultsController.getDefaults(opportunityRecord.Id)
          .contactId
      );
    }
  }

  @isTest
  static void createQuoteValidatesItsInput() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        TestDataFactory.azienda('Cliente Errori').Id
      );
      OpportunityQuoteDefaultsController.QuoteInput noName = new OpportunityQuoteDefaultsController.QuoteInput();
      noName.expirationDate = Date.today();
      OpportunityQuoteDefaultsController.QuoteInput noDate = new OpportunityQuoteDefaultsController.QuoteInput();
      noDate.quoteName = 'Nome';

      Integer failures = 0;
      for (
        OpportunityQuoteDefaultsController.QuoteInput input : new List<OpportunityQuoteDefaultsController.QuoteInput>{
          null,
          noName,
          noDate
        }
      ) {
        try {
          OpportunityQuoteDefaultsController.createQuote(
            opportunityRecord.Id,
            input
          );
        } catch (AuraHandledException e) {
          failures++;
        }
      }
      try {
        OpportunityQuoteDefaultsController.createQuote(null, noName);
      } catch (AuraHandledException e) {
        failures++;
      }
      try {
        OpportunityQuoteDefaultsController.getDefaults(null);
      } catch (AuraHandledException e) {
        failures++;
      }
      System.assertEquals(5, failures);
    }
  }
}
