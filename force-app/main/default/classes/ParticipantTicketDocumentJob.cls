public without sharing class ParticipantTicketDocumentJob implements Queueable, Database.AllowsCallouts {
  private static final Integer MIN_RENDERED_PDF_SIZE_BYTES = 1000;
  private final Set<Id> assetIds;

  public ParticipantTicketDocumentJob(Set<Id> assetIds) {
    this.assetIds = assetIds == null ? new Set<Id>() : new Set<Id>(assetIds);
  }

  public void execute(QueueableContext context) {
    generate(assetIds);
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

    for (ContentVersion file : [
      SELECT FirstPublishLocationId, Title
      FROM ContentVersion
      WHERE
        FirstPublishLocationId IN :assetIds
        AND Title LIKE 'Documenti partecipazione%'
        AND ContentSize >= :MIN_RENDERED_PDF_SIZE_BYTES
    ]) {
      existingDocumentKeys.add(
        String.valueOf(file.FirstPublishLocationId) + ':' + file.Title
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

  public class ParticipantTicketDocumentException extends Exception {
  }
}
