public with sharing class MexalOrderMappingService {
  public class MexalOrderMappingException extends Exception {
  }

  public static void saveCreatedOrderMapping(
    Id orderId,
    MexalOrderSendService.Result sendResult
  ) {
    if (orderId == null || sendResult == null) {
      return;
    }

    updateOrderMapping(orderId, sendResult);
    updateOrderItemMappings(sendResult.lineNumbersByOrderItemId);
  }

  private static void updateOrderMapping(
    Id orderId,
    MexalOrderSendService.Result sendResult
  ) {
    Order orderUpdate = new Order(
      Id = orderId,
      Mexal_Document_Sigla__c = sendResult.mexalDocumentSigla,
      Mexal_Document_Serie__c = toDecimal(sendResult.mexalDocumentSerie),
      Mexal_Document_Number__c = toDecimal(sendResult.mexalDocumentNumber),
      Mexal_Customer_Code__c = sendResult.mexalCustomerCode
    );

    update orderUpdate;
  }

  private static void updateOrderItemMappings(
    Map<Id, Integer> lineNumbersByOrderItemId
  ) {
    if (
      lineNumbersByOrderItemId == null || lineNumbersByOrderItemId.isEmpty()
    ) {
      return;
    }

    List<OrderItem> lineUpdates = new List<OrderItem>();
    for (Id orderItemId : lineNumbersByOrderItemId.keySet()) {
      lineUpdates.add(
        new OrderItem(
          Id = orderItemId,
          Mexal_Line_Number__c = toDecimal(
            lineNumbersByOrderItemId.get(orderItemId)
          )
        )
      );
    }

    update lineUpdates;
  }

  private static Decimal toDecimal(Integer value) {
    return value == null ? null : Decimal.valueOf(value);
  }
}
