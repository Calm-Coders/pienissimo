public with sharing class QuoteTrancheController {
  private static final Set<String> EDITABLE_QUOTE_STATUSES = new Set<String>{
    'Bozza',
    'Draft'
  };

  public class QuoteLineRow {
    @AuraEnabled
    public Id id;
    @AuraEnabled
    public String productName;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public Decimal quantity;
    @AuraEnabled
    public Decimal unitPrice;
    @AuraEnabled
    public Decimal totalPrice;
    @AuraEnabled
    public Id trancheId;
    @AuraEnabled
    public String trancheName;
    @AuraEnabled
    public Decimal trancheSequence;
    @AuraEnabled
    public Date dueDate;

    public QuoteLineRow(QuoteLineItem line) {
      id = line.Id;
      productName = line.Product2 == null ? null : line.Product2.Name;
      productCode = line.Product2 == null ? null : line.Product2.ProductCode;
      quantity = line.Quantity;
      unitPrice = line.UnitPrice;
      totalPrice = line.TotalPrice;
      trancheId = line.Tranche__c;
      trancheName = line.Tranche__r == null ? null : line.Tranche__r.Name;
      trancheSequence = line.Tranche__r == null
        ? null
        : line.Tranche__r.Sequenza__c;
      dueDate = line.Data_Scadenza__c;
    }
  }

  public class QuoteTrancheContext {
    @AuraEnabled
    public String quoteName;
    @AuraEnabled
    public String quoteStatus;
    @AuraEnabled
    public Boolean isEditable;
    @AuraEnabled
    public List<QuoteLineRow> lines;
  }

  @AuraEnabled
  public static QuoteTrancheContext getContext(Id quoteId) {
    validateQuoteId(quoteId);
    requireReadAccess();

    Quote quoteRecord = [
      SELECT Id, Name, QuoteNumber, Status
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
    ];

    QuoteTrancheContext context = new QuoteTrancheContext();
    context.quoteName = String.isBlank(quoteRecord.Name)
      ? quoteRecord.QuoteNumber
      : quoteRecord.Name;
    context.quoteStatus = quoteRecord.Status;
    context.isEditable = isEditableStatus(quoteRecord.Status);
    context.lines = new List<QuoteLineRow>();

    for (QuoteLineItem line : [
      SELECT
        Id,
        Quantity,
        UnitPrice,
        TotalPrice,
        Product2.Name,
        Product2.ProductCode,
        Tranche__c,
        Tranche__r.Name,
        Tranche__r.Sequenza__c,
        Data_Scadenza__c
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
      ORDER BY CreatedDate, Id
    ]) {
      context.lines.add(new QuoteLineRow(line));
    }

    return context;
  }

  @AuraEnabled
  public static QuoteTrancheContext createTranche(
    Id quoteId,
    Date dueDate,
    Decimal sequence,
    String quoteLineItemIdsJson
  ) {
    validateQuoteId(quoteId);
    requireWriteAccess();

    if (dueDate == null) {
      throw new AuraHandledException('Inserisci la data di scadenza.');
    }
    Decimal normalizedSequence = validateSequence(sequence);

    List<Id> selectedLineIds = parseSelectedLineIds(quoteLineItemIdsJson);
    if (selectedLineIds.isEmpty()) {
      throw new AuraHandledException(
        'Seleziona almeno una riga di preventivo.'
      );
    }

    Quote quoteRecord = [
      SELECT Id, Status
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
      FOR UPDATE
    ];
    if (!isEditableStatus(quoteRecord.Status)) {
      throw new AuraHandledException(
        'La tranche puo essere creata o modificata solo quando il preventivo e in Bozza.'
      );
    }

    Integer duplicateSequenceCount = [
      SELECT COUNT()
      FROM Tranche__c
      WHERE Quote__c = :quoteId AND Sequenza__c = :normalizedSequence
    ];
    if (duplicateSequenceCount > 0) {
      throw new AuraHandledException(
        'Esiste gia una tranche con questa sequenza per questo preventivo.'
      );
    }

    List<QuoteLineItem> selectedLines = [
      SELECT Id, QuoteId, TotalPrice, Tranche__c
      FROM QuoteLineItem
      WHERE Id IN :selectedLineIds AND QuoteId = :quoteId
      FOR UPDATE
    ];

    if (selectedLines.size() != selectedLineIds.size()) {
      throw new AuraHandledException(
        'Una o piu righe selezionate non appartengono a questo preventivo. Ricarica e riprova.'
      );
    }

    List<Id> alreadyAssigned = new List<Id>();
    for (QuoteLineItem line : selectedLines) {
      if (line.Tranche__c != null) {
        alreadyAssigned.add(line.Id);
      }
    }
    if (!alreadyAssigned.isEmpty()) {
      throw new AuraHandledException(
        'Una o piu righe selezionate sono gia associate a una tranche. Ricarica e riprova.'
      );
    }

    Decimal expectedAmount = 0;
    for (QuoteLineItem line : selectedLines) {
      expectedAmount += line.TotalPrice == null ? 0 : line.TotalPrice;
    }

    Tranche__c tranche = new Tranche__c(
      Quote__c = quoteId,
      Data_Scadenza__c = dueDate,
      Sequenza__c = normalizedSequence,
      Importo_Previsto__c = expectedAmount,
      Stato__c = 'Aperta',
      Completamente_Pagata__c = false
    );
    insert tranche;

    List<QuoteLineItem> updates = new List<QuoteLineItem>();
    for (QuoteLineItem line : selectedLines) {
      updates.add(
        new QuoteLineItem(
          Id = line.Id,
          Tranche__c = tranche.Id,
          Data_Scadenza__c = dueDate
        )
      );
    }
    update updates;

    return getContext(quoteId);
  }

  @AuraEnabled
  public static QuoteTrancheContext deleteTranche(Id quoteId, Id trancheId) {
    validateQuoteId(quoteId);
    validateTrancheId(trancheId);
    requireDeleteAccess();

    Quote quoteRecord = [
      SELECT Id, Status
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
      FOR UPDATE
    ];
    if (!isEditableStatus(quoteRecord.Status)) {
      throw new AuraHandledException(
        'La tranche puo essere creata o modificata solo quando il preventivo e in Bozza.'
      );
    }

    Tranche__c tranche = [
      SELECT Id, Quote__c
      FROM Tranche__c
      WHERE Id = :trancheId
      LIMIT 1
      FOR UPDATE
    ];
    if (tranche.Quote__c != quoteId) {
      throw new AuraHandledException(
        'La tranche selezionata non appartiene a questo preventivo. Ricarica e riprova.'
      );
    }

    List<QuoteLineItem> linkedLines = [
      SELECT Id
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId AND Tranche__c = :trancheId
      FOR UPDATE
    ];

    List<QuoteLineItem> updates = new List<QuoteLineItem>();
    for (QuoteLineItem line : linkedLines) {
      updates.add(
        new QuoteLineItem(
          Id = line.Id,
          Tranche__c = null,
          Data_Scadenza__c = null
        )
      );
    }
    if (!updates.isEmpty()) {
      update updates;
    }

    delete tranche;

    return getContext(quoteId);
  }

  private static void validateQuoteId(Id quoteId) {
    if (quoteId == null || quoteId.getSObjectType() != Quote.SObjectType) {
      throw new AuraHandledException('Apri questa azione da un preventivo.');
    }
  }

  private static void validateTrancheId(Id trancheId) {
    if (
      trancheId == null ||
      trancheId.getSObjectType() != Tranche__c.SObjectType
    ) {
      throw new AuraHandledException('Seleziona una tranche valida.');
    }
  }

  private static Boolean isEditableStatus(String status) {
    return EDITABLE_QUOTE_STATUSES.contains(status);
  }

  private static Decimal validateSequence(Decimal sequence) {
    if (sequence == null) {
      throw new AuraHandledException('Inserisci la sequenza della tranche.');
    }

    Integer integerSequence = sequence.intValue();
    Decimal normalizedSequence = Decimal.valueOf(
      String.valueOf(integerSequence)
    );
    if (sequence <= 0 || sequence != normalizedSequence) {
      throw new AuraHandledException(
        'La sequenza deve essere un numero intero maggiore di zero.'
      );
    }

    return normalizedSequence;
  }

  private static List<Id> parseSelectedLineIds(String selectedIdsJson) {
    if (String.isBlank(selectedIdsJson)) {
      return new List<Id>();
    }

    List<String> rawIds;
    try {
      rawIds = (List<String>) JSON.deserialize(
        selectedIdsJson,
        List<String>.class
      );
    } catch (JSONException jsonError) {
      throw new AuraHandledException(
        'La selezione delle righe non puo essere letta. Ricarica e riprova.'
      );
    }

    Set<Id> uniqueIds = new Set<Id>();
    for (String rawId : rawIds) {
      if (String.isBlank(rawId)) {
        continue;
      }
      try {
        Id lineId = (Id) rawId;
        if (lineId.getSObjectType() == QuoteLineItem.SObjectType) {
          uniqueIds.add(lineId);
        }
      } catch (StringException invalidId) {
        throw new AuraHandledException(
          'La selezione contiene una riga non valida. Ricarica e riprova.'
        );
      }
    }

    return new List<Id>(uniqueIds);
  }

  private static void requireReadAccess() {
    if (
      !Schema.sObjectType.Quote.isAccessible() ||
      !Schema.sObjectType.QuoteLineItem.isAccessible() ||
      !Schema.sObjectType.Tranche__c.isAccessible()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi necessari per leggere le tranche del preventivo.'
      );
    }
  }

  private static void requireWriteAccess() {
    requireReadAccess();
    if (
      !Schema.sObjectType.Tranche__c.isCreateable() ||
      !Schema.sObjectType.QuoteLineItem.isUpdateable() ||
      !Schema.sObjectType.Tranche__c.fields.Quote__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Data_Scadenza__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Sequenza__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Stato__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Completamente_Pagata__c.isCreateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Tranche__c.isUpdateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Data_Scadenza__c.isUpdateable()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi necessari per creare la tranche o aggiornare le righe.'
      );
    }
  }

  private static void requireDeleteAccess() {
    requireReadAccess();
    if (
      !Schema.sObjectType.Tranche__c.isDeletable() ||
      !Schema.sObjectType.QuoteLineItem.isUpdateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Tranche__c.isUpdateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Data_Scadenza__c.isUpdateable()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi necessari per eliminare la tranche o aggiornare le righe collegate.'
      );
    }
  }
}
