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
      trancheName = line.Tranche__r == null
        ? null
        : displayName(line.Tranche__r);
      trancheSequence = line.Tranche__r == null
        ? null
        : line.Tranche__r.Sequenza__c;
      dueDate = line.Data_Scadenza__c;
    }
  }

  public class TrancheInput {
    public String trancheId;
    public String name;
    public Date dueDate;
    public Decimal sequence;
    public List<String> quoteLineItemIds;
  }

  public class TrancheRow {
    @AuraEnabled
    public Id trancheId;
    @AuraEnabled
    public String trancheName;
    @AuraEnabled
    public Decimal trancheSequence;
    @AuraEnabled
    public Date dueDate;

    public TrancheRow(Tranche__c tranche) {
      trancheId = tranche.Id;
      trancheName = displayName(tranche);
      trancheSequence = tranche.Sequenza__c;
      dueDate = tranche.Data_Scadenza__c;
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
    @AuraEnabled
    public List<TrancheRow> tranches;
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
    context.tranches = new List<TrancheRow>();

    for (Tranche__c tranche : [
      SELECT Id, Name, Sequenza__c, Data_Scadenza__c
      FROM Tranche__c
      WHERE Quote__c = :quoteId
      ORDER BY Sequenza__c, CreatedDate, Id
    ]) {
      context.tranches.add(new TrancheRow(tranche));
    }

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
  public static QuoteTrancheContext createTranches(
    Id quoteId,
    String trancheInputsJson,
    String deletedTrancheIdsJson
  ) {
    validateQuoteId(quoteId);
    requireWriteAccess();
    Set<Id> deletedTrancheIds = parseTrancheIds(deletedTrancheIdsJson);
    if (!deletedTrancheIds.isEmpty()) {
      requireDeleteAccess();
    }

    List<TrancheInput> trancheInputs = parseTrancheInputs(trancheInputsJson);

    Quote quoteRecord = [
      SELECT Id, Status
      FROM Quote
      WHERE Id = :quoteId
      LIMIT 1
      FOR UPDATE
    ];
    if (!isEditableStatus(quoteRecord.Status)) {
      throw new AuraHandledException(
        'The tranche can be created or changed only when the quote is in Draft.'
      );
    }

    Set<Decimal> sequences = new Set<Decimal>();
    Set<Id> selectedLineIds = new Set<Id>();
    Set<Id> inputTrancheIds = new Set<Id>();
    Map<Integer, Id> inputIndexToExistingId = new Map<Integer, Id>();
    List<Tranche__c> tranches = new List<Tranche__c>();
    for (Integer i = 0; i < trancheInputs.size(); i++) {
      TrancheInput input = trancheInputs[i];
      Decimal normalizedSequence = validateSequence(input.sequence);
      if (!sequences.add(normalizedSequence)) {
        throw new AuraHandledException(
          'Each tranche must have a unique sequence.'
        );
      }
      if (String.isBlank(input.name)) {
        throw new AuraHandledException('Enter the tranche name.');
      }
      if (input.dueDate == null) {
        throw new AuraHandledException('Enter the due date for each tranche.');
      }
      if (input.quoteLineItemIds == null || input.quoteLineItemIds.isEmpty()) {
        throw new AuraHandledException(
          'Select at least one quote line for each tranche.'
        );
      }

      List<Id> lineIdsForInput = parseSelectedLineIds(input.quoteLineItemIds);
      if (lineIdsForInput.isEmpty()) {
        throw new AuraHandledException(
          'Select at least one quote line for each tranche.'
        );
      }

      for (Id lineId : lineIdsForInput) {
        if (!selectedLineIds.add(lineId)) {
          throw new AuraHandledException(
            'Each quote line can be assigned to only one tranche.'
          );
        }
      }

      if (!String.isBlank(input.trancheId)) {
        Id existingTrancheId = parseTrancheId(input.trancheId);
        inputTrancheIds.add(existingTrancheId);
        inputIndexToExistingId.put(i, existingTrancheId);
      }

      tranches.add(
        buildTrancheForSave(
          inputIndexToExistingId.get(i),
          quoteId,
          input.name.trim(),
          input.dueDate,
          normalizedSequence
        )
      );
    }

    inputTrancheIds.removeAll(deletedTrancheIds);

    if (!inputTrancheIds.isEmpty()) {
      Map<Id, Tranche__c> existingTranchesById = new Map<Id, Tranche__c>(
        [
          SELECT Id, Quote__c
          FROM Tranche__c
          WHERE Id IN :inputTrancheIds
          FOR UPDATE
        ]
      );
      if (existingTranchesById.size() != inputTrancheIds.size()) {
        throw new AuraHandledException(
          'One or more tranches could not be found. Reload and try again.'
        );
      }
      for (Tranche__c existingTranche : existingTranchesById.values()) {
        if (existingTranche.Quote__c != quoteId) {
          throw new AuraHandledException(
            'One or more tranches do not belong to this quote. Reload and try again.'
          );
        }
      }
    }

    Map<Id, QuoteLineItem> selectedLinesById = new Map<Id, QuoteLineItem>(
      [
        SELECT Id, QuoteId, TotalPrice, Tranche__c
        FROM QuoteLineItem
        WHERE Id IN :selectedLineIds AND QuoteId = :quoteId
        FOR UPDATE
      ]
    );

    if (selectedLinesById.size() != selectedLineIds.size()) {
      throw new AuraHandledException(
        'One or more selected lines do not belong to this quote. Reload and try again.'
      );
    }

    Set<Id> quoteLineIds = new Set<Id>();
    for (QuoteLineItem quoteLine : [
      SELECT Id
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
    ]) {
      quoteLineIds.add(quoteLine.Id);
    }
    if (quoteLineIds.size() != selectedLineIds.size()) {
      throw new AuraHandledException(
        'Assign every quote line to a tranche before saving.'
      );
    }
    for (Id quoteLineId : quoteLineIds) {
      if (!selectedLineIds.contains(quoteLineId)) {
        throw new AuraHandledException(
          'Assign every quote line to a tranche before saving.'
        );
      }
    }

    for (QuoteLineItem selectedLine : selectedLinesById.values()) {
      if (
        selectedLine.Tranche__c != null &&
        !inputTrancheIds.contains(selectedLine.Tranche__c)
      ) {
        throw new AuraHandledException(
          'One or more selected lines are already assigned to a tranche. Reload and try again.'
        );
      }
    }

    for (Integer i = 0; i < trancheInputs.size(); i++) {
      Decimal expectedAmount = 0;
      for (
        Id lineId : parseSelectedLineIds(trancheInputs[i].quoteLineItemIds)
      ) {
        QuoteLineItem selectedLine = selectedLinesById.get(lineId);
        expectedAmount += selectedLine.TotalPrice == null
          ? 0
          : selectedLine.TotalPrice;
      }
      tranches[i].Importo_Previsto__c = expectedAmount;
    }

    for (Tranche__c existingTranche : [
      SELECT Sequenza__c
      FROM Tranche__c
      WHERE
        Quote__c = :quoteId
        AND Sequenza__c IN :sequences
        AND Id NOT IN :inputTrancheIds
      FOR UPDATE
    ]) {
      throw new AuraHandledException(
        'A tranche with sequence ' +
          existingTranche.Sequenza__c +
          ' already exists for this quote.'
      );
    }

    List<Tranche__c> tranchesToInsert = new List<Tranche__c>();
    List<Tranche__c> tranchesToUpdate = new List<Tranche__c>();
    for (Tranche__c tranche : tranches) {
      if (tranche.Id == null) {
        tranchesToInsert.add(tranche);
      } else {
        tranchesToUpdate.add(tranche);
      }
    }
    if (!tranchesToInsert.isEmpty()) {
      insert tranchesToInsert;
    }
    if (!tranchesToUpdate.isEmpty()) {
      update tranchesToUpdate;
    }

    if (!deletedTrancheIds.isEmpty()) {
      deleteTrancheRecords(quoteId, deletedTrancheIds);
    }

    List<QuoteLineItem> lineUpdates = new List<QuoteLineItem>();
    if (!inputTrancheIds.isEmpty()) {
      for (QuoteLineItem lineToClear : [
        SELECT Id
        FROM QuoteLineItem
        WHERE
          QuoteId = :quoteId
          AND Tranche__c IN :inputTrancheIds
          AND Id NOT IN :selectedLineIds
        FOR UPDATE
      ]) {
        lineUpdates.add(
          new QuoteLineItem(
            Id = lineToClear.Id,
            Tranche__c = null,
            Data_Scadenza__c = null
          )
        );
      }
    }
    for (Integer i = 0; i < trancheInputs.size(); i++) {
      for (
        Id lineId : parseSelectedLineIds(trancheInputs[i].quoteLineItemIds)
      ) {
        lineUpdates.add(
          new QuoteLineItem(
            Id = lineId,
            Tranche__c = tranches[i].Id,
            Data_Scadenza__c = tranches[i].Data_Scadenza__c
          )
        );
      }
    }
    update lineUpdates;

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
        'The tranche can be created or changed only when the quote is in Draft.'
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
        'The selected tranche does not belong to this quote. Reload and try again.'
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
      throw new AuraHandledException('Open this action from a quote.');
    }
  }

  private static void validateTrancheId(Id trancheId) {
    if (
      trancheId == null ||
      trancheId.getSObjectType() != Tranche__c.SObjectType
    ) {
      throw new AuraHandledException('Select a valid tranche.');
    }
  }

  private static Id parseTrancheId(String rawTrancheId) {
    try {
      Id trancheId = (Id) rawTrancheId;
      if (trancheId.getSObjectType() != Tranche__c.SObjectType) {
        throw new AuraHandledException('Select a valid tranche.');
      }
      return trancheId;
    } catch (StringException invalidId) {
      throw new AuraHandledException('Select a valid tranche.');
    }
  }

  private static Set<Id> parseTrancheIds(String rawTrancheIdsJson) {
    Set<Id> trancheIds = new Set<Id>();
    if (String.isBlank(rawTrancheIdsJson)) {
      return trancheIds;
    }

    List<String> rawTrancheIds;
    try {
      rawTrancheIds = (List<String>) JSON.deserialize(
        rawTrancheIdsJson,
        List<String>.class
      );
    } catch (JSONException jsonError) {
      throw new AuraHandledException(
        'The deleted tranche selection could not be read. Reload and try again.'
      );
    }

    for (String rawTrancheId : rawTrancheIds) {
      if (!String.isBlank(rawTrancheId)) {
        trancheIds.add(parseTrancheId(rawTrancheId));
      }
    }

    return trancheIds;
  }

  private static Tranche__c buildTrancheForSave(
    Id trancheId,
    Id quoteId,
    String trancheName,
    Date dueDate,
    Decimal sequence
  ) {
    Tranche__c tranche = new Tranche__c(
      Id = trancheId,
      Name = trancheName,
      Data_Scadenza__c = dueDate,
      Sequenza__c = sequence,
      Importo_Previsto__c = 0,
      Stato__c = 'Aperta',
      Completamente_Pagata__c = false
    );
    if (trancheId == null) {
      tranche.Quote__c = quoteId;
    }
    return tranche;
  }

  private static void deleteTrancheRecords(Id quoteId, Set<Id> trancheIds) {
    Map<Id, Tranche__c> tranchesById = new Map<Id, Tranche__c>(
      [
        SELECT Id, Quote__c
        FROM Tranche__c
        WHERE Id IN :trancheIds
        FOR UPDATE
      ]
    );
    if (tranchesById.size() != trancheIds.size()) {
      throw new AuraHandledException(
        'One or more tranches could not be found. Reload and try again.'
      );
    }
    for (Tranche__c tranche : tranchesById.values()) {
      if (tranche.Quote__c != quoteId) {
        throw new AuraHandledException(
          'One or more tranches do not belong to this quote. Reload and try again.'
        );
      }
    }

    List<QuoteLineItem> linkedLineUpdates = new List<QuoteLineItem>();
    for (QuoteLineItem linkedLine : [
      SELECT Id
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId AND Tranche__c IN :trancheIds
      FOR UPDATE
    ]) {
      linkedLineUpdates.add(
        new QuoteLineItem(
          Id = linkedLine.Id,
          Tranche__c = null,
          Data_Scadenza__c = null
        )
      );
    }
    if (!linkedLineUpdates.isEmpty()) {
      update linkedLineUpdates;
    }

    delete tranchesById.values();
  }

  private static Boolean isEditableStatus(String status) {
    return EDITABLE_QUOTE_STATUSES.contains(status);
  }

  private static Decimal validateSequence(Decimal sequence) {
    if (sequence == null) {
      throw new AuraHandledException('Enter the tranche sequence.');
    }

    Integer integerSequence = sequence.intValue();
    Decimal normalizedSequence = Decimal.valueOf(
      String.valueOf(integerSequence)
    );
    if (sequence <= 0 || sequence != normalizedSequence) {
      throw new AuraHandledException(
        'The sequence must be a whole number greater than zero.'
      );
    }

    return normalizedSequence;
  }

  private static List<TrancheInput> parseTrancheInputs(String inputsJson) {
    if (String.isBlank(inputsJson)) {
      throw new AuraHandledException('Enter at least one tranche.');
    }

    List<TrancheInput> inputs;
    try {
      inputs = (List<TrancheInput>) JSON.deserialize(
        inputsJson,
        List<TrancheInput>.class
      );
    } catch (JSONException jsonError) {
      throw new AuraHandledException(
        'The tranche details could not be read. Reload and try again.'
      );
    }

    if (inputs == null || inputs.isEmpty()) {
      throw new AuraHandledException('Enter at least one tranche.');
    }
    if (inputs.size() > 20) {
      throw new AuraHandledException(
        'Create no more than 20 tranches at a time.'
      );
    }

    return inputs;
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
        'The line selection could not be read. Reload and try again.'
      );
    }

    Set<Id> uniqueIds = new Set<Id>();
    for (String rawId : rawIds) {
      if (String.isBlank(rawId)) {
        continue;
      }
      try {
        Id lineId = (Id) rawId;
        if (lineId.getSObjectType() != QuoteLineItem.SObjectType) {
          throw new AuraHandledException(
            'The selection contains an invalid line. Reload and try again.'
          );
        }
        uniqueIds.add(lineId);
      } catch (StringException invalidId) {
        throw new AuraHandledException(
          'The selection contains an invalid line. Reload and try again.'
        );
      }
    }

    return new List<Id>(uniqueIds);
  }

  private static List<Id> parseSelectedLineIds(List<String> rawIds) {
    Set<Id> uniqueIds = new Set<Id>();
    for (String rawId : rawIds) {
      if (String.isBlank(rawId)) {
        continue;
      }
      try {
        Id lineId = (Id) rawId;
        if (lineId.getSObjectType() != QuoteLineItem.SObjectType) {
          throw new AuraHandledException(
            'The selection contains an invalid line. Reload and try again.'
          );
        }
        uniqueIds.add(lineId);
      } catch (StringException invalidId) {
        throw new AuraHandledException(
          'The selection contains an invalid line. Reload and try again.'
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
        'You do not have the permissions needed to read the quote tranches.'
      );
    }
  }

  private static void requireWriteAccess() {
    requireReadAccess();
    if (
      !Schema.sObjectType.Tranche__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.isUpdateable() ||
      !Schema.sObjectType.QuoteLineItem.isUpdateable() ||
      !Schema.sObjectType.Tranche__c.fields.Quote__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Name.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Name.isUpdateable() ||
      !Schema.sObjectType.Tranche__c.fields.Data_Scadenza__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Data_Scadenza__c.isUpdateable() ||
      !Schema.sObjectType.Tranche__c.fields.Sequenza__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Sequenza__c.isUpdateable() ||
      !Schema.sObjectType.Tranche__c.fields.Stato__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Stato__c.isUpdateable() ||
      !Schema.sObjectType.Tranche__c.fields.Completamente_Pagata__c.isCreateable() ||
      !Schema.sObjectType.Tranche__c.fields.Completamente_Pagata__c.isUpdateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Tranche__c.isUpdateable() ||
      !Schema.sObjectType.QuoteLineItem.fields.Data_Scadenza__c.isUpdateable()
    ) {
      throw new AuraHandledException(
        'You do not have the permissions needed to create the tranche or update the lines.'
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
        'You do not have the permissions needed to delete the tranche or update the linked lines.'
      );
    }
  }

  private static String displayName(Tranche__c tranche) {
    return tranche.Name;
  }
}
