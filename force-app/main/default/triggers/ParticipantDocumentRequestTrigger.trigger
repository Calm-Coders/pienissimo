trigger ParticipantDocumentRequestTrigger on Participant_Document_Request__e(
  after insert
) {
  ParticipantTicketDocumentRequests.handle(Trigger.new);
}
