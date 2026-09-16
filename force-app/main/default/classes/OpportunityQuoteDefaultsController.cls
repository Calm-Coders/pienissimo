public with sharing class OpportunityQuoteDefaultsController {
  @AuraEnabled(cacheable=true)
  public static QuoteDefaults getDefaults(Id opportunityId) {
    if (opportunityId == null) {
      throw new AuraHandledException('Opportunity obbligatoria.');
    }

    Opportunity opportunityRecord = [
      SELECT
        Id,
        Name,
        AccountId,
        Account.Name,
        Account.BillingStreet,
        Account.BillingCity,
        Account.BillingState,
        Account.BillingPostalCode,
        Account.BillingCountry,
        Account.ShippingStreet,
        Account.ShippingCity,
        Account.ShippingState,
        Account.ShippingPostalCode,
        Account.ShippingCountry,
        ContactId,
        Locale__c
      FROM Opportunity
      WHERE Id = :opportunityId
      LIMIT 1
    ];

    Id contactId = opportunityRecord.ContactId;
    if (contactId == null) {
      List<OpportunityContactRole> primaryRoles = [
        SELECT ContactId
        FROM OpportunityContactRole
        WHERE OpportunityId = :opportunityId AND IsPrimary = TRUE
        LIMIT 1
      ];
      if (!primaryRoles.isEmpty()) {
        contactId = primaryRoles[0].ContactId;
      }
    }

    Contact contactRecord;
    if (contactId != null) {
      contactRecord = [
        SELECT Id, Name, Email, Phone
        FROM Contact
        WHERE Id = :contactId
        LIMIT 1
      ];
    }

    QuoteDefaults defaults = new QuoteDefaults();
    defaults.opportunityId = opportunityRecord.Id;
    defaults.opportunityName = opportunityRecord.Name;
    defaults.accountId = opportunityRecord.AccountId;
    defaults.accountName = opportunityRecord.Account == null
      ? null
      : opportunityRecord.Account.Name;
    defaults.localeId = opportunityRecord.Locale__c;
    defaults.quoteName = 'Preventivo - ' + opportunityRecord.Name;
    defaults.status = defaultQuoteStatus();

    Account accountRecord = opportunityRecord.Account;
    if (accountRecord != null) {
      defaults.billingStreet = accountRecord.BillingStreet;
      defaults.billingCity = accountRecord.BillingCity;
      defaults.billingState = accountRecord.BillingState;
      defaults.billingPostalCode = accountRecord.BillingPostalCode;
      defaults.billingCountry = accountRecord.BillingCountry;
      defaults.shippingStreet = accountRecord.ShippingStreet;
      defaults.shippingCity = accountRecord.ShippingCity;
      defaults.shippingState = accountRecord.ShippingState;
      defaults.shippingPostalCode = accountRecord.ShippingPostalCode;
      defaults.shippingCountry = accountRecord.ShippingCountry;
    }

    if (contactRecord != null) {
      defaults.contactId = contactRecord.Id;
      defaults.contactName = contactRecord.Name;
      defaults.email = contactRecord.Email;
      defaults.phone = contactRecord.Phone;
    }
    return defaults;
  }

  @AuraEnabled
  public static Id createQuote(Id opportunityId, QuoteInput input) {
    if (opportunityId == null) {
      throw new AuraHandledException('Opportunity obbligatoria.');
    }
    if (input == null) {
      throw new AuraHandledException('Dati preventivo obbligatori.');
    }
    input.quoteName = String.isBlank(input.quoteName)
      ? null
      : input.quoteName.trim();
    if (String.isBlank(input.quoteName)) {
      throw new AuraHandledException('Quote Name obbligatorio.');
    }
    if (input.expirationDate == null) {
      throw new AuraHandledException('Expiration Date obbligatoria.');
    }

    Quote quoteRecord = new Quote(
      Name = input.quoteName,
      OpportunityId = opportunityId,
      ExpirationDate = input.expirationDate,
      Status = input.status,
      ContactId = input.contactId,
      Email = input.email,
      Phone = input.phone,
      Locale__c = input.localeId,
      BillingName = input.accountName,
      BillingStreet = input.billingStreet,
      BillingCity = input.billingCity,
      BillingState = input.billingState,
      BillingPostalCode = input.billingPostalCode,
      BillingCountry = input.billingCountry,
      ShippingName = input.accountName,
      ShippingStreet = input.shippingStreet,
      ShippingCity = input.shippingCity,
      ShippingState = input.shippingState,
      ShippingPostalCode = input.shippingPostalCode,
      ShippingCountry = input.shippingCountry,
      QuoteToName = input.accountName,
      QuoteToStreet = input.billingStreet,
      QuoteToCity = input.billingCity,
      QuoteToState = input.billingState,
      QuoteToPostalCode = input.billingPostalCode,
      QuoteToCountry = input.billingCountry
    );

    insert quoteRecord;
    return quoteRecord.Id;
  }

  @AuraEnabled(cacheable=true)
  public static List<PicklistOption> getQuoteStatuses() {
    List<PicklistOption> options = new List<PicklistOption>();
    Schema.DescribeFieldResult statusField = Quote.Status.getDescribe();
    for (Schema.PicklistEntry entry : statusField.getPicklistValues()) {
      if (!entry.isActive()) {
        continue;
      }
      PicklistOption option = new PicklistOption();
      option.label = entry.getLabel();
      option.value = entry.getValue();
      options.add(option);
    }
    return options;
  }

  private static String defaultQuoteStatus() {
    Schema.DescribeFieldResult statusField = Quote.Status.getDescribe();
    for (Schema.PicklistEntry entry : statusField.getPicklistValues()) {
      if (entry.isDefaultValue()) {
        return entry.getValue();
      }
    }
    for (Schema.PicklistEntry entry : statusField.getPicklistValues()) {
      if (entry.isActive()) {
        return entry.getValue();
      }
    }
    return null;
  }

  public class QuoteDefaults {
    @AuraEnabled
    public Id opportunityId;
    @AuraEnabled
    public String opportunityName;
    @AuraEnabled
    public Id accountId;
    @AuraEnabled
    public String accountName;
    @AuraEnabled
    public String quoteName;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public Id contactId;
    @AuraEnabled
    public String contactName;
    @AuraEnabled
    public String email;
    @AuraEnabled
    public String phone;
    @AuraEnabled
    public Id localeId;
    @AuraEnabled
    public String billingStreet;
    @AuraEnabled
    public String billingCity;
    @AuraEnabled
    public String billingState;
    @AuraEnabled
    public String billingPostalCode;
    @AuraEnabled
    public String billingCountry;
    @AuraEnabled
    public String shippingStreet;
    @AuraEnabled
    public String shippingCity;
    @AuraEnabled
    public String shippingState;
    @AuraEnabled
    public String shippingPostalCode;
    @AuraEnabled
    public String shippingCountry;
  }

  public class QuoteInput {
    @AuraEnabled
    public String quoteName { get; set; }
    @AuraEnabled
    public String status { get; set; }
    @AuraEnabled
    public Date expirationDate { get; set; }
    @AuraEnabled
    public String accountName { get; set; }
    @AuraEnabled
    public Id contactId { get; set; }
    @AuraEnabled
    public String email { get; set; }
    @AuraEnabled
    public String phone { get; set; }
    @AuraEnabled
    public Id localeId { get; set; }
    @AuraEnabled
    public String billingStreet { get; set; }
    @AuraEnabled
    public String billingCity { get; set; }
    @AuraEnabled
    public String billingState { get; set; }
    @AuraEnabled
    public String billingPostalCode { get; set; }
    @AuraEnabled
    public String billingCountry { get; set; }
    @AuraEnabled
    public String shippingStreet { get; set; }
    @AuraEnabled
    public String shippingCity { get; set; }
    @AuraEnabled
    public String shippingState { get; set; }
    @AuraEnabled
    public String shippingPostalCode { get; set; }
    @AuraEnabled
    public String shippingCountry { get; set; }
  }

  public class PicklistOption {
    @AuraEnabled
    public String label;
    @AuraEnabled
    public String value;
  }
}
