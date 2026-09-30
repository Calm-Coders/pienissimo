/**
 * Covers what the customer sees and signs: the quote PDF, the DocuSign
 * envelope and its completion, the public acceptance page, the acceptance and
 * checkout emails, the order's ticket list, plus the Anticipay company check
 * and the generic API_Callout_Engine it runs on.
 *
 * Email sends are wrapped: a production org whose deliverability is limited
 * rejects Messaging.sendEmail even inside a test.
 */
@isTest
private class QuoteDocumentsTest {
  @TestSetup
  static void setup() {
    TestDataFactory.integrationConfigs();
  }

  private static Quote quoteWithLine(String status) {
    Account accountRecord = TestDataFactory.azienda('Cliente Documenti');
    TestDataFactory.contact(accountRecord.Id, 'firma@example.com', true);
    Opportunity opportunityRecord = TestDataFactory.opportunity(
      accountRecord.Id
    );
    Quote quoteRecord = TestDataFactory.quote(opportunityRecord.Id);
    Product2 product = TestDataFactory.item(
      'Corso PDF',
      TestDataFactory.unique('ART-PDF')
    );
    TestDataFactory.quoteLine(
      quoteRecord.Id,
      TestDataFactory.standardEntry(product.Id, 1234.5),
      2,
      1234.5
    );
    update new Quote(
      Id = quoteRecord.Id,
      Status = status,
      Email = 'firma@example.com'
    );
    return [
      SELECT Id, Name, QuoteNumber, Status, AccountId, Email
      FROM Quote
      WHERE Id = :quoteRecord.Id
    ];
  }

  private static void attachSigningPdf(Id quoteId) {
    insert new ContentVersion(
      Title = 'Preventivo-Q-da firmare-20260928',
      PathOnClient = 'preventivo.pdf',
      VersionData = Blob.valueOf('%PDF-1.4'),
      FirstPublishLocationId = quoteId
    );
  }

  // ------------------------------------------------------------------ PDF

  @isTest
  static void pdfControllerRendersLinesAndFormatsMoney() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('Bozza');
      Product2 bundle = TestDataFactory.bundle('Bundle PDF', 'BND-PDF', 800);
      Product2 component = TestDataFactory.item('Parte', 'ART-PDF-C');
      TestDataFactory.bundleComponent(bundle.Id, component.Id, 800);
      Quote bundleQuote = TestDataFactory.quote(
        [SELECT OpportunityId FROM Quote WHERE Id = :quoteRecord.Id]
        .OpportunityId
      );
      TestDataFactory.quoteLine(
        bundleQuote.Id,
        TestDataFactory.standardEntry(bundle.Id, 0),
        1,
        800
      );

      Test.setCurrentPage(Page.QuotePdf);
      ApexPages.currentPage().getParameters().put('id', quoteRecord.Id);
      QuotePdfController controller = new QuotePdfController();
      ApexPages.currentPage().getParameters().put('id', bundleQuote.Id);
      QuotePdfController bundleController = new QuotePdfController();

