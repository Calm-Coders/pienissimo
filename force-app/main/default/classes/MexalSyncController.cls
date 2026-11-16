// Privileged org-wide sync entry point. Require Full_Permission as well as
// Salesforce Apex class access. Configuration secrets and raw logs stay server-side.
public without sharing class MexalSyncController {
  private static final Set<String> JOB_CLASSES = new Set<String>{
    'MexalArticleSyncBatch',
    'MexalCustomerSyncBatch',
    'MexalInvoiceSyncJob',
    'MexalInvoiceLineImportBatch'
  };
  private static final Set<String> ACTIVE_STATUSES = new Set<String>{
    'Holding',
    'Queued',
    'Preparing',
    'Processing'
  };
  private static final Map<String, List<String>> ACTIONS = new Map<String, List<String>>{
    'articles' => new List<String>{ 'Mexal_Articoli_Ricerca' },
    'customers' => new List<String>{ 'Mexal_Clienti_Ricerca' },
    'invoices' => new List<String>{
      'Mexal_Movimenti_Magazzino_Ricerca',
      'Mexal_Scadenzario_Ricerca'
    }
  };

  public class SyncState {
    @AuraEnabled
    public String key;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public Datetime lastSuccess;
    @AuraEnabled
    public Boolean running;
    @AuraEnabled
    public Boolean configured;
    @AuraEnabled
    public Boolean blocked;
    @AuraEnabled
    public String errorReason;
    @AuraEnabled
    public Id errorLogId;
    @AuraEnabled
    public List<LogReference> successLogs;
  }

  public class LogReference {
    @AuraEnabled
    public Id logId;
    @AuraEnabled
    public String label;
  }

  @AuraEnabled
  public static List<SyncState> getStatus() {
    requireFullPermission();
    Map<String, Integration_Configuration2__c> configs = new Map<String, Integration_Configuration2__c>();
    for (Integration_Configuration2__c row : [
      SELECT
        Azione__c,
        Last_Successful_Sync__c,
        Last_Sync_Status__c,
        Last_Sync_Error__c
      FROM Integration_Configuration2__c
      WHERE
        Azione__c IN (
          'Mexal_Articoli_Ricerca',
          'Mexal_Clienti_Ricerca',
          'Mexal_Movimenti_Magazzino_Ricerca',
          'Mexal_Scadenzario_Ricerca'
        )
    ]) {
      configs.put(row.Azione__c, row);
    }
    List<AsyncApexJob> active = activeJobs();
    Map<String, Integration_Log__c> successLogs = latestSuccessLogs();
    Map<String, Integration_Log__c> latestErrorLogs = new Map<String, Integration_Log__c>();
    for (Integration_Log__c logRow : [
      SELECT Id, Flow_Name__c, CreatedDate
      FROM Integration_Log__c
      WHERE
        Is_Error__c = TRUE
        AND Flow_Name__c IN (
          'Mexal_Articoli_Sync',
          'Mexal_Clienti_Sync',
          'Mexal_Fatture_Scadenzario_Sync'
        )
      ORDER BY CreatedDate DESC
      LIMIT 100
    ]) {
      String logKey = logRow.Flow_Name__c == 'Mexal_Articoli_Sync'
        ? 'articles'
        : logRow.Flow_Name__c == 'Mexal_Clienti_Sync'
            ? 'customers'
            : 'invoices';
      if (!latestErrorLogs.containsKey(logKey))
        latestErrorLogs.put(logKey, logRow);
    }
    // Include scheduler runs and other users, not only jobs launched by this card.
    List<AsyncApexJob> recent = [
      SELECT ApexClass.Name, Status, NumberOfErrors, CreatedDate
      FROM AsyncApexJob
      WHERE ApexClass.Name IN :JOB_CLASSES AND JobType != 'BatchApexWorker'
      ORDER BY CreatedDate DESC
      LIMIT 100
    ];
    List<SyncState> states = new List<SyncState>();
    for (String key : new List<String>{ 'articles', 'customers', 'invoices' }) {
      SyncState state = new SyncState();
      state.key = key;
      state.successLogs = new List<LogReference>();
      state.running = false;
      state.configured = true;
      state.blocked = !active.isEmpty();
      Boolean failed = false;
      Boolean neverRun = false;
      for (String action : ACTIONS.get(key)) {
        Integration_Configuration2__c config = configs.get(action);
        if (config == null) {
          state.configured = false;
          continue;
        }
        failed = failed || config.Last_Sync_Status__c == 'Failed';
        if (
          config.Last_Sync_Status__c == 'Failed' &&
          state.errorReason == null
        ) {
          state.errorReason = safeErrorReason(config.Last_Sync_Error__c);
        }
        neverRun = neverRun || config.Last_Successful_Sync__c == null;
        if (
          config.Last_Successful_Sync__c != null &&
          (state.lastSuccess == null ||
          config.Last_Successful_Sync__c < state.lastSuccess)
        ) {
          state.lastSuccess = config.Last_Successful_Sync__c;
        }
      }
      if (neverRun || !state.configured) {
        state.lastSuccess = null;
      }
      for (AsyncApexJob job : active) {
        if (keyForClass(job.ApexClass.Name) == key) {
          state.running = true;
        }
      }
      for (AsyncApexJob job : recent) {
        if (
          keyForClass(job.ApexClass.Name) == key &&
          (state.lastSuccess == null ||
          job.CreatedDate >= state.lastSuccess) &&
          (job.NumberOfErrors > 0 ||
          job.Status == 'Failed' ||
          job.Status == 'Aborted')
        ) {
          failed = true;
        }
      }
      state.status = state.running
        ? 'In corso'
        : !state.configured
            ? 'Non configurato'
            : failed
                ? 'Errore'
                : state.lastSuccess == null ? 'Mai eseguita' : 'Completato';
      Integration_Log__c errorLog = latestErrorLogs.get(key);
      if (
        state.status == 'Errore' &&
        errorLog != null &&
        (state.lastSuccess == null ||
        errorLog.CreatedDate >= state.lastSuccess)
      ) {
        state.errorLogId = errorLog.Id;
      }
      if (state.status == 'Completato') {
        for (String action : ACTIONS.get(key)) {
          Integration_Log__c logRow = successLogs.get(action);
          Integration_Configuration2__c config = configs.get(action);
          // Never present a previous run's log as evidence for the latest sync.
          if (
            logRow != null &&
            config.Last_Successful_Sync__c != null &&
            logRow.CreatedDate >= config.Last_Successful_Sync__c
          ) {
            LogReference reference = new LogReference();
            reference.logId = logRow.Id;
            reference.label = key == 'articles'
              ? 'Log articoli'
              : key == 'customers'
                  ? 'Log clienti'
                  : action == 'Mexal_Movimenti_Magazzino_Ricerca'
                      ? 'Log fatture'
                      : 'Log scadenzario';
            state.successLogs.add(reference);
          }
        }
      }
      if (state.status != 'Errore')
        state.errorReason = null;
      states.add(state);
    }
    return states;
  }

  @AuraEnabled
  public static Id startSync(String syncType) {
    requireFullPermission();
    if (!ACTIONS.containsKey(syncType)) {
      throw handled('Tipo di sincronizzazione non valido.');
    }
    // Serialize starts across tabs/users using the same rows the sync jobs lock.
    // Lock all four, since customers must not race invoice linking.
    List<Integration_Configuration2__c> lockedConfigs = [
      SELECT Id, Azione__c
      FROM Integration_Configuration2__c
      WHERE
        Azione__c IN (
          'Mexal_Articoli_Ricerca',
          'Mexal_Clienti_Ricerca',
          'Mexal_Movimenti_Magazzino_Ricerca',
          'Mexal_Scadenzario_Ricerca'
        )
      FOR UPDATE
    ];
    Set<String> configuredActions = new Set<String>();
    for (Integration_Configuration2__c config : lockedConfigs) {
      configuredActions.add(config.Azione__c);
    }
    if (!configuredActions.containsAll(ACTIONS.get(syncType))) {
      throw handled(
        'Configurazione Mexal mancante. Contattare un amministratore.'
      );
    }
    if (!activeJobs().isEmpty()) {
      throw handled(
        'Una sincronizzazione Mexal e gia in corso. Attendere il completamento.'
      );
    }
    if (syncType == 'articles') {
      return Database.executeBatch(new MexalArticleSyncBatch(), 1);
    }
    if (syncType == 'customers') {
      return Database.executeBatch(new MexalCustomerSyncBatch(), 1);
    }
    return System.enqueueJob(new MexalInvoiceSyncJob());
  }

  private static Map<String, Integration_Log__c> latestSuccessLogs() {
    Map<String, Integration_Log__c> logs = new Map<String, Integration_Log__c>();
    for (Integration_Log__c row : [
      SELECT Id, CreatedDate
      FROM Integration_Log__c
      WHERE Is_Error__c = FALSE AND Flow_Name__c = 'Mexal_Articoli_Sync'
      ORDER BY CreatedDate DESC
      LIMIT 1
    ]) {
      logs.put('Mexal_Articoli_Ricerca', row);
    }
    for (Integration_Log__c row : [
      SELECT Id, CreatedDate
      FROM Integration_Log__c
      WHERE Is_Error__c = FALSE AND Flow_Name__c = 'Mexal_Clienti_Sync'
      ORDER BY CreatedDate DESC
      LIMIT 1
    ]) {
      logs.put('Mexal_Clienti_Ricerca', row);
    }
    // The invoice flow writes separate summary logs for its two steps. Read only
    // a bounded set of summaries; send record links, never raw payloads, to the UI.
    for (Integration_Log__c row : [
      SELECT Id, CreatedDate, Response_Body__c
      FROM Integration_Log__c
      WHERE
        Is_Error__c = FALSE
        AND Flow_Name__c = 'Mexal_Fatture_Scadenzario_Sync'
      ORDER BY CreatedDate DESC
      LIMIT 10
    ]) {
      String message = row.Response_Body__c == null ? '' : row.Response_Body__c;
      String action = message.startsWith('Sync fatture Mexal:')
        ? 'Mexal_Movimenti_Magazzino_Ricerca'
        : message.startsWith('Sync scadenzario Mexal:')
            ? 'Mexal_Scadenzario_Ricerca'
            : null;
      if (action != null && !logs.containsKey(action))
        logs.put(action, row);
    }
    return logs;
  }

  private static List<AsyncApexJob> activeJobs() {
    return [
      SELECT ApexClass.Name, Status
      FROM AsyncApexJob
      WHERE
        ApexClass.Name IN :JOB_CLASSES
        AND Status IN :ACTIVE_STATUSES
        AND JobType != 'BatchApexWorker'
    ];
  }

  private static String keyForClass(String className) {
    if (className == 'MexalArticleSyncBatch')
      return 'articles';
    if (className == 'MexalCustomerSyncBatch')
      return 'customers';
    return 'invoices';
  }

  // Translate recognized failures without exposing raw payloads, credentials,
  // customer data or catalogue values from configuration/log messages.
  private static String safeErrorReason(String rawError) {
    if (String.isBlank(rawError))
      return null;
    String message = rawError.toLowerCase();
    if (message.contains('timeout') || message.contains('timed out')) {
      return 'Mexal non ha risposto entro il tempo previsto. Riprovare tra qualche minuto.';
    }
    if (
      message.contains('statuscode=401') ||
      message.contains('http 401') ||
      message.contains('unauthorized')
    ) {
      return 'Accesso a Mexal non riuscito. Chiedere a un amministratore di verificare la connessione.';
    }
    if (
      message.contains('statuscode=403') ||
      message.contains('http 403') ||
      message.contains('forbidden')
    ) {
      return 'Mexal ha rifiutato la richiesta. Chiedere a un amministratore di verificare le autorizzazioni.';
    }
    if (message.contains('statuscode=404') || message.contains('http 404')) {
      return 'Il servizio richiesto non e stato trovato in Mexal. Chiedere a un amministratore di verificare la configurazione.';
    }
    if (message.contains('unable_to_lock_row')) {
      return 'Alcuni record sono in uso da un altro processo. Attendere e riprovare.';
    }
    if (
      message.contains('required_field_missing') ||
      message.contains('restricted_picklist') ||
      message.contains('field_custom_validation_exception') ||
      message.contains('duplicate_value')
    ) {
      return 'Alcuni dati non rispettano i controlli di Salesforce. Consultare il log e correggere i dati prima di riprovare.';
    }
    return null;
  }

  private static void requireFullPermission() {
    Id currentUserId = UserInfo.getUserId();
    if (
      ![
          SELECT Id
          FROM PermissionSetAssignment
          WHERE
            AssigneeId = :currentUserId
            AND PermissionSet.Name = 'Full_Permission'
            AND (ExpirationDate = NULL
            OR ExpirationDate >= TODAY)
          LIMIT 1
        ]
        .isEmpty()
    ) {
      return;
    }
    Set<Id> groupIds = new Set<Id>();
    for (PermissionSetGroupComponent component : [
      SELECT PermissionSetGroupId
      FROM PermissionSetGroupComponent
      WHERE PermissionSet.Name = 'Full_Permission'
    ]) {
      groupIds.add(component.PermissionSetGroupId);
    }
    if (
      !groupIds.isEmpty() &&
      ![
          SELECT Id
          FROM PermissionSetAssignment
          WHERE
            AssigneeId = :currentUserId
            AND PermissionSetGroupId IN :groupIds
            AND (ExpirationDate = NULL
            OR ExpirationDate >= TODAY)
          LIMIT 1
        ]
        .isEmpty()
    ) {
      return;
    }
    throw handled(
      'Questa funzione richiede il permission set Full_Permission.'
    );
  }

  private static AuraHandledException handled(String message) {
    AuraHandledException error = new AuraHandledException(message);
    error.setMessage(message);
    return error;
  }
}
