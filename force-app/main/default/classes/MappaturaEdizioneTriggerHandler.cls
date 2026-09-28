public with sharing class MappaturaEdizioneTriggerHandler {
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
        SELECT Id, StartDate, EndDate, Data_Evento__c
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

      mapping.Data_Inizio__c = campaign.StartDate;
      mapping.Data_Fine__c = campaign.EndDate;
      mapping.Data_Evento__c = campaign.Data_Evento__c;

      if (!shouldValidate(mapping, oldMappingMap)) {
        continue;
      }

      if (campaign.StartDate == null || campaign.EndDate == null) {
        mapping.addError(
          'La campagna figlia collegata deve avere Data Inizio e Data Fine valorizzate.'
        );
        continue;
      }

      MappingWindow window = new MappingWindow(
        mapping,
        campaign.StartDate,
        campaign.EndDate
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
