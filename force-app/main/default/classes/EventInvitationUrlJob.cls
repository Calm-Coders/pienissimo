public with sharing class EventInvitationUrlJob implements Queueable {
  private List<Id> invitationIds;

  public EventInvitationUrlJob(List<Id> invitationIds) {
    this.invitationIds = new List<Id>(invitationIds);
  }

  public void execute(QueueableContext context) {
    refresh(invitationIds);
  }

  public class RefreshResult {
    @InvocableVariable(label='Invito evento')
    public Id invitationId;
    @InvocableVariable(label='URL pronto')
    public Boolean success;
    @InvocableVariable(label='Link registrazione')
    public String registrationUrl;
    @InvocableVariable(label='Errore')
    public String errorMessage;
  }

  @InvocableMethod(
    label='Aggiorna link inviti evento'
    description='Risolve la community della org corrente e aggiorna i link prima dell invio.'
  )
  public static List<RefreshResult> refresh(List<Id> invitationIds) {
    List<RefreshResult> results = new List<RefreshResult>();
    if (invitationIds == null || invitationIds.isEmpty()) {
      return results;
    }
    Set<Id> ids = new Set<Id>(invitationIds);
    ids.remove(null);
    Map<Id, String> errors = new Map<Id, String>();
    String resolutionError;
    if (!ids.isEmpty()) {
      try {
        ParticipantCommunityUrl.pageUrl();
      } catch (Exception e) {
        // Never persist API response bodies or sensitive diagnostics.
        resolutionError = 'Impossibile risolvere la community Landing Page. Verificare pubblicazione e accesso.';
      }
    }
    // Read and lock after discovery so a concurrent relationship change cannot
    // be overwritten with a link built from stale Account/Campaign IDs.
    Map<Id, Event_Invitation__c> invitations = new Map<Id, Event_Invitation__c>(
      [
        SELECT Id, Account__c, Campaign__c, Status__c
        FROM Event_Invitation__c
        WHERE Id IN :ids
        FOR UPDATE
      ]
    );
    List<Event_Invitation__c> updates = new List<Event_Invitation__c>();
    for (Event_Invitation__c invitation : invitations.values()) {
      String errorMessage = resolutionError;
      String registrationUrl;
      if (errorMessage == null) {
        try {
          registrationUrl = ParticipantCommunityUrl.registrationUrl(
            invitation.Account__c,
            invitation.Campaign__c
          );
          if (registrationUrl.length() > 255) {
            errorMessage = 'Il link supera la lunghezza massima del campo URL.';
            registrationUrl = null;
          }
        } catch (Exception e) {
          errorMessage = 'Account o campagna non validi per la registrazione.';
        }
      }
      errors.put(invitation.Id, errorMessage);
      updates.add(
        new Event_Invitation__c(
          Id = invitation.Id,
          Status__c = errorMessage != null &&
            invitation.Status__c == 'Ready'
            ? 'Pending'
            : invitation.Status__c,
          Registration_Url__c = registrationUrl,
          URL_Status__c = errorMessage == null ? 'Ready' : 'Error',
          URL_Refreshed_At__c = System.now(),
          Last_URL_Error__c = errorMessage
        )
      );
    }
    // All-or-none prevents a caller from sending links whose stored refresh
    // failed. On failure, Flow follows its fault path and must not send.
    if (!updates.isEmpty()) {
      update updates;
    }
    Map<Id, Event_Invitation__c> refreshed = new Map<Id, Event_Invitation__c>(
      updates
    );
    for (Id invitationId : invitationIds) {
      RefreshResult result = new RefreshResult();
      result.invitationId = invitationId;
      Event_Invitation__c invitation = refreshed.get(invitationId);
      result.success = invitation != null && errors.get(invitationId) == null;
      result.registrationUrl = invitation == null
        ? null
        : invitation.Registration_Url__c;
      result.errorMessage = invitation == null
        ? 'Invito non trovato o non accessibile.'
        : errors.get(invitationId);
      results.add(result);
    }
    return results;
  }
}
