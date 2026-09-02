public with sharing class WooCheckoutEmailController {
  private static final String CHECKOUT_TEMPLATE_DEVELOPER_NAME = 'WooCommerce_Checkout_Link';

  @AuraEnabled(cacheable=true)
  public static CheckoutEmailContext getContext(Id opportunityId) {
    if (opportunityId == null) {
      throw new AuraHandledException('Opportunity id is required.');
    }

    Opportunity opportunityRecord = [
      SELECT Name
      FROM Opportunity
      WHERE Id = :opportunityId
      WITH USER_MODE
      LIMIT 1
    ];

    CheckoutEmailContext context = new CheckoutEmailContext();
    context.opportunityName = opportunityRecord.Name;
    return context;
  }

  @AuraEnabled
  public static void sendCheckoutEmail(
    Id opportunityId,
    String recipientEmail
  ) {
    if (opportunityId == null) {
      throw new AuraHandledException('Opportunity id is required.');
    }
    if (String.isBlank(recipientEmail)) {
      throw new AuraHandledException('Recipient email is required.');
    }

    String normalizedEmail = recipientEmail.trim();
    if (!isValidEmail(normalizedEmail)) {
      throw new AuraHandledException('Enter a valid recipient email address.');
    }

    Opportunity opportunityRecord = [
      SELECT Id
      FROM Opportunity
      WHERE Id = :opportunityId
      WITH USER_MODE
      LIMIT 1
    ];

    List<EmailTemplate> checkoutTemplates = [
      SELECT Id
      FROM EmailTemplate
      WHERE DeveloperName = :CHECKOUT_TEMPLATE_DEVELOPER_NAME
      LIMIT 1
    ];
    if (checkoutTemplates.isEmpty()) {
      throw new AuraHandledException('Checkout email template was not found.');
    }

    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
    message.setTemplateId(checkoutTemplates[0].Id);
    message.setTargetObjectId(UserInfo.getUserId());
    message.setTreatTargetObjectAsRecipient(false);
    message.setToAddresses(new List<String>{ normalizedEmail });
    message.setWhatId(opportunityRecord.Id);
    message.setSaveAsActivity(false);

    Messaging.SendEmailResult[] results = Messaging.sendEmail(
      new List<Messaging.SingleEmailMessage>{ message }
    );
    if (!results[0].isSuccess()) {
      Messaging.SendEmailError error = results[0].getErrors()[0];
      throw new AuraHandledException(error.getMessage());
    }
  }

  private static Boolean isValidEmail(String value) {
    return Pattern.matches('^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$', value);
  }

  public class CheckoutEmailContext {
    @AuraEnabled
    public String opportunityName;
  }
}