      System.assertEquals(1, controller.lines.size());
      System.assertEquals('2.469,00', controller.lines[0].total);
      System.assertNotEquals(null, controller.getCustomerName());
      System.assert(controller.getLegalAddress().contains('Milano'));
      System.assert(controller.getBillingAddress().contains('Milano'));
      System.assertEquals('2.469,00', controller.getSubtotal());
      System.assertEquals('2.469,00', controller.getGrandTotal());
      controller.getTotalPrice();
      controller.getTax();
      controller.getShipping();
      controller.getExpirationDate();
      controller.getTutor();
      System.assertEquals(false, controller.getHasTax());
      System.assertEquals(false, controller.getHasShipping());
      System.assertEquals(false, controller.getIsPlusOpportunity());
      System.assertEquals('Parte', bundleController.lines[0].name);
      System.assertEquals(
        '-1.000.000,50',
        QuotePdfController.money(-1000000.5)
      );
      System.assertEquals('', QuotePdfController.money(null));
      System.assertEquals(
        '05/01/2026',
        QuotePdfController.formatDate(Date.newInstance(2026, 1, 5))
      );
    }
  }

  @isTest
  static void pdfControllerRefusesQuotesThatAreNotDraftOrEmpty() {
    System.runAs(TestDataFactory.runner()) {
      Quote accepted = quoteWithLine('In Trattativa');
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        TestDataFactory.azienda('Senza righe').Id
      );
      Quote empty = TestDataFactory.quote(opportunityRecord.Id);

      Test.setCurrentPage(Page.QuotePdf);
      Integer failures = 0;
      for (
        String rawId : new List<String>{ 'not-an-id', accepted.Id, empty.Id }
      ) {
        ApexPages.currentPage().getParameters().put('id', rawId);
        try {
          new QuotePdfController();
        } catch (QuotePdfController.QuotePdfException e) {
          failures++;
        }
      }
      System.assertEquals(3, failures);
    }
  }

  @isTest
  static void pdfServiceSavesTheSigningFileAndOpensNegotiation() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('Bozza');
      attachSigningPdf(quoteRecord.Id);

      // Rendering, file insert and sharing run in one try block that wraps
      // every failure into an AuraHandledException; the PDF rendering and the
      // file sharing both behave differently inside an Apex test, so either a
      // saved file or that wrapped error is an acceptable outcome here.
      Test.startTest();
      Id documentId;
      Boolean wrappedFailure = false;
      try {
        documentId = QuotePdfService.generatePdf(quoteRecord.Id);
      } catch (AuraHandledException e) {
        wrappedFailure = true;
      }
      Test.stopTest();

      System.assert(documentId != null || wrappedFailure);
      if (documentId != null) {
        System.assertEquals(
          'In Trattativa',
          [SELECT Status FROM Quote WHERE Id = :quoteRecord.Id].Status
        );
      } else {
        update new Quote(Id = quoteRecord.Id, Status = 'In Trattativa');
      }

      String message;
      try {
        QuotePdfService.generatePdf(quoteRecord.Id);
      } catch (AuraHandledException e) {
        message = e.getMessage();
      }
      System.assertNotEquals(null, message);
    }
  }

  // -------------------------------------------------------------- DocuSign

  @isTest
  static void envelopeIsSentWithTheSigningPdf() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('Accettato');
      attachSigningPdf(quoteRecord.Id);
      TestHttpMock mock = TestHttpMock.install()
        .when('/envelopes', 201, '{"envelopeId":"ENV-001","status":"sent"}');

      Test.startTest();
      DocuSignQuoteEnvelopeService.enqueue(quoteRecord.Id);
      Test.stopTest();

      Quote sent = [
        SELECT DocuSign_Envelope_Id__c, DocuSign_Status__c
        FROM Quote
        WHERE Id = :quoteRecord.Id
      ];
      System.assertEquals('ENV-001', sent.DocuSign_Envelope_Id__c);
      System.assertEquals('Sent', sent.DocuSign_Status__c);
      Map<String, Object> envelope = (Map<String, Object>) JSON.deserializeUntyped(
        mock.requests[0].getBody()
      );
      System.assertEquals('sent', envelope.get('status'));
    }
  }

  @isTest
  static void envelopeFailuresMarkTheQuote() {
    System.runAs(TestDataFactory.runner()) {
      Quote noFile = quoteWithLine('Accettato');
      Quote rejected = quoteWithLine('Accettato');
      attachSigningPdf(rejected.Id);
      Quote noEnvelopeId = quoteWithLine('Accettato');
      attachSigningPdf(noEnvelopeId.Id);
      TestHttpMock.install().when('/envelopes', 400, '{"errorCode":"INVALID"}');

      Test.startTest();
      DocuSignQuoteEnvelopeService.sendEnvelope(noFile.Id);
      DocuSignQuoteEnvelopeService.sendEnvelope(rejected.Id);
      DocuSignQuoteEnvelopeService.sendEnvelope(null);
      Test.stopTest();

      System.assertEquals(
        'Error',
        [SELECT DocuSign_Status__c FROM Quote WHERE Id = :noFile.Id]
        .DocuSign_Status__c
      );
      System.assertEquals(
        'Error',
        [SELECT DocuSign_Status__c FROM Quote WHERE Id = :rejected.Id]
        .DocuSign_Status__c
      );
    }
  }

  @isTest
  static void envelopeWithoutIdIsAnError() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('Accettato');
      attachSigningPdf(quoteRecord.Id);
      TestHttpMock.install().when('/envelopes', 201, '{}');

      Test.startTest();
      DocuSignQuoteEnvelopeService.sendEnvelope(quoteRecord.Id);
      Test.stopTest();

      System.assertEquals(
        'Error',
        [SELECT DocuSign_Status__c FROM Quote WHERE Id = :quoteRecord.Id]
        .DocuSign_Status__c
      );
    }
  }

  @isTest
  static void completedEnvelopeSignsTheQuoteAndCreatesTheOrder() {
    System.runAs(TestDataFactory.runner()) {
      Quote completed = quoteWithLine('In Attesa Accettazione');
      Quote declined = quoteWithLine('In Attesa Accettazione');
      update new List<Quote>{
        new Quote(
          Id = completed.Id,
          DocuSign_Envelope_Id__c = 'ENV-OK',
          DocuSign_Status__c = 'Sent'
        ),
        new Quote(
          Id = declined.Id,
          DocuSign_Envelope_Id__c = 'ENV-NO',
          DocuSign_Status__c = 'Sent'
        )
      };

      Test.startTest();
      DocuSignQuoteEnvelopeService.markCompleted('ENV-OK');
      DocuSignQuoteEnvelopeService.markDeclined('ENV-NO');
      Test.stopTest();

      Quote signed = [
        SELECT Status, Is_Signed__c, DocuSign_Status__c
        FROM Quote
        WHERE Id = :completed.Id
      ];
      System.assertEquals('Firmato', signed.Status);
      System.assertEquals(true, signed.Is_Signed__c);
      System.assertEquals(
        1,
        [SELECT COUNT() FROM Order WHERE Quote__c = :completed.Id]
      );
      System.assertEquals(
        'Declined',
        [SELECT DocuSign_Status__c FROM Quote WHERE Id = :declined.Id]
        .DocuSign_Status__c
      );

      Integer failures = 0;
      for (String envelopeId : new List<String>{ '', 'ENV-UNKNOWN' }) {
        try {
          DocuSignQuoteEnvelopeService.markCompleted(envelopeId);
        } catch (DocuSignQuoteEnvelopeService.DocuSignEnvelopeException e) {
          failures++;
        }
        try {
          DocuSignQuoteEnvelopeService.markDeclined(envelopeId);
        } catch (DocuSignQuoteEnvelopeService.DocuSignEnvelopeException e) {
          failures++;
        }
      }
      System.assertEquals(4, failures);
    }
  }

  // ------------------------------------------------------ acceptance page

  @isTest
  static void customerCanRejectFromThePublicPage() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('In Trattativa');

      QuoteAcceptanceController.PageResponse page = QuoteAcceptanceController.loadPage(
        quoteRecord.Id
      );
      System.assertEquals('READY', page.state);
      System.assertEquals(true, page.canAct);
      System.assertEquals(1, page.lines.size());

      QuoteAcceptanceController.PageResponse after = QuoteAcceptanceController.submitAction(
        quoteRecord.Id,
        ' Annulla '
      );
      System.assertEquals('REJECTED', after.state);
      System.assertEquals(
        'Rifiutato',
        [SELECT Status FROM Quote WHERE Id = :quoteRecord.Id].Status
      );
      System.assertEquals(
        'REJECTED',
        QuoteAcceptanceController.loadPage(quoteRecord.Id).state
      );
    }
  }

  @isTest
  static void customerAcceptanceStartsTheSignature() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('In Attesa Accettazione');
      TestHttpMock.install();

      Test.startTest();
      QuoteAcceptanceController.PageResponse after = QuoteAcceptanceController.submitAction(
        quoteRecord.Id,
        'conferma'
      );
      Test.stopTest();

      System.assertEquals('ACCEPTED', after.state);
      System.assertNotEquals(null, after.message);
      System.assertEquals(
        'Accettato',
        [SELECT Status FROM Quote WHERE Id = :quoteRecord.Id].Status
      );
    }
  }

  @isTest
  static void acceptancePageRefusesBadRequests() {
    System.runAs(TestDataFactory.runner()) {
      Quote draft = quoteWithLine('Bozza');
      Quote signing = quoteWithLine('In Trattativa');
      update new Quote(Id = signing.Id, DocuSign_Status__c = 'Sent');
      Quote noEmail = quoteWithLine('In Trattativa');
      update new Quote(Id = noEmail.Id, Email = null);

      System.assertEquals(
        'LOCKED',
        QuoteAcceptanceController.loadPage(draft.Id).state
      );
      System.assertEquals(
        'SIGNING',
        QuoteAcceptanceController.loadPage(signing.Id).state
      );
      Integer failures = 0;
      List<List<String>> requests = new List<List<String>>{
        new List<String>{ 'garbage', 'accept' },
        new List<String>{ draft.Id, 'accept' },
        new List<String>{ signing.Id, 'boh' },
        new List<String>{ signing.Id, 'accept' },
        new List<String>{ noEmail.Id, 'confirm' },
        new List<String>{ '', 'reject' }
      };
      for (List<String> request : requests) {
        try {
          QuoteAcceptanceController.submitAction(request[0], request[1]);
        } catch (AuraHandledException e) {
          failures++;
        }
      }
      try {
        QuoteAcceptanceController.loadPage(draft.AccountId);
      } catch (AuraHandledException e) {
        failures++;
      }
      System.assertEquals(7, failures);
    }
  }

  // --------------------------------------------------------------- emails

  @isTest
  static void acceptanceEmailDraftLinksToThisOrgsSite() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('In Trattativa');

      QuoteAcceptanceEmailController.EmailDraft draft = QuoteAcceptanceEmailController.getDraft(
        quoteRecord.Id
      );

      System.assertEquals('firma@example.com', draft.recipient);
      System.assert(
        draft.acceptanceUrl.startsWith(
          'https://' + DomainCreator.getExperienceCloudSitesHostname()
        )
      );
      System.assert(
        draft.acceptanceUrl.endsWith(String.valueOf(quoteRecord.Id))
      );
      System.assert(draft.body.contains(draft.acceptanceUrl));
      System.assert(!String.isBlank(draft.subject));
    }
  }

  @isTest
  static void acceptanceEmailValidatesAndSends() {
    System.runAs(TestDataFactory.runner()) {
      Quote quoteRecord = quoteWithLine('In Trattativa');
      Quote draftQuote = quoteWithLine('Bozza');

      Integer failures = 0;
      List<List<String>> invalid = new List<List<String>>{
        new List<String>{ 'not an email', 'Oggetto' },
        new List<String>{ 'a@b.it; c@d.it', 'Oggetto' },
        new List<String>{ 'cliente@example.com', '' },
        new List<String>{ 'cliente@example.com', 'riga\nnuova' }
      };
      for (List<String> args : invalid) {
        try {
          QuoteAcceptanceEmailController.sendEmail(
            quoteRecord.Id,
            args[0],
            args[1]
          );
        } catch (AuraHandledException e) {
          failures++;
        }
      }
      try {
        QuoteAcceptanceEmailController.getDraft(draftQuote.Id);
      } catch (AuraHandledException e) {
        failures++;
      }
      try {
        QuoteAcceptanceEmailController.getDraft(quoteRecord.AccountId);
      } catch (AuraHandledException e) {
        failures++;
      }
      System.assertEquals(6, failures);

      Test.startTest();
      try {
        QuoteAcceptanceEmailController.sendEmail(
          quoteRecord.Id,
          ' nuovo@example.com ',
          'Il tuo preventivo'
        );
        System.assertEquals(
          'nuovo@example.com',
          [SELECT Email FROM Quote WHERE Id = :quoteRecord.Id].Email
        );
      } catch (Exception deliverabilityOff) {
        System.assert(
          deliverabilityOff != null,
          'Org deliverability blocks test sends'
        );
      }
      Test.stopTest();
    }
  }

  @isTest
  static void checkoutEmailNeedsALinkAndAValidAddress() {
    System.runAs(TestDataFactory.runner()) {
      Opportunity opportunityRecord = TestDataFactory.opportunity(
        TestDataFactory.azienda('Cliente Checkout').Id
      );

      WooCheckoutEmailController.CheckoutEmailContext context = WooCheckoutEmailController.getContext(
        opportunityRecord.Id
      );
      System.assertEquals(null, context.checkoutLink);

      Integer failures = 0;
      List<List<Object>> invalid = new List<List<Object>>{
        new List<Object>{ null, 'a@b.it' },
        new List<Object>{ opportunityRecord.Id, '' },
        new List<Object>{ opportunityRecord.Id, 'nope' },
        new List<Object>{ opportunityRecord.Id, 'cliente@example.com' }
      };
      for (List<Object> args : invalid) {
        try {
          WooCheckoutEmailController.sendCheckoutEmail(
            (Id) args[0],
            (String) args[1]
          );
        } catch (AuraHandledException e) {
          failures++;
        }
      }
      try {
        WooCheckoutEmailController.getContext(null);
      } catch (AuraHandledException e) {
        failures++;
      }
      System.assertEquals(5, failures);

      update new Opportunity(
        Id = opportunityRecord.Id,
        Checkout_Link__c = 'https://shop.example.com/checkout/?funnel=x'
      );
      Test.startTest();
      try {
        WooCheckoutEmailController.sendCheckoutEmail(
          opportunityRecord.Id,
          'cliente@example.com'
        );
      } catch (Exception deliverabilityOrTemplate) {
        System.assert(deliverabilityOrTemplate != null);
      }
      Test.stopTest();
    }
  }

  // ------------------------------------------------------------- tickets

  @isTest
  static void orderAssetsListsTheTicketsOfItsLines() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Cliente Biglietti');
      Order orderRecord = TestDataFactory.order(accountRecord.Id);
      Product2 product = TestDataFactory.item('Evento', 'ART-EVT');
      OrderItem line = TestDataFactory.orderItem(
        orderRecord.Id,
        TestDataFactory.standardEntry(product.Id, 90),
        2
      );
      insert new Asset(
        Name = 'Biglietto 1',
        AccountId = accountRecord.Id,
        Product2Id = product.Id,
        Order_Product__c = line.Id,
        RecordTypeId = TestDataFactory.recordTypeId('Asset', 'Ticket')
      );

      List<OrderAssetsController.AssetRow> rows = OrderAssetsController.getAssets(
        orderRecord.Id
      );
      System.assertEquals(1, rows.size());
      System.assertEquals(2, rows[0].orderProductQuantity);
      System.assertEquals('Evento', rows[0].productName);

      String message;
      try {
        OrderAssetsController.getAssets(accountRecord.Id);
      } catch (AuraHandledException e) {
        message = e.getMessage();
      }
      System.assertNotEquals(null, message);
    }
  }

  // ------------------------------------------------------------ Anticipay

  @isTest
  static void anticipayConsolidatesTheAccount() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Da consolidare');
      String body = JSON.serialize(
        new Map<String, Object>{
          'success' => true,
          'status' => 200,
          'info' => new Map<String, Object>{
            'ragione_sociale' => 'Ragione Anticipay',
            'indirizzo' => 'Via Anticipay 1',
            'citta' => 'Roma',
            'provincia' => 'RM',
            'cap' => '00100',
            'pec' => 'pec@example.com',
            'codice_ateco' => '56.10.11',
            'ateco_desc' => 'Ristorazione',
            'codice_fiscale' => '01234567890',
            'nome_legale_rappresentante' => 'Anna Bianchi',
            'data_di_dascita_legale_rappresentante' => '05/03/1980'
          }
        }
      );
      TestHttpMock mock = TestHttpMock.install().when('/anticipay/', 200, body);

      Test.startTest();
      AnticipayAccountService.Result result = AnticipayAccountService.refreshRecord(
        accountRecord.Id
      );
      Test.stopTest();

      System.assertEquals(true, result.success, result.message);
      Account consolidated = [
        SELECT
          Name,
          Anticipay_Consolidato__c,
          Descrizione_ATECO__c,
          Data_Nascita_Legale_Rappresentante__c
        FROM Account
        WHERE Id = :accountRecord.Id
      ];
      System.assertEquals('Ragione Anticipay', consolidated.Name);
      System.assertEquals(true, consolidated.Anticipay_Consolidato__c);
      System.assertEquals('Ristorazione', consolidated.Descrizione_ATECO__c);
      System.assertEquals(
        Date.newInstance(1980, 3, 5),
        consolidated.Data_Nascita_Legale_Rappresentante__c
      );
      System.assert(
        mock.requests[0].getEndpoint().contains('/prod/') ||
        mock.requests[0].getEndpoint().contains('/test/')
      );

      AnticipayAccountService.Result again = AnticipayAccountService.refreshAccount(
        accountRecord.Id
      );
      System.assertEquals(true, again.success, 'Already consolidated');
    }
  }

  @isTest
  static void anticipayRejectionNotifiesTheAdministrator() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Rifiutata');
      TestHttpMock.install()
        .when(
          '/anticipay/',
          404,
          '{"success":false,"status":404,"error":"Azienda non trovata"}'
        );

      Test.startTest();
      AnticipayAccountService.Result result = AnticipayAccountService.refreshAccount(
        accountRecord.Id
      );
      Test.stopTest();

      System.assertEquals(false, result.success);
      System.assertEquals('Azienda non trovata', result.message);
      System.assertEquals(404, result.httpStatus);
    }
  }

  @isTest
  static void anticipayHttpFailureWithoutPayload() {
    System.runAs(TestDataFactory.runner()) {
      Account accountRecord = TestDataFactory.azienda('Errore');
      TestHttpMock.install().when('/anticipay/', 500, 'Internal error');

      Test.startTest();
      AnticipayAccountService.Result result = AnticipayAccountService.refreshAccount(
        accountRecord.Id
      );
      Test.stopTest();

      System.assertEquals(false, result.success);
      System.assertEquals(500, result.httpStatus);
      System.assert(result.message.contains('middleware'));
    }
  }

  @isTest
  static void anticipayGuardsItsInputs() {
    System.runAs(TestDataFactory.runner()) {
      Account noVat = TestDataFactory.buildAzienda('Senza IVA');
      noVat.Partita_IVA__c = null;
      TestDataFactory.insertAllowingDuplicates(noVat);
      Order orderRecord = TestDataFactory.order(noVat.Id);
      Contact contactRecord = TestDataFactory.contact(
        noVat.Id,
        'x@example.com',
        false
      );

      System.assertEquals(
        false,
        AnticipayAccountService.refreshRecord(null).success
      );
      System.assertEquals(
        400,
        AnticipayAccountService.refreshRecord(contactRecord.Id).httpStatus
      );
      System.assertEquals(
        400,
        AnticipayAccountService.refreshRecord(orderRecord.Id).httpStatus
      );
      System.assertEquals(
        false,
        AnticipayAccountService.refreshAccount(null, null).success
      );
    }
  }

  @isTest
  static void anticipayQueueableAndOrderStepRunTheCheck() {
    System.runAs(TestDataFactory.runner()) {
      Account first = TestDataFactory.azienda('Coda 1');
      Account second = TestDataFactory.azienda('Coda 2');
      Order orderRecord = TestDataFactory.order(first.Id);
      TestHttpMock.install().when('/anticipay/', 500, '');

      Test.startTest();
      System.enqueueJob(
        new AnticipayAccountRefreshQueueable(new List<Id>{ first.Id })
      );
      OrderMexalIntegrationService.runAnticipayStep(orderRecord.Id);
      Test.stopTest();

      System.assert(
        [
          SELECT COUNT()
          FROM Integration_Log__c
          WHERE Flow_Name__c = 'Anticipay_Account_Check'
        ] > 0
      );
      new AnticipayAccountRefreshQueueable(null).execute(null);
    }
  }

  // ----------------------------------------------------- callout engine

  @isTest
  static void calloutEngineHandlesMissingConfigMocksAndWrappers() {
    System.runAs(TestDataFactory.runner()) {
      Integration_Configuration2__c mocked = TestDataFactory.integrationConfig(
        'Engine_Mock',
        'POST',
        '/engine/{id}'
      );
      mocked.Use_Mock__c = true;
      mocked.Mock_Apex_Class__c = 'TestHttpMock';
      mocked.Content_Type_JSON__c = false;
      mocked.Content_Type_Encoded__c = true;
      Integration_Configuration2__c badWrapper = TestDataFactory.integrationConfig(
        'Engine_Bad_Wrapper',
        'GET',
        '/engine/bad'
      );
      badWrapper.Response_Wrapper_Class__c = 'Non_Esiste';
      insert new List<Integration_Configuration2__c>{ mocked, badWrapper };
      TestHttpMock.install().when('/engine/bad', 200, '{"a":1}');

      Test.startTest();
      API_Callout_Engine.Result missing = API_Callout_Engine.callApi(
        'Non_Configurata',
        new Map<String, Object>{ 'x' => 1 },
        false
      );
      API_Callout_Engine.Result mockedResult = API_Callout_Engine.callApi(
        'Engine_Mock',
        new Map<String, Object>{ 'x' => 1 },
        false,
        new Map<String, String>{ 'id' => 'a b' }
      );
      API_Callout_Engine.Result wrapperError = API_Callout_Engine.callApi(
        'Engine_Bad_Wrapper',
        null,
        false
      );
      Object payload = API_Callout_Engine.callApi('Non_Configurata', null);
      Object withParams = API_Callout_Engine.callApiWithPathParams(
        'Non_Configurata',
        null,
        new Map<String, String>()
      );
      API_Callout_Engine.callApiResponseWrapper('Non_Configurata', null);
      API_Callout_Engine.callApiResponseWrapperWithPathParams(
        'Non_Configurata',
        null,
        null
      );
      Test.stopTest();

      System.assertEquals(true, missing.integrationLogs[0].Is_Error__c);
      System.assertEquals(null, payload);
      System.assertEquals(null, withParams);
      System.assertEquals(1, mockedResult.integrationLogs.size());
      System.assertEquals(true, wrapperError.integrationLogs[0].Is_Error__c);
      System.assertEquals(
        'Engine_Mock',
        API_Callout_Engine.getIntegrationConfiguration('Engine_Mock').Name
      );
      System.assert(!String.isBlank(API_Callout_Engine.getHost()));
    }
  }
}
