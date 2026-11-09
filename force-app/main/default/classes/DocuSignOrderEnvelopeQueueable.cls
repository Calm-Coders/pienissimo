public without sharing class DocuSignOrderEnvelopeQueueable implements Queueable, Database.AllowsCallouts {
  private final Id orderId;
  private final Id attemptId;
  private final Queueable continuation;

  public DocuSignOrderEnvelopeQueueable(Id orderId) {
    this(orderId, null, null);
  }

  public DocuSignOrderEnvelopeQueueable(Id orderId, Queueable continuation) {
    this(orderId, null, continuation);
  }

  private DocuSignOrderEnvelopeQueueable(
    Id orderId,
    Id attemptId,
    Queueable continuation
  ) {
    this.orderId = orderId;
    this.attemptId = attemptId;
    this.continuation = continuation;
  }

  public void execute(QueueableContext context) {
    Id preparedAttempt;
    try {
      if (attemptId == null) {
        preparedAttempt = DocuSignOrderEnvelopeService.prepareEnvelope(orderId);
      } else {
        DocuSignOrderEnvelopeService.sendEnvelope(orderId, attemptId);
      }
    } catch (Exception error) {
      // Rendering errors can retry; escaped send/persistence errors retain a
      // blocking reservation because an envelope might already exist.
      try {
        DocuSignOrderEnvelopeService.recordWorkerFailure(
          orderId,
          attemptId,
          error
        );
      } catch (Exception loggingError) {
        System.debug(
          LoggingLevel.ERROR,
          'DocuSign Order failure could not be recorded: ' +
          loggingError.getMessage()
        );
      }
    }
    // One child per async transaction; preserve the remaining Mexal order chain.
    if (preparedAttempt != null) {
      System.enqueueJob(
        new DocuSignOrderEnvelopeQueueable(
          orderId,
          preparedAttempt,
          continuation
        )
      );
    } else if (continuation != null) {
      System.enqueueJob(continuation);
    }
  }
}
