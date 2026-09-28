/**
 * Covers the commercial chain from Opportunity to Order: the Locale/Azienda
 * normalisation, the Quote trigger (primary quote, stage advance, amount,
 * order generation on signature), the Quote line mix rules, the product
 * configurator (items, bundles with tranche templates, Plus with tranches)
 * and the daily negotiation ageing batch.
 */
@isTest
private class QuoteCommercialTest {
  private static Account azienda() {
    return TestDataFactory.azienda('Cliente Preventivi');
  }

  private static PricebookEntry itemEntry(String code, Decimal price) {
    Product2 product = TestDataFactory.item('Prodotto ' + code, code);
    return TestDataFactory.standardEntry(product.Id, price);
  }

  private static QuoteManageProductsController.ProductSelection selection(
    Id entryId,
    Decimal quantity
  ) {
    QuoteManageProductsController.ProductSelection row = new QuoteManageProductsController.ProductSelection();
    row.pricebookEntryId = entryId;
    row.quantity = quantity;
    return row;
  }

  private static QuoteManageProductsController.TrancheSelection due(Date d) {
    QuoteManageProductsController.TrancheSelection row = new QuoteManageProductsController.TrancheSelection();
    row.dueDate = d;
    return row;
  }

  private static String expectAuraError(
    Id quoteId,
    List<QuoteManageProductsController.ProductSelection> products,
    List<QuoteManageProductsController.TrancheSelection> tranches
  ) {
    try {
      QuoteManageProductsController.saveProducts(quoteId, products, tranches);
    } catch (AuraHandledException e) {
      return e.getMessage();
    }
    System.assert(false, 'saveProducts should have refused the selection');
    return null;
  }

  // ------------------------------------------------ Opportunity + Account

  @isTest
  static void opportunityOnALocaleMovesToItsAzienda() {
    System.runAs(TestDataFactory.runner()) {
      Account parent = azienda();
      Account locale = TestDataFactory.locale('Locale Centro', parent.Id);

      Opportunity opportunityRecord = new Opportunity(
        Name = 'Da Locale',
        AccountId = locale.Id
      );
      insert opportunityRecord;

      Opportunity saved = [
        SELECT AccountId, Locale__c, StageName, CloseDate
        FROM Opportunity
        WHERE Id = :opportunityRecord.Id
      ];
      System.assertEquals(parent.Id, saved.AccountId);
      System.assertEquals(locale.Id, saved.Locale__c);
      System.assertEquals('Qualificato', saved.StageName);
      System.assertEquals(
        Date.newInstance(Date.today().year() + 1, 12, 31),
        saved.CloseDate
      );
      System.assertEquals(
        parent.Id,
        CommercialAccountResolver.resolve(locale.Id)
      );
      System.assertEquals(
        parent.Id,
        CommercialAccountResolver.resolve(parent.Id)
      );
      System.assertEquals(null, CommercialAccountResolver.resolve(null));
      System.assert(CommercialAccountResolver.resolveAll(null).isEmpty());
    }
  }

  @isTest
  static void aziendaWithLocaliCannotBeDeleted() {
    System.runAs(TestDataFactory.runner()) {
      Account parent = azienda();
      TestDataFactory.locale('Locale', parent.Id);
      Account lonely = azienda();

      Database.DeleteResult blocked = Database.delete(parent, false);
      System.assertEquals(false, blocked.isSuccess());
      System.assertEquals(true, Database.delete(lonely, false).isSuccess());
    }
  }

  // --------------------------------------------------------- Quote trigger

