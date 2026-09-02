/**
 * @description       : Class used for REST API
 **/
public without sharing class API_Callout_Engine {
  /* Method to be used to call a REST API, with JSON input/output and Named Credential for authentication,
   defined in a record of the Integration_Configuration__c custom setting*/
  private static final Boolean isSandBox = [
    SELECT IsSandbox
    FROM Organization
    LIMIT 1
  ]
  .IsSandbox;

  public class Result {
    @AuraEnabled
    public Object payload;
    @AuraEnabled
    public List<Integration_Log__c> integrationLogs;

    public Result() {
      payload = null;
      integrationLogs = new List<Integration_Log__c>();
    }
  }

  @AuraEnabled
  public static Object callApi(String apiName, Object request) {
    Result result = callApi(apiName, request, true);
    return result.payload;
  }

  @AuraEnabled
  public static Object callApiWithPathParams(
    String apiName,
    Object request,
    Map<String, String> pathParams
  ) {
    Result result = callApi(apiName, request, true, pathParams);
    return result.payload;
  }

  public static Result callApi(
    String apiName,
    Object request,
    Boolean insertLog
  ) {
    return callApi(apiName, request, insertLog, null);
  }

  public static Result callApi(
    String apiName,
    Object request,
    Boolean insertLog,
    Map<String, String> pathParams
  ) {
    System.debug('** Callout_Engine.callApi start **');
    System.debug('** Input apiName: ' + apiName + ' **');
    System.debug('** Input request: ' + request + ' **');
    System.debug('** Input pathParams: ' + pathParams + ' **');

    Result result = new Result();
    String respJson;
    Integration_Log__c logRow;

    try {
      // Retrieve Config, Create Log
      Integration_Configuration__c config = resolveIntegrationConfiguration(
        apiName
      );
      String reqJson = JSON.serialize(request);
      System.debug('Request after serialization :::' + reqJson);
      logRow = buildLog(apiName, reqJson);

      if (config == null) {
        logRow.Is_Error__c = true;
        logRow.Response_Body__c = abbreviate(
          'ERROR: The system could not find an Integration_Configuration__c custom setting record having name or Azione__c ' +
          apiName
        );
        saveLog(logRow, result, insertLog);
        return result;
      }

      // Make HTTP request
      HttpRequest req = buildRequest(config, reqJson, pathParams);

      HttpResponse res;
      Long timestampCallout = DateTime.now().getTime();
      if (!config.Use_Mock__c) {
        res = new Http().send(req);
      } else {
        res = runMock(config, req);
      }
      Long timestampResponseReceived = DateTime.now().getTime();

      respJson = res.getBody();
      logRow.Response_State__c = String.valueOf(res.getStatusCode());
      logRow.Is_Error__c = isErrorStatusCode(res.getStatusCode());
      logRow.Response_Body__c = abbreviate(
        buildElapsedTime(timestampCallout, timestampResponseReceived) +
          '************' +
          respJson
      );

      if (
        !hasJsonResponse(respJson) ||
        String.isBlank(config.Response_Wrapper_Class__c)
      ) {
        saveLog(logRow, result, insertLog);
        return result;
      }

      result.payload = deserializeResponse(config, respJson);
      saveLog(logRow, result, insertLog);
      return result;
    } catch (Exception e) {
      if (logRow == null) {
        logRow = new Integration_Log__c(
          Flow_Name__c = apiName,
          Inbound_Outbound__c = 'Outbound',
          Request_Body__c = JSON.serialize(request).abbreviate(131072)
        );
      }

      logRow.Is_Error__c = true;
      if (String.isBlank(logRow.Response_Body__c)) {
        logRow.Response_Body__c = (respJson)?.abbreviate(131072);
      }
      logRow.Exception_Message__c = (e.getTypeName() +
        '\n' +
        e.getMessage())
        .abbreviate(131072);
      logRow.Exception_StackTrace__c = (e.getStackTraceString())
        .abbreviate(131072);
      saveLog(logRow, result, insertLog);
      return result;
    }
  }

  @AuraEnabled
  public static Integration_Configuration__c getIntegrationConfiguration(
    String datasetName
  ) {
    return resolveIntegrationConfiguration(datasetName);
  }

  @AuraEnabled
  public static String getHost() {
    return Url.getOrgDomainUrl().getHost();
  }

  @AuraEnabled
  public static API_Callout_Engine.Result callApiResponseWrapper(
    String apiName,
    Object request
  ) {
    return callApi(apiName, request, true);
  }

  @AuraEnabled
  public static API_Callout_Engine.Result callApiResponseWrapperWithPathParams(
    String apiName,
    Object request,
    Map<String, String> pathParams
  ) {
    return callApi(apiName, request, true, pathParams);
  }

  private static Integration_Log__c buildLog(String apiName, String reqJson) {
    return new Integration_Log__c(
      Flow_Name__c = apiName,
      Inbound_Outbound__c = 'Outbound',
      Request_Body__c = reqJson.abbreviate(131072)
    );
  }

  private static Integration_Configuration__c resolveIntegrationConfiguration(
    String apiName
  ) {
    Integration_Configuration__c config = getConfigurationBySetupOwner(apiName);

    if (hasCallableConfiguration(config)) {
      return config;
    }

    Integration_Configuration__c actionConfig = getConfigurationByAction(
      apiName
    );
    return actionConfig == null ? config : actionConfig;
  }

  private static Integration_Configuration__c getConfigurationBySetupOwner(
    String setupOwnerId
  ) {
    try {
      return Integration_Configuration__c.getValues(setupOwnerId);
    } catch (System.InvalidParameterValueException ignored) {
      return null;
    }
  }

  private static Boolean hasCallableConfiguration(
    Integration_Configuration__c config
  ) {
    return config != null &&
      !String.isBlank(config.HTTP_Method__c) &&
      !String.isBlank(config.Endpoint_Path__c);
  }

  private static Integration_Configuration__c getConfigurationByAction(
    String apiName
  ) {
    List<Integration_Configuration__c> configs = [
      SELECT
        Apikey__c,
        Azione__c,
        Content_Type_Encoded__c,
        Content_Type_JSON__c,
        Endpoint_Host__c,
        Endpoint_Path__c,
        HTTP_Method__c,
        Mock_API_Scenario__c,
        Mock_Apex_Class__c,
        Name,
        Named_Credential_Prod__c,
        Named_Credential_Sandbox__c,
        Request_Wrapper_Class__c,
        Response_Wrapper_Class__c,
        SetupOwnerId,
        Timeout__c,
        Token__c,
        Use_Mock__c
      FROM Integration_Configuration__c
      WHERE Azione__c = :apiName AND SetupOwnerId IN :getHierarchyOwnerIds()
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

  private static HttpRequest buildRequest(
    Integration_Configuration__c config,
    String reqJson
  ) {
    return buildRequest(config, reqJson, null);
  }

  private static HttpRequest buildRequest(
    Integration_Configuration__c config,
    String reqJson,
    Map<String, String> pathParams
  ) {
    HttpRequest req = new HttpRequest();
    req.setEndpoint(buildEndpoint(config, pathParams));
    req.setMethod(getHttpMethod(config));
    req.setTimeout(getTimeout(config));
    setHeaders(req, config);

    if (getHttpMethod(config) != 'GET') {
      req.setBody(reqJson);
    }

    return req;
  }

  private static String buildEndpoint(Integration_Configuration__c config) {
    return buildEndpoint(config, null);
  }

  private static String buildEndpoint(
    Integration_Configuration__c config,
    Map<String, String> pathParams
  ) {
    String namedCredential = isSandBox
      ? config.Named_Credential_Sandbox__c
      : config.Named_Credential_Prod__c;

    return 'callout:' +
      namedCredential +
      replacePathParams(config.Endpoint_Path__c, pathParams);
  }

  private static String replacePathParams(
    String endpointPath,
    Map<String, String> pathParams
  ) {
    if (pathParams == null || pathParams.isEmpty()) {
      return endpointPath;
    }

    String resolvedPath = endpointPath;
    for (String key : pathParams.keySet()) {
      String encodedValue = encodePathParam(pathParams.get(key));
      resolvedPath = resolvedPath.replace('{' + key + '}', encodedValue);
      resolvedPath = resolvedPath.replace(':' + key, encodedValue);
    }

    return resolvedPath;
  }

  private static String encodePathParam(String value) {
    if (value == null) {
      return '';
    }

    return EncodingUtil.urlEncode(value, 'UTF-8').replace('+', '%20');
  }

  private static String getHttpMethod(Integration_Configuration__c config) {
    return config.HTTP_Method__c;
  }

  private static Boolean isErrorStatusCode(Integer statusCode) {
    return statusCode == null || statusCode < 200 || statusCode >= 300;
  }

  private static Boolean hasJsonResponse(String respJson) {
    if (String.isBlank(respJson)) {
      return false;
    }

    String trimmedResponse = respJson.trim();
    return trimmedResponse.startsWith('{') || trimmedResponse.startsWith('[');
  }

  private static Integer getTimeout(Integration_Configuration__c config) {
    return config.Timeout__c.intValue();
  }

  private static void setHeaders(
    HttpRequest req,
    Integration_Configuration__c config
  ) {
    if (config.Content_Type_JSON__c) {
      req.setHeader('Content-Type', 'application/json');
    }
    if (config.Content_Type_Encoded__c) {
      req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
    }
  }

  private static HttpResponse runMock(
    Integration_Configuration__c config,
    HttpRequest req
  ) {
    Type mockClass = Type.forName(config.Mock_Apex_Class__c);
    System.debug('Mock class name : ' + mockClass);
    HttpCalloutMock mockService = (HttpCalloutMock) mockClass.newInstance();
    return mockService.respond(req);
  }

  private static Object deserializeResponse(
    Integration_Configuration__c config,
    String respJson
  ) {
    Type respClass = Type.forName(config.Response_Wrapper_Class__c);
    Object responseWrapper = respClass.newInstance();
    System.debug('** respJson: ' + respJson);
    System.debug('** respClass: ' + respClass);
    responseWrapper = JSON.deserialize(respJson, respClass);
    System.debug('** respWrapper: ' + responseWrapper);
    return responseWrapper;
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
