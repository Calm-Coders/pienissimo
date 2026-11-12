/**
 * Covers OrderPdfService: the contract classification captured at the
 * WooCommerce import, the order guards, the Visualforce controller behind the
 * order PDF, the stored PDF and the queueable entry point.
 */
@isTest
private class OrderPdfServiceTest {
  private static Order wooOrder(String pdfType, String productCategory) {
    TestDataFactory.activateStandardPricebook();
    Product2 product = TestDataFactory.buildItem(
      TestDataFactory.unique('Corso PDF'),
      TestDataFactory.unique('SC-PDF')
    );
    product.Categoria_Articolo__c = productCategory;
    insert product;
    PricebookEntry entry = TestDataFactory.standardEntry(product.Id, 100);
    Account customer = TestDataFactory.azienda('Cliente Ordine PDF');
    Order orderRecord = TestDataFactory.order(customer.Id);
    orderRecord.Origine__c = 'WooCommerce';
    orderRecord.Contract_Pdf_Type__c = pdfType;
    update orderRecord;
    OrderItem line = TestDataFactory.orderItem(orderRecord.Id, entry, 2);
    line.Prezzo_Listino__c = 120;
    update line;
    return orderRecord;
  }

  @isTest
  static void classifyRecognisesItemsBundlesAndPlus() {
    System.runAs(TestDataFactory.runner()) {
      Product2 item = TestDataFactory.item('Corso singolo', 'SC-CLS-1');
      System.assertEquals(
        OrderPdfService.ITEM,
        OrderPdfService.classify(new Set<Id>{ item.Id })
      );

      Product2 bundle = TestDataFactory.bundle('Bundle PDF', 'BND-CLS', 500);
      Product2 part = TestDataFactory.item('Parte bundle', 'SC-CLS-2');
      TestDataFactory.bundleComponent(bundle.Id, part.Id, 500);
      System.assertEquals(
        OrderPdfService.BUNDLE,
        OrderPdfService.classify(new Set<Id>{ bundle.Id })
      );

      Product2 plus = TestDataFactory.buildItem('Plus attivazione', 'SC-PLUS');
      plus.Categoria_Articolo__c = 'C10';
      insert plus;
      System.assertEquals(
        OrderPdfService.PLUS,
        OrderPdfService.classify(new Set<Id>{ plus.Id })
      );

      // A bundle holding a Plus component is itself a Plus purchase.
      Product2 plusBundle = TestDataFactory.bundle(
        'Bundle Plus',
        'BND-PLUS',
        900
      );
      Product2 plusPart = TestDataFactory.buildItem('Parte Plus', 'SC-PLUS-2');
      plusPart.Categoria_Articolo__c = 'C11';
      insert plusPart;
      TestDataFactory.bundleComponent(plusBundle.Id, plusPart.Id, 900);
      System.assertEquals(
        OrderPdfService.PLUS,
        OrderPdfService.classify(new Set<Id>{ plusBundle.Id })
      );
    }
  }

  @isTest
  static void classifyRejectsInvalidSelections() {
    System.runAs(TestDataFactory.runner()) {
      Product2 item = TestDataFactory.item('Corso A', 'SC-ERR-1');
      Product2 plus = TestDataFactory.buildItem('Plus B', 'SC-ERR-2');
      plus.Categoria_Articolo__c = 'C10';
      insert plus;
      Product2 gone = TestDataFactory.item('Corso cancellato', 'SC-ERR-3');
      delete gone;

      List<Set<Id>> invalid = new List<Set<Id>>{
        null,
        new Set<Id>(),
        new Set<Id>{ gone.Id },
        new Set<Id>{ item.Id, plus.Id }
      };
      for (Set<Id> selection : invalid) {
        try {
          OrderPdfService.classify(selection);
          System.assert(false, 'The selection must be rejected.');
        } catch (OrderPdfService.ClassificationException expected) {
          System.assertNotEquals(null, expected.getMessage());
        }
      }
    }
  }

  @isTest
  static void requireWooCommerceOrderGuardsTheOrder() {
    System.runAs(TestDataFactory.runner()) {
      Order valid = wooOrder('Item', null);
      System.assertEquals(
        valid.Id,
        OrderPdfService.requireWooCommerceOrder(valid.Id).Id
      );

      Order notWoo = [SELECT Id FROM Order WHERE Id = :valid.Id];
      notWoo.Origine__c = 'Salesforce';
      update notWoo;
      Order noType = wooOrder(null, null);
      Account customer = TestDataFactory.azienda('Cliente Vuoto');
      Order noLines = TestDataFactory.order(customer.Id);
      noLines.Origine__c = 'WooCommerce';
      noLines.Contract_Pdf_Type__c = 'Item';
      update noLines;

      List<Id> invalid = new List<Id>{
        null,
        customer.Id,
        notWoo.Id,
        noType.Id,
        noLines.Id
      };
      for (Id orderId : invalid) {
        try {
          OrderPdfService.requireWooCommerceOrder(orderId);
          System.assert(false, 'The order must be rejected.');
        } catch (OrderPdfService.OrderPdfException expected) {
          System.assertNotEquals(null, expected.getMessage());
        }
      }
    }
  }

