public without sharing class DocuSignQuoteEnvelopeQueueable implements Queueable, Database.AllowsCallouts {
  private final Id quoteId;

  public DocuSignQuoteEnvelopeQueueable(Id quoteId) {
    this.quoteId = quoteId;
  }

  public void execute(QueueableContext context) {
    DocuSignQuoteEnvelopeService.sendEnvelope(quoteId);
  }
}
