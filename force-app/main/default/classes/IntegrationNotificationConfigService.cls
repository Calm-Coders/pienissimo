public with sharing class IntegrationNotificationConfigService {
  private static final String EMAIL_PATTERN = '^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$';

  public static List<String> getRecipientEmails(String configurationName) {
    Integration_Notification_Config__c configuration = getConfiguration(
      configurationName
    );
    if (
      configuration == null ||
      configuration.Enabled__c != true ||
      String.isBlank(configuration.Recipient_Emails__c)
    ) {
      return new List<String>();
    }

    List<String> recipients = new List<String>();
    Set<String> normalizedRecipients = new Set<String>();
    for (
      String candidate : configuration.Recipient_Emails__c.split('[,;\\r\\n]+')
    ) {
      String recipient = candidate == null ? null : candidate.trim();
      String normalizedRecipient = String.isBlank(recipient)
        ? null
        : recipient.toLowerCase();
      if (
        String.isBlank(normalizedRecipient) ||
        !Pattern.matches(EMAIL_PATTERN, recipient) ||
        normalizedRecipients.contains(normalizedRecipient)
      ) {
        continue;
      }

      normalizedRecipients.add(normalizedRecipient);
      recipients.add(recipient);
    }
    return recipients;
  }

  public static String getDefaultAgentCode(String configurationName) {
    User agent = getDefaultAgent(configurationName);
    return agent == null || String.isBlank(agent.Agente__c)
      ? null
      : agent.Agente__c.trim();
  }

  public static User getDefaultAgent(String configurationName) {
    Integration_Notification_Config__c configuration = getConfiguration(
      configurationName
    );
    if (
      configuration == null ||
      String.isBlank(configuration.Default_Agent_Username__c)
    ) {
      return null;
    }

    String username = configuration.Default_Agent_Username__c.trim();
    List<User> agents = [
      SELECT Id, Agente__c, Categoria_Provvigioni_Cliente__c
      FROM User
      WHERE Username = :username AND IsActive = TRUE
      LIMIT 1
    ];
    return agents.isEmpty() ? null : agents[0];
  }

  private static Integration_Notification_Config__c getConfiguration(
    String configurationName
  ) {
    if (String.isBlank(configurationName)) {
      return null;
    }

    try {
      return Integration_Notification_Config__c.getValues(
        configurationName.trim()
      );
    } catch (System.InvalidParameterValueException ignored) {
      return null;
    }
  }
}
