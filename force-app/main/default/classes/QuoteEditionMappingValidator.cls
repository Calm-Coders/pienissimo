// Checks, before a quote is sent for acceptance, that every ticket the order
// would generate has exactly one active Mappatura_Edizione__c on the given
// date. Mirrors OrderTriggerHandler ticket generation: a bundle line generates
// tickets for its components, any other line for its own product.
public without sharing class QuoteEditionMappingValidator {
  public static List<String> findMappingProblems(Id quoteId, Date onDate) {
    List<QuoteLineItem> quoteLines = [
      SELECT
        Id,
        Quantity,
        Product2Id,
        Product2.Name,
        Product2.ProductCode,
        Product2.Genera_Biglietto__c
      FROM QuoteLineItem
      WHERE QuoteId = :quoteId
    ];

    Set<Id> lineProductIds = new Set<Id>();
    for (QuoteLineItem line : quoteLines) {
      if (line.Product2Id != null) {
        lineProductIds.add(line.Product2Id);
      }
    }

    Map<Id, List<BundleComponent__c>> componentsByBundleId = new Map<Id, List<BundleComponent__c>>();
    if (!lineProductIds.isEmpty()) {
      for (BundleComponent__c component : [
        SELECT
          Bundle__c,
          Product__c,
          Product__r.Name,
          Product__r.ProductCode,
          Product__r.Genera_Biglietto__c,
          Quantity__c
        FROM BundleComponent__c
        WHERE Bundle__c IN :lineProductIds
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

    // Ticket-generating product id -> label shown to the user.
    Map<Id, String> ticketProducts = new Map<Id, String>();
    for (QuoteLineItem line : quoteLines) {
      if (
        line.Product2Id == null ||
        line.Quantity == null ||
        line.Quantity.intValue() <= 0
      ) {
        continue;
      }

      List<BundleComponent__c> components = componentsByBundleId.get(
        line.Product2Id
      );
      if (components != null && !components.isEmpty()) {
        for (BundleComponent__c component : components) {
          if (
            component.Product__c != null &&
            component.Product__r != null &&
            component.Product__r.Genera_Biglietto__c == true &&
            component.Quantity__c != null &&
            component.Quantity__c.intValue() > 0
          ) {
            ticketProducts.put(
              component.Product__c,
              label(
                  component.Product__r.ProductCode,
                  component.Product__r.Name
                ) +
                ' (nel bundle ' +
                label(line.Product2.ProductCode, line.Product2.Name) +
                ')'
            );
          }
        }
        continue;
      }

      if (line.Product2.Genera_Biglietto__c == true) {
        ticketProducts.put(
          line.Product2Id,
          label(line.Product2.ProductCode, line.Product2.Name)
        );
      }
    }

    List<String> problems = new List<String>();
    if (ticketProducts.isEmpty()) {
      return problems;
    }

    Map<Id, Integer> matchesByProductId = new Map<Id, Integer>();
    for (Mappatura_Edizione__c mapping : [
      SELECT Prodotto__c
      FROM Mappatura_Edizione__c
      WHERE
        Attiva__c = TRUE
        AND Prodotto__c IN :ticketProducts.keySet()
        AND Data_Inizio__c <= :onDate
        AND Data_Fine__c >= :onDate
    ]) {
      Integer count = matchesByProductId.get(mapping.Prodotto__c);
      matchesByProductId.put(
        mapping.Prodotto__c,
        count == null ? 1 : count + 1
      );
    }

    for (Id productId : ticketProducts.keySet()) {
      Integer count = matchesByProductId.get(productId);
      if (count == null) {
        problems.add(
          ticketProducts.get(productId) + ': nessuna campagna figlia mappata'
        );
      } else if (count > 1) {
        problems.add(
          ticketProducts.get(productId) +
            ': ' +
            count +
            ' mappature sovrapposte'
        );
      }
    }
    problems.sort();
    return problems;
  }

  private static String label(String productCode, String productName) {
    return String.isBlank(productCode)
      ? productName
      : productCode + ' - ' + productName;
  }
}
