public without sharing class MappaturaEdizioneTriggerHandler {
  // Set while the category siblings are inserted, so they are not expanded again.
  private static Boolean isMappingCategory = false;

  // A new mapping also maps every other product with the same
  // Product2.Categoria_Articolo__c to the same child campaign. A product already
  // mapped to that campaign, or with an active mapping overlapping the window,
  // is left as it is.
  public static void afterInsert(List<Mappatura_Edizione__c> newMappings) {
    if (isMappingCategory) {
      return;
    }

    Set<Id> productIds = new Set<Id>();
    for (Mappatura_Edizione__c mapping : newMappings) {
      if (mapping.Prodotto__c != null && mapping.Campagna__c != null) {
        productIds.add(mapping.Prodotto__c);
      }
    }
    if (productIds.isEmpty()) {
      return;
    }

    Map<Id, String> categoryByProductId = new Map<Id, String>();
    for (Product2 product : [
      SELECT Id, Categoria_Articolo__c
      FROM Product2
      WHERE Id IN :productIds AND Categoria_Articolo__c != NULL
    ]) {
      categoryByProductId.put(
        product.Id,
        normalizeCategory(product.Categoria_Articolo__c)
      );
    }
    if (categoryByProductId.isEmpty()) {
      return;
    }

    Map<String, List<Id>> productIdsByCategory = new Map<String, List<Id>>();
    for (Product2 product : [
      SELECT Id, Categoria_Articolo__c
      FROM Product2
      WHERE Categoria_Articolo__c IN :categoryByProductId.values()
      ORDER BY Name, Id
    ]) {
      String category = normalizeCategory(product.Categoria_Articolo__c);
      if (!productIdsByCategory.containsKey(category)) {
        productIdsByCategory.put(category, new List<Id>());
      }
      productIdsByCategory.get(category).add(product.Id);
    }

    Set<Id> siblingIds = new Set<Id>();
    for (List<Id> categoryProductIds : productIdsByCategory.values()) {
      siblingIds.addAll(categoryProductIds);
    }

    // Existing mappings plus the ones planned here, per product.
    Map<Id, List<Mappatura_Edizione__c>> mappingsByProductId = new Map<Id, List<Mappatura_Edizione__c>>();
    for (Mappatura_Edizione__c existing : [
      SELECT Prodotto__c, Campagna__c, Attiva__c, Data_Inizio__c, Data_Fine__c
      FROM Mappatura_Edizione__c
      WHERE Prodotto__c IN :siblingIds
    ]) {
      addMapping(mappingsByProductId, existing.Prodotto__c, existing);
    }

    List<Mappatura_Edizione__c> categoryMappings = new List<Mappatura_Edizione__c>();
    for (Mappatura_Edizione__c mapping : newMappings) {
      String category = categoryByProductId.get(mapping.Prodotto__c);
      if (category == null) {
        continue;
      }

      for (Id siblingId : productIdsByCategory.get(category)) {
        if (isAlreadyMapped(mapping, mappingsByProductId.get(siblingId))) {
          continue;
        }

        Mappatura_Edizione__c categoryMapping = new Mappatura_Edizione__c(
          Prodotto__c = siblingId,
          Campagna__c = mapping.Campagna__c,
          Attiva__c = mapping.Attiva__c,
          Data_Inizio__c = mapping.Data_Inizio__c,
          Data_Fine__c = mapping.Data_Fine__c
        );
        categoryMappings.add(categoryMapping);
        addMapping(mappingsByProductId, siblingId, categoryMapping);
      }
    }

    if (categoryMappings.isEmpty()) {
      return;
    }

    isMappingCategory = true;
    try {
      insert categoryMappings;
    } finally {
      isMappingCategory = false;
    }
  }

  private static Boolean isAlreadyMapped(
    Mappatura_Edizione__c mapping,
    List<Mappatura_Edizione__c> productMappings
  ) {
    if (productMappings == null) {
      return false;
    }

    for (Mappatura_Edizione__c other : productMappings) {
      if (other.Campagna__c == mapping.Campagna__c) {
        return true;
      }
      if (
        mapping.Attiva__c == true &&
        other.Attiva__c == true &&
        mapping.Data_Inizio__c != null &&
        mapping.Data_Fine__c != null &&
        other.Data_Inizio__c != null &&
        other.Data_Fine__c != null &&
        mapping.Data_Inizio__c <= other.Data_Fine__c &&
        mapping.Data_Fine__c >= other.Data_Inizio__c
      ) {
        return true;
      }
    }
    return false;
  }

  private static void addMapping(
    Map<Id, List<Mappatura_Edizione__c>> mappingsByProductId,
    Id productId,
    Mappatura_Edizione__c mapping
  ) {
    if (!mappingsByProductId.containsKey(productId)) {
      mappingsByProductId.put(productId, new List<Mappatura_Edizione__c>());
    }
    mappingsByProductId.get(productId).add(mapping);
  }

  private static String normalizeCategory(String value) {
    return String.isBlank(value) ? null : value.trim().toUpperCase();
  }

  public static void beforeSave(
    List<Mappatura_Edizione__c> newMappings,
    Map<Id, Mappatura_Edizione__c> oldMappingMap
  ) {
    Set<Id> campaignIds = new Set<Id>();

    for (Mappatura_Edizione__c mapping : newMappings) {
      if (mapping.Campagna__c != null) {
        campaignIds.add(mapping.Campagna__c);
      }
    }

    if (campaignIds.isEmpty()) {
      return;
    }

    Map<Id, Campaign> campaignById = new Map<Id, Campaign>(
      [
        SELECT Id, Da_Data_Competenza__c, A_Data_Competenza__c, Data_Evento__c
        FROM Campaign
        WHERE Id IN :campaignIds
      ]
    );

    List<MappingWindow> activeMappings = new List<MappingWindow>();
    Set<Id> productIds = new Set<Id>();
    Date minStartDate;
    Date maxEndDate;

    for (Mappatura_Edizione__c mapping : newMappings) {
      Campaign campaign = campaignById.get(mapping.Campagna__c);
      if (campaign == null) {
        continue;
      }

      mapping.Data_Inizio__c = campaign.Da_Data_Competenza__c;
      mapping.Data_Fine__c = campaign.A_Data_Competenza__c;
      mapping.Data_Evento__c = campaign.Data_Evento__c;

      if (!shouldValidate(mapping, oldMappingMap)) {
        continue;
      }

      if (
        campaign.Da_Data_Competenza__c == null ||
        campaign.A_Data_Competenza__c == null
      ) {
        mapping.addError(
          'La campagna figlia collegata deve avere Da Data Competenza e A Data Competenza valorizzate.'
        );
        continue;
      }

      MappingWindow window = new MappingWindow(
        mapping,
        campaign.Da_Data_Competenza__c,
        campaign.A_Data_Competenza__c
      );

      activeMappings.add(window);
      productIds.add(mapping.Prodotto__c);

      minStartDate = minStartDate == null ||
        window.startDate < minStartDate
        ? window.startDate
        : minStartDate;
      maxEndDate = maxEndDate == null ||
        window.endDate > maxEndDate
        ? window.endDate
        : maxEndDate;
    }

    if (activeMappings.isEmpty()) {
      return;
    }

    validateWithinTransaction(activeMappings);
    validateAgainstExisting(
      activeMappings,
      productIds,
      minStartDate,
      maxEndDate
    );
  }

  private static Boolean shouldValidate(
    Mappatura_Edizione__c mapping,
    Map<Id, Mappatura_Edizione__c> oldMappingMap
  ) {
    if (
      mapping.Attiva__c != true ||
      mapping.Prodotto__c == null ||
      mapping.Campagna__c == null
    ) {
      return false;
    }

    if (oldMappingMap == null || !oldMappingMap.containsKey(mapping.Id)) {
      return true;
    }

    Mappatura_Edizione__c oldMapping = oldMappingMap.get(mapping.Id);
    return oldMapping.Attiva__c != mapping.Attiva__c ||
      oldMapping.Prodotto__c != mapping.Prodotto__c ||
      oldMapping.Campagna__c != mapping.Campagna__c ||
      oldMapping.Data_Inizio__c != mapping.Data_Inizio__c ||
      oldMapping.Data_Fine__c != mapping.Data_Fine__c;
  }

  private static void validateWithinTransaction(List<MappingWindow> mappings) {
    for (Integer i = 0; i < mappings.size(); i++) {
      MappingWindow leftMapping = mappings[i];

      for (Integer j = i + 1; j < mappings.size(); j++) {
        MappingWindow rightMapping = mappings[j];

        if (
          leftMapping.productId == rightMapping.productId &&
          rangesOverlap(leftMapping, rightMapping)
        ) {
          addOverlapError(leftMapping.mapping);
          addOverlapError(rightMapping.mapping);
        }
      }
    }
  }

  private static void validateAgainstExisting(
    List<MappingWindow> mappings,
    Set<Id> productIds,
    Date minStartDate,
    Date maxEndDate
  ) {
    List<Mappatura_Edizione__c> existingMappings = [
      SELECT Id, Prodotto__c, Data_Inizio__c, Data_Fine__c
      FROM Mappatura_Edizione__c
      WHERE
        Attiva__c = TRUE
        AND Prodotto__c IN :productIds
        AND Data_Inizio__c <= :maxEndDate
        AND Data_Fine__c >= :minStartDate
    ];

    for (MappingWindow mapping : mappings) {
      for (Mappatura_Edizione__c existingMapping : existingMappings) {
        if (
          mapping.mapping.Id != null &&
          mapping.mapping.Id == existingMapping.Id
        ) {
          continue;
        }

        MappingWindow existingWindow = new MappingWindow(
          existingMapping,
          existingMapping.Data_Inizio__c,
          existingMapping.Data_Fine__c
        );

        if (
          mapping.productId == existingWindow.productId &&
          rangesOverlap(mapping, existingWindow)
        ) {
          addOverlapError(mapping.mapping);
          break;
        }
      }
    }
  }

  private static Boolean rangesOverlap(
    MappingWindow leftMapping,
    MappingWindow rightMapping
  ) {
    return leftMapping.startDate <= rightMapping.endDate &&
      leftMapping.endDate >= rightMapping.startDate;
  }

  private static void addOverlapError(Mappatura_Edizione__c mapping) {
    mapping.addError(
      'Esiste gia una mappatura edizione attiva per questo prodotto con date sovrapposte.'
    );
  }

  private class MappingWindow {
    private Mappatura_Edizione__c mapping;
    private Id productId;
    private Date startDate;
    private Date endDate;

    private MappingWindow(
      Mappatura_Edizione__c mapping,
      Date startDate,
      Date endDate
    ) {
      this.mapping = mapping;
      this.productId = mapping.Prodotto__c;
      this.startDate = startDate;
      this.endDate = endDate;
    }
  }
}