  @isTest
  static void firstQuoteIsPrimaryAndMovesTheOpportunityToNegotiation() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);

      Quote first = TestDataFactory.quote(opportunityRecord.Id);
      Quote second = TestDataFactory.quote(opportunityRecord.Id);

      System.assertEquals(
        true,
        [SELECT Is_Primary__c FROM Quote WHERE Id = :first.Id].Is_Primary__c
      );
      System.assertEquals(
        false,
        [SELECT Is_Primary__c FROM Quote WHERE Id = :second.Id].Is_Primary__c
      );
      Opportunity afterQuote = [
        SELECT StageName, Preventivo_Primario__c
        FROM Opportunity
        WHERE Id = :opportunityRecord.Id
      ];
      System.assertEquals('In trattativa (Prev inviato)', afterQuote.StageName);
      System.assertEquals(first.Id, afterQuote.Preventivo_Primario__c);

      Test.startTest();
      update new Quote(Id = second.Id, Is_Primary__c = true);
      Test.stopTest();

      System.assertEquals(
        false,
        [SELECT Is_Primary__c FROM Quote WHERE Id = :first.Id].Is_Primary__c
      );
      System.assertEquals(
        second.Id,
        [
          SELECT Preventivo_Primario__c
          FROM Opportunity
          WHERE Id = :opportunityRecord.Id
        ]
        .Preventivo_Primario__c
      );
    }
  }

  @isTest
  static void quoteInheritsTheOpportunityLocaleAndRejectsAnother() {
    System.runAs(TestDataFactory.runner()) {
      Account parent = azienda();
      Account centro = TestDataFactory.locale('Centro', parent.Id);
      Account periferia = TestDataFactory.locale('Periferia', parent.Id);
      Opportunity opportunityRecord = new Opportunity(
        Name = 'Con Locale',
        AccountId = centro.Id,
        StageName = 'Qualificato',
        CloseDate = Date.today().addDays(10)
      );
      insert opportunityRecord;

      Quote inherited = TestDataFactory.quote(opportunityRecord.Id);
      System.assertEquals(
        centro.Id,
        [SELECT Locale__c FROM Quote WHERE Id = :inherited.Id].Locale__c
      );

      Quote mismatched = new Quote(
        Name = 'Altro Locale',
        OpportunityId = opportunityRecord.Id,
        Locale__c = periferia.Id
      );
      System.assertEquals(
        false,
        Database.insert(mismatched, false).isSuccess()
      );
    }
  }

  @isTest
  static void signedAcceptedQuoteGeneratesTheOrderWithItsLines() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);
      Tranche__c trancheRecord = TestDataFactory.tranche(quoteRecord.Id, 1);
      QuoteLineItem line = new QuoteLineItem(
        QuoteId = quoteRecord.Id,
        PricebookEntryId = itemEntry('ART-Q1', 300).Id,
        Quantity = 2,
        UnitPrice = 300,
        Tranche__c = trancheRecord.Id,
        Data_Scadenza__c = Date.today().addMonths(1)
      );
      insert line;

      Test.startTest();
      update new Quote(
        Id = quoteRecord.Id,
        Status = 'Accettato',
        DocuSign_Status__c = 'Completed'
      );
      Test.stopTest();

      Quote signed = [
        SELECT Is_Signed__c
        FROM Quote
        WHERE Id = :quoteRecord.Id
      ];
      System.assertEquals(true, signed.Is_Signed__c);
      Order generated = [
        SELECT
          Status,
          OpportunityId,
          Origine__c,
          (SELECT Quantity, UnitPrice, Tranche__c FROM OrderItems)
        FROM Order
        WHERE Quote__c = :quoteRecord.Id
      ];
      System.assertEquals('Ordinato', generated.Status);
      System.assertEquals('Salesforce', generated.Origine__c);
      System.assertEquals(opportunityRecord.Id, generated.OpportunityId);
      System.assertEquals(1, generated.OrderItems.size());
      System.assertEquals(trancheRecord.Id, generated.OrderItems[0].Tranche__c);
      System.assertEquals(
        600,
        [SELECT Amount FROM Opportunity WHERE Id = :opportunityRecord.Id].Amount
      );

      // A second signature event never generates a second order.
      update new Quote(Id = quoteRecord.Id, Is_Signed__c = false);
      update new Quote(Id = quoteRecord.Id, Is_Signed__c = true);
      System.assertEquals(
        1,
        [SELECT COUNT() FROM Order WHERE Quote__c = :quoteRecord.Id]
      );
    }
  }

  // ------------------------------------------------------ Quote line rules

  @isTest
  static void quoteCannotMixABundleWithItems() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);
      Product2 bundle = TestDataFactory.bundle('Bundle Mix', 'BND-MIX', 1000);
      PricebookEntry bundleEntry = TestDataFactory.standardEntry(
        bundle.Id,
        1000
      );
      PricebookEntry item = itemEntry('ART-MIX', 100);

      TestDataFactory.quoteLine(quoteRecord.Id, item, 1, 100);
      QuoteLineItem bundleLine = new QuoteLineItem(
        QuoteId = quoteRecord.Id,
        PricebookEntryId = bundleEntry.Id,
        Quantity = 1,
        UnitPrice = 1000
      );
      System.assertEquals(
        false,
        Database.insert(bundleLine, false).isSuccess()
      );

      Quote bundleQuote = TestDataFactory.quote(opportunityRecord.Id);
      TestDataFactory.quoteLine(bundleQuote.Id, bundleEntry, 1, 1000);
      QuoteLineItem secondBundle = new QuoteLineItem(
        QuoteId = bundleQuote.Id,
        PricebookEntryId = bundleEntry.Id,
        Quantity = 1,
        UnitPrice = 1000
      );
      System.assertEquals(
        false,
        Database.insert(secondBundle, false).isSuccess()
      );
    }
  }

  @isTest
  static void plusBundleMustBeAlone() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);
      Product2 plusBundle = TestDataFactory.buildBundle(
        'Plus',
        'BND-PLUS',
        500
      );
      plusBundle.Is_Plus__c = true;
      insert plusBundle;
      PricebookEntry plusEntry = TestDataFactory.standardEntry(
        plusBundle.Id,
        500
      );

      QuoteLineItem first = TestDataFactory.quoteLine(
        quoteRecord.Id,
        plusEntry,
        1,
        250
      );
      QuoteLineItem item = new QuoteLineItem(
        QuoteId = quoteRecord.Id,
        PricebookEntryId = itemEntry('ART-PL', 10).Id,
        Quantity = 1,
        UnitPrice = 10
      );
      System.assertEquals(false, Database.insert(item, false).isSuccess());

      first.Quantity = 2;
      update first;
    }
  }

  @isTest
  static void addingOrRemovingLinesReturnsTheQuoteToDraftAndCleansTranches() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);
      update new Quote(Id = quoteRecord.Id, Status = 'In Trattativa');
      Tranche__c trancheRecord = TestDataFactory.tranche(quoteRecord.Id, 1);
      QuoteLineItem line = new QuoteLineItem(
        QuoteId = quoteRecord.Id,
        PricebookEntryId = itemEntry('ART-DR', 50).Id,
        Quantity = 1,
        UnitPrice = 50,
        Tranche__c = trancheRecord.Id
      );
      insert line;
      System.assertEquals(
        'Bozza',
        [SELECT Status FROM Quote WHERE Id = :quoteRecord.Id].Status
      );

      update new Quote(Id = quoteRecord.Id, Status = 'In Trattativa');
      Test.startTest();
      delete line;
      Test.stopTest();

      System.assertEquals(
        'Bozza',
        [SELECT Status FROM Quote WHERE Id = :quoteRecord.Id].Status
      );
      System.assertEquals(
        0,
        [SELECT COUNT() FROM Tranche__c WHERE Id = :trancheRecord.Id]
      );
    }
  }

  // ---------------------------------------------------- product configurator

  @isTest
  static void contextAndSearchFollowTheOpportunityType() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = azienda();
      Opportunity standard = TestDataFactory.opportunity(accountRecord.Id);
      Quote quoteRecord = TestDataFactory.quote(standard.Id);
      PricebookEntry item = itemEntry('ART-SRCH', 100);
      Product2 plusItem = TestDataFactory.buildItem(
        'Plus annuale',
        'PLUS-SRCH'
      );
      plusItem.Is_Plus__c = true;
      plusItem.Numero_Tranche__c = 2;
      insert plusItem;
      TestDataFactory.standardEntry(plusItem.Id, 1200);
      Product2 bundle = TestDataFactory.bundle(
        'Bundle Ricerca',
        'BND-SRCH',
        900
      );
      TestDataFactory.standardEntry(bundle.Id, 0);

      Test.startTest();
      QuoteManageProductsController.QuoteProductsContext context = QuoteManageProductsController.getContext(
        quoteRecord.Id
      );
      List<QuoteManageProductsController.ProductOption> standardOptions = QuoteManageProductsController.searchProducts(
        quoteRecord.Id,
        ''
      );
      List<QuoteManageProductsController.ProductOption> byCode = QuoteManageProductsController.searchProducts(
        quoteRecord.Id,
        'ART-SRCH'
      );
      Opportunity plus = TestDataFactory.opportunity(
        accountRecord.Id,
        'Plus_Attivazione_Rinnovo'
      );
      Quote plusQuote = TestDataFactory.quote(plus.Id);
      List<QuoteManageProductsController.ProductOption> plusOptions = QuoteManageProductsController.searchProducts(
        plusQuote.Id,
        'Plus'
      );
      Opportunity recall = TestDataFactory.opportunity(
        accountRecord.Id,
        'Recall_Tutor'
      );
      List<QuoteManageProductsController.ProductOption> recallOptions = QuoteManageProductsController.searchProducts(
        TestDataFactory.quote(recall.Id).Id,
        null
      );
      Test.stopTest();

      System.assertEquals(true, context.isStandardOpportunity);
      System.assertEquals(false, context.isPlusOpportunity);
      System.assertEquals(true, context.isEditable);
      Set<String> standardCodes = new Set<String>();
      for (
        QuoteManageProductsController.ProductOption option : standardOptions
      ) {
        standardCodes.add(option.productCode);
      }
      System.assert(standardCodes.contains('ART-SRCH'));
      System.assert(standardCodes.contains('BND-SRCH'));
      System.assert(!standardCodes.contains('PLUS-SRCH'));
      System.assertEquals(1, byCode.size());
      System.assertEquals(item.Id, byCode[0].pricebookEntryId);
      for (
        QuoteManageProductsController.ProductOption option : standardOptions
      ) {
        if (option.productCode == 'BND-SRCH') {
          System.assertEquals(
            900,
            option.unitPrice,
            'Bundles sell at their price'
          );
        }
      }
      System.assertEquals(1, plusOptions.size());
      System.assertEquals(true, plusOptions[0].isPlus);
      System.assertEquals(2, plusOptions[0].trancheCount);
      System.assert(
        recallOptions.size() >= 3,
        'Recall sees every product type'
      );
    }
  }

  @isTest
  static void savingItemsCreatesOneLinePerSelection() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);
      PricebookEntry first = itemEntry('ART-S1', 100);
      PricebookEntry second = itemEntry('ART-S2', 40);

      Test.startTest();
      QuoteManageProductsController.saveProducts(
        quoteRecord.Id,
        new List<QuoteManageProductsController.ProductSelection>{
          selection(first.Id, 2),
          selection(second.Id, 1)
        },
        null
      );
      Test.stopTest();

      System.assertEquals(
        240,
        [SELECT Subtotal FROM Quote WHERE Id = :quoteRecord.Id].Subtotal
      );
      QuoteManageProductsController.QuoteProductsContext context = QuoteManageProductsController.getContext(
        quoteRecord.Id
      );
      System.assertEquals(true, context.hasItemLines);
      System.assertEquals(2, context.existingLines.size());
      // Items already present: bundles are no longer offered.
      for (
        QuoteManageProductsController.ProductOption option : QuoteManageProductsController.searchProducts(
          quoteRecord.Id,
          ''
        )
      ) {
        System.assertEquals('Item', option.productType);
      }
    }
  }

  @isTest
  static void saveRefusesInvalidSelections() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = azienda();
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        accountRecord.Id
      );
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);
      PricebookEntry item = itemEntry('ART-BAD', 100);
      Product2 bundleProduct = TestDataFactory.bundle('Bundle', 'BND-BAD', 500);
      PricebookEntry bundleEntry = TestDataFactory.standardEntry(
        bundleProduct.Id,
        0
      );
      Product2 inactive = TestDataFactory.buildItem('Spento', 'ART-OFF');
      insert inactive;
      PricebookEntry inactiveEntry = TestDataFactory.standardEntry(
        inactive.Id,
        10
      );
      inactive.IsActive = false;
      update inactive;
      Product2 plusItem = TestDataFactory.buildItem('Plus', 'PLUS-BAD');
      plusItem.Is_Plus__c = true;
      insert plusItem;
      PricebookEntry plusEntry = TestDataFactory.standardEntry(plusItem.Id, 10);

      List<String> messages = new List<String>{
        expectAuraError(quoteRecord.Id, null, null),
        expectAuraError(
          accountRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(item.Id, 1)
          },
          null
        ),
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(accountRecord.Id, 1)
          },
          null
        ),
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(inactiveEntry.Id, 1)
          },
          null
        ),
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(item.Id, 1),
            selection(bundleEntry.Id, 1)
          },
          null
        ),
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(plusEntry.Id, 1)
          },
          null
        ),
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(item.Id, 0)
          },
          null
        ),
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(bundleEntry.Id, 1)
          },
          null
        )
      };
      System.assertEquals(8, messages.size());
      TestDataFactory.assertContains(messages[7], 'bundle');
    }
  }

  private static Product2 bundleWithComponents(Boolean withTemplates) {
    Product2 bundle = TestDataFactory.bundle('Bundle Stage', 'BND-STG', 1000);
    TestDataFactory.standardEntry(bundle.Id, 0);
    Product2 first = TestDataFactory.item('Modulo A', 'ART-STG-A');
    Product2 second = TestDataFactory.item('Modulo B', 'ART-STG-B');
    TestDataFactory.standardEntry(first.Id, 700);
    TestDataFactory.standardEntry(second.Id, 500);
    Bundle_Tranch__c firstTranch;
    Bundle_Tranch__c secondTranch;
    if (withTemplates) {
      firstTranch = new Bundle_Tranch__c(
        Name = 'Acconto',
        Bundle__c = bundle.Id,
        Sequenza__c = 1,
        Data_Scadenza__c = Date.today().addDays(30)
      );
      secondTranch = new Bundle_Tranch__c(
        Name = 'Saldo',
        Bundle__c = bundle.Id,
        Sequenza__c = 2,
        Data_Scadenza__c = Date.today().addDays(90)
      );
      insert new List<Bundle_Tranch__c>{ firstTranch, secondTranch };
    }
    insert new List<BundleComponent__c>{
      new BundleComponent__c(
        Bundle__c = bundle.Id,
        Product__c = first.Id,
        Quantity__c = 1,
        Spread_Price__c = 600,
        Bundle_Tranch__c = withTemplates ? firstTranch.Id : null
      ),
      new BundleComponent__c(
        Bundle__c = bundle.Id,
        Product__c = second.Id,
        Quantity__c = 2,
        Spread_Price__c = 400,
        Bundle_Tranch__c = withTemplates ? secondTranch.Id : null
      )
    };
    return bundle;
  }

  private static Id bundleEntryId(Id bundleId) {
    return [
      SELECT Id
      FROM PricebookEntry
      WHERE
        Product2Id = :bundleId
        AND Pricebook2Id = :Test.getStandardPricebookId()
    ]
    .Id;
  }

  @isTest
  static void standardBundleExplodesIntoComponentLinesWithTemplateTranches() {
    System.runAs(TestDataFactory.runner()) {
      Product2 bundle = bundleWithComponents(true);
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);

      Test.startTest();
      QuoteManageProductsController.saveProducts(
        quoteRecord.Id,
        new List<QuoteManageProductsController.ProductSelection>{
          selection(bundleEntryId(bundle.Id), 1)
        },
        null
      );
      Test.stopTest();

      List<QuoteLineItem> lines = [
        SELECT Description, UnitPrice, Quantity, Tranche__c, Data_Scadenza__c
        FROM QuoteLineItem
        WHERE QuoteId = :quoteRecord.Id
      ];
      System.assertEquals(2, lines.size());
      for (QuoteLineItem line : lines) {
        System.assertEquals('Bundle: Bundle Stage', line.Description);
        System.assertNotEquals(null, line.Tranche__c);
        System.assertNotEquals(null, line.Data_Scadenza__c);
      }
      List<Tranche__c> tranches = [
        SELECT Name, Importo_Previsto__c, Bundle_Tranch__c
        FROM Tranche__c
        WHERE Quote__c = :quoteRecord.Id
        ORDER BY Sequenza__c
      ];
      System.assertEquals(2, tranches.size());
      System.assertEquals('Acconto', tranches[0].Name);
      System.assertEquals(600, tranches[0].Importo_Previsto__c);
      System.assertEquals(400, tranches[1].Importo_Previsto__c);

      QuoteManageProductsController.QuoteProductsContext context = QuoteManageProductsController.getContext(
        quoteRecord.Id
      );
      System.assertEquals(
        'Bundle Stage',
        context.existingBundleLine.productName
      );
      System.assert(
        QuoteManageProductsController.searchProducts(quoteRecord.Id, '')
          .isEmpty(),
        'A quote holding a bundle offers nothing more'
      );
      TestDataFactory.assertContains(
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(bundleEntryId(bundle.Id), 1)
          },
          null
        ),
        'bundle'
      );
    }
  }

  @isTest
  static void standardBundleWithoutTemplatesCreatesLinesOnly() {
    System.runAs(TestDataFactory.runner()) {
      Product2 bundle = bundleWithComponents(false);
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);

      Test.startTest();
      QuoteManageProductsController.saveProducts(
        quoteRecord.Id,
        new List<QuoteManageProductsController.ProductSelection>{
          selection(bundleEntryId(bundle.Id), 1)
        },
        null
      );
      Test.stopTest();

      System.assertEquals(
        2,
        [SELECT COUNT() FROM QuoteLineItem WHERE QuoteId = :quoteRecord.Id]
      );
      System.assertEquals(
        0,
        [SELECT COUNT() FROM Tranche__c WHERE Quote__c = :quoteRecord.Id]
      );
    }
  }

  @isTest
  static void bundleWithUnassignedComponentIsRefused() {
    System.runAs(TestDataFactory.runner()) {
      Product2 bundle = bundleWithComponents(true);
      BundleComponent__c component = [
        SELECT Id
        FROM BundleComponent__c
        WHERE Bundle__c = :bundle.Id
        LIMIT 1
      ];
      component.Bundle_Tranch__c = null;
      update component;
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);

      String message;
      try {
        QuoteManageProductsController.saveProducts(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(bundleEntryId(bundle.Id), 1)
          },
          null
        );
      } catch (AuraHandledException e) {
        message = e.getMessage();
      }
      System.assertNotEquals(null, message);
    }
  }

  @isTest
  static void bundleWithoutComponentsIsRefused() {
    System.runAs(TestDataFactory.runner()) {
      Product2 bundle = TestDataFactory.bundle('Vuoto', 'BND-EMPTY', 100);
      PricebookEntry entry = TestDataFactory.standardEntry(bundle.Id, 0);
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);

      TestDataFactory.assertContains(
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(entry.Id, 1)
          },
          null
        ),
        'Configura'
      );
    }
  }

  @isTest
  static void plusProductCreatesOneTrancheAndLinePerDueDate() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = azienda();
      Opportunity plus = TestDataFactory.opportunity(
        accountRecord.Id,
        'Plus_Attivazione_Rinnovo'
      );
      Quote quoteRecord = TestDataFactory.quote(plus.Id);
      Product2 plusItem = TestDataFactory.buildItem('Plus 12 mesi', 'PLUS-12');
      plusItem.Is_Plus__c = true;
      plusItem.Numero_Tranche__c = 2;
      insert plusItem;
      PricebookEntry plusEntry = TestDataFactory.standardEntry(
        plusItem.Id,
        300
      );
      List<QuoteManageProductsController.ProductSelection> products = new List<QuoteManageProductsController.ProductSelection>{
        selection(plusEntry.Id, 1)
      };

      TestDataFactory.assertContains(
        expectAuraError(
          quoteRecord.Id,
          products,
          new List<QuoteManageProductsController.TrancheSelection>{
            due(Date.today())
          }
        ),
        'scadenza'
      );
      TestDataFactory.assertContains(
        expectAuraError(
          quoteRecord.Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(itemEntry('ART-NOPLUS', 10).Id, 1)
          },
          null
        ),
        'Plus'
      );

      Test.startTest();
      QuoteManageProductsController.saveProducts(
        quoteRecord.Id,
        products,
        new List<QuoteManageProductsController.TrancheSelection>{
          due(Date.today().addMonths(1)),
          due(Date.today().addMonths(7))
        }
      );
      Test.stopTest();

      List<Tranche__c> tranches = [
        SELECT Sequenza__c, Importo_Previsto__c, Stato__c
        FROM Tranche__c
        WHERE Quote__c = :quoteRecord.Id
        ORDER BY Sequenza__c
      ];
      System.assertEquals(2, tranches.size());
      System.assertEquals(300, tranches[0].Importo_Previsto__c);
      System.assertEquals('Aperta', tranches[1].Stato__c);
      System.assertEquals(
        2,
        [
          SELECT COUNT()
          FROM QuoteLineItem
          WHERE QuoteId = :quoteRecord.Id AND Tranche__c != NULL
        ]
      );
      QuoteManageProductsController.QuoteProductsContext context = QuoteManageProductsController.getContext(
        quoteRecord.Id
      );
      System.assertEquals(true, context.hasPlusLine);
      System.assert(
        QuoteManageProductsController.searchProducts(quoteRecord.Id, '')
          .isEmpty()
      );
      TestDataFactory.assertContains(
        expectAuraError(quoteRecord.Id, products, null),
        'tranche'
      );
    }
  }

  @isTest
  static void plusProductNeedsAValidTrancheCount() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity plus = TestDataFactory.opportunity(
        azienda().Id,
        'Plus_Attivazione_Rinnovo'
      );
      Product2 noCount = TestDataFactory.buildItem('Plus senza', 'PLUS-NOC');
      noCount.Is_Plus__c = true;
      Product2 tooMany = TestDataFactory.buildItem('Plus troppi', 'PLUS-TOO');
      tooMany.Is_Plus__c = true;
      tooMany.Numero_Tranche__c = 30;
      insert new List<Product2>{ noCount, tooMany };

      TestDataFactory.assertContains(
        expectAuraError(
          TestDataFactory.quote(plus.Id).Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(TestDataFactory.standardEntry(noCount.Id, 10).Id, 1)
          },
          null
        ),
        'Numero Tranche'
      );
      TestDataFactory.assertContains(
        expectAuraError(
          TestDataFactory.quote(plus.Id).Id,
          new List<QuoteManageProductsController.ProductSelection>{
            selection(TestDataFactory.standardEntry(tooMany.Id, 10).Id, 1)
          },
          null
        ),
        'tra 1 e 20'
      );
    }
  }

  @isTest
  static void missingPricebooksAreFilledFromTheSelection() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = azienda();
      Opportunity opportunityRecord = new Opportunity(
        Name = 'Senza listino',
        AccountId = accountRecord.Id,
        StageName = 'Qualificato',
        CloseDate = Date.today().addDays(5),
        RecordTypeId = TestDataFactory.recordTypeId(
          'Opportunity',
          'Recall_Tutor'
        )
      );
      insert opportunityRecord;
      Quote quoteRecord = new Quote(
        Name = 'Senza listino',
        OpportunityId = opportunityRecord.Id
      );
      insert quoteRecord;
      PricebookEntry item = itemEntry('ART-PB', 80);

      Test.startTest();
      QuoteManageProductsController.searchProducts(quoteRecord.Id, 'ART');
      QuoteManageProductsController.saveProducts(
        quoteRecord.Id,
        new List<QuoteManageProductsController.ProductSelection>{
          selection(item.Id, 1)
        },
        null
      );
      Test.stopTest();

      System.assertEquals(
        Test.getStandardPricebookId(),
        [SELECT Pricebook2Id FROM Quote WHERE Id = :quoteRecord.Id].Pricebook2Id
      );
      System.assertEquals(
        Test.getStandardPricebookId(),
        [
          SELECT Pricebook2Id
          FROM Opportunity
          WHERE Id = :opportunityRecord.Id
        ]
        .Pricebook2Id
      );
    }
  }

  // ------------------------------------------------------- ageing batch

  @isTest
  static void staleNegotiationsMoveToAwaitingAcceptance() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(azienda().Id);
      Quote stale = TestDataFactory.quote(opportunityRecord.Id);
      Quote fresh = TestDataFactory.quote(opportunityRecord.Id);
      update new List<Quote>{
        new Quote(
          Id = stale.Id,
          Status = 'In Trattativa',
          In_Trattativa_Dal__c = Date.today().addDays(-10)
        ),
        new Quote(
          Id = fresh.Id,
          Status = 'In Trattativa',
          In_Trattativa_Dal__c = Date.today()
        )
      };

      Test.startTest();
      new QuoteNegotiationAgingBatch().execute((SchedulableContext) null);
      Id jobId = QuoteNegotiationAgingBatch.scheduleDaily();
      Test.stopTest();

      System.assertEquals(
        'In Attesa Accettazione',
        [SELECT Status FROM Quote WHERE Id = :stale.Id].Status
      );
      System.assertEquals(
        'In Trattativa',
        [SELECT Status FROM Quote WHERE Id = :fresh.Id].Status
      );
      System.assertNotEquals(null, jobId);
    }
  }
}
