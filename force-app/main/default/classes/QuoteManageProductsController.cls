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
      unitPrice = salesUnitPrice(entry);
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

  public class ExistingQuoteLine {
    @AuraEnabled
    public Id quoteLineItemId;
    @AuraEnabled
    public Id pricebookEntryId;
    @AuraEnabled
    public String productName;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public String productType;
    @AuraEnabled
    public Boolean isPlus;
    @AuraEnabled
    public Decimal quantity;
    @AuraEnabled
    public Decimal unitPrice;

    public ExistingQuoteLine(QuoteLineItem line) {
      quoteLineItemId = line.Id;
      pricebookEntryId = line.PricebookEntryId;
      productName = line.Product2 == null ? null : line.Product2.Name;
      productCode = line.Product2 == null ? null : line.Product2.ProductCode;
      productType = line.PricebookEntry == null ||
        line.PricebookEntry.Product2 == null ||
        line.PricebookEntry.Product2.RecordType == null
        ? null
        : line.PricebookEntry.Product2.RecordType.DeveloperName;
      isPlus = line.Product2 != null && line.Product2.Is_Plus__c == true;
      quantity = line.Quantity;
      unitPrice = line.UnitPrice;
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
    @AuraEnabled
    public List<ExistingQuoteLine> existingLines;
  }

  public class ProductSelection {
    @AuraEnabled
    public Id pricebookEntryId { get; set; }
    @AuraEnabled
    public Decimal quantity { get; set; }
  }

  public class TrancheSelection {
    @AuraEnabled
    public Date dueDate { get; set; }
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
    context.existingLines = new List<ExistingQuoteLine>();

    for (QuoteLineItem line : [
      SELECT
        Id,
        PricebookEntryId,
        Quantity,
        UnitPrice,
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
        context.existingLines.add(new ExistingQuoteLine(line));
        continue;
      }

      if (!isBundleLine(line)) {
        context.hasItemLines = true;
      }

      context.existingLines.add(new ExistingQuoteLine(line));
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

    Set<String> allowedTypes = context.isPlusOpportunity
      ? new Set<String>{ ITEM_RECORD_TYPE_DEVELOPER_NAME }
      : context.hasItemLines
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
      String.isBlank(searchTerm) ? 50 : 10
    );
  }

  @AuraEnabled
  public static void saveProducts(
    Id quoteId,
    List<ProductSelection> products,
    List<TrancheSelection> tranches
  ) {
    if (products == null || products.isEmpty()) {
      throw new AuraHandledException('Seleziona almeno un prodotto.');
    }
    validateQuoteId(quoteId);

    Quote quoteRecord = [
      SELECT
        Id,
        Name,
        QuoteNumber,
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
          Product2.Bundle_Selling_Price__c,
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
      requireTrancheCreateAccess();
      validatePlusTranches(quoteId, tranches);
      if (context.hasPlusLine || plusCount != 1 || entriesById.size() > 1) {
        throw new AuraHandledException(
          'Questo preventivo puo contenere un solo prodotto Plus.'
        );
      }
      if (bundleCount > 0 || itemCount != 1) {
        throw new AuraHandledException(
          'Per una opportunita Plus seleziona un solo prodotto Item marcato Is Plus.'
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

    if (context.isPlusOpportunity) {
      PricebookEntry plusEntry = entriesById.values()[0];
      Decimal plusUnitPrice = requireSalesUnitPrice(plusEntry);
      List<Tranche__c> plusTranches = buildPlusTranches(
        quoteRecord,
        tranches,
        plusUnitPrice
      );
      insert plusTranches;
      insert buildPlusQuoteLines(quoteId, plusEntry, plusTranches);
      return;
    }

    List<QuoteLineItem> linesToInsert = new List<QuoteLineItem>();
    for (Id entryId : selectionByEntryId.keySet()) {
      PricebookEntry entry = entriesById.get(entryId);
      ProductSelection selection = selectionByEntryId.get(entryId);
      Boolean isBundle = isBundleEntry(entry);
      Decimal quantity = isBundle ? 1 : selection.quantity;
      Decimal unitPrice = requireSalesUnitPrice(entry);
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
          UnitPrice = unitPrice
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
      String.escapeSingleQuotes((searchTerm == null ? '' : searchTerm).trim()) +
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
          Product2.Bundle_Selling_Price__c,
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
          Product2.Bundle_Selling_Price__c,
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
          Product2.Bundle_Selling_Price__c,
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
          Product2.Bundle_Selling_Price__c,
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
          Product2.Bundle_Selling_Price__c,
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
          Product2.Bundle_Selling_Price__c,
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

  private static Decimal salesUnitPrice(PricebookEntry entry) {
    if (isBundleEntry(entry)) {
      return entry.Product2.Bundle_Selling_Price__c;
    }

    return entry.UnitPrice;
  }

  private static Decimal requireSalesUnitPrice(PricebookEntry entry) {
    Decimal unitPrice = salesUnitPrice(entry);
    if (unitPrice == null || unitPrice <= 0) {
      throw new AuraHandledException(
        isBundleEntry(entry)
          ? 'Configura il prezzo di vendita del bundle prima di aggiungerlo al preventivo.'
          : 'Configura un prezzo di listino valido prima di aggiungere il prodotto al preventivo.'
      );
    }

    return unitPrice;
  }

  private static void validatePlusTranches(
    Id quoteId,
    List<TrancheSelection> tranches
  ) {
    if (tranches == null || tranches.isEmpty()) {
      throw new AuraHandledException(
        'Inserisci il numero di tranche e la data di scadenza di ogni tranche.'
      );
    }
    if (tranches.size() > 20) {
      throw new AuraHandledException(
        'Crea al massimo 20 tranche per questo prodotto.'
      );
    }
    for (TrancheSelection tranche : tranches) {
      if (tranche == null || tranche.dueDate == null) {
        throw new AuraHandledException(
          'Inserisci la data di scadenza di ogni tranche.'
        );
      }
    }

    Integer existingTranches = [
      SELECT COUNT()
      FROM Tranche__c
      WHERE Quote__c = :quoteId
    ];
    if (existingTranches > 0) {
      throw new AuraHandledException(
        'Questo preventivo ha gia delle tranche. Ricarica e modifica le tranche esistenti.'
      );
    }
  }

  private static List<Tranche__c> buildPlusTranches(
    Quote quoteRecord,
    List<TrancheSelection> tranches,
    Decimal totalAmount
  ) {
    Integer trancheCount = tranches.size();
    Decimal normalizedTotal = (totalAmount == null ? 0 : totalAmount)
      .setScale(2);
    Decimal baseAmount = (normalizedTotal / trancheCount)
      .setScale(2, RoundingMode.DOWN);
    Decimal assignedAmount = 0;
    String quoteName = String.isBlank(quoteRecord.Name)
      ? quoteRecord.QuoteNumber
      : quoteRecord.Name;
    List<Tranche__c> records = new List<Tranche__c>();

    for (Integer i = 0; i < trancheCount; i++) {
      Decimal trancheAmount = i == trancheCount - 1
        ? normalizedTotal - assignedAmount
        : baseAmount;
      assignedAmount += trancheAmount;
      Integer sequence = i + 1;
      records.add(
        new Tranche__c(
          Quote__c = quoteRecord.Id,
          Name = 'T' + sequence + ' - ' + quoteName,
          Data_Scadenza__c = tranches[i].dueDate,
          Sequenza__c = sequence,
          Importo_Previsto__c = trancheAmount,
          Stato__c = 'Aperta',
          Completamente_Pagata__c = false
        )
      );
    }

    return records;
  }

  private static List<QuoteLineItem> buildPlusQuoteLines(
    Id quoteId,
    PricebookEntry plusEntry,
    List<Tranche__c> tranches
  ) {
    List<QuoteLineItem> lines = new List<QuoteLineItem>();
    for (Tranche__c tranche : tranches) {
      lines.add(
        new QuoteLineItem(
          QuoteId = quoteId,
          PricebookEntryId = plusEntry.Id,
          Quantity = 1,
          UnitPrice = tranche.Importo_Previsto__c,
          Tranche__c = tranche.Id,
          Data_Scadenza__c = tranche.Data_Scadenza__c
        )
      );
    }
    return lines;
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

  private static void requireTrancheCreateAccess() {
    if (
      !Schema.sObjectType.Tranche__c.isAccessible() ||
      !Schema.sObjectType.Tranche__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Quote__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Name.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Data_Scadenza__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Sequenza__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Importo_Previsto__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Stato__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Completamente_Pagata__c.isCreateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Tranche__c.isCreateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Data_Scadenza__c.isCreateable()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi per creare le tranche del preventivo.'
      );
    }
  }
}
