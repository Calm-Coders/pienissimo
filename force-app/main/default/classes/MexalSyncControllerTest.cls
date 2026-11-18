/**
 * Covers MexalSyncController, the home-page Mexal sync panel's server side:
 * the status card per sync (completed, never run, failed, not configured),
 * the user-safe error translation, the success log links, the manual start
 * of each sync with its guards, and the Full_Permission gate (direct
 * assignment and through a permission set group).
 */
@isTest
private class MexalSyncControllerTest {
  @TestSetup
  static void setup() {
    TestDataFactory.integrationConfigs();
  }

  private static User fullPermissionUser() {
    User adminUser;
    System.runAs(new User(Id = UserInfo.getUserId())) {
      adminUser = TestDataFactory.mexalAdminUser();
    }
    return adminUser;
  }

  private static User userWithoutFullPermission() {
    User plainUser = new User(
      ProfileId = UserInfo.getProfileId(),
      Username = 'mexal.sync.noperm.' +
        String.valueOf(Crypto.getRandomInteger()).replace('-', '') +
        '@pienissimo.test',
      LastName = 'No Full Permission',
      Email = 'no.full.permission@example.com',
      Alias = 'mxnop',
      TimeZoneSidKey = 'Europe/Rome',
      LocaleSidKey = 'it_IT',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'it'
    );
    System.runAs(new User(Id = UserInfo.getUserId())) {
      insert plainUser;
    }
    return plainUser;
  }

  private static Map<String, Integration_Configuration2__c> configs() {
    Map<String, Integration_Configuration2__c> byAction = new Map<String, Integration_Configuration2__c>();
    for (Integration_Configuration2__c row : [
      SELECT Id, Azione__c
      FROM Integration_Configuration2__c
      WHERE
        Azione__c IN (
          'Mexal_Articoli_Ricerca',
          'Mexal_Clienti_Ricerca',
          'Mexal_Movimenti_Magazzino_Ricerca',
          'Mexal_Scadenzario_Ricerca'
        )
    ]) {
      byAction.put(row.Azione__c, row);
    }
    return byAction;
  }

  private static void markAllSuccessful(Datetime lastSuccess) {
    List<Integration_Configuration2__c> rows = configs().values();
    for (Integration_Configuration2__c row : rows) {
      row.Last_Sync_Status__c = 'Success';
      row.Last_Successful_Sync__c = lastSuccess;
      row.Last_Sync_Error__c = null;
    }
    update rows;
  }

  private static Integration_Log__c log(
    String flowName,
    Boolean isError,
    String body
  ) {
    return new Integration_Log__c(
      Flow_Name__c = flowName,
      Is_Error__c = isError,
      Response_Body__c = body
    );
  }

  private static Map<String, MexalSyncController.SyncState> statusByKey(
    User runner
  ) {
    Map<String, MexalSyncController.SyncState> byKey = new Map<String, MexalSyncController.SyncState>();
    System.runAs(runner) {
      for (
        MexalSyncController.SyncState state : MexalSyncController.getStatus()
      ) {
        byKey.put(state.key, state);
      }
    }
    return byKey;
  }

  // --------------------------------------------------------------- status

  @isTest
  static void statusReportsCompletedSyncsWithTheirLogs() {
    User runner = fullPermissionUser();
    markAllSuccessful(Datetime.now().addHours(-1));
    insert new List<Integration_Log__c>{
      log('Mexal_Articoli_Sync', false, 'Sync articoli Mexal: 3'),
      log('Mexal_Clienti_Sync', false, 'Sync clienti Mexal: 2'),
      log('Mexal_Fatture_Scadenzario_Sync', false, 'Sync fatture Mexal: 1'),
      log('Mexal_Fatture_Scadenzario_Sync', false, 'Sync scadenzario Mexal: 4'),
      log('Mexal_Fatture_Scadenzario_Sync', false, null)
    };

    Test.startTest();
    Map<String, MexalSyncController.SyncState> states = statusByKey(runner);
    Test.stopTest();

    System.assertEquals(3, states.size());
    for (MexalSyncController.SyncState state : states.values()) {
      System.assertEquals('Completato', state.status, state.key);
      System.assertEquals(true, state.configured, state.key);
      System.assertEquals(false, state.running, state.key);
      System.assertEquals(null, state.errorReason, state.key);
      System.assertNotEquals(null, state.lastSuccess, state.key);
    }
    System.assertEquals(1, states.get('articles').successLogs.size());
    System.assertEquals(
      'Log articoli',
      states.get('articles').successLogs[0].label
    );
    System.assertEquals(
      'Log clienti',
      states.get('customers').successLogs[0].label
    );
    Set<String> invoiceLabels = new Set<String>();
    for (
      MexalSyncController.LogReference reference : states.get('invoices')
        .successLogs
    ) {
      invoiceLabels.add(reference.label);
      System.assertNotEquals(null, reference.logId);
    }
    System.assertEquals(
      new Set<String>{ 'Log fatture', 'Log scadenzario' },
      invoiceLabels
    );
  }

