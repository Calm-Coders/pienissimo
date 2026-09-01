public with sharing class WooCheckoutEmailController {
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

  public class CheckoutEmailContext {
    @AuraEnabled
    public String opportunityName;
  }
}
