public with sharing class LeadConversionTriggerHandler {
  private static final String QUALIFIED_STATUS = 'Qualificato';
  private static Boolean conversionJobEnqueued = false;

  public static void afterUpdate(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    if (conversionJobEnqueued) {
      return;
    }

    List<Id> qualifiedLeadIds = new List<Id>();
    for (Lead leadRecord : newLeads) {
      Lead oldLead = oldLeadMap.get(leadRecord.Id);
      if (
        leadRecord.IsConverted != true &&
        leadRecord.Status == QUALIFIED_STATUS &&
        oldLead.Status != QUALIFIED_STATUS
      ) {
        qualifiedLeadIds.add(leadRecord.Id);
      }
    }

    if (!qualifiedLeadIds.isEmpty()) {
      conversionJobEnqueued = true;
      System.enqueueJob(new LeadConversionQueueable(qualifiedLeadIds));
    }
  }
}
