public with sharing class OrderAssetsController {
  public class AssetRow {
    @AuraEnabled
    public Id id;
    @AuraEnabled
    public String name;
    @AuraEnabled
    public String status;
    @AuraEnabled
    public Id productId;
    @AuraEnabled
    public String productName;
    @AuraEnabled
    public String productCode;
    @AuraEnabled
    public Id orderProductId;
    @AuraEnabled
    public Decimal orderProductQuantity;
    @AuraEnabled
    public Id campaignId;
    @AuraEnabled
    public String campaignName;
    @AuraEnabled
    public Datetime createdDate;

    public AssetRow(Asset assetRecord) {
      id = assetRecord.Id;
      name = assetRecord.Name;
      status = assetRecord.Status;
      productId = assetRecord.Product2Id;
      productName = assetRecord.Product2 == null
        ? null
        : assetRecord.Product2.Name;
      productCode = assetRecord.Product2 == null
        ? null
        : assetRecord.Product2.ProductCode;
      orderProductId = assetRecord.Order_Product__c;
      orderProductQuantity = assetRecord.Order_Product__r == null
        ? null
        : assetRecord.Order_Product__r.Quantity;
      campaignId = assetRecord.Campaign__c;
      campaignName = assetRecord.Campaign__r == null
        ? null
        : assetRecord.Campaign__r.Name;
      createdDate = assetRecord.CreatedDate;
    }
  }

  @AuraEnabled(cacheable=true)
  public static List<AssetRow> getAssets(Id orderId) {
    validateOrderId(orderId);

    if (!Schema.sObjectType.Asset.isAccessible()) {
      throw new AuraHandledException('Accesso agli Asset non disponibile.');
    }

    List<AssetRow> rows = new List<AssetRow>();
    for (Asset assetRecord : [
      SELECT
        Id,
        Name,
        Status,
        Product2Id,
        Product2.Name,
        Product2.ProductCode,
        Order_Product__c,
        Order_Product__r.Quantity,
        Campaign__c,
        Campaign__r.Name,
        CreatedDate
      FROM Asset
      WHERE Order_Product__r.OrderId = :orderId
      WITH USER_MODE
      ORDER BY Product2.Name ASC NULLS LAST, CreatedDate ASC, Id ASC
    ]) {
      rows.add(new AssetRow(assetRecord));
    }

    return rows;
  }

  private static void validateOrderId(Id orderId) {
    if (orderId == null || orderId.getSObjectType() != Order.SObjectType) {
      throw new AuraHandledException('Apri il componente da un ordine valido.');
    }
  }
}
