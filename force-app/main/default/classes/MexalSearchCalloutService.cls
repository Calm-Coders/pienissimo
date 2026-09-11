public with sharing class MexalSearchCalloutService {
  private static final String DEFAULT_NAMED_CREDENTIAL = 'Mexal';
  private static final String COORDINATE_GESTIONALE_HEADER = 'Coordinate-Gestionale';
  private static final String CONTENT_TYPE_JSON = 'application/json';
  private static final String MEXAL_COMPANY = 'PIE';
  private static final Set<String> READ_ONLY_ACTIONS = new Set<String>{
    'Mexal_Clienti_Ricerca',
    'Mexal_Articoli_Ricerca'
  };

  private static final Boolean IS_SANDBOX = [
    SELECT IsSandbox
    FROM Organization
    LIMIT 1
  ]
  .IsSandbox;

  public class Result {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public Integer statusCode;
    @AuraEnabled
    public String body;
    @AuraEnabled
    public List<Integration_Log__c> integrationLogs;

    public Result() {
      success = false;
      integrationLogs = new List<Integration_Log__c>();
    }
  }

  public class MexalSearchCalloutException extends Exception {
  }

  public static Result search(String actionName, Object requestBody) {
    return sendReadOnly(actionName, requestBody, true);
  }

  public static Result sendReadOnly(
    String actionName,
    Object requestBody,
    Boolean insertLog
  ) {
    validateReadOnlyAction(actionName);

    Integration_Configuration__c config = resolveConfiguration(actionName);
    validateReadOnlyConfiguration(actionName, config);

    String requestJson = requestBody == null
      ? '{}'
      : JSON.serialize(requestBody);
    HttpRequest request = buildRequest(config, requestJson);
    Integration_Log__c logRow = buildLog(actionName, request, requestJson);
    Result result = new Result();

    try {
      Long sentAt = DateTime.now().getTime();
      HttpResponse response = new Http().send(request);
      Long receivedAt = DateTime.now().getTime();

      result.statusCode = response.getStatusCode();
      result.body = response.getBody();
      result.success = !isErrorStatusCode(result.statusCode);

      logRow.Response_State__c = String.valueOf(result.statusCode);
      logRow.Is_Error__c = !result.success;
      logRow.Response_Body__c = abbreviate(
        buildElapsedTime(sentAt, receivedAt) + '************' + result.body
      );
    } catch (Exception error) {
      logRow.Is_Error__c = true;
      logRow.Exception_Message__c = abbreviate(
        error.getTypeName() + '\n' + error.getMessage()
      );
      logRow.Exception_StackTrace__c = abbreviate(error.getStackTraceString());
    }

    saveLog(logRow, result, insertLog);
    return result;
  }

  private static Integration_Configuration__c resolveConfiguration(
    String actionName
  ) {
    List<Integration_Configuration__c> configs = [
      SELECT
        Azione__c,
        Content_Type_JSON__c,
        Endpoint_Path__c,
        HTTP_Method__c,
        Name,
        Named_Credential_Prod__c,
        Named_Credential_Sandbox__c,
        SetupOwnerId,
        Timeout__c
      FROM Integration_Configuration__c
      WHERE Azione__c = :actionName AND SetupOwnerId IN :getHierarchyOwnerIds()
    ];

    return chooseHierarchyConfiguration(configs);
  }

  private static Set<Id> getHierarchyOwnerIds() {
    return new Set<Id>{
      UserInfo.getUserId(),
      UserInfo.getProfileId(),
      UserInfo.getOrganizationId()
    };
  }

  private static Integration_Configuration__c chooseHierarchyConfiguration(
    List<Integration_Configuration__c> configs
  ) {
    Integration_Configuration__c profileConfig;
    Integration_Configuration__c orgConfig;

    for (Integration_Configuration__c config : configs) {
      if (config.SetupOwnerId == UserInfo.getUserId()) {
        return config;
      }
      if (config.SetupOwnerId == UserInfo.getProfileId()) {
        profileConfig = config;
      }
      if (config.SetupOwnerId == UserInfo.getOrganizationId()) {
        orgConfig = config;
      }
    }

    return profileConfig == null ? orgConfig : profileConfig;
  }

  private static void validateReadOnlyAction(String actionName) {
    if (!READ_ONLY_ACTIONS.contains(actionName)) {
      throw new MexalSearchCalloutException(
        'Azione Mexal non consentita in modalita sola lettura: ' + actionName
      );
    }
  }

  private static void validateReadOnlyConfiguration(
    String actionName,
    Integration_Configuration__c config
  ) {
    if (config == null) {
      throw new MexalSearchCalloutException(
        'Configurazione Mexal non trovata per azione: ' + actionName
      );
    }
    if (String.isBlank(config.Endpoint_Path__c)) {
      throw new MexalSearchCalloutException(
        'Endpoint Path obbligatorio per azione Mexal: ' + actionName
      );
    }
    if (!config.Endpoint_Path__c.endsWith('/ricerca')) {
      throw new MexalSearchCalloutException(
        'Sono consentiti solo endpoint Mexal /ricerca.'
      );
    }
    if (getHttpMethod(config) != 'POST') {
      throw new MexalSearchCalloutException(
        'Le ricerche Mexal devono usare HTTP POST.'
      );
    }
  }

  private static HttpRequest buildRequest(
    Integration_Configuration__c config,
    String requestJson
  ) {
    HttpRequest request = new HttpRequest();
    request.setEndpoint(buildEndpoint(config));
    request.setMethod(getHttpMethod(config));
    request.setTimeout(getTimeout(config));
    request.setHeader('Content-Type', CONTENT_TYPE_JSON);
    request.setHeader(
      COORDINATE_GESTIONALE_HEADER,
      'Azienda=' +
        MEXAL_COMPANY +
        ' Anno=' +
        String.valueOf(Date.today().year())
    );
    request.setBody(requestJson);
    return request;
  }

  private static String buildEndpoint(Integration_Configuration__c config) {
    String namedCredential = IS_SANDBOX
      ? config.Named_Credential_Sandbox__c
      : config.Named_Credential_Prod__c;

    if (String.isBlank(namedCredential)) {
      namedCredential = DEFAULT_NAMED_CREDENTIAL;
    }

    return 'callout:' + namedCredential + config.Endpoint_Path__c;
  }

  private static String getHttpMethod(Integration_Configuration__c config) {
    return String.isBlank(config.HTTP_Method__c)
      ? null
      : config.HTTP_Method__c.trim().toUpperCase();
  }

  private static Integer getTimeout(Integration_Configuration__c config) {
    return config.Timeout__c == null ? 120000 : config.Timeout__c.intValue();
  }

  private static Integration_Log__c buildLog(
    String actionName,
    HttpRequest request,
    String requestJson
  ) {
    return new Integration_Log__c(
      Flow_Name__c = actionName,
      Inbound_Outbound__c = 'Outbound',
      Request_Body__c = abbreviate(requestJson),
      Request_Endpoint__c = abbreviate(request.getEndpoint()),
      Request_Headers__c = abbreviate(
        'Content-Type=' +
          CONTENT_TYPE_JSON +
          '\n' +
          COORDINATE_GESTIONALE_HEADER +
          '=' +
          request.getHeader(COORDINATE_GESTIONALE_HEADER) +
          '\nAuthorization=<managed by Named Credential>'
      )
    );
  }

  private static Boolean isErrorStatusCode(Integer statusCode) {
    return statusCode == null || statusCode < 200 || statusCode >= 300;
  }

  private static void saveLog(
    Integration_Log__c logRow,
    Result result,
    Boolean insertLog
  ) {
    if (insertLog) {
      insert logRow;
    }
    result.integrationLogs.add(logRow);
  }

  private static String buildElapsedTime(Long sentAt, Long receivedAt) {
    return 'Timestamp invio richiesta: ' +
      String.valueOf(sentAt) +
      ' ; Timestamp ricezione risposta: ' +
      String.valueOf(receivedAt) +
      ' ; ELAPSED TIME: ' +
      String.valueOf(receivedAt - sentAt) +
      ' ms .';
  }

  private static String abbreviate(String value) {
    return value == null ? null : value.abbreviate(131072);
  }
}