  @isTest
  static void statusReportsNeverRunFailedAndUnconfiguredSyncs() {
    User runner = fullPermissionUser();
    Map<String, Integration_Configuration2__c> byAction = configs();
    // Articles: configured, never synced.
    Integration_Configuration2__c articles = byAction.get(
      'Mexal_Articoli_Ricerca'
    );
    articles.Last_Successful_Sync__c = null;
    articles.Last_Sync_Status__c = null;
    // Customers: last run failed after an earlier success.
    Integration_Configuration2__c customers = byAction.get(
      'Mexal_Clienti_Ricerca'
    );
    customers.Last_Successful_Sync__c = Datetime.now().addDays(-1);
    customers.Last_Sync_Status__c = 'Failed';
    customers.Last_Sync_Error__c = 'Read timed out';
    update new List<Integration_Configuration2__c>{ articles, customers };
    // Invoices: one of its two configurations is missing.
    delete byAction.get('Mexal_Scadenzario_Ricerca');
    insert new List<Integration_Log__c>{
      log('Mexal_Clienti_Sync', true, 'errore'),
      log('Mexal_Articoli_Sync', true, 'errore'),
      log('Mexal_Fatture_Scadenzario_Sync', true, 'errore')
    };

    Test.startTest();
    Map<String, MexalSyncController.SyncState> states = statusByKey(runner);
    Test.stopTest();

    System.assertEquals('Mai eseguita', states.get('articles').status);
    System.assertEquals(null, states.get('articles').lastSuccess);
    System.assertEquals(null, states.get('articles').errorLogId);

    MexalSyncController.SyncState failed = states.get('customers');
    System.assertEquals('Errore', failed.status);
    System.assertNotEquals(null, failed.errorLogId);
    System.assert(
      failed.errorReason.contains('tempo previsto'),
      failed.errorReason
    );
    System.assert(failed.successLogs.isEmpty());

    System.assertEquals('Non configurato', states.get('invoices').status);
    System.assertEquals(false, states.get('invoices').configured);
    System.assertEquals(null, states.get('invoices').lastSuccess);
  }

  @isTest
  static void statusTranslatesKnownErrorsAndHidesUnknownOnes() {
    User runner = fullPermissionUser();
    Integration_Configuration2__c customers = configs()
      .get('Mexal_Clienti_Ricerca');
    customers.Last_Successful_Sync__c = Datetime.now().addDays(-1);
    customers.Last_Sync_Status__c = 'Failed';

    Map<String, String> expectedFragment = new Map<String, String>{
      'Callout timeout' => 'tempo previsto',
      'statusCode=401' => 'Accesso a Mexal',
      'HTTP 403 Forbidden' => 'rifiutato',
      'statusCode=404' => 'non e stato trovato',
      'UNABLE_TO_LOCK_ROW' => 'in uso',
      'REQUIRED_FIELD_MISSING: Name' => 'controlli di Salesforce',
      'Errore sconosciuto con dati interni' => null,
      '' => null
    };

    Test.startTest();
    for (String rawError : expectedFragment.keySet()) {
      customers.Last_Sync_Error__c = rawError;
      update customers;
      String reason = statusByKey(runner).get('customers').errorReason;
      String fragment = expectedFragment.get(rawError);
      if (fragment == null) {
        System.assertEquals(null, reason, rawError);
      } else {
        System.assert(
          reason != null && reason.contains(fragment),
          rawError + ' -> ' + reason
        );
        // The raw message never reaches the UI.
        System.assert(!reason.contains(rawError), reason);
      }
    }
    Test.stopTest();
  }

  // --------------------------------------------------------------- start

