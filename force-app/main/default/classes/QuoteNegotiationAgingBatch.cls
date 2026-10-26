public without sharing class QuoteNegotiationAgingBatch implements Database.Batchable<SObject>, Schedulable {
  public static final String JOB_NAME = 'Quote Negotiation Aging - Daily';
  public static final String DAILY_0300_CRON = '0 0 3 * * ?';

  private static final Integer DAYS_IN_NEGOTIATION = 5;
  private static final Integer REMINDER_DAY = 2;
  private static final String NEGOTIATION_STATUS = 'In Trattativa';
  private static final String AWAITING_ACCEPTANCE_STATUS = 'In Attesa Accettazione';
  private static final String ACCEPTED_STATUS = 'Accettato';
  private static final String REJECTED_STATUS = 'Rifiutato';
  private static final String REMINDER_TEMPLATE = 'Quote_Follow_Up_Reminder';
  private static final String REMINDER_TASK_SUBJECT = 'Preventivo Inviato';

  public Database.QueryLocator start(Database.BatchableContext context) {
    Date today = Date.today();
    Datetime reminderCutoff = Datetime.now().addDays(-REMINDER_DAY);
    Date expiryCutoff = Date.today().addDays(-DAYS_IN_NEGOTIATION);
    Datetime fallbackExpiryCutoff = Datetime.newInstance(
      expiryCutoff,
      Time.newInstance(23, 59, 59, 999)
    );
    return Database.getQueryLocator(
      [
        SELECT
          Id,
          Name,
          QuoteNumber,
          Status,
          Email,
          ExpirationDate,
          Data_Ora_Invio_Preventivo__c,
          In_Trattativa_Dal__c,
          LastModifiedDate,
          OpportunityId,
          Opportunity.OwnerId,
          Opportunity.Owner.IsActive,
          Opportunity.Owner.Name,
          Opportunity.Owner.Email,
          Account.Email_Contatto_Principale__c,
          Promemoria_2_Giorni_Inviato__c
        FROM Quote
        WHERE
          (Status = :NEGOTIATION_STATUS
          AND (ExpirationDate <= :today
          OR (ExpirationDate = NULL
          AND In_Trattativa_Dal__c <= :expiryCutoff)
          OR (ExpirationDate = NULL
          AND In_Trattativa_Dal__c = NULL
          AND LastModifiedDate <= :fallbackExpiryCutoff)))
          OR (Status != :ACCEPTED_STATUS
          AND Status != :REJECTED_STATUS
          AND Promemoria_2_Giorni_Inviato__c = FALSE
          AND Data_Ora_Invio_Preventivo__c != NULL
          AND Data_Ora_Invio_Preventivo__c <= :reminderCutoff)
      ]
    );
  }

  public void execute(Database.BatchableContext context, List<SObject> scope) {
    List<Quote> quotesToUpdate = new List<Quote>();
    List<Task> reminderTasks = new List<Task>();
    List<Messaging.SingleEmailMessage> reminderEmails = new List<Messaging.SingleEmailMessage>();
    EmailTemplate reminderTemplate = getReminderTemplate();

    for (SObject record : scope) {
      Quote quoteRecord = (Quote) record;
      Date negotiationDate = quoteRecord.In_Trattativa_Dal__c;
      if (negotiationDate == null) {
        negotiationDate = quoteRecord.LastModifiedDate.date();
      }
      Date expirationDate = quoteRecord.ExpirationDate == null
        ? negotiationDate.addDays(DAYS_IN_NEGOTIATION)
        : quoteRecord.ExpirationDate;
      Boolean reminderDue =
        quoteRecord.Promemoria_2_Giorni_Inviato__c != true &&
        quoteRecord.Status != ACCEPTED_STATUS &&
        quoteRecord.Status != REJECTED_STATUS &&
        quoteRecord.Data_Ora_Invio_Preventivo__c != null &&
        quoteRecord.Data_Ora_Invio_Preventivo__c <=
        Datetime.now().addDays(-REMINDER_DAY);
      Boolean expired =
        quoteRecord.Status == NEGOTIATION_STATUS &&
        expirationDate <= Date.today();

      Quote quoteUpdate = new Quote(Id = quoteRecord.Id);
      if (reminderDue) {
        quoteUpdate.Promemoria_2_Giorni_Inviato__c = true;
        Id reminderOwnerId = getReminderOwnerId(quoteRecord);
        if (quoteRecord.OpportunityId != null && reminderOwnerId != null) {
          reminderTasks.add(
            new Task(
              ActivityDate = Date.today().addDays(1),
              Description = 'Ricontattare il cliente per il preventivo ' +
                quoteRecord.QuoteNumber +
                '.',
              OwnerId = reminderOwnerId,
              Priority = 'Normal',
              Status = 'Not Started',
              Subject = REMINDER_TASK_SUBJECT,
              Sottotipo__c = 'Da Ricontattare',
              WhatId = quoteRecord.OpportunityId
            )
          );
        }

        Messaging.SingleEmailMessage reminderEmail = buildReminderEmail(
          quoteRecord,
          reminderTemplate,
          expirationDate
        );
        if (reminderEmail != null) {
          reminderEmails.add(reminderEmail);
        }
      }

      if (expired) {
        quoteUpdate.Status = AWAITING_ACCEPTANCE_STATUS;
      }
      quotesToUpdate.add(quoteUpdate);
    }

    if (!reminderTasks.isEmpty()) {
      Database.insert(reminderTasks, false);
    }
    if (!reminderEmails.isEmpty()) {
      Messaging.sendEmail(reminderEmails, false);
    }

    if (!quotesToUpdate.isEmpty()) {
      Database.update(quotesToUpdate, false);
    }
  }

  public void finish(Database.BatchableContext context) {
  }

  public void execute(SchedulableContext context) {
    Database.executeBatch(new QuoteNegotiationAgingBatch(), 10);
  }

  public static Id scheduleDaily() {
    return System.schedule(
      JOB_NAME,
      DAILY_0300_CRON,
      new QuoteNegotiationAgingBatch()
    );
  }

  private static EmailTemplate getReminderTemplate() {
    List<EmailTemplate> templates = [
      SELECT Subject, HtmlValue
      FROM EmailTemplate
      WHERE DeveloperName = :REMINDER_TEMPLATE
      LIMIT 1
    ];
    return templates.isEmpty() ? null : templates[0];
  }

  private static Messaging.SingleEmailMessage buildReminderEmail(
    Quote quoteRecord,
    EmailTemplate template,
    Date expirationDate
  ) {
    String recipient = quoteRecord.Email;
    if (String.isBlank(recipient) && quoteRecord.Account != null) {
      recipient = quoteRecord.Account.Email_Contatto_Principale__c;
    }
    if (String.isBlank(recipient) || getReminderOwnerId(quoteRecord) == null) {
      return null;
    }

    String subject = template == null || String.isBlank(template.Subject)
      ? 'Promemoria preventivo ' + quoteRecord.QuoteNumber
      : replaceTokens(template.Subject, quoteRecord, expirationDate, false);
    String htmlBody = template == null || String.isBlank(template.HtmlValue)
      ? '<p>Buongiorno,</p><p>ti ricordiamo che il preventivo ' +
        html(quoteRecord.QuoteNumber) +
        ' e disponibile fino al ' +
        html(String.valueOf(expirationDate)) +
        '.</p><p>Grazie,<br/>Il team Pienissimo</p>'
      : replaceTokens(template.HtmlValue, quoteRecord, expirationDate, true);

    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
    message.setTargetObjectId(getReminderOwnerId(quoteRecord));
    message.setTreatTargetObjectAsRecipient(false);
    message.setToAddresses(new List<String>{ recipient.trim() });
    message.setWhatId(quoteRecord.Id);
    message.setSubject(subject);
    message.setHtmlBody(htmlBody);
    message.setSaveAsActivity(false);
    if (!String.isBlank(quoteRecord.Opportunity.Owner.Email)) {
      message.setReplyTo(quoteRecord.Opportunity.Owner.Email);
    }
    if (!String.isBlank(quoteRecord.Opportunity.Owner.Name)) {
      message.setSenderDisplayName(quoteRecord.Opportunity.Owner.Name);
    }
    return message;
  }

  private static String replaceTokens(
    String source,
    Quote quoteRecord,
    Date expirationDate,
    Boolean escapeHtml
  ) {
    Map<String, String> values = new Map<String, String>{
      '{{quoteNumber}}' => quoteRecord.QuoteNumber,
      '{{quoteName}}' => quoteRecord.Name,
      '{{expirationDate}}' => String.valueOf(expirationDate),
      '{{tutorName}}' => quoteRecord.Opportunity.Owner.Name
    };
    String result = source;
    for (String token : values.keySet()) {
      String value = values.get(token) == null ? '' : values.get(token);
      result = result.replace(token, escapeHtml ? html(value) : value);
    }
    return result;
  }

  private static String html(String value) {
    return value == null ? '' : value.escapeHtml4();
  }

  private static Id getReminderOwnerId(Quote quoteRecord) {
    if (
      quoteRecord.Opportunity != null &&
      quoteRecord.Opportunity.OwnerId != null &&
      quoteRecord.Opportunity.Owner.IsActive
    ) {
      return quoteRecord.Opportunity.OwnerId;
    }
    return UserInfo.getUserId();
  }
}
