public with sharing class BundleTranchController {
  public class ComponentRow {
    @AuraEnabled
    public Id id;
    @AuraEnabled
    public String productName;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public Decimal quantity;
    @AuraEnabled
    public Decimal spreadPrice;
    @AuraEnabled
    public Id bundleTranchId;

    public ComponentRow(BundleComponent__c component) {
      id = component.Id;
      productName = component.Product__r == null
        ? null
        : component.Product__r.Name;
      productCode = component.Product__r == null
        ? null
        : component.Product__r.ProductCode;
      quantity = component.Quantity__c;
      spreadPrice = component.Spread_Price__c;
      bundleTranchId = component.Bundle_Tranch__c;
    }
  }

  public class TranchRow {
    @AuraEnabled
    public Id tranchId;
    @AuraEnabled
    public String tranchName;
    @AuraEnabled
    public Decimal tranchSequence;
    @AuraEnabled
    public Date dueDate;

    public TranchRow(Bundle_Tranch__c tranch) {
      tranchId = tranch.Id;
      tranchName = tranch.Name;
      tranchSequence = tranch.Sequenza__c;
      dueDate = tranch.Data_Scadenza__c;
    }
  }

  public class BundleTranchContext {
    @AuraEnabled
    public String bundleName;
    @AuraEnabled
    public List<ComponentRow> components;
    @AuraEnabled
    public List<TranchRow> tranches;
  }

  public class TranchInput {
    public String tranchId;
    public String name;
    public Date dueDate;
    public Decimal sequence;
    public List<String> componentIds;
  }

  @AuraEnabled
  public static BundleTranchContext getContext(Id bundleId) {
    validateBundleId(bundleId);
    requireReadAccess();

    Product2 bundle = [
      SELECT Id, Name
      FROM Product2
      WHERE Id = :bundleId
      LIMIT 1
    ];

    BundleTranchContext context = new BundleTranchContext();
    context.bundleName = bundle.Name;
    context.components = new List<ComponentRow>();
    context.tranches = new List<TranchRow>();

    for (Bundle_Tranch__c tranch : [
      SELECT Id, Name, Sequenza__c, Data_Scadenza__c
      FROM Bundle_Tranch__c
      WHERE Bundle__c = :bundleId
      ORDER BY Sequenza__c, CreatedDate, Id
    ]) {
      context.tranches.add(new TranchRow(tranch));
    }

    for (BundleComponent__c component : [
      SELECT
        Id,
        Product__r.Name,
        Product__r.ProductCode,
        Quantity__c,
        Spread_Price__c,
        Bundle_Tranch__c
      FROM BundleComponent__c
      WHERE Bundle__c = :bundleId
      ORDER BY Product__r.Name, Id
    ]) {
      context.components.add(new ComponentRow(component));
    }

    return context;
  }

  @AuraEnabled
  public static BundleTranchContext saveTranches(
    Id bundleId,
    String tranchInputsJson,
    String deletedTranchIdsJson
  ) {
    validateBundleId(bundleId);
    requireWriteAccess();
    Set<Id> deletedTranchIds = parseTranchIds(deletedTranchIdsJson);
    if (!deletedTranchIds.isEmpty()) {
      requireDeleteAccess();
    }

    List<TranchInput> inputs = parseTranchInputs(tranchInputsJson);
    Set<Decimal> sequences = new Set<Decimal>();
    Set<Id> selectedComponentIds = new Set<Id>();
    Set<Id> inputTranchIds = new Set<Id>();
    Map<Integer, Id> inputIndexToExistingId = new Map<Integer, Id>();
    List<Bundle_Tranch__c> tranches = new List<Bundle_Tranch__c>();

    for (Integer i = 0; i < inputs.size(); i++) {
      TranchInput input = inputs[i];
      Decimal sequence = validateSequence(input.sequence);
      if (!sequences.add(sequence)) {
        throw new AuraHandledException(
          'Ogni tranch deve avere una sequenza unica.'
        );
      }
      if (String.isBlank(input.name)) {
        throw new AuraHandledException('Inserisci il nome della tranch.');
      }
      if (input.dueDate == null) {
        throw new AuraHandledException(
          'Inserisci la data di scadenza per ogni tranch.'
        );
      }
      if (input.componentIds == null || input.componentIds.isEmpty()) {
        throw new AuraHandledException(
          'Seleziona almeno un componente per ogni tranch.'
        );
      }

      List<Id> componentIds = parseComponentIds(input.componentIds);
      if (componentIds.isEmpty()) {
        throw new AuraHandledException(
          'Seleziona almeno un componente per ogni tranch.'
        );
      }
      for (Id componentId : componentIds) {
        if (!selectedComponentIds.add(componentId)) {
          throw new AuraHandledException(
            'Ogni componente del bundle puo essere assegnato a una sola tranch.'
          );
        }
      }

      if (!String.isBlank(input.tranchId)) {
        Id existingTranchId = parseTranchId(input.tranchId);
        inputTranchIds.add(existingTranchId);
        inputIndexToExistingId.put(i, existingTranchId);
      }

      tranches.add(
        buildTranchForSave(
          inputIndexToExistingId.get(i),
          bundleId,
          input.name.trim(),
          input.dueDate,
          sequence
        )
      );
    }

    inputTranchIds.removeAll(deletedTranchIds);
    validateExistingTranches(bundleId, inputTranchIds);

    Map<Id, BundleComponent__c> selectedComponentsById = new Map<Id, BundleComponent__c>(
      [
        SELECT Id, Bundle__c, Bundle_Tranch__c
        FROM BundleComponent__c
        WHERE Id IN :selectedComponentIds AND Bundle__c = :bundleId
        FOR UPDATE
      ]
    );
    if (selectedComponentsById.size() != selectedComponentIds.size()) {
      throw new AuraHandledException(
        'Uno o piu componenti non appartengono a questo bundle. Ricarica e riprova.'
      );
    }

    Set<Id> allComponentIds = new Set<Id>();
    for (BundleComponent__c component : [
      SELECT Id
      FROM BundleComponent__c
      WHERE Bundle__c = :bundleId
    ]) {
      allComponentIds.add(component.Id);
    }
    if (allComponentIds.size() != selectedComponentIds.size()) {
      throw new AuraHandledException(
        'Assegna ogni componente del bundle a una tranch prima di salvare.'
      );
    }

    for (BundleComponent__c component : selectedComponentsById.values()) {
      if (
        component.Bundle_Tranch__c != null &&
        !inputTranchIds.contains(component.Bundle_Tranch__c) &&
        !deletedTranchIds.contains(component.Bundle_Tranch__c)
      ) {
        throw new AuraHandledException(
          'Uno o piu componenti sono gia assegnati a una tranch. Ricarica e riprova.'
        );
      }
    }

    for (Bundle_Tranch__c existingTranch : [
      SELECT Sequenza__c
      FROM Bundle_Tranch__c
      WHERE
        Bundle__c = :bundleId
        AND Sequenza__c IN :sequences
        AND Id NOT IN :inputTranchIds
      FOR UPDATE
    ]) {
      throw new AuraHandledException(
        'Esiste gia una tranch con sequenza ' + existingTranch.Sequenza__c + '.'
      );
    }

    List<Bundle_Tranch__c> tranchesToInsert = new List<Bundle_Tranch__c>();
    List<Bundle_Tranch__c> tranchesToUpdate = new List<Bundle_Tranch__c>();
    for (Bundle_Tranch__c tranch : tranches) {
      if (tranch.Id == null) {
        tranchesToInsert.add(tranch);
      } else {
        tranchesToUpdate.add(tranch);
      }
    }
    if (!tranchesToInsert.isEmpty()) {
      insert tranchesToInsert;
    }
    if (!tranchesToUpdate.isEmpty()) {
      update tranchesToUpdate;
    }

    if (!deletedTranchIds.isEmpty()) {
      deleteTranchRecords(bundleId, deletedTranchIds);
    }

    List<BundleComponent__c> componentUpdates = new List<BundleComponent__c>();
    if (!inputTranchIds.isEmpty()) {
      for (BundleComponent__c componentToClear : [
        SELECT Id
        FROM BundleComponent__c
        WHERE
          Bundle__c = :bundleId
          AND Bundle_Tranch__c IN :inputTranchIds
          AND Id NOT IN :selectedComponentIds
        FOR UPDATE
      ]) {
        componentUpdates.add(
          new BundleComponent__c(
            Id = componentToClear.Id,
            Bundle_Tranch__c = null
          )
        );
      }
    }
    for (Integer i = 0; i < inputs.size(); i++) {
      for (Id componentId : parseComponentIds(inputs[i].componentIds)) {
        componentUpdates.add(
          new BundleComponent__c(
            Id = componentId,
            Bundle_Tranch__c = tranches[i].Id
          )
        );
      }
    }
    update componentUpdates;

    return getContext(bundleId);
  }

  private static void validateExistingTranches(
    Id bundleId,
    Set<Id> inputTranchIds
  ) {
    if (inputTranchIds.isEmpty()) {
      return;
    }

    Map<Id, Bundle_Tranch__c> existingById = new Map<Id, Bundle_Tranch__c>(
      [
        SELECT Id, Bundle__c
        FROM Bundle_Tranch__c
        WHERE Id IN :inputTranchIds
        FOR UPDATE
      ]
    );
    if (existingById.size() != inputTranchIds.size()) {
      throw new AuraHandledException(
        'Una o piu tranch non sono state trovate. Ricarica e riprova.'
      );
    }
    for (Bundle_Tranch__c existing : existingById.values()) {
      if (existing.Bundle__c != bundleId) {
        throw new AuraHandledException(
          'Una o piu tranch non appartengono a questo bundle. Ricarica e riprova.'
        );
      }
    }
  }

  private static void deleteTranchRecords(Id bundleId, Set<Id> tranchIds) {
    Map<Id, Bundle_Tranch__c> tranchesById = new Map<Id, Bundle_Tranch__c>(
      [
        SELECT Id, Bundle__c
        FROM Bundle_Tranch__c
        WHERE Id IN :tranchIds
        FOR UPDATE
      ]
    );
    if (tranchesById.size() != tranchIds.size()) {
      throw new AuraHandledException(
        'Una o piu tranch non sono state trovate. Ricarica e riprova.'
      );
    }
    for (Bundle_Tranch__c tranch : tranchesById.values()) {
      if (tranch.Bundle__c != bundleId) {
        throw new AuraHandledException(
          'Una o piu tranch non appartengono a questo bundle. Ricarica e riprova.'
        );
      }
    }

    List<BundleComponent__c> componentUpdates = new List<BundleComponent__c>();
    for (BundleComponent__c component : [
      SELECT Id
      FROM BundleComponent__c
      WHERE Bundle__c = :bundleId AND Bundle_Tranch__c IN :tranchIds
      FOR UPDATE
    ]) {
      componentUpdates.add(
        new BundleComponent__c(Id = component.Id, Bundle_Tranch__c = null)
      );
    }
    if (!componentUpdates.isEmpty()) {
      update componentUpdates;
    }

    delete tranchesById.values();
  }

  private static Bundle_Tranch__c buildTranchForSave(
    Id tranchId,
    Id bundleId,
    String tranchName,
    Date dueDate,
    Decimal sequence
  ) {
    Bundle_Tranch__c tranch = new Bundle_Tranch__c(
      Id = tranchId,
      Name = tranchName,
      Data_Scadenza__c = dueDate,
      Sequenza__c = sequence
    );
    if (tranchId == null) {
      tranch.Bundle__c = bundleId;
    }
    return tranch;
  }

  private static List<TranchInput> parseTranchInputs(String inputsJson) {
    if (String.isBlank(inputsJson)) {
      throw new AuraHandledException('Inserisci almeno una tranch.');
    }

    List<TranchInput> inputs;
    try {
      inputs = (List<TranchInput>) JSON.deserialize(
        inputsJson,
        List<TranchInput>.class
      );
    } catch (JSONException jsonError) {
      throw new AuraHandledException(
        'I dettagli delle tranch non possono essere letti. Ricarica e riprova.'
      );
    }

    if (inputs == null || inputs.isEmpty()) {
      throw new AuraHandledException('Inserisci almeno una tranch.');
    }
    if (inputs.size() > 20) {
      throw new AuraHandledException('Crea al massimo 20 tranch alla volta.');
    }

    return inputs;
  }

  private static Set<Id> parseTranchIds(String rawIdsJson) {
    Set<Id> ids = new Set<Id>();
    if (String.isBlank(rawIdsJson)) {
      return ids;
    }

    List<String> rawIds;
    try {
      rawIds = (List<String>) JSON.deserialize(rawIdsJson, List<String>.class);
    } catch (JSONException jsonError) {
      throw new AuraHandledException(
        'Le tranch eliminate non possono essere lette. Ricarica e riprova.'
      );
    }
    for (String rawId : rawIds) {
      if (!String.isBlank(rawId)) {
        ids.add(parseTranchId(rawId));
      }
    }
    return ids;
  }

  private static Id parseTranchId(String rawId) {
    try {
      Id recordId = (Id) rawId;
      if (recordId.getSObjectType() != Bundle_Tranch__c.SObjectType) {
        throw new AuraHandledException('Seleziona una tranch valida.');
      }
      return recordId;
    } catch (StringException invalidId) {
      throw new AuraHandledException('Seleziona una tranch valida.');
    }
  }

  private static List<Id> parseComponentIds(List<String> rawIds) {
    Set<Id> ids = new Set<Id>();
    for (String rawId : rawIds) {
      if (String.isBlank(rawId)) {
        continue;
      }
      try {
        Id recordId = (Id) rawId;
        if (recordId.getSObjectType() != BundleComponent__c.SObjectType) {
          throw new AuraHandledException(
            'La selezione contiene un componente non valido. Ricarica e riprova.'
          );
        }
        ids.add(recordId);
      } catch (StringException invalidId) {
        throw new AuraHandledException(
          'La selezione contiene un componente non valido. Ricarica e riprova.'
        );
      }
    }
    return new List<Id>(ids);
  }

  private static Decimal validateSequence(Decimal sequence) {
    if (sequence == null) {
      throw new AuraHandledException('Inserisci la sequenza della tranch.');
    }

    Integer integerSequence = sequence.intValue();
    Decimal normalized = Decimal.valueOf(String.valueOf(integerSequence));
    if (sequence <= 0 || sequence != normalized) {
      throw new AuraHandledException(
        'La sequenza deve essere un numero intero maggiore di zero.'
      );
    }
    return normalized;
  }

  private static void validateBundleId(Id bundleId) {
    if (bundleId == null || bundleId.getSObjectType() != Product2.SObjectType) {
      throw new AuraHandledException('Apri questa azione da un bundle.');
    }
  }

  private static void requireReadAccess() {
    if (
      !Schema.sObjectType.Product2.isAccessible() ||
      !Schema.sObjectType.BundleComponent__c.isAccessible() ||
      !Schema.sObjectType.Bundle_Tranch__c.isAccessible()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi per visualizzare le tranch del bundle.'
      );
    }
  }

  private static void requireWriteAccess() {
    requireReadAccess();
    if (
      !Schema.sObjectType.Bundle_Tranch__c.isCreateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.isUpdateable() ||
      !Schema.sObjectType.BundleComponent__c.isUpdateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.fields.Bundle__c.isCreateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.fields.Name.isCreateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.fields.Name.isUpdateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.fields.Sequenza__c.isCreateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.fields.Sequenza__c.isUpdateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.fields.Data_Scadenza__c.isCreateable() ||
      !Schema.sObjectType.Bundle_Tranch__c.fields.Data_Scadenza__c.isUpdateable() ||
      !Schema.sObjectType.BundleComponent__c.fields.Bundle_Tranch__c.isUpdateable()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi per creare le tranch del bundle.'
      );
    }
  }

  private static void requireDeleteAccess() {
    requireReadAccess();
    if (
      !Schema.sObjectType.Bundle_Tranch__c.isDeletable() ||
      !Schema.sObjectType.BundleComponent__c.isUpdateable() ||
      !Schema.sObjectType.BundleComponent__c.fields.Bundle_Tranch__c.isUpdateable()
    ) {
      throw new AuraHandledException(
        'Non hai i permessi per eliminare le tranch del bundle.'
      );
    }
  }
}
