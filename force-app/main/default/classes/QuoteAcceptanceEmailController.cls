public with sharing class QuoteAcceptanceEmailController {
  private static final String SENDABLE_STATUS = 'In Trattativa';
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
    draft.recipient = quoteRecord.Account.Email_Contatto_Principale__c;
    draft.acceptanceUrl = ACCEPTANCE_URL + quoteRecord.Id;
    draft.subject =
      'Preventivo ' +
      quoteRecord.QuoteNumber +
      ' - Richiesta di accettazione';
    draft.body =
      'Buongiorno,\n\n' +
      'ti inviamo il preventivo ' +
      quoteRecord.QuoteNumber +
      ' (' +
      quoteRecord.Name +
      ').\n\n' +
      'Puoi consultare, accettare o rifiutare il preventivo dal seguente link:\n' +
      draft.acceptanceUrl +
      '\n\nGrazie,\nIl team Pienissimo';
    return draft;
  }

  @AuraEnabled
  public static void sendEmail(
    Id quoteId,
    String recipient,
    String subject,
    String body
  ) {
    Quote quoteRecord = loadSendableQuote(quoteId);
    if (
      String.isBlank(recipient) ||
      recipient.length() > 254 ||
      !Pattern.matches(
        '^[^\\s@,;<>]+@[^\\s@,;<>]+\\.[^\\s@,;<>]+$',
        recipient.trim()
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
    if (String.isBlank(body) || body.length() > 32000) {
      throw new AuraHandledException(
        'Inserisci il testo del messaggio, massimo 32000 caratteri.'
      );
    }
    String link = ACCEPTANCE_URL + quoteRecord.Id;
    if (!body.contains(link)) {
      throw new AuraHandledException(
        'Il messaggio deve contenere il link di questo preventivo.'
      );
    }
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    email.setToAddresses(new List<String>{ recipient.trim() });
    email.setSubject(subject.trim());
    email.setPlainTextBody(body);
    email.setSaveAsActivity(false);
    Messaging.SendEmailResult[] results = Messaging.sendEmail(
      new List<Messaging.SingleEmailMessage>{ email }
    );
    if (!results[0].isSuccess()) {
      throw new AuraHandledException(results[0].getErrors()[0].getMessage());
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
    if (quoteRecord.Status != SENDABLE_STATUS) {
      throw new AuraHandledException(
        'Invio consentito solo per preventivi in stato In Trattativa.'
      );
    }
    if (quoteRecord.AccountId == null) {
      throw new AuraHandledException(
        'Collega il preventivo a un account prima di inviare email.'
      );
    }
    return quoteRecord;
  }
}
