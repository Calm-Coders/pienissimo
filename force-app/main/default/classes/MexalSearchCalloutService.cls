public with sharing class MexalSearchCalloutService {
  private static final String DEFAULT_NAMED_CREDENTIAL = 'Mexal';
  private static final String COORDINATE_GESTIONALE_HEADER = 'Coordinate-Gestionale';
  private static final String CONTENT_TYPE_JSON = 'application/json';
  private static final String MEXAL_COMPANY = 'PIE';
  private static final String CUSTOMER_SEARCH_ACTION = 'Mexal_Clienti_Ricerca';
  private static final String ARTICLE_SEARCH_ACTION = 'Mexal_Articoli_Ricerca';
  private static final String CUSTOMER_CREATE_ACTION = 'Mexal_Clienti_Creazione';
  private static final String CUSTOMER_UPDATE_ACTION = 'Mexal_Clienti_Modifica';
  private static final String CUSTOMER_SEARCH_FIELDS = 'codice,cod_alternativo,cod_paese,codice_fiscale,partita_iva,ragione_sociale,indirizzo,cap,localita,provincia,telefono,fax,email,pec,codice_sdi,cod_agente,tp_nazionalita,cod_listino,valuta,gest_fatt_el';
  private static final Set<String> READ_ONLY_ACTIONS = new Set<String>{
    CUSTOMER_SEARCH_ACTION,
    ARTICLE_SEARCH_ACTION
  };
  private static final Set<String> WRITE_ACTIONS = new Set<String>{
    CUSTOMER_CREATE_ACTION,
    CUSTOMER_UPDATE_ACTION
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
    public List<String> responseHeaders;
    @AuraEnabled
    public List<Integration_Log__c> integrationLogs;

    public Result() {
      success = false;
      responseHeaders = new List<String>();
      integrationLogs = new List<Integration_Log__c>();
    }
  }

  public class MexalSearchCalloutException extends Exception {
  }

  public static Result search(String actionName, Object requestBody) {
    return sendReadOnly(actionName, requestBody, true);
  }

  public static Result createCustomer(Object requestBody) {
    return sendWrite(CUSTOMER_CREATE_ACTION, requestBody, true);
  }

  public static Result updateCustomer(String customerCode, Object requestBody) {
    if (String.isBlank(customerCode)) {
      throw new MexalSearchCalloutException(
        'Codice cliente Mexal obbligatorio per modifica cliente.'
      );
    }

    Integration_Configuration2__c config = resolveConfiguration(
      CUSTOMER_UPDATE_ACTION
    );
    validateWriteConfiguration(CUSTOMER_UPDATE_ACTION, config);
    config.Endpoint_Path__c = replacePathParam(
      config.Endpoint_Path__c,
      'codice',
      customerCode.trim()
    );
    return send(CUSTOMER_UPDATE_ACTION, config, requestBody, true);
  }

  public static Result sendReadOnly(
    String actionName,
    Object requestBody,
    Boolean insertLog
  ) {
    validateReadOnlyAction(actionName);

    Integration_Configuration2__c config = resolveConfiguration(actionName);
    validateReadOnlyConfiguration(actionName, config);

    String requestJson = requestBody == null
      ? '{}'
      : JSON.serialize(requestBody);
    HttpRequest request = buildRequest(actionName, config, requestJson);
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

  public static Result sendWrite(
    String actionName,
    Object requestBody,
    Boolean insertLog
  ) {
    validateWriteAction(actionName);

    Integration_Configuration2__c config = resolveConfiguration(actionName);
    validateWriteConfiguration(actionName, config);

    return send(actionName, config, requestBody, insertLog);
  }

  private static Result send(
    String actionName,
    Integration_Configuration2__c config,
    Object requestBody,
    Boolean insertLog
  ) {
    String requestJson = requestBody == null
      ? '{}'
      : JSON.serialize(requestBody);
    HttpRequest request = buildRequest(actionName, config, requestJson);
    Integration_Log__c logRow = buildLog(actionName, request, requestJson);
    Result result = new Result();

    try {
      Long sentAt = DateTime.now().getTime();
      HttpResponse response = new Http().send(request);
      Long receivedAt = DateTime.now().getTime();

      result.statusCode = response.getStatusCode();
      result.body = response.getBody();
      result.responseHeaders = collectResponseHeaders(response);
      result.success = !isErrorStatusCode(result.statusCode);

      logRow.Response_State__c = String.valueOf(result.statusCode);
      logRow.Is_Error__c = !result.success;
      logRow.Response_Body__c = abbreviate(
        buildElapsedTime(sentAt, receivedAt) +
          '************HEADERS: ' +
          String.join(result.responseHeaders, '\n') +
          '************BODY: ' +
          result.body
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

  private static Integration_Configuration2__c resolveConfiguration(
    String actionName
  ) {
    List<Integration_Configuration2__c> configs = [
      SELECT
        Azione__c,
        Content_Type_JSON__c,
        Endpoint_Path__c,
        HTTP_Method__c,
        Name,
        Named_Credential_Prod__c,
        Named_Credential_Sandbox__c,
        Timeout__c
      FROM Integration_Configuration2__c
      WHERE Azione__c = :actionName
      ORDER BY Name
      LIMIT 1
    ];

    return configs.isEmpty() ? null : configs[0];
  }

  private static void validateReadOnlyAction(String actionName) {
    if (!READ_ONLY_ACTIONS.contains(actionName)) {
      throw new MexalSearchCalloutException(
        'Azione Mexal non consentita in modalita sola lettura: ' + actionName
      );
    }
  }

  private static void validateWriteAction(String actionName) {
    if (!WRITE_ACTIONS.contains(actionName)) {
      throw new MexalSearchCalloutException(
        'Azione Mexal non consentita in modalita scrittura: ' + actionName
      );
    }
  }

  private static void validateReadOnlyConfiguration(
    String actionName,
    Integration_Configuration2__c config
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
    if (!pathWithoutQueryString(config.Endpoint_Path__c).endsWith('/ricerca')) {
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

  private static void validateWriteConfiguration(
    String actionName,
    Integration_Configuration2__c config
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
    if (pathWithoutQueryString(config.Endpoint_Path__c).endsWith('/ricerca')) {
      throw new MexalSearchCalloutException(
        'Gli endpoint Mexal /ricerca non sono consentiti in scrittura.'
      );
    }
    if (
      actionName == CUSTOMER_CREATE_ACTION &&
      getHttpMethod(config) != 'POST'
    ) {
      throw new MexalSearchCalloutException(
        'La creazione cliente Mexal deve usare HTTP POST.'
      );
    }
    if (
      actionName == CUSTOMER_UPDATE_ACTION &&
      getHttpMethod(config) != 'PUT'
    ) {
      throw new MexalSearchCalloutException(
        'La modifica cliente Mexal deve usare HTTP PUT.'
      );
    }
  }

  private static HttpRequest buildRequest(
    String actionName,
    Integration_Configuration2__c config,
    String requestJson
  ) {
    HttpRequest request = new HttpRequest();
    request.setEndpoint(buildEndpoint(actionName, config));
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

  private static String buildEndpoint(
    String actionName,
    Integration_Configuration2__c config
  ) {
    String namedCredential = IS_SANDBOX
      ? config.Named_Credential_Sandbox__c
      : config.Named_Credential_Prod__c;

    if (String.isBlank(namedCredential)) {
      namedCredential = DEFAULT_NAMED_CREDENTIAL;
    }

    return 'callout:' +
      namedCredential +
      appendActionQueryParameters(actionName, config.Endpoint_Path__c);
  }

  private static String appendActionQueryParameters(
    String actionName,
    String endpointPath
  ) {
    if (
      actionName != CUSTOMER_SEARCH_ACTION || endpointPath.contains('fields=')
    ) {
      return endpointPath;
    }

    return endpointPath +
      (endpointPath.contains('?') ? '&' : '?') +
      'fields=' +
      CUSTOMER_SEARCH_FIELDS;
  }

  private static String pathWithoutQueryString(String endpointPath) {
    Integer queryIndex = endpointPath.indexOf('?');
    return queryIndex < 0
      ? endpointPath
      : endpointPath.substring(0, queryIndex);
  }

  private static String replacePathParam(
    String endpointPath,
    String paramName,
    String paramValue
  ) {
    if (String.isBlank(endpointPath)) {
      return endpointPath;
    }

    return endpointPath.replace(
      '{' + paramName + '}',
      EncodingUtil.urlEncode(paramValue, 'UTF-8').replace('+', '%20')
    );
  }

  private static String getHttpMethod(Integration_Configuration2__c config) {
    return String.isBlank(config.HTTP_Method__c)
      ? null
      : config.HTTP_Method__c.trim().toUpperCase();
  }

  private static Integer getTimeout(Integration_Configuration2__c config) {
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

  private static List<String> collectResponseHeaders(HttpResponse response) {
    List<String> headers = new List<String>();
    for (String headerName : response.getHeaderKeys()) {
      headers.add(headerName + '=' + response.getHeader(headerName));
    }
    headers.sort();
    return headers;
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
