public with sharing class AnticipayErrorNotificationService {
  private static final String TEMPLATE_DEVELOPER_NAME = 'Anticipay_Error_Notification';
  private static final String ADMIN_EMAIL = 'a.aga@romicompany.com';

  public static void sendIfError(AnticipayAccountService.Result result) {
    if (result == null || !hasErrorLog(result.integrationLogs)) {
      return;
    }

    try {
      EmailTemplate template = getTemplate();
      NotificationContext context = new NotificationContext(result);

      Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
      message.setToAddresses(new List<String>{ ADMIN_EMAIL });
      message.setSaveAsActivity(false);
      message.setSubject(applyTokens(getSubject(template), context, false));
      message.setPlainTextBody(
        applyTokens(getPlainBody(template), context, false)
      );
      message.setHtmlBody(applyTokens(getHtmlBody(template), context, true));

      Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ message });
    } catch (Exception ignored) {
      System.debug(
        LoggingLevel.ERROR,
        'Invio email errore Anticipay non riuscito: ' + ignored.getMessage()
      );
    }
  }

  private static Boolean hasErrorLog(List<Integration_Log__c> logs) {
    if (logs == null) {
      return false;
    }

    for (Integration_Log__c logRow : logs) {
      if (logRow.Is_Error__c == true) {
        return true;
      }
    }

    return false;
  }

  private static EmailTemplate getTemplate() {
    List<EmailTemplate> templates = [
      SELECT Subject, Body, HtmlValue
      FROM EmailTemplate
      WHERE DeveloperName = :TEMPLATE_DEVELOPER_NAME
      LIMIT 1
    ];

    return templates.isEmpty() ? null : templates[0];
  }

  private static String getSubject(EmailTemplate template) {
    return template == null || String.isBlank(template.Subject)
      ? 'Errore Anticipay da verificare - {{accountId}}'
      : template.Subject;
  }

  private static String getPlainBody(EmailTemplate template) {
    return template == null || String.isBlank(template.Body)
      ? getDefaultPlainBody()
      : template.Body;
  }

  private static String getHtmlBody(EmailTemplate template) {
    return template == null || String.isBlank(template.HtmlValue)
      ? getDefaultHtmlBody()
      : template.HtmlValue;
  }

  private static String getDefaultPlainBody() {
    return 'Errore controllo Anticipay\n\n' +
      'Il controllo Anticipay ha restituito un errore e richiede una verifica amministrativa.\n\n' +
      'Link Account Salesforce: {{accountLink}}\n\n' +
      'Dettagli\n' +
      'Account: {{accountId}}\n' +
      'Stato HTTP: {{httpStatus}}\n' +
      'Messaggio: {{message}}\n' +
      'Log integrazione: {{logId}}\n\n' +
      'Email generata automaticamente da Salesforce.';
  }

  private static String getDefaultHtmlBody() {
    return '<div style="font-family: Arial, sans-serif; color: #1f2933; line-height: 1.5">' +
      '<h2 style="margin: 0 0 12px; color: #b42318; font-size: 20px">Errore controllo Anticipay</h2>' +
      '<p style="margin: 0 0 16px">Il controllo Anticipay ha restituito un errore e richiede una verifica amministrativa.</p>' +
      '<p style="margin: 0 0 20px">Link Account Salesforce: <a href="{{accountLink}}" style="color: #1b5f8c">{{accountLink}}</a></p>' +
      '<table cellpadding="0" cellspacing="0" style="border-collapse: collapse; width: 100%; max-width: 680px">' +
      '<tr><td style="padding: 8px; border: 1px solid #d9e2ec; font-weight: bold">Account</td><td style="padding: 8px; border: 1px solid #d9e2ec">{{accountId}}</td></tr>' +
      '<tr><td style="padding: 8px; border: 1px solid #d9e2ec; font-weight: bold">Stato HTTP</td><td style="padding: 8px; border: 1px solid #d9e2ec">{{httpStatus}}</td></tr>' +
      '<tr><td style="padding: 8px; border: 1px solid #d9e2ec; font-weight: bold">Messaggio</td><td style="padding: 8px; border: 1px solid #d9e2ec">{{message}}</td></tr>' +
      '<tr><td style="padding: 8px; border: 1px solid #d9e2ec; font-weight: bold">Log integrazione</td><td style="padding: 8px; border: 1px solid #d9e2ec">{{logId}}</td></tr>' +
      '</table>' +
      '<p style="margin: 18px 0 0; color: #52606d; font-size: 13px">Email generata automaticamente da Salesforce.</p>' +
      '</div>';
  }

  private static String applyTokens(
    String templateBody,
    NotificationContext context,
    Boolean escapeHtml
  ) {
    Map<String, String> tokens = new Map<String, String>{
      '{{recordLink}}' => context.recordLink,
      '{{accountLink}}' => context.accountLink,
      '{{sourceObject}}' => context.sourceObject,
      '{{sourceRecordId}}' => String.valueOf(context.sourceRecordId),
      '{{accountId}}' => String.valueOf(context.accountId),
      '{{httpStatus}}' => context.httpStatus,
      '{{message}}' => context.message,
      '{{logId}}' => String.valueOf(context.logId)
    };

    String body = templateBody;
    for (String token : tokens.keySet()) {
      String value = tokens.get(token);
      body = body.replace(token, escapeHtml ? html(value) : text(value));
    }

    return body;
  }

  private static String buildRecordLink(Id recordId, String objectApiName) {
    if (recordId == null || String.isBlank(objectApiName)) {
      return '';
    }

    return Url.getOrgDomainUrl().toExternalForm() +
      '/lightning/r/' +
      objectApiName +
      '/' +
      recordId +
      '/view';
  }

  private static Integration_Log__c getFirstErrorLog(
    List<Integration_Log__c> logs
  ) {
    if (logs == null) {
      return null;
    }

    for (Integration_Log__c logRow : logs) {
      if (logRow.Is_Error__c == true) {
        return logRow;
      }
    }

    return null;
  }

  private static String text(String value) {
    return value == null ? '' : value;
  }

  private static String html(String value) {
    return value == null ? '' : value.escapeHtml4();
  }

  private class NotificationContext {
    private Id accountId;
    private Id sourceRecordId;
    private Id logId;
    private String httpStatus;
    private String message;
    private String accountLink;
    private String recordLink;
    private String sourceObject;

    private NotificationContext(AnticipayAccountService.Result result) {
      Integration_Log__c errorLog = getFirstErrorLog(result.integrationLogs);
      accountId = result.accountId;
      sourceRecordId = result.sourceRecordId;
      logId = errorLog == null ? null : errorLog.Id;
      httpStatus = result.httpStatus == null
        ? ''
        : String.valueOf(result.httpStatus);
      message = result.message;
      sourceObject = result.sourceRecordObjectApiName;
      accountLink = buildRecordLink(accountId, 'Account');
      recordLink = buildRecordLink(sourceRecordId, sourceObject);
    }
  }
}
