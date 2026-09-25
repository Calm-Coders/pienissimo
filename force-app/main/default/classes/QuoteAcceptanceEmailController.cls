public without sharing class QuoteAcceptanceEmailController {
  private static final Set<String> SENDABLE_STATUSES = new Set<String>{
    'In Trattativa',
    'In Attesa Accettazione'
  };
  private static final String TEMPLATE_DEVELOPER_NAME = 'Quote_Acceptance_Request';
  private static final String ACCEPTANCE_URL = 'https://ability-customization-52152--partial.sandbox.my.site.com/gestione-preventivo?quoteId=';

  public class EmailDraft {
    @AuraEnabled
    public String recipient;
    @AuraEnabled
    public String subject;
    @AuraEnabled
    public String body;
    @AuraEnabled
    public String acceptanceUrl;
  }

  @AuraEnabled
  public static EmailDraft getDraft(Id quoteId) {
    Quote quoteRecord = loadSendableQuote(quoteId);
    EmailDraft draft = new EmailDraft();
    EmailTemplate template = getTemplate();
    draft.recipient = quoteRecord.Account.Email_Contatto_Principale__c;
    draft.acceptanceUrl = ACCEPTANCE_URL + quoteRecord.Id;
    draft.subject = applyQuoteTokens(getSubject(template), quoteRecord);
    draft.body = buildPlainTextBody(quoteRecord, draft.acceptanceUrl);
    return draft;
  }

  @AuraEnabled
  public static void sendEmail(Id quoteId, String recipient, String subject) {
    Quote quoteRecord = loadSendableQuote(quoteId);
    String normalizedRecipient = recipient == null ? null : recipient.trim();
    if (
      String.isBlank(normalizedRecipient) ||
      normalizedRecipient.length() > 254 ||
      !Pattern.matches(
        '^[^\\s@,;<>]+@[^\\s@,;<>]+\\.[^\\s@,;<>]+$',
        normalizedRecipient
      )
    ) {
      throw new AuraHandledException(
        'Inserisci un solo indirizzo email valido.'
      );
    }
    if (
      String.isBlank(subject) ||
      subject.length() > 255 ||
      subject.contains('\n') ||
      subject.contains('\r')
    ) {
      throw new AuraHandledException(
        'Inserisci un oggetto valido, massimo 255 caratteri e su una sola riga.'
      );
    }
    String link = ACCEPTANCE_URL + quoteRecord.Id;
    EmailTemplate template = getTemplate();
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setTargetObjectId(UserInfo.getUserId());
    email.setTreatTargetObjectAsRecipient(false);
    email.setToAddresses(new List<String>{ normalizedRecipient });
    email.setWhatId(quoteRecord.Id);
    email.setSubject(subject.trim());
    email.setPlainTextBody(buildPlainTextBody(quoteRecord, link));
    email.setHtmlBody(buildHtmlBody(template, quoteRecord, link));
    email.setSaveAsActivity(true);
    Messaging.SendEmailResult[] results = Messaging.sendEmail(
      new List<Messaging.SingleEmailMessage>{ email }
    );
    if (!results[0].isSuccess()) {
      throw new AuraHandledException(results[0].getErrors()[0].getMessage());
    }
    if (quoteRecord.Email != normalizedRecipient) {
      update new Quote(Id = quoteRecord.Id, Email = normalizedRecipient);
    }
  }

  private static Quote loadSendableQuote(Id quoteId) {
    if (quoteId == null || quoteId.getSObjectType() != Quote.SObjectType) {
      throw new AuraHandledException('Seleziona un preventivo valido.');
    }
    List<Quote> records = [
      SELECT
        Id,
        Name,
        QuoteNumber,
        Email,
        Status,
        AccountId,
        Account.Email_Contatto_Principale__c
      FROM Quote
      WHERE Id = :quoteId
      WITH USER_MODE
      LIMIT 1
    ];
    if (records.isEmpty()) {
      throw new AuraHandledException('Preventivo non disponibile.');
    }
    Quote quoteRecord = records[0];
    if (!SENDABLE_STATUSES.contains(quoteRecord.Status)) {
      throw new AuraHandledException(
        'Invio consentito solo per preventivi in stato In Trattativa o In Attesa Accettazione.'
      );
    }
    if (quoteRecord.AccountId == null) {
      throw new AuraHandledException(
        'Collega il preventivo a un account prima di inviare email.'
      );
    }
    return quoteRecord;
  }

  private static EmailTemplate getTemplate() {
    List<EmailTemplate> templates = [
      SELECT Subject, HtmlValue
      FROM EmailTemplate
      WHERE DeveloperName = :TEMPLATE_DEVELOPER_NAME
      LIMIT 1
    ];

    return templates.isEmpty() ? null : templates[0];
  }

  private static String getSubject(EmailTemplate template) {
    return template == null || String.isBlank(template.Subject)
      ? 'Preventivo {{quoteNumber}} - Richiesta di accettazione'
      : template.Subject;
  }

  private static String buildHtmlBody(
    EmailTemplate template,
    Quote quoteRecord,
    String link
  ) {
    if (template == null || String.isBlank(template.HtmlValue)) {
      return buildDefaultHtmlBody(quoteRecord, link);
    }

    Map<String, String> tokens = new Map<String, String>{
      '{{acceptanceUrl}}' => link.escapeHtml4(),
      '{{quoteNumber}}' => html(quoteRecord.QuoteNumber),
      '{{quoteName}}' => html(quoteRecord.Name)
    };

    String htmlBody = template.HtmlValue;
    for (String token : tokens.keySet()) {
      htmlBody = htmlBody.replace(token, tokens.get(token));
    }

    return htmlBody;
  }

  private static String applyQuoteTokens(
    String templateText,
    Quote quoteRecord
  ) {
    return templateText
      .replace('{{quoteNumber}}', text(quoteRecord.QuoteNumber))
      .replace('{{quoteName}}', text(quoteRecord.Name));
  }

  private static String buildPlainTextBody(Quote quoteRecord, String link) {
    return 'Buongiorno,\n\n' +
      'ti inviamo il preventivo ' +
      text(quoteRecord.QuoteNumber) +
      ' (' +
      text(quoteRecord.Name) +
      ').\n\n' +
      'Puoi consultare, accettare o rifiutare il preventivo:\n' +
      link +
      '\n\nGrazie,\nIl team Pienissimo';
  }

  private static String buildDefaultHtmlBody(Quote quoteRecord, String link) {
    return '<div style="font-family: Arial, sans-serif; color: #1f2933; line-height: 1.5">' +
      '<p>Buongiorno,</p>' +
      '<p>ti inviamo il preventivo ' +
      html(quoteRecord.QuoteNumber) +
      ' (' +
      html(quoteRecord.Name) +
      ').</p>' +
      '<p>Puoi consultare, accettare o rifiutare il preventivo:</p>' +
      '<p style="margin: 20px 0"><a href="' +
      link.escapeHtml4() +
      '" style="background-color: #0176d3; border-radius: 4px; color: #ffffff; display: inline-block; font-family: Arial, sans-serif; font-size: 14px; font-weight: 700; line-height: 40px; min-width: 120px; padding: 0 18px; text-align: center; text-decoration: none;">Apri il preventivo</a></p>' +
      '<p>Grazie,<br/>Il team Pienissimo</p>' +
      '</div>';
  }

  private static String text(String value) {
    return value == null ? '' : value;
  }

  private static String html(String value) {
    return value == null ? '' : value.escapeHtml4();
  }
}
