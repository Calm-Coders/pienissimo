public with sharing class QuoteManageProductsController {
  private static final String BUNDLE_RECORD_TYPE_DEVELOPER_NAME = 'Bundle';
  private static final String ITEM_RECORD_TYPE_DEVELOPER_NAME = 'Item';
  private static final String PLUS_OPPORTUNITY_RECORD_TYPE = 'Plus_Attivazione_Rinnovo';
  private static final String STANDARD_OPPORTUNITY_RECORD_TYPE = 'Standart';

  public class ProductOption {
    @AuraEnabled
    public Id pricebookEntryId;
    @AuraEnabled
    public Id pricebook2Id;
    @AuraEnabled
    public Id productId;
    @AuraEnabled
    public String productName;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public String productType;
    @AuraEnabled
    public Boolean isPlus;
    @AuraEnabled
    public Decimal unitPrice;

    public ProductOption(PricebookEntry entry) {
      pricebookEntryId = entry.Id;
      pricebook2Id = entry.Pricebook2Id;
      productId = entry.Product2Id;
      productName = entry.Product2 == null ? null : entry.Product2.Name;
      productCode = entry.Product2 == null ? null : entry.Product2.ProductCode;
      productType = entry.Product2 == null ||
        entry.Product2.RecordType == null
        ? null
        : entry.Product2.RecordType.DeveloperName;
      isPlus = entry.Product2 != null && entry.Product2.Is_Plus__c == true;
      unitPrice = entry.UnitPrice;
    }
  }

  public class ExistingBundleLine {
    @AuraEnabled
    public Id quoteLineItemId;
    @AuraEnabled
    public String productName;
    @AuraEnabled
    public String productCode;

    public ExistingBundleLine(QuoteLineItem line) {
      quoteLineItemId = line.Id;
      productName = line.Product2 == null ? null : line.Product2.Name;
      productCode = line.Product2 == null ? null : line.Product2.ProductCode;
    }
  }

  public class QuoteProductsContext {
    @AuraEnabled
    public String quoteName;
    @AuraEnabled
    public String quoteStatus;
    @AuraEnabled
    public Boolean isEditable;
    @AuraEnabled
    public Boolean hasItemLines;
    @AuraEnabled
    public String opportunityRecordTypeDeveloperName;
    @AuraEnabled
    public Boolean isPlusOpportunity;
    @AuraEnabled
    public Boolean isStandardOpportunity;
    @AuraEnabled
    public Boolean hasPlusLine;
    @AuraEnabled
    public ExistingBundleLine existingBundleLine;
  }

  public class ProductSelection {
    @AuraEnabled
    public Id pricebookEntryId { get; set; }
    @AuraEnabled
    public Decimal quantity { get; set; }
  }

  @AuraEnabled
  public static QuoteProductsContext getContext(Id quoteId) {
    validateQuoteId(quoteId);
    requireReadAccess();

    Quote quoteRecord = [
      SELECT Id, Name, QuoteNumber, Status, Opportunity.RecordType.DeveloperName
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
    ];

    QuoteProductsContext context = new QuoteProductsContext();
    context.quoteName = String.isBlank(quoteRecord.Name)
      ? quoteRecord.QuoteNumber
      : quoteRecord.Name;
    context.quoteStatus = quoteRecord.Status;
    context.isEditable = true;
    context.hasItemLines = false;
    context.opportunityRecordTypeDeveloperName = opportunityRecordTypeDeveloperName(
      quoteRecord
    );
    context.isPlusOpportunity = isPlusOpportunity(quoteRecord);
    context.isStandardOpportunity = isStandardOpportunity(quoteRecord);
    context.hasPlusLine = false;

    for (QuoteLineItem line : [
      SELECT
        Id,
        Product2.Name,
        Product2.ProductCode,
        Product2.Is_Plus__c,
        PricebookEntry.Product2.RecordType.DeveloperName
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
      ORDER BY CreatedDate, Id
    ]) {
      if (line.Product2 != null && line.Product2.Is_Plus__c == true) {
        context.hasPlusLine = true;
      }

      if (isBundleLine(line) && context.existingBundleLine == null) {
        context.existingBundleLine = new ExistingBundleLine(line);
        continue;
      }

      if (!isBundleLine(line)) {
        context.hasItemLines = true;
      }
    }

    return context;
  }

  @AuraEnabled
  public static List<ProductOption> searchProducts(
    Id quoteId,
    String searchTerm
  ) {
    validateQuoteId(quoteId);
    requireReadAccess();

    if (String.isBlank(searchTerm)) {
      return new List<ProductOption>();
    }

    Quote quoteRecord = [
      SELECT
        Id,
        Pricebook2Id,
        OpportunityId,
        Opportunity.Pricebook2Id,
        Opportunity.RecordType.DeveloperName
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
    ];

    QuoteProductsContext context = getContext(quoteId);
    if (context.existingBundleLine != null) {
      return new List<ProductOption>();
    }
    if (context.isPlusOpportunity && context.hasPlusLine) {
      return new List<ProductOption>();
    }

    Set<String> allowedTypes = context.hasItemLines
      ? new Set<String>{ ITEM_RECORD_TYPE_DEVELOPER_NAME }
      : new Set<String>{
          BUNDLE_RECORD_TYPE_DEVELOPER_NAME,
          ITEM_RECORD_TYPE_DEVELOPER_NAME
        };

    return findProductOptions(
      effectivePricebook2Id(quoteRecord),
      searchTerm,
      allowedTypes,
      context.isPlusOpportunity,
      context.isStandardOpportunity,
      5
    );
  }

  @AuraEnabled
  public static void saveProducts(Id quoteId, List<ProductSelection> products) {
    if (products == null || products.isEmpty()) {
      throw new AuraHandledException('Seleziona almeno un prodotto.');
    }
    validateQuoteId(quoteId);

    Quote quoteRecord = [
      SELECT
        Id,
        Status,
        Pricebook2Id,
        OpportunityId,
        Opportunity.Pricebook2Id,
        Opportunity.RecordType.DeveloperName
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
      FOR UPDATE
    ];

    requireSaveAccess();

    QuoteProductsContext context = getContext(quoteId);
    if (context.existingBundleLine != null) {
      throw new AuraHandledException(
        'Il preventivo contiene gia un bundle. Non puoi aggiungerne un altro.'
      );
    }

    Map<Id, ProductSelection> selectionByEntryId = new Map<Id, ProductSelection>();
    for (ProductSelection selection : products) {
      validatePricebookEntryId(selection.pricebookEntryId);
      selectionByEntryId.put(selection.pricebookEntryId, selection);
    }

    Map<Id, PricebookEntry> entriesById = new Map<Id, PricebookEntry>(
      [
        SELECT
          Id,
          Pricebook2Id,
          UnitPrice,
          Product2.Is_Plus__c,
          Product2.RecordType.DeveloperName
        FROM PricebookEntry
        WHERE
          Id IN :selectionByEntryId.keySet()
          AND IsActive = TRUE
          AND Product2.IsActive = TRUE
      ]
    );

    if (entriesById.size() != selectionByEntryId.size()) {
      throw new AuraHandledException('Seleziona prodotti attivi.');
    }

    Id effectivePricebook2Id = effectivePricebook2Id(quoteRecord);
    Id selectedPricebook2Id;
    Integer bundleCount = 0;
    Integer itemCount = 0;
    Integer plusCount = 0;
    for (PricebookEntry entry : entriesById.values()) {
      if (selectedPricebook2Id == null) {
        selectedPricebook2Id = entry.Pricebook2Id;
      }
      if (entry.Pricebook2Id != selectedPricebook2Id) {
        throw new AuraHandledException(
          'Seleziona prodotti dallo stesso listino prezzi.'
        );
      }
      if (
        effectivePricebook2Id != null &&
        entry.Pricebook2Id != effectivePricebook2Id
      ) {
        throw new AuraHandledException(
          'Seleziona prodotti dal listino prezzi del preventivo.'
        );
      }

      if (entry.Product2 != null && entry.Product2.Is_Plus__c == true) {
        plusCount++;
      }

      if (isBundleEntry(entry)) {
        bundleCount++;
      } else {
        itemCount++;
      }
    }

    if (bundleCount > 0 && (bundleCount > 1 || itemCount > 0)) {
      throw new AuraHandledException(
        'Puoi selezionare un solo bundle oppure uno o piu prodotti Item.'
      );
    }

    if (context.isPlusOpportunity) {
      if (context.hasPlusLine || plusCount > 1 || entriesById.size() > 1) {
        throw new AuraHandledException(
          'Questo preventivo puo contenere un solo prodotto Plus.'
        );
      }
      if (plusCount != 1) {
        throw new AuraHandledException(
          'Per una opportunita Plus seleziona solo prodotti marcati Is Plus.'
        );
      }
    }

    if (context.isStandardOpportunity && plusCount > 0) {
      throw new AuraHandledException(
        'Per una Vendita Standard non puoi selezionare prodotti Plus.'
      );
    }

    if (bundleCount > 0 && context.hasItemLines) {
      throw new AuraHandledException(
        'Il preventivo contiene gia prodotti Item. Rimuovili prima di aggiungere un bundle.'
      );
    }

    setSalesPricebookWhenMissing(quoteRecord, selectedPricebook2Id);

    List<QuoteLineItem> linesToInsert = new List<QuoteLineItem>();
    for (Id entryId : selectionByEntryId.keySet()) {
      PricebookEntry entry = entriesById.get(entryId);
      ProductSelection selection = selectionByEntryId.get(entryId);
      Boolean isBundle = isBundleEntry(entry);
      Decimal quantity = isBundle ? 1 : selection.quantity;
      if (quantity == null || quantity <= 0) {
        throw new AuraHandledException(
          'Inserisci una quantita maggiore di zero.'
        );
      }

      linesToInsert.add(
        new QuoteLineItem(
          QuoteId = quoteId,
          PricebookEntryId = entry.Id,
          Quantity = quantity,
          UnitPrice = entry.UnitPrice
        )
      );
    }

    insert linesToInsert;
  }

  private static List<ProductOption> findProductOptions(
    Id quotePricebook2Id,
    String searchTerm,
    Set<String> allowedTypes,
    Boolean isPlusOnly,
    Boolean excludePlus,
    Integer limitSize
  ) {
    String normalizedSearchTerm =
      '%' +
      String.escapeSingleQuotes(searchTerm.trim()) +
      '%';

    List<PricebookEntry> entries;
    if (quotePricebook2Id == null && isPlusOnly == true) {
      entries = [
        SELECT
          Id,
          Pricebook2Id,
          Product2Id,
          Product2.Name,
          Product2.ProductCode,
          Product2.Is_Plus__c,
          Product2.RecordType.DeveloperName,
          UnitPrice
        FROM PricebookEntry
        WHERE
          IsActive = TRUE
          AND Product2.IsActive = TRUE
          AND Product2.Is_Plus__c = TRUE
          AND Product2.RecordType.DeveloperName IN :allowedTypes
          AND (Product2.Name LIKE :normalizedSearchTerm
          OR Product2.ProductCode LIKE :normalizedSearchTerm)
        ORDER BY Product2.Name
        LIMIT :limitSize
      ];
    } else if (quotePricebook2Id != null && isPlusOnly == true) {
      entries = [
        SELECT
          Id,
          Pricebook2Id,
          Product2Id,
          Product2.Name,
          Product2.ProductCode,
          Product2.Is_Plus__c,
          Product2.RecordType.DeveloperName,
          UnitPrice
        FROM PricebookEntry
        WHERE
          Pricebook2Id = :quotePricebook2Id
          AND IsActive = TRUE
          AND Product2.IsActive = TRUE
          AND Product2.Is_Plus__c = TRUE
          AND Product2.RecordType.DeveloperName IN :allowedTypes
          AND (Product2.Name LIKE :normalizedSearchTerm
          OR Product2.ProductCode LIKE :normalizedSearchTerm)
        ORDER BY Product2.Name
        LIMIT :limitSize
      ];
    } else if (quotePricebook2Id == null && excludePlus == true) {
      entries = [
        SELECT
          Id,
          Pricebook2Id,
          Product2Id,
          Product2.Name,
          Product2.ProductCode,
          Product2.Is_Plus__c,
          Product2.RecordType.DeveloperName,
          UnitPrice
        FROM PricebookEntry
        WHERE
          IsActive = TRUE
          AND Product2.IsActive = TRUE
          AND Product2.Is_Plus__c = FALSE
          AND Product2.RecordType.DeveloperName IN :allowedTypes
          AND (Product2.Name LIKE :normalizedSearchTerm
          OR Product2.ProductCode LIKE :normalizedSearchTerm)
        ORDER BY Product2.Name
        LIMIT :limitSize
      ];
    } else if (quotePricebook2Id != null && excludePlus == true) {
      entries = [
        SELECT
          Id,
          Pricebook2Id,
          Product2Id,
          Product2.Name,
          Product2.ProductCode,
          Product2.Is_Plus__c,
          Product2.RecordType.DeveloperName,
          UnitPrice
        FROM PricebookEntry
        WHERE
          Pricebook2Id = :quotePricebook2Id
          AND IsActive = TRUE
          AND Product2.IsActive = TRUE
          AND Product2.Is_Plus__c = FALSE
          AND Product2.RecordType.DeveloperName IN :allowedTypes
          AND (Product2.Name LIKE :normalizedSearchTerm
          OR Product2.ProductCode LIKE :normalizedSearchTerm)
        ORDER BY Product2.Name
        LIMIT :limitSize
      ];
    } else if (quotePricebook2Id == null) {
      entries = [
        SELECT
          Id,
          Pricebook2Id,
          Product2Id,
          Product2.Name,
          Product2.ProductCode,
          Product2.Is_Plus__c,
          Product2.RecordType.DeveloperName,
          UnitPrice
        FROM PricebookEntry
        WHERE
          IsActive = TRUE
          AND Product2.IsActive = TRUE
          AND Product2.RecordType.DeveloperName IN :allowedTypes
          AND (Product2.Name LIKE :normalizedSearchTerm
          OR Product2.ProductCode LIKE :normalizedSearchTerm)
        ORDER BY Product2.Name
        LIMIT :limitSize
      ];
    } else {
      entries = [
        SELECT
          Id,
          Pricebook2Id,
          Product2Id,
          Product2.Name,
          Product2.ProductCode,
          Product2.Is_Plus__c,
          Product2.RecordType.DeveloperName,
          UnitPrice
        FROM PricebookEntry
        WHERE
          Pricebook2Id = :quotePricebook2Id
          AND IsActive = TRUE
          AND Product2.IsActive = TRUE
          AND Product2.RecordType.DeveloperName IN :allowedTypes
          AND (Product2.Name LIKE :normalizedSearchTerm
          OR Product2.ProductCode LIKE :normalizedSearchTerm)
        ORDER BY Product2.Name
        LIMIT :limitSize
      ];
    }

    List<ProductOption> options = new List<ProductOption>();
    for (PricebookEntry entry : entries) {
      options.add(new ProductOption(entry));
    }
    return options;
  }

  private static Id effectivePricebook2Id(Quote quoteRecord) {
    if (quoteRecord.Pricebook2Id != null) {
      return quoteRecord.Pricebook2Id;
    }

    return quoteRecord.Opportunity == null
      ? null
      : quoteRecord.Opportunity.Pricebook2Id;
  }

  private static Boolean isPlusOpportunity(Quote quoteRecord) {
    return opportunityRecordTypeDeveloperName(quoteRecord) ==
      PLUS_OPPORTUNITY_RECORD_TYPE;
  }

  private static Boolean isStandardOpportunity(Quote quoteRecord) {
    return opportunityRecordTypeDeveloperName(quoteRecord) ==
      STANDARD_OPPORTUNITY_RECORD_TYPE;
  }

  private static String opportunityRecordTypeDeveloperName(Quote quoteRecord) {
    return quoteRecord.Opportunity != null &&
      quoteRecord.Opportunity.RecordType != null &&
      quoteRecord.Opportunity.RecordType.DeveloperName != null
      ? quoteRecord.Opportunity.RecordType.DeveloperName
      : '';
  }

  private static void setSalesPricebookWhenMissing(
    Quote quoteRecord,
    Id selectedPricebook2Id
  ) {
    if (
      quoteRecord.OpportunityId != null &&
      quoteRecord.Opportunity != null &&
      quoteRecord.Opportunity.Pricebook2Id == null
    ) {
      update new Opportunity(
        Id = quoteRecord.OpportunityId,
        Pricebook2Id = selectedPricebook2Id
      );
      quoteRecord.Opportunity.Pricebook2Id = selectedPricebook2Id;
    }

    if (quoteRecord.Pricebook2Id != null) {
      return;
    }

    update new Quote(Id = quoteRecord.Id, Pricebook2Id = selectedPricebook2Id);
    quoteRecord.Pricebook2Id = selectedPricebook2Id;
  }

  private static Boolean isBundleLine(QuoteLineItem line) {
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

  private static Boolean isBundleEntry(PricebookEntry entry) {
    if (entry.Product2 == null || entry.Product2.RecordType == null) {
      return false;
    }

    return entry.Product2.RecordType.DeveloperName ==
      BUNDLE_RECORD_TYPE_DEVELOPER_NAME;
  }

  private static void validateQuoteId(Id quoteId) {
    if (quoteId == null || quoteId.getSObjectType() != Quote.SObjectType) {
      throw new AuraHandledException('Apri questa azione da un preventivo.');
    }
  }

  private static void validatePricebookEntryId(Id pricebookEntryId) {
    if (
      pricebookEntryId == null ||
      pricebookEntryId.getSObjectType() != PricebookEntry.SObjectType
    ) {
      throw new AuraHandledException('Seleziona un prodotto.');
    }
  }

  private static void requireReadAccess() {
    if (
      !Schema.sObjectType.Quote.isAccessible() ||
      !Schema.sObjectType.QuoteLineItem.isAccessible() ||
      !Schema.sObjectType.PricebookEntry.isAccessible() ||
      !Schema.sObjectType.Product2.isAccessible()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi per visualizzare i prodotti del preventivo.'
      );
    }
  }

  private static void requireSaveAccess() {
    requireReadAccess();

    if (!Schema.sObjectType.QuoteLineItem.isCreateable()) {
      throw new AuraHandledException(
        'Non hai i permessi per salvare i prodotti del preventivo.'
      );
    }
  }
}
