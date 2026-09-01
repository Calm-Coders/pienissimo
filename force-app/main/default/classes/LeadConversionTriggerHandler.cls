public with sharing class LeadConversionTriggerHandler {
  private static final String NON_RISPONDE_STATUS = 'Non Risponde';
  private static final String FOLLOW_UP_TASK_SUBJECT = 'Ricontattare Lead - Non Risponde';
  private static final String FOLLOW_UP_TASK_DESCRIPTION = 'Lead moved to Non Risponde. Follow up with the prospect.';
  private static final String TASK_STATUS_OPEN = 'Open';
  private static final String TASK_PRIORITY_NORMAL = 'Normal';
  private static final String QUALIFIED_STATUS = 'Qualificato';
  private static Boolean conversionJobEnqueued = false;

  public static void afterUpdate(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    List<Task> followUpTasks = buildNonRispondeFollowUpTasks(
      newLeads,
      oldLeadMap
    );
    if (!followUpTasks.isEmpty()) {
      insert followUpTasks;
    }

    enqueueLeadConversions(newLeads, oldLeadMap);
  }

  private static List<Task> buildNonRispondeFollowUpTasks(
    List<Lead> newLeads,
    Map<Id, Lead> oldLeadMap
  ) {
    List<Task> followUpTasks = new List<Task>();
    for (Lead leadRecord : newLeads) {
      Lead oldLead = oldLeadMap.get(leadRecord.Id);
      if (
        leadRecord.IsConverted != true &&
        leadRecord.Status == NON_RISPONDE_STATUS &&
        oldLead.Status != NON_RISPONDE_STATUS
      ) {
        followUpTasks.add(
          new Task(
            ActivityDate = Date.today().addDays(2),
            Description = FOLLOW_UP_TASK_DESCRIPTION,
            OwnerId = leadRecord.OwnerId,
            Priority = TASK_PRIORITY_NORMAL,
            Status = TASK_STATUS_OPEN,
            Subject = FOLLOW_UP_TASK_SUBJECT,
            WhoId = leadRecord.Id
          )
        );
      }
    }

    return followUpTasks;
  }

  private static void enqueueLeadConversions(
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
