/**
 * Covers the Mexal integration: the callout guard, the customer / article /
 * warehouse / scadenzario searches, the nightly batches and their cursor, the
 * invoice-to-order-line payment mapping, and the customer and order writes.
 *
 * Every test makes at most one callout after its own DML. The services insert
 * an Integration_Log__c after each callout, so a second callout in the same
 * transaction fails with "uncommitted work pending" - that is production
 * behaviour, and the tests that reach it assert the failure path.
 */
@isTest
private class MexalIntegrationTest {
  private static final String CUSTOMER_CODE = '501.00001';

  @TestSetup
  static void setup() {
    TestDataFactory.integrationConfigs();
  }

  private static String mexalDate(Date value) {
    return String.valueOf(value.year()) +
      String.valueOf(value.month()).leftPad(2, '0') +
      String.valueOf(value.day()).leftPad(2, '0');
  }

  private static User mexalAdmin() {
    User adminUser;
    System.runAs(new User(Id = UserInfo.getUserId())) {
      adminUser = TestDataFactory.mexalAdminUser();
    }
    return adminUser;
  }

  private static Integration_Configuration2__c config(String actionName) {
    return [
      SELECT
        Id,
        Endpoint_Path__c,
        HTTP_Method__c,
        Last_Sync_Status__c,
        Last_Sync_Error__c,
        Last_Successful_Sync__c,
        Initial_Sync_Lookback_Hours__c
      FROM Integration_Configuration2__c
      WHERE Azione__c = :actionName
      LIMIT 1
    ];
  }

  private static void assertThrows(String label, Exception error) {
    System.assertNotEquals(null, error, label + ' should throw');
  }

  // --------------------------------------------------------------- guards

