public without sharing class QuoteLineItemsController {
  private static final Set<String> DELETABLE_QUOTE_STATUSES = new Set<String>{
    'Bozza',
    'Draft',
    'In Trattativa'
  };

  public class QuoteLinesContext {
    @AuraEnabled
    public String quoteName;
    @AuraEnabled
    public String quoteStatus;
    @AuraEnabled
    public Boolean canDeleteLines;
    @AuraEnabled
    public List<LineRow> rows;
  }

  public class LineRow {
    @AuraEnabled
    public String key;
    @AuraEnabled
    public Id id;
    @AuraEnabled
    public Id parentLineId;
    @AuraEnabled
    public Boolean isComponent;
    @AuraEnabled
    public Boolean deleteDisabled;
    @AuraEnabled
    public String productName;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public Decimal quantity;
    @AuraEnabled
    public Decimal unitPrice;
    @AuraEnabled
    public Decimal totalPrice;

    public LineRow(QuoteLineItem line, Boolean canDeleteLines) {
      key = String.valueOf(line.Id);
      id = line.Id;
      isComponent = false;
      deleteDisabled = !canDeleteLines;
      productName = line.Product2 == null ? null : line.Product2.Name;
      productCode = line.Product2 == null ? null : line.Product2.ProductCode;
      description = line.Description;
      quantity = line.Quantity;
      unitPrice = line.UnitPrice;
      totalPrice = line.TotalPrice;
    }

    public LineRow(BundleComponent__c component, QuoteLineItem parentLine) {
      Decimal parentQuantity = parentLine.Quantity == null
        ? 0
        : parentLine.Quantity;
      Decimal componentQuantity = component.Quantity__c == null
        ? 0
        : component.Quantity__c;

      key = String.valueOf(parentLine.Id) + '-' + String.valueOf(component.Id);
      id = component.Id;
      parentLineId = parentLine.Id;
      isComponent = true;
      deleteDisabled = true;
      productName = component.Product__r == null
        ? null
        : component.Product__r.Name;
      productCode = component.Product__r == null
        ? null
        : component.Product__r.ProductCode;
      description = 'Componente bundle';
      quantity = parentQuantity * componentQuantity;
      unitPrice = component.Unit_Spread__c;
      totalPrice = parentQuantity * component.Spread_Price__c;
    }
  }

  @AuraEnabled(cacheable=true)
  public static QuoteLinesContext getContext(Id quoteId) {
    validateQuoteId(quoteId);
    requireReadAccess();

    Quote quoteRecord = [
      SELECT Id, Name, QuoteNumber, Status
      FROM Quote
      WHERE Id = :quoteId
      WITH USER_MODE
      LIMIT 1
    ];

    List<QuoteLineItem> quoteLines = [
      SELECT
        Id,
        Product2Id,
        Quantity,
        UnitPrice,
        TotalPrice,
        Description,
        Product2.Name,
        Product2.ProductCode
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
      WITH USER_MODE
      ORDER BY SortOrder ASC NULLS LAST, CreatedDate ASC, Id ASC
    ];

    Set<Id> productIds = new Set<Id>();
    for (QuoteLineItem line : quoteLines) {
      if (line.Product2Id != null) {
        productIds.add(line.Product2Id);
      }
    }

    Map<Id, List<BundleComponent__c>> componentsByBundleId = new Map<Id, List<BundleComponent__c>>();
    if (!productIds.isEmpty()) {
      for (BundleComponent__c component : [
        SELECT
          Id,
          Bundle__c,
          Quantity__c,
          Unit_Spread__c,
          Spread_Price__c,
          Product__r.Name,
          Product__r.ProductCode
        FROM BundleComponent__c
        WHERE Bundle__c IN :productIds
        WITH USER_MODE
        ORDER BY Product__r.Name, Id
      ]) {
        if (!componentsByBundleId.containsKey(component.Bundle__c)) {
          componentsByBundleId.put(
            component.Bundle__c,
            new List<BundleComponent__c>()
          );
        }
        componentsByBundleId.get(component.Bundle__c).add(component);
      }
    }

    Boolean canDeleteLines =
      DELETABLE_QUOTE_STATUSES.contains(quoteRecord.Status) &&
      Schema.sObjectType.QuoteLineItem.isDeletable();

    QuoteLinesContext context = new QuoteLinesContext();
    context.quoteName = String.isBlank(quoteRecord.Name)
      ? quoteRecord.QuoteNumber
      : quoteRecord.Name;
    context.quoteStatus = quoteRecord.Status;
    context.canDeleteLines = canDeleteLines;
    context.rows = new List<LineRow>();

    for (QuoteLineItem line : quoteLines) {
      context.rows.add(new LineRow(line, canDeleteLines));
      List<BundleComponent__c> components = componentsByBundleId.get(
        line.Product2Id
      );
      if (components == null) {
        continue;
      }
      for (BundleComponent__c component : components) {
        context.rows.add(new LineRow(component, line));
      }
    }

    return context;
  }

  @AuraEnabled
  public static QuoteLinesContext deleteLine(Id quoteId, Id lineId) {
    validateQuoteId(quoteId);
    validateLineId(lineId);
    requireDeleteAccess();

    Quote quoteRecord = [
      SELECT Id, Status
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
      FOR UPDATE
    ];
    if (!DELETABLE_QUOTE_STATUSES.contains(quoteRecord.Status)) {
      throw new AuraHandledException(
        'Le righe possono essere eliminate solo quando il preventivo e in Bozza o In Trattativa.'
      );
    }

    List<QuoteLineItem> lines = [
      SELECT Id, QuoteId
      FROM QuoteLineItem
      WHERE Id = :lineId
      LIMIT 1
      FOR UPDATE
    ];
    if (lines.isEmpty() || lines[0].QuoteId != quoteId) {
      throw new AuraHandledException(
        'La riga selezionata non appartiene a questo preventivo. Ricarica e riprova.'
      );
    }

    delete lines[0];
    return getContext(quoteId);
  }

  private static void validateQuoteId(Id quoteId) {
    if (quoteId == null || quoteId.getSObjectType() != Quote.SObjectType) {
      throw new AuraHandledException(
        'Apri questo componente da un preventivo.'
      );
    }
  }

  private static void validateLineId(Id lineId) {
    if (
      lineId == null ||
      lineId.getSObjectType() != QuoteLineItem.SObjectType
    ) {
      throw new AuraHandledException('Seleziona una riga preventivo valida.');
    }
  }

  private static void requireReadAccess() {
    if (
      !Schema.sObjectType.Quote.isAccessible() ||
      !Schema.sObjectType.QuoteLineItem.isAccessible() ||
      !Schema.sObjectType.Product2.isAccessible() ||
      !Schema.sObjectType.BundleComponent__c.isAccessible()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi necessari per leggere le righe preventivo.'
      );
    }
  }

  private static void requireDeleteAccess() {
    requireReadAccess();
    if (!Schema.sObjectType.QuoteLineItem.isDeletable()) {
      throw new AuraHandledException(
        'Non hai i permessi necessari per eliminare le righe preventivo.'
      );
    }
  }
}
