// Searches behind the New Mappatura Edizione form: products by name, product
// code or Categoria_Articolo__c while typing (the standard lookup only matches
// the name), and the distinct Categoria_Articolo__c values grouped from Product2.
public with sharing class MappaturaEdizioneProductSearch {
  private static final Integer MAX_RESULTS = 50;
  // An event name describes a category only if it covers at least this share of
  // the category's products, so one stray product does not rename it.
  private static final Decimal EVENT_NAME_MIN_SHARE = 0.1;

  public class ProductOption {
    @AuraEnabled
    public Id id;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public String category;
    @AuraEnabled
    public Boolean isActive;
  }

  public class CategoryOption {
    @AuraEnabled
    public String code;
    @AuraEnabled
    public String description;
    @AuraEnabled
    public Integer productCount = 0;
    @AuraEnabled
    public Integer activeCount = 0;
  }

  // With a category, the search is limited to it and an empty term lists it.
  @AuraEnabled
  public static List<ProductOption> searchProducts(
    String searchTerm,
    String category
  ) {
    List<ProductOption> options = new List<ProductOption>();
    String term = searchTerm == null ? '' : searchTerm.trim();
    Boolean hasCategory = !String.isBlank(category);
    if (!hasCategory && term.length() < 2) {
      return options;
    }

    String pattern = '%' + term + '%';
    List<Product2> products = hasCategory
      ? [
          SELECT Id, Name, ProductCode, Categoria_Articolo__c, IsActive
          FROM Product2
          WHERE
            Categoria_Articolo__c = :category.trim()
            AND (Name LIKE :pattern
            OR ProductCode LIKE :pattern)
          ORDER BY IsActive DESC, Name
          LIMIT :MAX_RESULTS
        ]
      : [
          SELECT Id, Name, ProductCode, Categoria_Articolo__c, IsActive
          FROM Product2
          WHERE
            Name LIKE :pattern
            OR ProductCode LIKE :pattern
            OR Categoria_Articolo__c LIKE :pattern
          ORDER BY IsActive DESC, Name
          LIMIT :MAX_RESULTS
        ];

    for (Product2 product : products) {
      ProductOption option = new ProductOption();
      option.id = product.Id;
      option.name = product.Name;
      option.productCode = product.ProductCode;
      option.category = product.Categoria_Articolo__c;
      option.isActive = product.IsActive;
      options.add(option);
    }
    return options;
  }

  @AuraEnabled
  public static List<CategoryOption> getCategories() {
    Map<String, CategoryOption> optionByCode = new Map<String, CategoryOption>();
    Map<String, Map<String, Integer>> eventCountsByCode = new Map<String, Map<String, Integer>>();
    Map<String, String> levelZeroByCode = new Map<String, String>();

    for (AggregateResult row : [
      SELECT
        Categoria_Articolo__c categoryCode,
        Evento__c eventName,
        Livello_0__c levelZero,
        IsActive active,
        COUNT(Id) productCount
      FROM Product2
      WHERE Categoria_Articolo__c != NULL
      GROUP BY Categoria_Articolo__c, Evento__c, Livello_0__c, IsActive
    ]) {
      String code = normalize((String) row.get('categoryCode'));
      Integer count = (Integer) row.get('productCount');

      CategoryOption option = optionByCode.get(code);
      if (option == null) {
        option = new CategoryOption();
        option.code = code;
        optionByCode.put(code, option);
        eventCountsByCode.put(code, new Map<String, Integer>());
      }
      option.productCount += count;
      if ((Boolean) row.get('active') == true) {
        option.activeCount += count;
      }

      String eventName = (String) row.get('eventName');
      if (!String.isBlank(eventName) && eventName != 'ND') {
        Map<String, Integer> eventCounts = eventCountsByCode.get(code);
        Integer eventCount = eventCounts.get(eventName);
        eventCounts.put(
          eventName,
          (eventCount == null ? 0 : eventCount) + count
        );
      }

      String levelZero = (String) row.get('levelZero');
      if (!String.isBlank(levelZero) && !levelZeroByCode.containsKey(code)) {
        levelZeroByCode.put(code, levelZero);
      }
    }

    List<String> codes = new List<String>(optionByCode.keySet());
    codes.sort();
    List<CategoryOption> options = new List<CategoryOption>();
    for (String code : codes) {
      CategoryOption option = optionByCode.get(code);
      option.description = describe(
        eventCountsByCode.get(code),
        levelZeroByCode.get(code),
        option.productCount
      );
      options.add(option);
    }
    return options;
  }

  // The product a category-only mapping is saved on; the trigger then maps the
  // rest of the category. It must not already be mapped to the campaign or have
  // an active mapping overlapping the campaign window, or the save would fail.
  @AuraEnabled
  public static Id findProductToMap(String category, Id campaignId) {
    if (String.isBlank(category) || campaignId == null) {
      return null;
    }

    Campaign campaign = [
      SELECT Da_Data_Competenza__c, A_Data_Competenza__c
      FROM Campaign
      WHERE Id = :campaignId
    ];
    Date startDate = campaign.Da_Data_Competenza__c;
    Date endDate = campaign.A_Data_Competenza__c;

    Set<Id> unavailable = new Set<Id>();
    for (Mappatura_Edizione__c mapping : [
      SELECT Prodotto__c, Campagna__c, Attiva__c, Data_Inizio__c, Data_Fine__c
      FROM Mappatura_Edizione__c
      WHERE Prodotto__r.Categoria_Articolo__c = :category.trim()
    ]) {
      Boolean overlaps =
        mapping.Attiva__c == true &&
        startDate != null &&
        endDate != null &&
        mapping.Data_Inizio__c != null &&
        mapping.Data_Fine__c != null &&
        mapping.Data_Inizio__c <= endDate &&
        mapping.Data_Fine__c >= startDate;
      if (mapping.Campagna__c == campaignId || overlaps) {
        unavailable.add(mapping.Prodotto__c);
      }
    }

    for (Product2 product : [
      SELECT Id, Categoria_Articolo__c
      FROM Product2
      WHERE Categoria_Articolo__c = :category.trim()
      ORDER BY IsActive DESC, Name
    ]) {
      if (!unavailable.contains(product.Id)) {
        return product.Id;
      }
    }
    return null;
  }

  private static String normalize(String value) {
    return String.isBlank(value) ? null : value.trim().toUpperCase();
  }

  private static String describe(
    Map<String, Integer> eventCounts,
    String levelZero,
    Integer productCount
  ) {
    List<String> eventNames = new List<String>();
    for (String eventName : eventCounts.keySet()) {
      if (eventCounts.get(eventName) >= productCount * EVENT_NAME_MIN_SHARE) {
        eventNames.add(eventName);
      }
    }
    if (!eventNames.isEmpty()) {
      eventNames.sort();
      return String.join(eventNames, ' / ');
    }
    // Livello 0 reads "B) Eventi"; the letter prefix is only a sort key.
    return String.isBlank(levelZero)
      ? null
      : levelZero.replaceFirst('^[A-Z]\\)\\s*', '');
  }
}
