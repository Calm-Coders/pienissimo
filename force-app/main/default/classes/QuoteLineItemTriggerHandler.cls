public without sharing class QuoteLineItemTriggerHandler {
  private static final String BUNDLE_RECORD_TYPE_DEVELOPER_NAME = 'Bundle';
  private static final String DRAFT_QUOTE_STATUS = 'Bozza';
  private static final String INVALID_QUOTE_MIX_ERROR = 'Il Preventivo puo contenere un solo Bundle oppure prodotti Item, non entrambi. Rimuovi le righe esistenti prima di cambiare tipologia.';

  public static void beforeSave(
    List<QuoteLineItem> newLines,
    Map<Id, QuoteLineItem> oldLineMap
  ) {
    if (newLines == null || newLines.isEmpty()) {
      return;
    }

    Set<Id> quoteIds = new Set<Id>();
    Set<Id> replacedLineIds = new Set<Id>();
    Set<Id> pricebookEntryIds = new Set<Id>();
    Map<Id, List<QuoteLineItem>> pendingLinesByQuoteId = new Map<Id, List<QuoteLineItem>>();

    for (QuoteLineItem line : newLines) {
      if (line.QuoteId != null) {
        quoteIds.add(line.QuoteId);
        if (!pendingLinesByQuoteId.containsKey(line.QuoteId)) {
          pendingLinesByQuoteId.put(line.QuoteId, new List<QuoteLineItem>());
        }
        pendingLinesByQuoteId.get(line.QuoteId).add(line);
      }

      if (line.PricebookEntryId != null) {
        pricebookEntryIds.add(line.PricebookEntryId);
      }

      QuoteLineItem oldLine = oldLineMap == null
        ? null
        : oldLineMap.get(line.Id);
      if (oldLine == null) {
        continue;
      }

      replacedLineIds.add(oldLine.Id);
      if (oldLine.QuoteId != null) {
        quoteIds.add(oldLine.QuoteId);
      }
    }

    if (quoteIds.isEmpty()) {
      return;
    }

    Map<Id, ProductLineKind> kindByPricebookEntryId = loadProductLineKinds(
      pricebookEntryIds
    );
    Map<Id, QuoteProductMix> mixByQuoteId = initializeMixes(quoteIds);

    addExistingLines(mixByQuoteId, replacedLineIds);
    addPendingLines(
      mixByQuoteId,
      pendingLinesByQuoteId,
      kindByPricebookEntryId
    );

    for (Id quoteId : pendingLinesByQuoteId.keySet()) {
      QuoteProductMix mix = mixByQuoteId.get(quoteId);
      if (mix == null || mix.isValid()) {
        continue;
      }

      for (QuoteLineItem line : pendingLinesByQuoteId.get(quoteId)) {
        line.addError(INVALID_QUOTE_MIX_ERROR);
      }
    }
  }

  public static void afterInsert(List<QuoteLineItem> newLines) {
    if (newLines == null || newLines.isEmpty()) {
      return;
    }

    Set<Id> quoteIds = new Set<Id>();
    for (QuoteLineItem line : newLines) {
      if (line.QuoteId != null) {
        quoteIds.add(line.QuoteId);
      }
    }

    resetQuotesToDraft(quoteIds);
  }

  public static void afterDelete(List<QuoteLineItem> oldLines) {
    if (oldLines == null || oldLines.isEmpty()) {
      return;
    }

    Set<Id> quoteIds = new Set<Id>();
    Set<Id> trancheIds = new Set<Id>();
    for (QuoteLineItem line : oldLines) {
      if (line.QuoteId != null) {
        quoteIds.add(line.QuoteId);
      }
      if (line.Tranche__c != null) {
        trancheIds.add(line.Tranche__c);
      }
    }

    resetQuotesToDraft(quoteIds);

    if (trancheIds.isEmpty()) {
      return;
    }

    for (QuoteLineItem remainingLine : [
      SELECT Tranche__c
      FROM QuoteLineItem
      WHERE Tranche__c IN :trancheIds
    ]) {
      trancheIds.remove(remainingLine.Tranche__c);
    }

    if (trancheIds.isEmpty()) {
      return;
    }

    delete [
      SELECT Id
      FROM Tranche__c
      WHERE Id IN :trancheIds
    ];
  }

  private static void resetQuotesToDraft(Set<Id> quoteIds) {
    if (quoteIds == null || quoteIds.isEmpty()) {
      return;
    }

    List<Quote> quotesToUpdate = new List<Quote>();
    for (Quote quoteRecord : [
      SELECT Id, Status
      FROM Quote
      WHERE Id IN :quoteIds AND Status != :DRAFT_QUOTE_STATUS
    ]) {
      quotesToUpdate.add(
        new Quote(Id = quoteRecord.Id, Status = DRAFT_QUOTE_STATUS)
      );
    }

    if (!quotesToUpdate.isEmpty()) {
      update quotesToUpdate;
    }
  }

  private static Map<Id, QuoteProductMix> initializeMixes(Set<Id> quoteIds) {
    Map<Id, QuoteProductMix> mixByQuoteId = new Map<Id, QuoteProductMix>();
    for (Id quoteId : quoteIds) {
      mixByQuoteId.put(quoteId, new QuoteProductMix());
    }
    return mixByQuoteId;
  }

  private static Map<Id, ProductLineKind> loadProductLineKinds(
    Set<Id> pricebookEntryIds
  ) {
    Map<Id, ProductLineKind> kindByPricebookEntryId = new Map<Id, ProductLineKind>();
    if (pricebookEntryIds == null || pricebookEntryIds.isEmpty()) {
      return kindByPricebookEntryId;
    }

    for (PricebookEntry entry : [
      SELECT Id, Product2.Is_Plus__c, Product2.RecordType.DeveloperName
      FROM PricebookEntry
      WHERE Id IN :pricebookEntryIds
    ]) {
      kindByPricebookEntryId.put(entry.Id, new ProductLineKind(entry));
    }

    return kindByPricebookEntryId;
  }

  private static void addExistingLines(
    Map<Id, QuoteProductMix> mixByQuoteId,
    Set<Id> replacedLineIds
  ) {
    Set<Id> quoteIds = mixByQuoteId.keySet();
    if (quoteIds.isEmpty()) {
      return;
    }

    List<QuoteLineItem> existingLines = replacedLineIds == null ||
      replacedLineIds.isEmpty()
      ? [
          SELECT
            Id,
            QuoteId,
            PricebookEntry.Product2.RecordType.DeveloperName,
            PricebookEntry.Product2.Is_Plus__c
          FROM QuoteLineItem
          WHERE QuoteId IN :quoteIds
        ]
      : [
          SELECT
            Id,
            QuoteId,
            PricebookEntry.Product2.RecordType.DeveloperName,
            PricebookEntry.Product2.Is_Plus__c
          FROM QuoteLineItem
          WHERE QuoteId IN :quoteIds AND Id NOT IN :replacedLineIds
        ];

    for (QuoteLineItem line : existingLines) {
      QuoteProductMix mix = mixByQuoteId.get(line.QuoteId);
      if (mix != null) {
        mix.addLine(new ProductLineKind(line));
      }
    }
  }

  private static void addPendingLines(
    Map<Id, QuoteProductMix> mixByQuoteId,
    Map<Id, List<QuoteLineItem>> pendingLinesByQuoteId,
    Map<Id, ProductLineKind> kindByPricebookEntryId
  ) {
    for (Id quoteId : pendingLinesByQuoteId.keySet()) {
      QuoteProductMix mix = mixByQuoteId.get(quoteId);
      if (mix == null) {
        continue;
      }

      for (QuoteLineItem line : pendingLinesByQuoteId.get(quoteId)) {
        mix.addLine(kindByPricebookEntryId.get(line.PricebookEntryId));
      }
    }
  }

  private static Boolean isBundle(QuoteLineItem line) {
    if (
      line.PricebookEntry == null ||
      line.PricebookEntry.Product2 == null ||
      line.PricebookEntry.Product2.RecordType == null
    ) {
      return false;
    }

    return line.PricebookEntry.Product2.RecordType.DeveloperName ==
      BUNDLE_RECORD_TYPE_DEVELOPER_NAME;
  }

  private static Boolean isBundle(PricebookEntry entry) {
    if (entry.Product2 == null || entry.Product2.RecordType == null) {
      return false;
    }

    return entry.Product2.RecordType.DeveloperName ==
      BUNDLE_RECORD_TYPE_DEVELOPER_NAME;
  }

  private class QuoteProductMix {
    Integer bundleLineCount = 0;
    Integer itemLineCount = 0;
    Integer plusBundleLineCount = 0;

    void addLine(ProductLineKind kind) {
      if (kind == null) {
        itemLineCount++;
        return;
      }

      if (kind.isPlusBundle) {
        plusBundleLineCount++;
        return;
      }

      if (kind.isBundle) {
        bundleLineCount++;
        return;
      }

      itemLineCount++;
    }

    Boolean isValid() {
      if (plusBundleLineCount > 0) {
        return bundleLineCount == 0 && itemLineCount == 0;
      }

      return bundleLineCount <= 1 &&
        (bundleLineCount == 0 ||
        itemLineCount == 0);
    }
  }

  private class ProductLineKind {
    Boolean isBundle;
    Boolean isPlusBundle;

    ProductLineKind(PricebookEntry entry) {
      isBundle = isBundle(entry);
      isPlusBundle =
        isBundle &&
        entry.Product2 != null &&
        entry.Product2.Is_Plus__c == true;
    }

    ProductLineKind(QuoteLineItem line) {
      isBundle = isBundle(line);
      isPlusBundle =
        isBundle &&
        line.PricebookEntry.Product2 != null &&
        line.PricebookEntry.Product2.Is_Plus__c == true;
    }
  }
}