  @isTest
  static void controllerRendersTheOrderForThePdfPage() {
    System.runAs(TestDataFactory.runner()) {
      Order orderRecord = wooOrder('Plus', 'C11');
      Test.setCurrentPage(Page.QuotePdf);
      ApexPages.currentPage().getParameters().put('id', orderRecord.Id);

      OrderPdfService controller = new OrderPdfService();

      System.assertEquals(1, controller.lines.size());
      System.assertEquals(
        'Cliente Ordine PDF',
        controller.getCustomerName().left(18)
      );
      System.assertEquals(true, controller.getIsPlusOpportunity());
      System.assertEquals(true, controller.getIsPerformancePlusRenewal());
      System.assertNotEquals(null, controller.getLegalAddress());
      System.assertNotEquals(null, controller.getBillingAddress());
      System.assertNotEquals(null, controller.getListPriceTotal());
      System.assertNotEquals(null, controller.getDiscountTotal());
      System.assertEquals(
        controller.getTotalPrice(),
        controller.getGrandTotal()
      );
      System.assertNotEquals(null, controller.getTutor());
      System.assertEquals(2, controller.lines[0].quantity);
      System.assertNotEquals(null, controller.lines[0].listPrice);
      System.assertNotEquals(null, controller.lines[0].total);
    }
  }

  @isTest
  static void controllerRejectsAnInvalidOrderId() {
    System.runAs(TestDataFactory.runner()) {
      Test.setCurrentPage(Page.QuotePdf);
      ApexPages.currentPage().getParameters().put('id', 'not-an-id');
      try {
        new OrderPdfService();
        System.assert(false, 'An invalid id must be rejected.');
      } catch (OrderPdfService.OrderPdfException expected) {
        System.assertEquals('Ordine non valido.', expected.getMessage());
      }
    }
  }

  // Visualforce rendering (getContentAsPDF) is not allowed in Apex tests, so
  // the stored contract is created directly under the title the service uses.
  private static Id storedContract(Id orderId) {
    String orderNumber = [SELECT OrderNumber FROM Order WHERE Id = :orderId]
    .OrderNumber;
    ContentVersion file = new ContentVersion(
      Title = 'Contratto-Ordine-' + orderNumber,
      PathOnClient = 'contratto.pdf',
      VersionData = Blob.valueOf('pdf'),
      FirstPublishLocationId = orderId
    );
    insert file;
    return [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :file.Id]
    .ContentDocumentId;
  }

  @isTest
  static void generatePdfReturnsTheStoredContractWithoutRenderingAgain() {
    System.runAs(TestDataFactory.runner()) {
      Order orderRecord = wooOrder('Item', null);
      Id stored = storedContract(orderRecord.Id);

      System.assertEquals(stored, OrderPdfService.generatePdf(orderRecord.Id));
      System.assertEquals(stored, OrderPdfService.generatePdf(orderRecord.Id));
      System.assertEquals(
        1,
        [
          SELECT COUNT()
          FROM ContentDocumentLink
          WHERE LinkedEntityId = :orderRecord.Id
        ]
      );
    }
  }

  @isTest
  static void generatePdfReportsAHandledErrorForANonWooCommerceOrder() {
    System.runAs(TestDataFactory.runner()) {
      Account customer = TestDataFactory.azienda('Cliente Salesforce');
      Order orderRecord = TestDataFactory.order(customer.Id);
      try {
        OrderPdfService.generatePdf(orderRecord.Id);
        System.assert(false, 'Only WooCommerce orders have an order PDF.');
      } catch (AuraHandledException expected) {
        System.assert(
          expected.getMessage().contains('Generazione PDF ordine non riuscita')
        );
      }
    }
  }

  @isTest
  static void queueableLogsAFailureAndLeavesAStoredContractAlone() {
    System.runAs(TestDataFactory.runner()) {
      Order orderRecord = wooOrder('Item', null);
      storedContract(orderRecord.Id);
      Account customer = TestDataFactory.azienda('Cliente Log');
      Order rejected = TestDataFactory.order(customer.Id);

      Test.startTest();
      new OrderPdfService(orderRecord.Id).execute(null);
      new OrderPdfService(rejected.Id).execute(null);
      Test.stopTest();

      System.assertEquals(
        1,
        [
          SELECT COUNT()
          FROM ContentDocumentLink
          WHERE LinkedEntityId = :orderRecord.Id
        ]
      );
      Integration_Log__c failure = [
        SELECT Is_Error__c, Exception_Message__c
        FROM Integration_Log__c
        WHERE Flow_Name__c = 'OrderPdfService.generatePdf'
      ];
      System.assertEquals(true, failure.Is_Error__c);
      System.assert(
        failure.Exception_Message__c.contains(String.valueOf(rejected.Id))
      );
    }
  }
}