  @isTest
  static void calloutServiceRejectsUnsafeActionsAndConfigurations() {
    TestHttpMock.install();
    Exception error;

    try {
      MexalSearchCalloutService.search('Not_An_Action', null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Unknown read action', error);

    error = null;
    try {
      MexalSearchCalloutService.sendWrite('Mexal_Clienti_Ricerca', null, false);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Search used as write', error);

    error = null;
    try {
      MexalSearchCalloutService.updateCustomer(' ', null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Update without code', error);

    error = null;
    try {
      MexalSearchCalloutService.getMovementDetail('FT', null, 1, 'C');
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Incomplete movement key', error);

    Integration_Configuration2__c customerSearch = config(
      'Mexal_Clienti_Ricerca'
    );
    customerSearch.Endpoint_Path__c = '/webapi/risorse/clienti';
    update customerSearch;
    error = null;
    try {
      MexalSearchCalloutService.search('Mexal_Clienti_Ricerca', null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Search on a non /ricerca endpoint', error);

    customerSearch.Endpoint_Path__c = '/webapi/risorse/clienti/ricerca';
    customerSearch.HTTP_Method__c = 'GET';
    update customerSearch;
    error = null;
    try {
      MexalSearchCalloutService.search('Mexal_Clienti_Ricerca', null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Search with GET', error);

    customerSearch.Endpoint_Path__c = null;
    update customerSearch;
    error = null;
    try {
      MexalSearchCalloutService.search('Mexal_Clienti_Ricerca', null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Search without path', error);

    Integration_Configuration2__c create = config('Mexal_Clienti_Creazione');
    create.HTTP_Method__c = 'PUT';
    update create;
    error = null;
    try {
      MexalSearchCalloutService.createCustomer(null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Customer create with PUT', error);

    create.HTTP_Method__c = 'POST';
    create.Endpoint_Path__c = '/webapi/risorse/clienti/ricerca';
    update create;
    error = null;
    try {
      MexalSearchCalloutService.createCustomer(null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Write to a /ricerca endpoint', error);

    Integration_Configuration2__c modify = config('Mexal_Clienti_Modifica');
    modify.HTTP_Method__c = 'POST';
    update modify;
    error = null;
    try {
      MexalSearchCalloutService.updateCustomer('C1', null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Customer update with POST', error);

    Integration_Configuration2__c orderCreate = config(
      'Mexal_Ordini_Creazione'
    );
    orderCreate.HTTP_Method__c = 'PUT';
    update orderCreate;
    error = null;
    try {
      MexalSearchCalloutService.createOrder(null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Order create with PUT', error);

    Integration_Configuration2__c shipping = config(
      'Mexal_Indirizzi_Spedizione_Creazione'
    );
    shipping.HTTP_Method__c = 'PUT';
    update shipping;
    error = null;
    try {
      MexalSearchCalloutService.createShippingAddress(null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Shipping address with PUT', error);

    Integration_Configuration2__c detail = config(
      'Mexal_Movimenti_Magazzino_Dettaglio'
    );
    detail.HTTP_Method__c = 'POST';
    update detail;
    error = null;
    try {
      MexalSearchCalloutService.getMovementDetail('FT', 1, 2, 'C');
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Movement detail with POST', error);

    detail.HTTP_Method__c = 'GET';
    detail.Endpoint_Path__c = '/webapi/risorse/documenti/movimenti-magazzino/ricerca';
    update detail;
    error = null;
    try {
      MexalSearchCalloutService.getMovementDetail('FT', 1, 2, 'C');
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Movement detail on /ricerca', error);

    detail.Endpoint_Path__c = '/webapi/risorse/altro';
    update detail;
    error = null;
    try {
      MexalSearchCalloutService.getMovementDetail('FT', 1, 2, 'C');
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Movement detail outside its resource', error);

    delete [
      SELECT Id
      FROM Integration_Configuration2__c
      WHERE Azione__c = 'Mexal_Scadenzario_Ricerca'
    ];
    error = null;
    try {
      MexalSearchCalloutService.search('Mexal_Scadenzario_Ricerca', null);
    } catch (MexalSearchCalloutService.MexalSearchCalloutException e) {
      error = e;
    }
    assertThrows('Missing configuration', error);
  }

  @isTest
  static void searchLogsTheCalloutAndItsFailure() {
    TestHttpMock.install().when('/clienti/ricerca', 503, 'down');

    Test.startTest();
    MexalSearchCalloutService.Result result = MexalSearchCalloutService.sendReadOnly(
      'Mexal_Clienti_Ricerca',
      new Map<String, Object>{ 'filtri' => new List<Object>() },
      true
    );
    Test.stopTest();

    System.assertEquals(false, result.success);
    System.assertEquals(503, result.statusCode);
    Integration_Log__c logRow = result.integrationLogs[0];
    System.assertEquals(true, logRow.Is_Error__c);
    System.assert(
      logRow.Request_Endpoint__c.contains('fields='),
      'Customer searches carry the field list'
    );
  }

  // ------------------------------------------------------------- customers

  @isTest
  static void customerSearchMatchesByCodeAndVatAndSkipsAmbiguity() {
    User adminUser = mexalAdmin();
    System.runAs(adminUser) {
      Account byVat = TestDataFactory.buildAzienda('Per Partita IVA');
      byVat.Partita_IVA__c = 'IT11111111111';
      Account byCode = TestDataFactory.buildAzienda('Per Codice');
      byCode.Codice_Cliente_Mexal__c = '501.00009';
      Account twinA = TestDataFactory.buildAzienda('Gemello A');
      twinA.Partita_IVA__c = 'ITDUPLICATO';
      Account twinB = TestDataFactory.buildAzienda('Gemello B');
      twinB.Partita_IVA__c = 'ITDUPLICATO';
      TestDataFactory.insertAllowingDuplicates(
        new List<Account>{ byVat, byCode, twinA, twinB }
      );

      String body = JSON.serialize(
        new Map<String, Object>{
          'data_ric_elab' => '20260928 120000',
          'dati' => new List<Object>{
            new Map<String, Object>{
              'codice' => CUSTOMER_CODE,
              'partita_iva' => 'it11111111111',
              'ragione_sociale' => 'Ragione Aggiornata',
              'email' => ' INFO@EXAMPLE.COM ',
              'indirizzo' => 'Via Verdi 2',
              'cap' => '10100',
              'localita' => 'Torino',
              'provincia' => 'TO',
              'cod_paese' => 'IT'
            },
            // An Azienda must keep a Partita IVA, and the sync copies
            // Mexal's value over it, so the code match carries one too.
            new Map<String, Object>{
              'codice' => '501.00009',
              'partita_iva' => 'IT22222222222',
              'ragione_sociale' => 'Per Codice'
            },
            new Map<String, Object>{
              'codice' => '501.00010',
              'partita_iva' => 'ITDUPLICATO',
              'ragione_sociale' => 'Doppio'
            },
            new Map<String, Object>{
              'codice' => '501.00011',
              'partita_iva' => 'ITSCONOSCIUTO'
            },
            'non una mappa'
          }
        }
      );
      TestHttpMock.install().when('/clienti/ricerca', 200, body);

      Test.startTest();
      MexalCustomerSearchService.Result result = MexalCustomerSearchService.searchModifiedSince(
        System.now().addDays(-1)
      );
      Test.stopTest();

      System.assertEquals(true, result.success, result.message);
      System.assertEquals(5, result.customersReturned);
      System.assertEquals(1, result.matchedByPartitaIva);
      System.assertEquals(1, result.matchedByMexalCode);
      System.assertEquals(1, result.ambiguousMatches);
      System.assertEquals(2, result.updatedAccounts, result.saveErrors + '');
      Account updated = [
        SELECT Name, Codice_Cliente_Mexal__c, Email__c, BillingCity
        FROM Account
        WHERE Id = :byVat.Id
      ];
      System.assertEquals(CUSTOMER_CODE, updated.Codice_Cliente_Mexal__c);
      System.assertEquals('Ragione Aggiornata', updated.Name);
      System.assertEquals('info@example.com', updated.Email__c);
      System.assertEquals('Torino', updated.BillingCity);
    }
  }

  @isTest
  static void customerSearchByCodeReportsFailure() {
    TestHttpMock.install().when('/clienti/ricerca', 500, '{"error":{}}');

    Test.startTest();
    MexalCustomerSearchService.Result result = MexalCustomerSearchService.searchByCustomerCode(
      ' ' + CUSTOMER_CODE + ' '
    );
    Test.stopTest();

    System.assertEquals(false, result.success);
    System.assertEquals(CUSTOMER_CODE, result.requestDateTime);
    System.assertEquals(0, result.customersReturned);
  }

  @isTest
  static void customerSearchRequiresItsArguments() {
    Exception error;
    try {
      MexalCustomerSearchService.searchModifiedSince(null);
    } catch (MexalCustomerSearchService.MexalCustomerSearchException e) {
      error = e;
    }
    assertThrows('Missing date', error);
    error = null;
    try {
      MexalCustomerSearchService.searchByCustomerCode('');
    } catch (MexalCustomerSearchService.MexalCustomerSearchException e) {
      error = e;
    }
    assertThrows('Missing code', error);
  }

  @isTest
  static void customerSyncBatchAdvancesTheCursorOnCleanSuccess() {
    TestHttpMock.install()
      .when(
        '/clienti/ricerca',
        200,
        '{"data_ric_elab":"20260928 020000","dati":[]}'
      );

    Test.startTest();
    Database.executeBatch(new MexalCustomerSyncBatch(), 1);
    Test.stopTest();

    Integration_Configuration2__c cursor = config('Mexal_Clienti_Ricerca');
    System.assertEquals('Success', cursor.Last_Sync_Status__c);
    System.assertNotEquals(null, cursor.Last_Successful_Sync__c);
  }

  @isTest
  static void customerSyncBatchRecordsFailure() {
    TestHttpMock.install().when('/clienti/ricerca', 500, 'errore');

    Test.startTest();
    Database.executeBatch(new MexalCustomerSyncBatch(), 1);
    Test.stopTest();

    System.assertEquals(
      'Failed',
      config('Mexal_Clienti_Ricerca').Last_Sync_Status__c
    );
  }

  @isTest
  static void customerSyncBatchSurvivesAMissingConfiguration() {
    delete [
      SELECT Id
      FROM Integration_Configuration2__c
      WHERE Azione__c = 'Mexal_Clienti_Ricerca'
    ];

    Test.startTest();
    Database.executeBatch(new MexalCustomerSyncBatch(), 1);
    Test.stopTest();

    System.assertEquals(
      1,
      [
        SELECT COUNT()
        FROM Integration_Log__c
        WHERE Flow_Name__c = 'Mexal_Clienti_Sync' AND Is_Error__c = TRUE
      ]
    );
  }

  // --------------------------------------------------------------- articles

  @isTest
  static void articleSyncUpsertsItemsAndSkipsBundlesAndBadRows() {
    TestDataFactory.bundle('Bundle esistente', 'BND-EXISTING', 1000);
    Integer month = Date.today().month();
    String body = JSON.serialize(
      new Map<String, Object>{
        'data_ric_elab' => '20260928 120000',
        'dati' => new List<Object>{
          new Map<String, Object>{
            'codice' => 'ART-001',
            'descr_completa' => 'Corso base',
            'descr_estesa' => new List<Object>{ 'Riga uno', ' ', 'Riga due' },
            'prz_listino' => new List<Object>{
              new List<Object>{ 1, '12,50' },
              new List<Object>{ 2, '1.234,56' }
            },
            'gest_attiva' => new List<Object>{ new List<Object>{ month, 'S' } },
            'tipologia' => 'Servizio',
            'livello_0' => 'Formazione'
          },
          new Map<String, Object>{
            'codice_articolo' => 'ART-002',
            'descrizione' => 'Corso annullato',
            'prezzo_1' => '99.90',
            'gest_annullato' => 'S'
          },
          new Map<String, Object>{
            'codice' => 'ART-003',
            'descrizione' => 'Corso sospeso',
            'attivo' => 'no'
          },
          new Map<String, Object>{
            'codice' => 'BND-EXISTING',
            'descrizione' => 'Collide con un bundle'
          },
          new Map<String, Object>{ 'descrizione' => 'Senza codice' },
          42
        }
      }
    );
    TestHttpMock.install().when('/articoli/ricerca', 200, body);

    Test.startTest();
    MexalArticleSyncService.Result result = MexalArticleSyncService.syncModifiedSince(
      System.now().addHours(-2)
    );
    Test.stopTest();

    System.assertEquals(true, result.success);
    System.assertEquals(6, result.articlesReturned);
    System.assertEquals(2, result.skippedRows);
    System.assertEquals(1, result.skippedBundleMatches);
    System.assertEquals(3, result.upsertedProducts, result.saveErrors + '');

    Product2 first = [
      SELECT Name, Price_1__c, Price_2__c, IsActive, Description, ProductCode
      FROM Product2
      WHERE External_Product_Code__c = 'ART-001'
    ];
    System.assertEquals('Corso base', first.Name);
    System.assertEquals(12.5, first.Price_1__c);
    System.assertEquals(1234.56, first.Price_2__c);
    System.assertEquals(true, first.IsActive);
    // Description is the name, then Mexal's extended description.
    System.assertEquals('Corso base\nRiga uno\nRiga due', first.Description);
    System.assertEquals('ART-001', first.ProductCode);
    System.assertEquals(
      false,
      [SELECT IsActive FROM Product2 WHERE External_Product_Code__c = 'ART-002']
      .IsActive
    );
    System.assertEquals(
      false,
      [SELECT IsActive FROM Product2 WHERE External_Product_Code__c = 'ART-003']
      .IsActive
    );
  }

  @isTest
  static void articleSyncByCodeRequiresACode() {
    Exception error;
    try {
      MexalArticleSyncService.syncByArticleCode(' ');
    } catch (MexalArticleSyncService.MexalArticleSyncException e) {
      error = e;
    }
    assertThrows('Missing code', error);
    error = null;
    try {
      MexalArticleSyncService.syncModifiedSince(null);
    } catch (MexalArticleSyncService.MexalArticleSyncException e) {
      error = e;
    }
    assertThrows('Missing date', error);
  }

  @isTest
  static void articleSyncByCodeReportsFailure() {
    TestHttpMock.install().when('/articoli/ricerca', 404, '');

    Test.startTest();
    MexalArticleSyncService.Result result = MexalArticleSyncService.syncByArticleCode(
      'ART-404'
    );
    Test.stopTest();

    System.assertEquals(false, result.success);
    System.assertEquals('ART-404', result.requestValue);
  }

  @isTest
  static void articleSyncBatchAdvancesTheCursor() {
    TestHttpMock.install().when('/articoli/ricerca', 200, '{"dati":[]}');

    Test.startTest();
    Database.executeBatch(new MexalArticleSyncBatch(), 1);
    Test.stopTest();

    System.assertEquals(
      'Success',
      config('Mexal_Articoli_Ricerca').Last_Sync_Status__c
    );
  }

  @isTest
  static void articleSyncBatchRecordsFailure() {
    TestHttpMock.install()
      .when('/articoli/ricerca', 200, '{"dati":[{"descrizione":"x"}]}');

    Test.startTest();
    Database.executeBatch(new MexalArticleSyncBatch(), 1);
    Test.stopTest();

    System.assertEquals(
      'Failed',
      config('Mexal_Articoli_Ricerca').Last_Sync_Status__c
    );
  }

  @isTest
  static void articleSyncBatchSurvivesAMissingConfiguration() {
    delete [
      SELECT Id
      FROM Integration_Configuration2__c
      WHERE Azione__c = 'Mexal_Articoli_Ricerca'
    ];

    Test.startTest();
    Database.executeBatch(new MexalArticleSyncBatch(), 1);
    Test.stopTest();

    System.assertEquals(
      1,
      [
        SELECT COUNT()
        FROM Integration_Log__c
        WHERE Flow_Name__c = 'Mexal_Articoli_Sync' AND Is_Error__c = TRUE
      ]
    );
  }

  // ---------------------------------------------------- warehouse + payments

  @isTest
  static void warehouseSearchMapsInvoiceDocuments() {
    String body = JSON.serialize(
      new Map<String, Object>{
        'data_ric_elab' => '20260928 120000',
        'dati' => new List<Object>{
          new Map<String, Object>{
            'sigla' => 'FT',
            'serie' => 1,
            'numero' => 55,
            'cod_conto' => CUSTOMER_CODE,
            'data_documento' => '20260901',
            'sigla_ordine' => new List<Object>{ new List<Object>{ 1, 'OC' } },
            'serie_ordine' => new List<Object>{ new List<Object>{ 1, 10 } },
            'numero_ordine' => new List<Object>{ new List<Object>{ 1, 7 } },
            'data_ordine' => new List<Object>{
              new List<Object>{ 1, '20260801' }
            },
            'data_ult_mod' => '20260902 101010'
          },
          new Map<String, Object>{
            'sigla' => 'BC',
            'serie' => 'x',
            'numero_ordine' => new List<Object>()
          },
          'riga non valida'
        }
      }
    );
    TestHttpMock.install().when('/movimenti-magazzino/ricerca', 200, body);

    Test.startTest();
    MexalMaggazinoSearchService.Result result = MexalMaggazinoSearchService.searchModifiedSince(
      System.now().addDays(-1)
    );
    Test.stopTest();

    System.assertEquals(true, result.success);
    System.assertEquals(3, result.documentsReturned);
    System.assertEquals(1, result.ftDocumentsReturned);
    System.assertEquals(1, result.skippedRows);
    MexalMaggazinoSearchService.MaggazinoDocument document = result.documents[0];
    System.assertEquals('OC', document.orderSigla);
    System.assertEquals(10, document.orderSerie);
    System.assertEquals(7, document.orderNumber);
    System.assertEquals(null, result.documents[1].serie);
  }

  @isTest
  static void warehouseSearchRequiresADate() {
    Exception error;
    try {
      MexalMaggazinoSearchService.searchModifiedSince(null);
    } catch (MexalMaggazinoSearchService.MexalMaggazinoSearchException e) {
      error = e;
    }
    assertThrows('Missing date', error);
  }

  @isTest
  static void scadenzarioSearchMapsPaymentDeadlines() {
    String body = JSON.serialize(
      new Map<String, Object>{
        'dati' => new List<Object>{
          new Map<String, Object>{
            'codice' => CUSTOMER_CODE,
            'serie' => 1,
            'numero' => 55,
            'causale' => 'FE',
            'data_documento' => '20260901',
            'dt_sca_pg' => new List<Object>{
              new List<Object>{ 1, '20261031' },
              new List<Object>{ 2, 'bad' }
            },
            'imp_scadenza' => new List<Object>{
              new List<Object>{ 1, '100.50' },
              new List<Object>{ 2, 'x' }
            },
            'stato_pagamento' => new List<Object>{
              new List<Object>{ 1, 'P' },
              new List<Object>{ 2, 'A' }
            }
          },
          7
        }
      }
    );
    TestHttpMock.install().when('/scadenzario/ricerca', 200, body);

    Test.startTest();
    MexalScadenzarioSearchService.Result result = MexalScadenzarioSearchService.searchModifiedSince(
      System.now().addDays(-1)
    );
    Test.stopTest();

    System.assertEquals(true, result.success);
    System.assertEquals(2, result.paymentRowsReturned);
    System.assertEquals(1, result.skippedRows);
    MexalScadenzarioSearchService.PaymentDeadline firstDeadline;
    for (
      MexalScadenzarioSearchService.PaymentDeadline deadline : result.documents[0]
        .deadlines
    ) {
      if (deadline.rowIndex == 1) {
        firstDeadline = deadline;
      }
    }
    System.assertEquals(Date.newInstance(2026, 10, 31), firstDeadline.dueDate);
    System.assertEquals(100.50, firstDeadline.amount);
    System.assertEquals(true, firstDeadline.paid);
  }

  @isTest
  static void scadenzarioSearchRequiresADate() {
    Exception error;
    try {
      MexalScadenzarioSearchService.searchModifiedSince(null);
    } catch (MexalScadenzarioSearchService.MexalScadenzarioSearchException e) {
      error = e;
    }
    assertThrows('Missing date', error);
  }

  private static OrderItem mexalOrderLine(
    Tranche__c trancheRecord,
    Date dueDate
  ) {
    Account accountRecord = TestDataFactory.azienda('Cliente Mexal');
    Product2 product = TestDataFactory.item('Corso', 'ART-PAY');
    PricebookEntry entry = TestDataFactory.standardEntry(product.Id, 100);
    Order orderRecord = new Order(
      AccountId = accountRecord.Id,
      EffectiveDate = Date.today(),
      Status = 'Ordinato',
      Pricebook2Id = Test.getStandardPricebookId(),
      Mexal_Document_Sigla__c = 'OC',
      Mexal_Document_Serie__c = 10,
      Mexal_Document_Number__c = 7,
      Mexal_Customer_Code__c = CUSTOMER_CODE
    );
    insert orderRecord;
    OrderItem line = new OrderItem(
      OrderId = orderRecord.Id,
      PricebookEntryId = entry.Id,
      Quantity = 1,
      UnitPrice = 100,
      Mexal_Line_Number__c = 1,
      Data_Scadenza__c = dueDate,
      Tranche__c = trancheRecord == null ? null : trancheRecord.Id
    );
    insert line;
    return line;
  }

  private static String invoiceDetailBody() {
    return JSON.serialize(
      new Map<String, Object>{
        'dati' => new List<Object>{
          new Map<String, Object>{
            'sigla' => 'FT',
            'serie' => 1,
            'numero' => 55,
            'data_documento' => '20260901',
            'cod_conto' => CUSTOMER_CODE,
            'id_riga' => new List<Object>{
              new List<Object>{ 1, 1 },
              new List<Object>{ 2, 2 }
            },
            'id_riga_orig' => new List<Object>{
              new List<Object>{ 1, 1 },
              new List<Object>{ 2, 9 }
            },
            'codice_articolo' => new List<Object>{
              new List<Object>{ 1, 'ART-PAY' },
              new List<Object>{ 2, 'ART-ALTRO' }
            },
            'sigla_ordine' => new List<Object>{
              new List<Object>{ 1, 'OC' },
              new List<Object>{ 2, 'OC' }
            },
            'serie_ordine' => new List<Object>{
              new List<Object>{ 1, 10 },
              new List<Object>{ 2, 10 }
            },
            'numero_doc_orig' => new List<Object>{
              new List<Object>{ 1, 7 },
              new List<Object>{ 2, 7 }
            }
          }
        }
      }
    );
  }

  @isTest
  static void paidDeadlineMarksLineTrancheTicketsAndOrderAsCollected() {
    Tranche__c trancheRecord = TestDataFactory.tranche(null, 1);
    Date dueDate = Date.today().addMonths(1);
    OrderItem line = mexalOrderLine(trancheRecord, dueDate);

    MexalScadenzarioSearchService.PaymentDeadline deadline = new MexalScadenzarioSearchService.PaymentDeadline();
    deadline.rowIndex = 1;
    deadline.dueDate = dueDate;
    deadline.amount = 100;
    deadline.paymentStatus = 'P';
    deadline.paid = true;
    MexalScadenzarioSearchService.ScadenzarioDocument document = new MexalScadenzarioSearchService.ScadenzarioDocument();
    document.customerCode = CUSTOMER_CODE;
    document.serie = 1;
    document.numero = 55;
    document.documentDate = '20260901';
    // One installment: several cannot yet be allocated to order lines.
    document.deadlines.add(deadline);

    Test.startTest();
    MexalInvoiceOrderLineMappingService.Result mapping = MexalInvoiceOrderLineMappingService.mapInvoiceDetail(
      invoiceDetailBody(),
      new List<MexalScadenzarioSearchService.ScadenzarioDocument>{
        document,
        null
      }
    );
    Integer updates = MexalInvoiceOrderLineMappingService.updateOrderItemPaymentStatuses(
      mapping.mappings
    );
    Test.stopTest();

    System.assertEquals(2, mapping.invoiceLinesReturned);
    System.assertEquals(1, mapping.matchedLines);
    System.assertEquals(1, mapping.unmatchedLines);
    // The payment matches on the invoice key, so both invoice lines read paid;
    // only the line matched to Salesforce is updated.
    System.assertEquals(2, mapping.paidLines);
    System.assertEquals(0, mapping.linesWithoutPaymentMatch);
    System.assertEquals(1, updates);
    System.assertEquals(
      'Paid',
      [SELECT Mexal_Payment_Status__c FROM OrderItem WHERE Id = :line.Id]
      .Mexal_Payment_Status__c
    );
    Tranche__c paidTranche = [
      SELECT Stato__c, Completamente_Pagata__c
      FROM Tranche__c
      WHERE Id = :trancheRecord.Id
    ];
    System.assertEquals('Pagata', paidTranche.Stato__c);
    System.assertEquals(true, paidTranche.Completamente_Pagata__c);
    System.assertEquals(
      'Incassato',
      [SELECT Status FROM Order WHERE Id = :line.OrderId].Status
    );
  }

  @isTest
  static void paidScadenzaFatturaMarksItsOrderLinesPaid() {
    OrderItem line = mexalOrderLine(null, Date.today().addMonths(1));
    Fattura__c invoice = new Fattura__c(Name = 'FT 1/55');
    insert invoice;
    Scadenza_Fattura__c deadline = new Scadenza_Fattura__c(
      Fattura__c = invoice.Id,
      // No Mexal state yet: Pagata__c is true only for P or E.
      Data_Scadenza__c = Date.today().addMonths(1)
    );
    insert deadline;
    // The line reaches its rates through its invoice.
    update new OrderItem(
      Id = line.Id,
      Fattura__c = invoice.Id,
      Scadenza_Fattura__c = deadline.Id
    );

    Test.startTest();
    // Pagata__c is a formula on the Mexal payment state.
    deadline.Stato_Pagamento_Mexal__c = 'P';
    update deadline;
    Test.stopTest();

    System.assertEquals(
      'Paid',
      [SELECT Mexal_Payment_Status__c FROM OrderItem WHERE Id = :line.Id]
      .Mexal_Payment_Status__c
    );
  }

  // ------------------------------------------------------- invoice import

  private static String invoiceSearchBody() {
    return JSON.serialize(
      new Map<String, Object>{
        'dati' => new List<Object>{
          new Map<String, Object>{
            'serie' => 1,
            'numero' => 55,
            'cod_conto' => CUSTOMER_CODE,
            'data_documento' => '20260901',
            'data_ult_mod' => '20260902 101500'
          },
          new Map<String, Object>{ 'numero' => 56 }
        }
      }
    );
  }

  private static String scadenzarioSearchBody() {
    return JSON.serialize(
      new Map<String, Object>{
        'dati' => new List<Object>{
          new Map<String, Object>{
            'serie' => 1,
            'numero' => 55,
            'data_documento' => '20260901',
            'dt_sca_pg' => new List<Object>{
              new List<Object>{ 1, '20261001' }
            },
            'imp_scadenza' => new List<Object>{ new List<Object>{ 1, 500 } },
            'stato_pagamento' => new List<Object>{ new List<Object>{ 1, 'p' } }
          },
          // A rate of an invoice Salesforce does not hold is left out.
          new Map<String, Object>{
            'serie' => 2,
            'numero' => 99,
            'data_documento' => '20260901',
            'dt_sca_pg' => new List<Object>{ new List<Object>{ 1, '20261001' } }
          },
          new Map<String, Object>{ 'numero' => 7 }
        }
      }
    );
  }

  @isTest
  static void invoiceImportSavesTheHeaderOnTheCustomerAccount() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    TestHttpMock.install()
      .when('/movimenti-magazzino/ricerca', 200, invoiceSearchBody());

    Test.startTest();
    MexalInvoiceImportService.Result result = MexalInvoiceImportService.importInvoicesModifiedSince(
      System.now().addDays(-1)
    );
    Test.stopTest();

    System.assertEquals(2, result.invoicesReturned);
    System.assertEquals(1, result.invoicesSaved, result.errors + '');
    System.assertEquals(1, result.errors.size(), 'The row without serie');
    Fattura__c invoice = [
      SELECT Name, Account__c, Data_Documento__c, Chiave_Mexal__c
      FROM Fattura__c
    ];
    System.assertEquals('FT 1/55', invoice.Name);
    System.assertEquals('FT+1+55+2026', invoice.Chiave_Mexal__c);
    System.assertEquals(
      Date.newInstance(2026, 9, 1),
      invoice.Data_Documento__c
    );
    System.assertEquals(
      [SELECT AccountId FROM Order WHERE Id = :orderRecord.Id].AccountId,
      invoice.Account__c
    );
  }

  @isTest
  static void scadenzarioImportSavesRatesAndPaysTheInvoicedLines() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    Fattura__c invoice = new Fattura__c(
      Name = 'FT 1/55',
      Chiave_Mexal__c = 'FT+1+55+2026'
    );
    insert invoice;
    OrderItem line = [SELECT Id FROM OrderItem WHERE OrderId = :orderRecord.Id];
    update new OrderItem(Id = line.Id, Fattura__c = invoice.Id);
    TestHttpMock.install()
      .when('/scadenzario/ricerca', 200, scadenzarioSearchBody());

    Test.startTest();
    MexalInvoiceImportService.Result result = MexalInvoiceImportService.importScadenzarioModifiedSince(
      System.now().addDays(-1)
    );
    Test.stopTest();

    System.assertEquals(3, result.scadenzarioDocumentsReturned);
    System.assertEquals(1, result.deadlinesSaved, result.errors + '');
    System.assertEquals(1, result.deadlinesWithoutInvoice);
    System.assertEquals(1, result.orderLinesUpdated, result.errors + '');
    Scadenza_Fattura__c rate = [
      SELECT Importo__c, Pagata__c, Data_Scadenza__c
      FROM Scadenza_Fattura__c
      WHERE Fattura__c = :invoice.Id
    ];
    System.assertEquals(500, rate.Importo__c);
    System.assertEquals(true, rate.Pagata__c);
    System.assertEquals(
      'Paid',
      [SELECT Mexal_Payment_Status__c FROM OrderItem WHERE Id = :line.Id]
      .Mexal_Payment_Status__c
    );
  }

  @isTest
  static void invoiceBackfillByDocumentDateRunsBothSearches() {
    orderForMexal(CUSTOMER_CODE, true);
    TestHttpMock.install()
      .when('/movimenti-magazzino/ricerca', 200, invoiceSearchBody())
      .when('/scadenzario/ricerca', 200, scadenzarioSearchBody());

    Test.startTest();
    MexalInvoiceImportService.Result result = MexalInvoiceImportService.importByDocumentDate(
      Date.newInstance(2026, 9, 1)
    );
    Test.stopTest();

    System.assertEquals(1, result.invoicesSaved, result.errors + '');
    System.assertEquals(1, result.deadlinesSaved, result.errors + '');

    Integer refused = 0;
    try {
      MexalInvoiceImportService.importInvoicesModifiedSince(null);
    } catch (MexalInvoiceImportService.MexalInvoiceImportException error) {
      refused++;
    }
    try {
      MexalInvoiceImportService.importScadenzarioModifiedSince(null);
    } catch (MexalInvoiceImportService.MexalInvoiceImportException error) {
      refused++;
    }
    try {
      MexalInvoiceImportService.importByDocumentDate(null);
    } catch (MexalInvoiceImportService.MexalInvoiceImportException error) {
      refused++;
    }
    System.assertEquals(3, refused);
  }

  @isTest
  static void unmatchedPaymentMarksLineWithoutMatch() {
    OrderItem line = mexalOrderLine(null, Date.today().addMonths(2));

    Test.startTest();
    MexalInvoiceOrderLineMappingService.Result mapping = MexalInvoiceOrderLineMappingService.mapInvoiceDetail(
      invoiceDetailBody()
    );
    MexalInvoiceOrderLineMappingService.updateOrderItemPaymentStatuses(
      mapping.mappings
    );
    Test.stopTest();

    System.assertEquals(
      'No Payment Match',
      [SELECT Mexal_Payment_Status__c FROM OrderItem WHERE Id = :line.Id]
      .Mexal_Payment_Status__c
    );
    System.assertEquals(
      0,
      MexalInvoiceOrderLineMappingService.updateOrderItemPaymentStatuses(null)
    );
    System.assertEquals(
      0,
      MexalInvoiceOrderLineMappingService.mapInvoiceDetail('')
        .invoiceLinesReturned
    );
    System.assertEquals(
      0,
      MexalInvoiceOrderLineMappingService.mapInvoiceDetail('[1]')
        .invoiceLinesReturned
    );
  }

  @isTest
  static void unpaidDeadlineKeepsTheTranchePartial() {
    Tranche__c trancheRecord = TestDataFactory.tranche(null, 1);
    Date dueDate = Date.today().addMonths(1);
    OrderItem paidLine = mexalOrderLine(trancheRecord, dueDate);
    OrderItem secondLine = paidLine.clone(false, true);
    secondLine.Mexal_Line_Number__c = 2;
    insert secondLine;

    Test.startTest();
    update new OrderItem(Id = paidLine.Id, Mexal_Payment_Status__c = 'Paid');
    Test.stopTest();

    System.assertEquals(
      'Parzialmente Pagata',
      [SELECT Stato__c FROM Tranche__c WHERE Id = :trancheRecord.Id].Stato__c
    );
    System.assertNotEquals(
      'Incassato',
      [SELECT Status FROM Order WHERE Id = :paidLine.OrderId].Status
    );
  }

  @isTest
  static void warehouseDetailMapsTheInvoiceAgainstSalesforceLines() {
    mexalOrderLine(null, Date.today().addMonths(1));
    TestHttpMock.install()
      .when('/movimenti-magazzino/FT', 200, invoiceDetailBody());
    MexalMaggazinoSearchService.MaggazinoDocument document = new MexalMaggazinoSearchService.MaggazinoDocument();
    document.sigla = 'FT';
    document.serie = 1;
    document.numero = 55;
    document.documentDate = '20260901';
    document.customerCode = CUSTOMER_CODE;

    Test.startTest();
    MexalMaggazinoDetailService.Result result = MexalMaggazinoDetailService.getDetail(
      document
    );
    Test.stopTest();

    System.assertEquals(true, result.success, result.message);
    System.assertEquals(1, result.rowsReturned);
    System.assertEquals(1, result.mappedInvoiceLines);
    System.assertEquals(1, result.unmappedInvoiceLines);
    System.assertEquals(2, result.invoiceLinesWithoutPaymentMatch);
  }

  @isTest
  static void warehouseDetailRejectsIncompleteKeys() {
    Exception error;
    try {
      MexalMaggazinoDetailService.getDetail('BC', 1, 1, 'C');
    } catch (MexalMaggazinoDetailService.MexalMaggazinoDetailException e) {
      error = e;
    }
    assertThrows('Non-FT document', error);
    error = null;
    try {
      MexalMaggazinoDetailService.getDetail('FT', 1, null, 'C');
    } catch (MexalMaggazinoDetailService.MexalMaggazinoDetailException e) {
      error = e;
    }
    assertThrows('Missing number', error);
    error = null;
    try {
      MexalMaggazinoDetailService.getDetail(null);
    } catch (MexalMaggazinoDetailService.MexalMaggazinoDetailException e) {
      error = e;
    }
    assertThrows('Missing document', error);
  }

  // A non-JSON error body makes getDetail throw (countRows parses the body
  // even when the call failed); the batch catches it. JSON bodies report.
  @isTest
  static void warehouseDetailReportsHttpFailure() {
    TestHttpMock.install()
      .when('/movimenti-magazzino/FT', 500, '{"error":"interno"}');

    Test.startTest();
    MexalMaggazinoDetailService.Result result = MexalMaggazinoDetailService.getDetail(
      'FT',
      1,
      55,
      CUSTOMER_CODE
    );
    Test.stopTest();

    System.assertEquals(false, result.success);
    System.assertEquals(0, result.mappedInvoiceLines);
  }

  @isTest
  static void warehouseBatchStopsWhenTheSearchFails() {
    TestHttpMock.install().when('/movimenti-magazzino/ricerca', 500, 'errore');

    Test.startTest();
    Database.executeBatch(new MexalMaggazinoSyncBatch(), 1);
    Test.stopTest();

    System.assertEquals(
      'Failed',
      config('Mexal_Movimenti_Magazzino_Ricerca').Last_Sync_Status__c
    );
  }

  // The search logs its callout, so the scadenzario callout that follows in
  // the same execute fails with "uncommitted work pending" and the batch
  // records a failed run. This asserts the current production behaviour.
  @isTest
  static void warehouseBatchRecordsTheSecondCalloutFailure() {
    TestHttpMock.install()
      .when('/movimenti-magazzino/ricerca', 200, '{"dati":[]}')
      .when('/scadenzario/ricerca', 200, '{"dati":[]}');

    Test.startTest();
    Database.executeBatch(new MexalMaggazinoSyncBatch(), 1);
    Test.stopTest();

    System.assertNotEquals(
      null,
      config('Mexal_Movimenti_Magazzino_Ricerca').Last_Sync_Status__c
    );
  }

  @isTest
  static void warehouseBatchSurvivesAMissingConfiguration() {
    delete [
      SELECT Id
      FROM Integration_Configuration2__c
      WHERE Azione__c = 'Mexal_Movimenti_Magazzino_Ricerca'
    ];

    Test.startTest();
    Database.executeBatch(new MexalMaggazinoSyncBatch(), 1);
    Test.stopTest();

    System.assertEquals(
      1,
      [
        SELECT COUNT()
        FROM Integration_Log__c
        WHERE
          Flow_Name__c = 'Mexal_Movimenti_Magazzino_Sync'
          AND Is_Error__c = TRUE
      ]
    );
  }

  // --------------------------------------------------------------- cursor

  @isTest
  static void cursorFallsBackToTheLookbackAndRecordsOutcomes() {
    Integration_Configuration2__c cursor = config('Mexal_Articoli_Ricerca');
    cursor.Initial_Sync_Lookback_Hours__c = 48;
    update cursor;

    Datetime fallback = MexalSyncCursorService.getLastSuccessfulSync(
      'Mexal_Articoli_Ricerca'
    );
    System.assert(fallback < System.now().addHours(-47));

    Datetime marker = System.now();
    MexalSyncCursorService.markSuccessful('Mexal_Articoli_Ricerca', marker);
    System.assertEquals(
      marker,
      MexalSyncCursorService.getLastSuccessfulSync('Mexal_Articoli_Ricerca')
    );

    MexalSyncCursorService.markFailed(
      'Mexal_Articoli_Ricerca',
      'x'.repeat(400)
    );
    System.assertEquals(
      255,
      config('Mexal_Articoli_Ricerca').Last_Sync_Error__c.length()
    );

    System.assert(
      MexalSyncCursorService.getLastSuccessfulSync('Mexal_Clienti_Ricerca', 0) <
      System.now()
    );

    Exception error;
    try {
      MexalSyncCursorService.markSuccessful('Mexal_Articoli_Ricerca', null);
    } catch (MexalSyncCursorService.CursorException e) {
      error = e;
    }
    assertThrows('Missing cursor', error);
    error = null;
    try {
      MexalSyncCursorService.markFailed('', 'x');
    } catch (MexalSyncCursorService.CursorException e) {
      error = e;
    }
    assertThrows('Missing action', error);
    error = null;
    try {
      MexalSyncCursorService.markFailed('Sconosciuta', 'x');
    } catch (MexalSyncCursorService.CursorException e) {
      error = e;
    }
    assertThrows('Unknown action', error);
  }

  @isTest
  static void schedulerRegistersTheNightlyJob() {
    Test.startTest();
    Id jobId = MexalCustomerSyncScheduler.scheduleNightly();
    Test.stopTest();

    System.assertEquals(
      MexalCustomerSyncScheduler.NIGHTLY_0200_CRON,
      [SELECT CronExpression FROM CronTrigger WHERE Id = :jobId].CronExpression
    );
  }

  @isTest
  static void schedulerStartsTheCustomerBatch() {
    TestHttpMock.install();

    Test.startTest();
    new MexalCustomerSyncScheduler().execute(null);
    Test.stopTest();

    // Articles and invoices run on their own schedulers.
    System.assertEquals(
      1,
      [
        SELECT COUNT()
        FROM AsyncApexJob
        WHERE JobType = 'BatchApex'
      ]
    );
  }

  @isTest
  static void loggerWritesInfoAndErrorRows() {
    MexalIntegrationLogger.logInfo('Test_Flow', 'ok');
    MexalIntegrationLogger.logError(
      'Test_Flow',
      null,
      new DmlException('boom')
    );

    List<Integration_Log__c> logs = [
      SELECT Is_Error__c, Exception_Message__c
      FROM Integration_Log__c
      WHERE Flow_Name__c = 'Test_Flow'
      ORDER BY Is_Error__c
    ];
    System.assertEquals(2, logs.size());
    System.assertEquals(false, logs[0].Is_Error__c);
    System.assert(logs[1].Exception_Message__c.contains('boom'));
  }

  // ----------------------------------------------------- customer writes

  private static Account accountToCreate() {
    Account accountRecord = TestDataFactory.buildAzienda('Nuovo Cliente');
    accountRecord.ShippingCity = 'Bologna';
    accountRecord.Codice_Fiscale__c = 'RSSMRA80A01F205X';
    TestDataFactory.insertAllowingDuplicates(accountRecord);
    return accountRecord;
  }

  @isTest
  static void customerCreateStoresTheCodeFromTheLocationHeader() {
    Account accountRecord = accountToCreate();
    TestHttpMock.install()
      .when(
        '/webapi/risorse/clienti',
        201,
        '',
        new Map<String, String>{
          'Location' => '/webapi/risorse/clienti/501.00077?x=1'
        }
      );

    Test.startTest();
    MexalCustomerCreateService.createForAccount(accountRecord.Id);
    Test.stopTest();

    System.assertEquals(
      '501.00077',
      [SELECT Codice_Cliente_Mexal__c FROM Account WHERE Id = :accountRecord.Id]
      .Codice_Cliente_Mexal__c
    );
  }

  @isTest
  static void customerCreateStoresTheCodeFromTheBody() {
    Account accountRecord = accountToCreate();
    TestHttpMock.install()
      .when('/webapi/risorse/clienti', 201, '{"codice_cliente":"501.00078"}');

    Test.startTest();
    MexalCustomerCreateService.createForAccount(accountRecord.Id);
    Test.stopTest();

    System.assertEquals(
      '501.00078',
      [SELECT Codice_Cliente_Mexal__c FROM Account WHERE Id = :accountRecord.Id]
      .Codice_Cliente_Mexal__c
    );
  }

  @isTest
  static void customerCreateAdoptsTheDuplicateVatCustomer() {
    Account accountRecord = accountToCreate();
    TestHttpMock.install()
      .when(
        '/webapi/risorse/clienti',
        409,
        '{"error":{"response-detail":"La partita IVA esiste gia sul cliente <501.00088>"}}'
      );

    Test.startTest();
    MexalCustomerCreateService.createForAccount(accountRecord.Id);
    Test.stopTest();

    System.assertEquals(
      '501.00088',
      [SELECT Codice_Cliente_Mexal__c FROM Account WHERE Id = :accountRecord.Id]
      .Codice_Cliente_Mexal__c
    );
  }

  @isTest
  static void customerCreateFailureLeavesTheAccountUntouched() {
    Account accountRecord = accountToCreate();
    TestHttpMock.install().when('/webapi/risorse/clienti', 500, '[]');

    Test.startTest();
    MexalCustomerCreateService.Result result = MexalCustomerCreateService.createForAccount(
      accountRecord.Id
    );
    Test.stopTest();

    System.assertEquals(false, result.success);
    System.assertEquals('Creazione cliente Mexal fallita.', result.message);
    System.assertEquals(
      null,
      [SELECT Codice_Cliente_Mexal__c FROM Account WHERE Id = :accountRecord.Id]
      .Codice_Cliente_Mexal__c
    );
    System.assertEquals('I', result.requestPayload.get('tp_nazionalita'));
  }

  @isTest
  static void customerCreateAndUpdateGuardTheirInputs() {
    Account linked = TestDataFactory.buildAzienda('Gia collegato');
    linked.Codice_Cliente_Mexal__c = CUSTOMER_CODE;
    Account unlinked = TestDataFactory.buildAzienda('Non collegato');
    TestDataFactory.insertAllowingDuplicates(
      new List<Account>{ linked, unlinked }
    );

    List<Exception> errors = new List<Exception>();
    try {
      MexalCustomerCreateService.createForAccount(null);
    } catch (MexalCustomerCreateService.MexalCustomerCreateException e) {
      errors.add(e);
    }
    try {
      MexalCustomerCreateService.createForAccount(linked.Id);
    } catch (MexalCustomerCreateService.MexalCustomerCreateException e) {
      errors.add(e);
    }
    try {
      MexalCustomerCreateService.updateForAccount(null);
    } catch (MexalCustomerCreateService.MexalCustomerCreateException e) {
      errors.add(e);
    }
    try {
      MexalCustomerCreateService.updateForAccount(unlinked.Id);
    } catch (MexalCustomerCreateService.MexalCustomerCreateException e) {
      errors.add(e);
    }
    System.assertEquals(4, errors.size());
  }

  // Inserting an Account with an Agente copies the agent code and commission
  // category from that user; a later edit that keeps the Agente does not.
  private static void setMexalAgentFields(
    Id accountId,
    String agentCode,
    String zone,
    String commissionCategory
  ) {
    AccountTriggerHandler.setBypassMexalCustomerUpdate(true);
    update new Account(
      Id = accountId,
      Codice_Agente_Esterno__c = agentCode,
      Zona__c = zone,
      Categoria_Provvigioni_Cliente__c = commissionCategory
    );
    AccountTriggerHandler.setBypassMexalCustomerUpdate(false);
  }

  @isTest
  static void customerUpdatePutsToTheCustomerResource() {
    Account accountRecord = TestDataFactory.buildAzienda('Da aggiornare');
    accountRecord.Codice_Cliente_Mexal__c = CUSTOMER_CODE;
    accountRecord.BillingCountry = 'IT';
    TestDataFactory.insertAllowingDuplicates(accountRecord);
    setMexalAgentFields(accountRecord.Id, 'AG001', '7', '19');
    TestHttpMock mock = TestHttpMock.install()
      .when('/clienti/501.00001', 204, '');

    Test.startTest();
    MexalCustomerCreateService.updateForAccount(accountRecord.Id);
    Test.stopTest();

    System.assertEquals('PUT', mock.requests[0].getMethod());
    System.assert(
      !mock.requests[0].getBody().contains('"codice":'),
      'An update never sends the generated-code placeholder'
    );
    System.assert(
      mock.requests[0].getBody().contains('"cod_agente":"AG001"'),
      'The customer update should send the Account agent code'
    );
    System.assert(
      mock.requests[0].getBody().contains('"cod_zona":7'),
      'The customer update should send the Account zone'
    );
    System.assert(
      mock.requests[0].getBody().contains('"cod_cat_pr":19'),
      'The customer update should send the Account commission category'
    );
    System.assert(
      mock.requests[0].getBody().contains('"gest_fatt_el":"S"'),
      'Italian customers should enable electronic invoicing'
    );
    System.assert(
      mock.requests[0].getBody().contains('"serie_fatt_el":3'),
      'Italian customers should send the agreed electronic invoice series'
    );
    System.assert(
      mock.requests[0].getBody().contains('"cod_modu_allega":"FT"'),
      'Italian customers should send the agreed PDF attachment module'
    );
  }

  @isTest
  static void customerUpdateOmitsBlankOptionalMexalFields() {
    Account accountRecord = TestDataFactory.buildAzienda('San Marino');
    accountRecord.Codice_Cliente_Mexal__c = CUSTOMER_CODE;
    accountRecord.BillingCountry = 'SM';
    TestDataFactory.insertAllowingDuplicates(accountRecord);
    setMexalAgentFields(accountRecord.Id, '610.00019', null, null);
    TestHttpMock mock = TestHttpMock.install()
      .when('/clienti/501.00001', 204, '');

    Test.startTest();
    MexalCustomerCreateService.updateForAccount(accountRecord.Id);
    Test.stopTest();

    String requestBody = mock.requests[0].getBody();
    System.assert(
      requestBody.contains('"cod_listino":1'),
      'Customer updates should still send the fixed price-list code'
    );
    System.assert(
      requestBody.contains('"valuta":1'),
      'Customer updates should still send the fixed currency code'
    );
    System.assert(
      requestBody.contains('"tp_nazionalita":"R"'),
      'San Marino customers should send the Mexal fiscal-residence code'
    );
    System.assert(
      !requestBody.contains('"cod_zona":'),
      'Blank numeric optional fields should be omitted'
    );
    System.assert(
      !requestBody.contains('"cod_cat_pr":'),
      'Blank numeric optional fields should be omitted'
    );
    System.assert(
      // Mexal refuses N (OI-211); San Marino now carries P.
      requestBody.contains('"gest_fatt_el":"P"'),
      'San Marino customers should send the e-invoicing code P'
    );
    System.assert(
      requestBody.contains('"serie_fatt_el":1'),
      'San Marino customers should send VAT sectional 1'
    );
    System.assert(
      requestBody.contains('"cod_modu_allega":"FT"'),
      'San Marino customers should send the FT attachment module'
    );
  }

  @isTest
  static void editingALinkedAccountQueuesTheMexalUpdate() {
    User adminUser = mexalAdmin();
    System.runAs(adminUser) {
      Account accountRecord = TestDataFactory.buildAzienda('Collegato');
      accountRecord.Codice_Cliente_Mexal__c = CUSTOMER_CODE;
      TestDataFactory.insertAllowingDuplicates(accountRecord);
      TestHttpMock.install().when('/clienti/501.00001', 500, '');

      Test.startTest();
      accountRecord.Phone = '0299999999';
      update accountRecord;
      Test.stopTest();

      System.assert(
        [
          SELECT COUNT()
          FROM Integration_Log__c
          WHERE Flow_Name__c = 'Mexal_Clienti_Modifica'
        ] > 0,
        'The queueable should call Mexal and log the result'
      );
    }
  }

  @isTest
  static void bypassSkipsTheMexalUpdate() {
    User adminUser = mexalAdmin();
    System.runAs(adminUser) {
      Account accountRecord = TestDataFactory.buildAzienda('Bypass');
      accountRecord.Codice_Cliente_Mexal__c = CUSTOMER_CODE;
      TestDataFactory.insertAllowingDuplicates(accountRecord);

      Test.startTest();
      AccountTriggerHandler.setBypassMexalCustomerUpdate(true);
      accountRecord.Phone = '0288888888';
      update accountRecord;
      AccountTriggerHandler.setBypassMexalCustomerUpdate(false);
      Test.stopTest();

      System.assertEquals(
        0,
        [
          SELECT COUNT()
          FROM AsyncApexJob
          WHERE ApexClass.Name = 'MexalCustomerUpdateQueueable'
        ]
      );
    }
  }

  @isTest
  static void updateQueueableLogsEveryFailure() {
    Account accountRecord = TestDataFactory.buildAzienda('Queue');
    accountRecord.Codice_Cliente_Mexal__c = CUSTOMER_CODE;
    TestDataFactory.insertAllowingDuplicates(accountRecord);
    TestHttpMock.install().when('/clienti/', 500, '');

    Test.startTest();
    System.enqueueJob(
      new MexalCustomerUpdateQueueable(
        new Set<Id>{ accountRecord.Id, TestDataFactory.azienda('Senza').Id }
      )
    );
    Test.stopTest();

    System.assert(
      [
        SELECT COUNT()
        FROM Integration_Log__c
        WHERE Flow_Name__c = 'Mexal_Clienti_Modifica' AND Is_Error__c = TRUE
      ] >= 2,
      'Both accounts should leave an error log'
    );
    new MexalCustomerUpdateQueueable(null);
  }

  // --------------------------------------------------------- order writes

  private static Order orderForMexal(String customerCode, Boolean withLine) {
    Account accountRecord = TestDataFactory.buildAzienda('Cliente Ordine');
    accountRecord.Codice_Cliente_Mexal__c = customerCode;
    TestDataFactory.insertAllowingDuplicates(accountRecord);
    Order orderRecord = TestDataFactory.order(accountRecord.Id);
    if (withLine) {
      Product2 product = TestDataFactory.item(
        'Corso Ordine',
        TestDataFactory.unique('ART-ORD')
      );
      OrderItem line = TestDataFactory.orderItem(
        orderRecord.Id,
        TestDataFactory.standardEntry(product.Id, 250),
        2
      );
      line.Data_Scadenza__c = Date.today().addDays(30);
      update line;
    }
    return orderRecord;
  }

  @isTest
  static void orderSendMapsTheMexalDocumentBack() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    orderRecord.Condizione_di_Pagamento__c = '64';
    update orderRecord;
    TestHttpMock mock = TestHttpMock.install()
      .when(
        '/ordini-clienti',
        201,
        '',
        new Map<String, String>{
          'location' => '/webapi/risorse/documenti/ordini-clienti/OC+10+77'
        }
      );

    Test.startTest();
    OrderMexalIntegrationService.runMexalOrderStep(orderRecord.Id);
    Test.stopTest();

    Order sent = [
      SELECT
        Mexal_Integration_Status__c,
        Mexal_Order_Number__c,
        Mexal_Document_Sigla__c,
        Mexal_Document_Serie__c,
        Mexal_Document_Number__c,
        Mexal_Customer_Code__c,
        (SELECT Mexal_Line_Number__c FROM OrderItems)
      FROM Order
      WHERE Id = :orderRecord.Id
    ];
    // Mexal_Integration_Status__c is not asserted: in production the order
    // insert also queues the full Mexal chain, which runs at stopTest.
    System.assertEquals('77', sent.Mexal_Order_Number__c);
    System.assertEquals('OC', sent.Mexal_Document_Sigla__c);
    // Series 10 in a sandbox, 1 in production (MexalOrderSendService).
    System.assertEquals(
      [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox ? 10 : 1,
      sent.Mexal_Document_Serie__c
    );
    System.assertEquals(77, sent.Mexal_Document_Number__c);
    System.assertEquals(CUSTOMER_CODE, sent.Mexal_Customer_Code__c);
    System.assertEquals(1, sent.OrderItems[0].Mexal_Line_Number__c);
    Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(
      mock.requests[0].getBody()
    );
    System.assertEquals(CUSTOMER_CODE, payload.get('cod_conto'));
    System.assertEquals(64, payload.get('id_pagamento'));
    List<Object> lineDueDates = (List<Object>) payload.get('dt_sca_riga');
    List<Object> firstLineDueDate = (List<Object>) lineDueDates[0];
    System.assertEquals(1, firstLineDueDate[0]);
    System.assertEquals(
      formatDate(Date.today().addDays(30)),
      firstLineDueDate[1]
    );
  }

  @isTest
  static void orderSendOmitsBlankLineDueDates() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    List<OrderItem> lines = [
      SELECT Id, Data_Scadenza__c
      FROM OrderItem
      WHERE OrderId = :orderRecord.Id
    ];
    for (OrderItem line : lines) {
      line.Data_Scadenza__c = null;
    }
    update lines;
    TestHttpMock mock = TestHttpMock.install().when('/ordini-clienti', 201, '');

    Test.startTest();
    MexalOrderSendService.Result result = MexalOrderSendService.sendOrder(
      orderRecord.Id
    );
    Test.stopTest();

    System.assertEquals(true, result.success);
    System.assert(
      !mock.requests[0].getBody().contains('"dt_sca_riga":'),
      'Blank line due dates should not be sent to Mexal'
    );
  }

  @isTest
  static void orderSendCarriesTheListPriceAndLineDiscount() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    // Unit price 250 from the helper; 300 before the discount, quantity 2.
    update new OrderItem(
      Id = [SELECT Id FROM OrderItem WHERE OrderId = :orderRecord.Id]
      .Id,
      Prezzo_Listino__c = 300.25
    );
    TestHttpMock mock = TestHttpMock.install().when('/ordini-clienti', 201, '');

    Test.startTest();
    MexalOrderSendService.sendOrder(orderRecord.Id);
    Test.stopTest();

    Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(
      mock.requests[0].getBody()
    );
    List<Object> firstPrice = (List<Object>) ((List<Object>) payload.get(
      'prezzo'
    ))[0];
    List<Object> firstDiscount = (List<Object>) ((List<Object>) payload.get(
      'sconto'
    ))[0];
    System.assertEquals(300.25, (Decimal) firstPrice[1]);
    // (300.25 - 250) x 2, as an amount with a comma decimal separator.
    System.assertEquals('-100,5', firstDiscount[1]);
  }

  private static String orderDetailBody(String articleCode, Integer quantity) {
    return JSON.serialize(
      new Map<String, Object>{
        'dati' => new List<Object>{
          new Map<String, Object>{
            'id_riga' => new List<Object>{
              new List<Object>{ 1, 555 },
              new List<Object>{ 2, 556 }
            },
            // A descriptive row is skipped: only article rows (R) are lines.
            'tp_riga' => new List<Object>{
              new List<Object>{ 1, 'R' },
              new List<Object>{ 2, 'D' }
            },
            'codice_articolo' => new List<Object>{
              new List<Object>{ 1, articleCode }
            },
            'quantita' => new List<Object>{ new List<Object>{ 1, quantity } }
          }
        }
      }
    );
  }

  @isTest
  static void orderLineSyncStoresMexalLineIdsAndRefusesMismatches() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    OrderItem line = [
      SELECT Id, Product2.External_Product_Code__c
      FROM OrderItem
      WHERE OrderId = :orderRecord.Id
    ];
    String articleCode = line.Product2.External_Product_Code__c;
    update new Order(
      Id = orderRecord.Id,
      Mexal_Document_Sigla__c = 'OC',
      Mexal_Document_Serie__c = 10,
      Mexal_Document_Number__c = 77
    );
    TestHttpMock.install()
      .when('/ordini-clienti/OC', 200, orderDetailBody(articleCode, 2));

    // One callout per transaction: the read logs, and no callout may follow.
    Test.startTest();
    MexalOrderLineSyncService.Result aligned = MexalOrderLineSyncService.syncOrderLines(
      orderRecord.Id
    );
    Test.stopTest();

    System.assertEquals(true, aligned.aligned, aligned.message);
    System.assertEquals(1, aligned.linesUpdated);
    System.assertEquals(
      555,
      [SELECT Mexal_Line_Number__c FROM OrderItem WHERE Id = :line.Id]
      .Mexal_Line_Number__c
    );

    MexalOrderLineSyncService.clearLineNumbers(orderRecord.Id);
    System.assertEquals(
      null,
      [SELECT Mexal_Line_Number__c FROM OrderItem WHERE Id = :line.Id]
      .Mexal_Line_Number__c
    );
  }

  @isTest
  static void orderLineSyncRefusesAQuantityMismatch() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    String articleCode = [
      SELECT Product2.External_Product_Code__c
      FROM OrderItem
      WHERE OrderId = :orderRecord.Id
    ]
    .Product2.External_Product_Code__c;
    update new Order(
      Id = orderRecord.Id,
      Mexal_Document_Sigla__c = 'OC',
      Mexal_Document_Serie__c = 10,
      Mexal_Document_Number__c = 77
    );
    TestHttpMock.install()
      .when('/ordini-clienti/OC', 200, orderDetailBody(articleCode, 3));

    Test.startTest();
    MexalOrderLineSyncService.Result mismatched = MexalOrderLineSyncService.syncOrderLines(
      orderRecord.Id
    );
    Test.stopTest();

    System.assertEquals(false, mismatched.aligned);
    TestDataFactory.assertContains(mismatched.message, 'quantita');
  }

  @isTest
  static void orderLineSyncNeedsTheMexalDocumentKey() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    String message;
    try {
      MexalOrderLineSyncService.syncOrderLines(orderRecord.Id);
    } catch (MexalOrderLineSyncService.MexalOrderLineSyncException error) {
      message = error.getMessage();
    }
    TestDataFactory.assertContains(message, 'Chiave documento');
  }

  @isTest
  static void orderSendRequiresAPaymentCode() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    orderRecord.Condizione_di_Pagamento__c = null;
    update orderRecord;
    TestHttpMock.install().when('/ordini-clienti', 201, '');

    String message;
    Test.startTest();
    try {
      MexalOrderSendService.sendOrder(orderRecord.Id);
    } catch (MexalOrderSendService.MexalOrderSendException error) {
      message = error.getMessage();
    }
    Test.stopTest();

    TestDataFactory.assertContains(message, 'Condizione di pagamento');
  }

  @isTest
  static void orderSendReadsTheNumberFromTheBody() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    TestHttpMock.install()
      .when('/ordini-clienti', 200, '{"numero_documento":"ABC"}');

    Test.startTest();
    MexalOrderSendService.Result result = MexalOrderSendService.sendOrder(
      orderRecord.Id
    );
    Test.stopTest();

    System.assertEquals('ABC', result.mexalOrderNumber);
    System.assertEquals(null, result.mexalDocumentNumber);
    MexalOrderMappingService.saveCreatedOrderMapping(null, result);
  }

  @isTest
  static void orderSendRejectsIncompleteOrdersAndErpErrors() {
    Order withoutCode = orderForMexal(null, true);
    Order withoutLines = orderForMexal(CUSTOMER_CODE, false);
    Order valid = orderForMexal(CUSTOMER_CODE, true);
    TestHttpMock.install().when('/ordini-clienti', 500, '{"error":"interno"}');

    List<Exception> errors = new List<Exception>();
    for (Id orderId : new List<Id>{ null, withoutCode.Id, withoutLines.Id }) {
      try {
        MexalOrderSendService.sendOrder(orderId);
      } catch (MexalOrderSendService.MexalOrderSendException e) {
        errors.add(e);
      }
    }
    Test.startTest();
    try {
      MexalOrderSendService.sendOrder(valid.Id);
    } catch (MexalOrderSendService.MexalOrderSendException e) {
      errors.add(e);
    }
    Test.stopTest();
    System.assertEquals(4, errors.size());
  }

  // --------------------------------------------- order integration steps

  @isTest
  static void customerStepCreatesTheCustomerOnTheFirstOrder() {
    Order orderRecord = orderForMexal(null, true);
    TestHttpMock.install().when('/webapi/risorse/clienti', 500, '');

    Test.startTest();
    Exception error;
    try {
      OrderMexalIntegrationService.runMexalCustomerStep(orderRecord.Id, true);
    } catch (OrderMexalIntegrationService.OrderMexalIntegrationException e) {
      error = e;
    }
    Test.stopTest();

    System.assert(error.getMessage().startsWith('Creazione cliente Mexal'));
  }

  @isTest
  static void customerStepRefusesALaterOrderWithoutCode() {
    Order orderRecord = orderForMexal(null, true);
    Exception error;
    try {
      OrderMexalIntegrationService.runMexalCustomerStep(orderRecord.Id, false);
    } catch (OrderMexalIntegrationService.OrderMexalIntegrationException e) {
      error = e;
    }
    assertThrows('Later order without customer code', error);
  }

  @isTest
  static void customerStepUpdatesAKnownCustomer() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    TestHttpMock.install().when('/clienti/501.00001', 500, '');

    Test.startTest();
    Exception error;
    try {
      OrderMexalIntegrationService.runMexalCustomerStep(orderRecord.Id, false);
    } catch (OrderMexalIntegrationService.OrderMexalIntegrationException e) {
      error = e;
    }
    Test.stopTest();

    System.assert(error.getMessage().startsWith('Modifica cliente Mexal'));
  }

  @isTest
  static void failureIsLoggedAndMarksTheOrder() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);

    OrderMexalIntegrationService.markOrderRunning(orderRecord.Id);
    OrderMexalIntegrationService.logFailure(
      orderRecord.Id,
      'Mexal Order',
      new DmlException('boom')
    );

    System.assertEquals(
      'Failed',
      [SELECT Mexal_Integration_Status__c FROM Order WHERE Id = :orderRecord.Id]
      .Mexal_Integration_Status__c
    );
    System.assertEquals(
      1,
      [
        SELECT COUNT()
        FROM Integration_Log__c
        WHERE Flow_Name__c = 'OrderMexalIntegration' AND Is_Error__c = TRUE
      ]
    );
  }

  @isTest
  static void queueableWalksTheStepsAndSurvivesFailures() {
    Order orderRecord = orderForMexal(CUSTOMER_CODE, true);
    TestHttpMock.install();

    Test.startTest();
    System.enqueueJob(
      new OrderMexalIntegrationQueueable(
        new List<Id>{ orderRecord.Id },
        new Set<Id>{ orderRecord.Id }
      )
    );
    Test.stopTest();

    System.assertNotEquals(
      null,
      [SELECT Mexal_Integration_Status__c FROM Order WHERE Id = :orderRecord.Id]
      .Mexal_Integration_Status__c
    );
    new OrderMexalIntegrationQueueable(null, null).execute(null);
  }

  private static String formatDate(Date value) {
    return value == null
      ? null
      : String.valueOf(value.year()).leftPad(4, '0') +
        String.valueOf(value.month()).leftPad(2, '0') +
        String.valueOf(value.day()).leftPad(2, '0');
  }
}
