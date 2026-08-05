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
  ].IsSandbox;

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

  public static Result callApi(
    String apiName,
    Object request,
    Boolean insertLog
  ) {
    System.debug('** Callout_Engine.callApi start **');
    System.debug('** Input apiName: ' + apiName + ' **');
    System.debug('** Input request: ' + request + ' **');

    Result result = new Result();
    String respJson;
    Integration_Log__c logRow;

    try {
      // Retrieve Config, Create Log
      Integration_Configuration__c config = Integration_Configuration__c.getValues(
        apiName
      );
      String reqJson = JSON.serialize(request);
      System.debug('Request after serialization :::' + reqJson);
      logRow = buildLog(apiName, reqJson);

      if (config == null) {
        logRow.Is_Error__c = true;
        logRow.Response_Body__c = abbreviate(
          'ERROR: The system could not find an Integration_Configuration__c custom setting record having name ' +
          apiName
        );
        saveLog(logRow, result, insertLog);
        return result;
      }

      // Make HTTP request
      HttpRequest req = buildRequest(config, reqJson);

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
      logRow.Response_Body__c = abbreviate(
        buildElapsedTime(timestampCallout, timestampResponseReceived) +
        '************' +
        respJson
      );

      result.payload = deserializeResponse(config, respJson);
      saveLog(logRow, result, insertLog);
      return result;
    } catch (Exception e) {
      logRow = new Integration_Log__c(
        Flow_Name__c = apiName,
        Inbound_Outbound__c = 'Outbound',
        Request_Body__c = JSON.serialize(request).abbreviate(131072),
        Is_Error__c = true,
        Response_Body__c = (respJson)?.abbreviate(131072),
        Exception_Message__c = (e.getTypeName() + '\n' + e.getMessage())
          .abbreviate(131072),
        Exception_StackTrace__c = (e.getStackTraceString()).abbreviate(131072)
      );
      saveLog(logRow, result, insertLog);
      return result;
    }
  }

  @AuraEnabled
  public static Integration_Configuration__c getIntegrationConfiguration(
    String datasetName
  ) {
    return Integration_Configuration__c.getValues(datasetName);
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

  private static Integration_Log__c buildLog(String apiName, String reqJson) {
    return new Integration_Log__c(
      Flow_Name__c = apiName,
      Inbound_Outbound__c = 'Outbound',
      Request_Body__c = reqJson.abbreviate(131072)
    );
  }

  private static HttpRequest buildRequest(
    Integration_Configuration__c config,
    String reqJson
  ) {
    HttpRequest req = new HttpRequest();
    req.setEndpoint(buildEndpoint(config));
    req.setMethod(getHttpMethod(config));
    req.setTimeout(getTimeout(config));
    setHeaders(req, config);

    if (getHttpMethod(config) != 'GET') {
      req.setBody(reqJson);
    }

    return req;
  }

  private static String buildEndpoint(Integration_Configuration__c config) {
    String namedCredential = isSandBox
      ? config.Named_Credential_Sandbox__c
      : config.Named_Credential_Prod__c;

    return 'callout:' + namedCredential + config.Endpoint_Path__c;
  }

  private static String getHttpMethod(Integration_Configuration__c config) {
    return config.HTTP_Method__c;
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
