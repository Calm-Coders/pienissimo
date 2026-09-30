/**
 * Renders the participant document PDF of each ticket Asset and files it on
 * the Asset. Queued by ParticipantTicketDocumentRequests, so it runs as the
 * event subscriber's internal user: the site guest user cannot render the page.
 */
public without sharing class ParticipantTicketDocumentJob implements Queueable, Database.AllowsCallouts {
  private static final Integer MIN_RENDERED_PDF_SIZE_BYTES = 1000;
  // One document is ~1.4 MB (ten full-page background images). Ten of them in
  // one transaction would pass the 12 MB asynchronous heap, so each job renders
  // one ticket and a finalizer queues the next job with the rest.
  @TestVisible
  private static final Integer DOCUMENTS_PER_JOB = 1;
  @TestVisible
  private static Set<Id> chainedAssetIds = new Set<Id>();
  private final List<Id> assetIds;

  public ParticipantTicketDocumentJob(Set<Id> assetIds) {
    this.assetIds = assetIds == null ? new List<Id>() : new List<Id>(assetIds);
    this.assetIds.sort();
  }

  public void execute(QueueableContext context) {
    Set<Id> current = new Set<Id>();
    Set<Id> remaining = new Set<Id>();
    for (Id assetId : assetIds) {
      if (current.size() < DOCUMENTS_PER_JOB) {
        current.add(assetId);
      } else {
        remaining.add(assetId);
      }
    }

    if (!remaining.isEmpty()) {
      System.attachFinalizer(new NextDocuments(remaining));
    }
    generate(current);
  }

  public static void generate(Set<Id> assetIds) {
    if (assetIds.isEmpty()) {
      throw new ParticipantTicketDocumentException(
        'No Asset ids were provided for participant document generation.'
      );
    }

    List<ContentVersion> documents = new List<ContentVersion>();
    List<String> skippedAssets = new List<String>();
    Integer queriedAssetCount = 0;
    Integer existingDocumentCount = 0;
    Set<String> existingDocumentKeys = new Set<String>();

    // Through the Asset's links: a ContentVersion query only returns files the
    // running user owns, so it would miss a document filed by another user.
    for (ContentDocumentLink link : [
      SELECT LinkedEntityId, ContentDocument.Title
      FROM ContentDocumentLink
      WHERE
        LinkedEntityId IN :assetIds
        AND ContentDocument.Title LIKE 'Documenti partecipazione%'
        AND ContentDocument.ContentSize >= :MIN_RENDERED_PDF_SIZE_BYTES
    ]) {
      existingDocumentKeys.add(
        String.valueOf(link.LinkedEntityId) + ':' + link.ContentDocument.Title
      );
    }

    for (Asset ticket : [
      SELECT Id, Name, QR_Id__c
      FROM Asset
      WHERE Id IN :assetIds
      ORDER BY Id
    ]) {
      queriedAssetCount++;
      String suffix = String.isBlank(ticket.QR_Id__c)
        ? String.valueOf(ticket.Id)
        : ticket.QR_Id__c;
      String title = 'Documenti partecipazione - ' + suffix;
      if (
        existingDocumentKeys.contains(String.valueOf(ticket.Id) + ':' + title)
      ) {
        existingDocumentCount++;
        continue;
      }

      Blob body = renderDocument(ticket.Id);
      if (body == null || body.size() < MIN_RENDERED_PDF_SIZE_BYTES) {
        skippedAssets.add(
          String.valueOf(ticket.Id) +
            ' rendered ' +
            (body == null ? 'null' : String.valueOf(body.size()) + ' bytes')
        );
        continue;
      }

      documents.add(
        new ContentVersion(
          Title = title,
          PathOnClient = title.replace(' ', '-') + '.pdf',
          VersionData = body,
          FirstPublishLocationId = ticket.Id
        )
      );
    }

    if (!documents.isEmpty()) {
      insert documents;
      return;
    }
    if (existingDocumentCount > 0 && skippedAssets.isEmpty()) {
      return;
    }

    if (queriedAssetCount == 0) {
      throw new ParticipantTicketDocumentException(
        'No readable Asset records were found for ids: ' +
        String.join(toStringList(assetIds), ', ')
      );
    }

    throw new ParticipantTicketDocumentException(
      'No participant documents were generated. ' +
      String.join(skippedAssets, '; ')
    );
  }

  private static Blob renderDocument(Id assetId) {
    if (Test.isRunningTest()) {
      return Blob.valueOf('Participant ticket PDF'.leftPad(1000, ' '));
    }

    PageReference page = Page.ParticipantTicketPdf;
    page.getParameters().put('id', String.valueOf(assetId));

    return page.getContentAsPDF();
  }

  private static List<String> toStringList(Set<Id> values) {
    List<String> stringValues = new List<String>();
    for (Id value : values) {
      stringValues.add(String.valueOf(value));
    }
    return stringValues;
  }

  /**
   * Queues the next job whether this one succeeded or failed, so one ticket
   * that cannot be rendered does not stop the others. A failed ticket still
   * shows as a Failed job in Apex Jobs.
   */
  public class NextDocuments implements Finalizer {
    private final Set<Id> assetIds;

    public NextDocuments(Set<Id> assetIds) {
      this.assetIds = assetIds;
    }

    public void execute(FinalizerContext context) {
      if (Test.isRunningTest()) {
        // Apex tests cannot chain queueable jobs.
        chainedAssetIds.addAll(assetIds);
        return;
      }
      System.enqueueJob(new ParticipantTicketDocumentJob(assetIds));
    }
  }

  public class ParticipantTicketDocumentException extends Exception {
  }
}