  @isTest
  static void startSyncLaunchesTheArticleBatchAndBlocksASecondStart() {
    User runner = fullPermissionUser();
    TestHttpMock.install().when('/articoli/ricerca', 200, '{"dati":[]}');

    Id jobId;
    Exception secondStart;
    List<AsyncApexJob> active;
    System.runAs(runner) {
      jobId = MexalSyncController.startSync('articles');
      active = [
        SELECT Id
        FROM AsyncApexJob
        WHERE
          ApexClass.Name = 'MexalArticleSyncBatch'
          AND Status IN ('Holding', 'Queued', 'Preparing', 'Processing')
      ];
      try {
        MexalSyncController.startSync('customers');
      } catch (AuraHandledException e) {
        secondStart = e;
      }
    }

    System.assertNotEquals(null, jobId);
    if (!active.isEmpty()) {
      System.assertNotEquals(
        null,
        secondStart,
        'a second sync must not start while one is running'
      );
      System.assert(
        secondStart.getMessage().contains('in corso'),
        secondStart.getMessage()
      );
    }
  }

  @isTest
  static void startSyncLaunchesTheCustomerBatch() {
    User runner = fullPermissionUser();
    TestHttpMock.install()
      .when(
        '/clienti/ricerca',
        200,
        '{"data_ric_elab":"20260928 020000","dati":[]}'
      );

    Id jobId;
    Test.startTest();
    System.runAs(runner) {
      jobId = MexalSyncController.startSync('customers');
    }
    Test.stopTest();

    System.assertNotEquals(null, jobId);
  }

  @isTest
  static void startSyncEnqueuesTheInvoiceJob() {
    User runner = fullPermissionUser();

    Id jobId;
    System.runAs(runner) {
      jobId = MexalSyncController.startSync('invoices');
    }

    System.assertNotEquals(null, jobId);
    System.assertEquals(
      'MexalInvoiceSyncJob',
      [SELECT ApexClass.Name FROM AsyncApexJob WHERE Id = :jobId].ApexClass.Name
    );
  }

  @isTest
  static void startSyncRejectsAnUnknownType() {
    User runner = fullPermissionUser();
    Exception error;
    System.runAs(runner) {
      try {
        MexalSyncController.startSync('ordini');
      } catch (AuraHandledException e) {
        error = e;
      }
    }
    System.assertNotEquals(null, error);
    System.assert(error.getMessage().contains('non valido'));
  }

  @isTest
  static void startSyncRequiresTheConfiguration() {
    User runner = fullPermissionUser();
    delete configs().get('Mexal_Clienti_Ricerca');

    Exception error;
    System.runAs(runner) {
      try {
        MexalSyncController.startSync('customers');
      } catch (AuraHandledException e) {
        error = e;
      }
    }
    System.assertNotEquals(null, error);
    System.assert(error.getMessage().contains('Configurazione Mexal'));
  }

  // --------------------------------------------------------------- access

  @isTest
  static void everyEntryPointRequiresFullPermission() {
    User runner = userWithoutFullPermission();
    Exception statusError;
    Exception startError;
    System.runAs(runner) {
      try {
        MexalSyncController.getStatus();
      } catch (AuraHandledException e) {
        statusError = e;
      }
      try {
        MexalSyncController.startSync('articles');
      } catch (AuraHandledException e) {
        startError = e;
      }
    }
    System.assertNotEquals(null, statusError);
    System.assert(statusError.getMessage().contains('Full_Permission'));
    System.assertNotEquals(null, startError);
    System.assert(startError.getMessage().contains('Full_Permission'));
  }

  @isTest
  static void fullPermissionThroughAPermissionSetGroupIsAccepted() {
    User runner = userWithoutFullPermission();
    System.runAs(new User(Id = UserInfo.getUserId())) {
      PermissionSetGroup psGroup = new PermissionSetGroup(
        DeveloperName = 'Mexal_Sync_Test_Group',
        MasterLabel = 'Mexal Sync Test Group'
      );
      insert psGroup;
      insert new PermissionSetGroupComponent(
        PermissionSetGroupId = psGroup.Id,
        PermissionSetId = [
          SELECT Id
          FROM PermissionSet
          WHERE Name = 'Full_Permission'
          LIMIT 1
        ]
        .Id
      );
      Test.calculatePermissionSetGroup(psGroup.Id);
      insert new PermissionSetAssignment(
        AssigneeId = runner.Id,
        PermissionSetGroupId = psGroup.Id
      );
    }

    Test.startTest();
    Map<String, MexalSyncController.SyncState> states = statusByKey(runner);
    Test.stopTest();

    System.assertEquals(3, states.size());
  }
}
