public with sharing class MappaturaEdizioneTriggerHandler {
  public static void beforeSave(
    List<Mappatura_Edizione__c> newMappings,
    Map<Id, Mappatura_Edizione__c> oldMappingMap
  ) {
    List<Mappatura_Edizione__c> activeMappings = new List<Mappatura_Edizione__c>();
    Set<Id> productIds = new Set<Id>();
    Date minStartDate;
    Date maxEndDate;

    for (Mappatura_Edizione__c mapping : newMappings) {
      if (!shouldValidate(mapping, oldMappingMap)) {
        continue;
      }

      activeMappings.add(mapping);
      productIds.add(mapping.Prodotto__c);

      minStartDate = minStartDate == null ||
        mapping.Data_Inizio__c < minStartDate
        ? mapping.Data_Inizio__c
        : minStartDate;
      maxEndDate = maxEndDate == null ||
        mapping.Data_Fine__c > maxEndDate
        ? mapping.Data_Fine__c
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
      mapping.Data_Inizio__c == null ||
      mapping.Data_Fine__c == null
    ) {
      return false;
    }

    if (oldMappingMap == null || !oldMappingMap.containsKey(mapping.Id)) {
      return true;
    }

    Mappatura_Edizione__c oldMapping = oldMappingMap.get(mapping.Id);
    return oldMapping.Attiva__c != mapping.Attiva__c ||
      oldMapping.Prodotto__c != mapping.Prodotto__c ||
      oldMapping.Data_Inizio__c != mapping.Data_Inizio__c ||
      oldMapping.Data_Fine__c != mapping.Data_Fine__c;
  }

  private static void validateWithinTransaction(
    List<Mappatura_Edizione__c> mappings
  ) {
    for (Integer i = 0; i < mappings.size(); i++) {
      Mappatura_Edizione__c leftMapping = mappings[i];

      for (Integer j = i + 1; j < mappings.size(); j++) {
        Mappatura_Edizione__c rightMapping = mappings[j];

        if (
          leftMapping.Prodotto__c == rightMapping.Prodotto__c &&
          rangesOverlap(leftMapping, rightMapping)
        ) {
          addOverlapError(leftMapping);
          addOverlapError(rightMapping);
        }
      }
    }
  }

  private static void validateAgainstExisting(
    List<Mappatura_Edizione__c> mappings,
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

    for (Mappatura_Edizione__c mapping : mappings) {
      for (Mappatura_Edizione__c existingMapping : existingMappings) {
        if (mapping.Id != null && mapping.Id == existingMapping.Id) {
          continue;
        }

        if (
          mapping.Prodotto__c == existingMapping.Prodotto__c &&
          rangesOverlap(mapping, existingMapping)
        ) {
          addOverlapError(mapping);
          break;
        }
      }
    }
  }

  private static Boolean rangesOverlap(
    Mappatura_Edizione__c leftMapping,
    Mappatura_Edizione__c rightMapping
  ) {
    return leftMapping.Data_Inizio__c <= rightMapping.Data_Fine__c &&
      leftMapping.Data_Fine__c >= rightMapping.Data_Inizio__c;
  }

  private static void addOverlapError(Mappatura_Edizione__c mapping) {
    mapping.addError(
      'Esiste gia una mappatura edizione attiva per questo prodotto con date sovrapposte.'
    );
  }
}
