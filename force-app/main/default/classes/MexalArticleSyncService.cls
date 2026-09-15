public with sharing class MexalArticleSyncService {
  public static final String ACTION_NAME = 'Mexal_Articoli_Ricerca';

  public class Result {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public Integer statusCode;
    @AuraEnabled
    public String body;
    @AuraEnabled
    public Integer bodyLength;
    @AuraEnabled
    public Id integrationLogId;
    @AuraEnabled
    public String requestValue;
    @AuraEnabled
    public String mexalProcessedDateTime;
    @AuraEnabled
    public Integer articlesReturned;
    @AuraEnabled
    public Integer mappedProducts;
    @AuraEnabled
    public Integer skippedRows;
    @AuraEnabled
    public Integer skippedBundleMatches;
    @AuraEnabled
    public Integer upsertedProducts;
    @AuraEnabled
    public Integer failedSaves;
    @AuraEnabled
    public List<String> saveErrors;
    @AuraEnabled
    public List<Product2> products;
    @AuraEnabled
    public String message;

    public Result() {
      success = false;
      bodyLength = 0;
      articlesReturned = 0;
      mappedProducts = 0;
      skippedRows = 0;
      skippedBundleMatches = 0;
      upsertedProducts = 0;
      failedSaves = 0;
      saveErrors = new List<String>();
      products = new List<Product2>();
    }
  }

  public class MexalArticleSyncException extends Exception {
  }

  @AuraEnabled
  public static Result syncModifiedSince(Datetime modifiedSince) {
    if (modifiedSince == null) {
      throw new MexalArticleSyncException(
        'La data di ultima modifica e obbligatoria.'
      );
    }

    String mexalDateTime = formatMexalDateTime(modifiedSince);
    MexalSearchCalloutService.Result httpResult = MexalSearchCalloutService.search(
      ACTION_NAME,
      buildModifiedSinceRequest(mexalDateTime)
    );

    return buildResult(httpResult, mexalDateTime);
  }

  @AuraEnabled
  public static Result syncByArticleCode(String articleCode) {
    if (String.isBlank(articleCode)) {
      throw new MexalArticleSyncException('Il codice articolo e obbligatorio.');
    }

    String normalizedCode = articleCode.trim();
    MexalSearchCalloutService.Result httpResult = MexalSearchCalloutService.search(
      ACTION_NAME,
      buildArticleCodeRequest(normalizedCode)
    );

    return buildResult(httpResult, normalizedCode);
  }

  private static Map<String, Object> buildModifiedSinceRequest(
    String mexalDateTime
  ) {
    return new Map<String, Object>{
      'filtri' => new List<Object>{
        new Map<String, Object>{
          'campo' => 'data_ult_mod',
          'condizione' => '>=',
          'valore' => mexalDateTime
        }
      }
    };
  }

  private static Map<String, Object> buildArticleCodeRequest(
    String articleCode
  ) {
    return new Map<String, Object>{
      'filtri' => new List<Object>{
        new Map<String, Object>{
          'campo' => 'codice',
          'condizione' => '=',
          'valore' => articleCode
        }
      }
    };
  }

  private static String formatMexalDateTime(Datetime value) {
    return value.format('yyyyMMdd HHmmss');
  }

  private static Result buildResult(
    MexalSearchCalloutService.Result httpResult,
    String requestValue
  ) {
    Result result = new Result();
    result.requestValue = requestValue;

    if (httpResult == null) {
      result.message = 'Nessuna risposta dal servizio Mexal.';
      return result;
    }

    result.success = httpResult.success;
    result.statusCode = httpResult.statusCode;
    result.body = httpResult.body;
    result.bodyLength = String.isBlank(httpResult.body)
      ? 0
      : httpResult.body.length();
    mapResponseBody(result);
    result.integrationLogId = getLastLogId(httpResult.integrationLogs);
    result.message = result.success
      ? 'Sincronizzazione articoli Mexal completata.'
      : 'Sincronizzazione articoli Mexal fallita.';
    return result;
  }

  private static void mapResponseBody(Result result) {
    if (!result.success || String.isBlank(result.body)) {
      return;
    }

    Object response = JSON.deserializeUntyped(result.body);
    if (!(response instanceof Map<String, Object>)) {
      return;
    }

    Map<String, Object> responseMap = (Map<String, Object>) response;
    result.mexalProcessedDateTime = getString(responseMap, 'data_ric_elab');

    Object dati = responseMap.get('dati');
    if (!(dati instanceof List<Object>)) {
      return;
    }

    List<Object> articles = (List<Object>) dati;
    result.articlesReturned = articles.size();

    for (Object article : articles) {
      if (!(article instanceof Map<String, Object>)) {
        result.skippedRows++;
        continue;
      }

      Product2 product = mapArticleToProduct((Map<String, Object>) article);
      if (String.isBlank(product.External_Product_Code__c)) {
        result.skippedRows++;
        result.saveErrors.add('Articolo Mexal senza codice articolo.');
        continue;
      }

      result.products.add(product);
    }

    result.mappedProducts = result.products.size();
    saveProducts(result);
  }

  private static void saveProducts(Result result) {
    if (result.products.isEmpty()) {
      return;
    }

    Id itemRecordTypeId = getProductRecordTypeId('Item');
    Set<String> articleCodes = new Set<String>();
    for (Product2 product : result.products) {
      articleCodes.add(product.External_Product_Code__c);
    }

    Map<String, Product2> existingProductsByCode = new Map<String, Product2>();
    for (Product2 existingProduct : [
      SELECT
        Id,
        External_Product_Code__c,
        RecordTypeId,
        RecordType.DeveloperName
      FROM Product2
      WHERE External_Product_Code__c IN :articleCodes
    ]) {
      existingProductsByCode.put(
        normalizeMatchKey(existingProduct.External_Product_Code__c),
        existingProduct
      );
    }

    List<Product2> productsToUpsert = new List<Product2>();
    for (Product2 product : result.products) {
      Product2 existingProduct = existingProductsByCode.get(
        normalizeMatchKey(product.External_Product_Code__c)
      );

      if (
        existingProduct != null &&
        existingProduct.RecordType.DeveloperName != 'Item'
      ) {
        result.skippedBundleMatches++;
        result.saveErrors.add(
          'Articolo Mexal non sincronizzato perche il codice corrisponde a un Product2 non Item: ' +
          product.External_Product_Code__c
        );
        continue;
      }

      if (existingProduct == null && itemRecordTypeId != null) {
        product.RecordTypeId = itemRecordTypeId;
      }
      productsToUpsert.add(product);
    }

    Database.UpsertResult[] saveResults = Database.upsert(
      productsToUpsert,
      Product2.External_Product_Code__c,
      false
    );
    applySaveResults(saveResults, result);
  }

  private static void applySaveResults(
    List<Database.UpsertResult> saveResults,
    Result result
  ) {
    for (Database.UpsertResult saveResult : saveResults) {
      if (saveResult.isSuccess()) {
        result.upsertedProducts++;
        continue;
      }

      result.failedSaves++;
      result.saveErrors.add(buildSaveError(saveResult));
    }
  }

  private static String buildSaveError(Database.UpsertResult saveResult) {
    List<String> messages = new List<String>();
    for (Database.Error error : saveResult.getErrors()) {
      messages.add(error.getStatusCode() + ': ' + error.getMessage());
    }
    return String.join(messages, ' | ');
  }

  private static Product2 mapArticleToProduct(Map<String, Object> article) {
    String articleCode = chooseFirstPopulated(
      getString(article, 'codice'),
      getString(article, 'codice_articolo')
    );
    String description = chooseFirstPopulated(
      getString(article, 'descr_completa'),
      getString(article, 'descrizione'),
      articleCode
    );
    Decimal price1 = getListinoPrice(article, 1);
    Decimal price2 = getListinoPrice(article, 2);

    Product2 product = new Product2();
    product.External_Product_Code__c = trimToLength(articleCode, 255);
    product.Name = trimToLength(description, 255);
    product.Description = trimToLength(
      chooseFirstPopulated(
        getExtendedDescription(article),
        getString(article, 'descrizione_agg'),
        description
      ),
      4000
    );
    product.StockKeepingUnit = trimToLength(articleCode, 180);
    product.IsActive = resolveIsActive(article);
    product.Price_1__c = price1;
    product.Price_2__c = price2;
    product.Product_Price__c = price1;
    product.Tipologia__c = trimToLength(
      chooseFirstPopulated(
        getString(article, 'tipologia'),
        getString(article, 'tipo_articolo')
      ),
      255
    );
    product.Livello_0__c = trimToLength(getString(article, 'livello_0'), 255);
    product.Livello_1__c = trimToLength(getString(article, 'livello_1'), 255);
    product.Livello_2__c = trimToLength(getString(article, 'livello_2'), 255);
    product.Livello_3__c = trimToLength(getString(article, 'livello_3'), 255);
    product.Livello_4__c = trimToLength(getString(article, 'livello_4'), 255);
    product.Livello_5__c = trimToLength(getString(article, 'livello_5'), 255);
    product.Livello_6__c = trimToLength(getString(article, 'livello_6'), 255);
    return product;
  }

  private static Boolean resolveIsActive(Map<String, Object> article) {
    if (
      isMexalYes(getString(article, 'gest_annullato')) ||
      isMexalYes(getString(article, 'gest_precanc'))
    ) {
      return false;
    }

    Boolean currentMonthActive = getCurrentMonthActive(article);
    if (currentMonthActive != null) {
      return currentMonthActive;
    }

    String activeValue = chooseFirstPopulated(
      getString(article, 'attivo'),
      getString(article, 'is_active'),
      getString(article, 'stato')
    );

    if (String.isBlank(activeValue)) {
      return true;
    }

    String normalizedValue = activeValue.trim().toLowerCase();
    if (
      normalizedValue == 'false' ||
      normalizedValue == '0' ||
      normalizedValue == 'no' ||
      normalizedValue == 'n' ||
      normalizedValue == 'non attivo' ||
      normalizedValue == 'disattivo' ||
      normalizedValue == 'annullato' ||
      normalizedValue == 'obsoleto'
    ) {
      return false;
    }

    return true;
  }

  private static Boolean getCurrentMonthActive(Map<String, Object> article) {
    Object rawValue = article.get('gest_attiva');
    if (!(rawValue instanceof List<Object>)) {
      return null;
    }

    Integer currentMonth = Date.today().month();
    for (Object rowValue : (List<Object>) rawValue) {
      if (!(rowValue instanceof List<Object>)) {
        continue;
      }

      List<Object> row = (List<Object>) rowValue;
      if (row.size() < 2 || parseInteger(row[0]) != currentMonth) {
        continue;
      }

      return isMexalYes(String.valueOf(row[1]));
    }

    return null;
  }

  private static Boolean isMexalYes(String value) {
    return !String.isBlank(value) && value.trim().toUpperCase() == 'S';
  }

  private static Id getProductRecordTypeId(String developerName) {
    List<RecordType> recordTypes = [
      SELECT Id
      FROM RecordType
      WHERE SObjectType = 'Product2' AND DeveloperName = :developerName
      LIMIT 1
    ];

    return recordTypes.isEmpty() ? null : recordTypes[0].Id;
  }

  private static String normalizeMatchKey(String value) {
    return String.isBlank(value) ? null : value.trim().toUpperCase();
  }

  private static String chooseFirstPopulated(
    String firstValue,
    String secondValue
  ) {
    return String.isBlank(firstValue) ? secondValue : firstValue;
  }

  private static String chooseFirstPopulated(
    String firstValue,
    String secondValue,
    String thirdValue
  ) {
    return chooseFirstPopulated(
      chooseFirstPopulated(firstValue, secondValue),
      thirdValue
    );
  }

  private static String getString(
    Map<String, Object> source,
    String fieldName
  ) {
    if (source == null || !source.containsKey(fieldName)) {
      return null;
    }

    Object value = source.get(fieldName);
    return value == null ? null : String.valueOf(value);
  }

  private static Decimal getDecimal(
    Map<String, Object> source,
    List<String> fieldNames
  ) {
    for (String fieldName : fieldNames) {
      Decimal value = parseDecimal(getString(source, fieldName));
      if (value != null) {
        return value;
      }
    }
    return null;
  }

  private static Decimal getListinoPrice(
    Map<String, Object> source,
    Integer listinoNumber
  ) {
    Object rawValue = source.get('prz_listino');
    if (!(rawValue instanceof List<Object>)) {
      return getDecimal(
        source,
        new List<String>{
          'prezzo_' + String.valueOf(listinoNumber),
          'listino_' + String.valueOf(listinoNumber)
        }
      );
    }

    for (Object rowValue : (List<Object>) rawValue) {
      if (!(rowValue instanceof List<Object>)) {
        continue;
      }

      List<Object> row = (List<Object>) rowValue;
      if (row.size() < 2 || parseInteger(row[0]) != listinoNumber) {
        continue;
      }

      return parseDecimal(String.valueOf(row[1]));
    }

    return null;
  }

  private static Integer parseInteger(Object value) {
    if (value == null) {
      return null;
    }

    try {
      return Integer.valueOf(String.valueOf(value));
    } catch (Exception ignored) {
      return null;
    }
  }

  private static Decimal parseDecimal(String value) {
    if (String.isBlank(value)) {
      return null;
    }

    String normalizedValue = value.trim();
    if (normalizedValue.contains(',') && normalizedValue.contains('.')) {
      normalizedValue = normalizedValue.replace('.', '').replace(',', '.');
    } else if (normalizedValue.contains(',')) {
      normalizedValue = normalizedValue.replace(',', '.');
    }
    try {
      return Decimal.valueOf(normalizedValue);
    } catch (Exception ignored) {
      return null;
    }
  }

  private static String trimToLength(String value, Integer maxLength) {
    if (String.isBlank(value)) {
      return null;
    }

    String trimmedValue = value.trim();
    return trimmedValue.length() > maxLength
      ? trimmedValue.substring(0, maxLength)
      : trimmedValue;
  }

  private static String getExtendedDescription(Map<String, Object> article) {
    Object rawValue = article.get('descr_estesa');
    if (!(rawValue instanceof List<Object>)) {
      return getString(article, 'descr_estesa');
    }

    List<String> lines = new List<String>();
    for (Object lineValue : (List<Object>) rawValue) {
      if (lineValue != null && !String.isBlank(String.valueOf(lineValue))) {
        lines.add(String.valueOf(lineValue).trim());
      }
    }

    return lines.isEmpty() ? null : String.join(lines, '\n');
  }

  private static Id getLastLogId(List<Integration_Log__c> integrationLogs) {
    if (integrationLogs == null || integrationLogs.isEmpty()) {
      return null;
    }

    return integrationLogs[integrationLogs.size() - 1].Id;
  }
}
