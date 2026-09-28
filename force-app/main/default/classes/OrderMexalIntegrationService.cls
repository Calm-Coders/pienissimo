public with sharing class OrderMexalIntegrationService {
  private static final String FLOW_NAME = 'OrderMexalIntegration';
  private static final String STATUS_QUEUED = 'Queued';
  private static final String STATUS_RUNNING = 'Running';
  private static final String STATUS_SENT = 'Sent';
  private static final String STATUS_FAILED = 'Failed';
  private static final Set<Id> ORDER_IDS_QUEUED_IN_TRANSACTION = new Set<Id>();

  public class OrderMexalIntegrationException extends Exception {
  }

  public static void enqueueForCreatedOrders(List<Order> newOrders) {
    if (isSandbox()) {
      return;
    }

    if (newOrders == null || newOrders.isEmpty()) {
      return;
    }

    List<Id> orderIds = new List<Id>();
    Set<Id> insertedOrderIds = new Set<Id>();
    Set<Id> accountIds = new Set<Id>();
    Map<Id, Id> firstInsertedOrderIdByAccountId = new Map<Id, Id>();

    for (Order orderRecord : newOrders) {
      if (
        orderRecord.Id == null ||
        orderRecord.AccountId == null ||
        ORDER_IDS_QUEUED_IN_TRANSACTION.contains(orderRecord.Id)
      ) {
        continue;
      }

      orderIds.add(orderRecord.Id);
      insertedOrderIds.add(orderRecord.Id);
      accountIds.add(orderRecord.AccountId);
      ORDER_IDS_QUEUED_IN_TRANSACTION.add(orderRecord.Id);

      if (!firstInsertedOrderIdByAccountId.containsKey(orderRecord.AccountId)) {
        firstInsertedOrderIdByAccountId.put(
          orderRecord.AccountId,
          orderRecord.Id
        );
      }
    }

    if (orderIds.isEmpty()) {
      return;
    }

    Set<Id> accountsWithEarlierOrders = getAccountsWithEarlierOrders(
      accountIds,
      insertedOrderIds
    );
    Set<Id> firstOrderIds = new Set<Id>();
    for (Id accountId : firstInsertedOrderIdByAccountId.keySet()) {
      if (!accountsWithEarlierOrders.contains(accountId)) {
        firstOrderIds.add(firstInsertedOrderIdByAccountId.get(accountId));
      }
    }

    markOrdersQueued(orderIds);
    System.enqueueJob(
      new OrderMexalIntegrationQueueable(orderIds, firstOrderIds)
    );
  }

  public static void markOrderRunning(Id orderId) {
    updateOrderIntegrationFields(orderId, STATUS_RUNNING, null);
  }

  public static void runAnticipayStep(Id orderId) {
    Order orderRecord = loadOrderWithAccount(orderId);
    if (orderRecord.AccountId == null) {
      throw new OrderMexalIntegrationException(
        'Ordine senza Account: impossibile avviare Anticipay.'
      );
    }

    if (orderRecord.Account.Anticipay_Consolidato__c == true) {
      return;
    }

    AnticipayAccountService.Result result = AnticipayAccountService.refreshAccount(
      orderRecord.AccountId,
      orderRecord.Id
    );
    if (result.success != true) {
      logNonBlockingAnticipayFailure(orderRecord.Id, result);
    }
  }

  public static void runMexalCustomerStep(Id orderId, Boolean isFirstOrder) {
    Order orderRecord = loadOrderWithAccount(orderId);
    if (orderRecord.AccountId == null) {
      throw new OrderMexalIntegrationException(
        'Ordine senza Account: impossibile sincronizzare il cliente Mexal.'
      );
    }

    Account accountRecord = orderRecord.Account;
    if (String.isBlank(accountRecord.Codice_Cliente_Mexal__c)) {
      if (isFirstOrder == true) {
        MexalCustomerCreateService.Result createResult = MexalCustomerCreateService.createForAccount(
          accountRecord.Id
        );
        if (
          createResult.success != true &&
          createResult.accountUpdated != true
        ) {
          throw new OrderMexalIntegrationException(
            'Creazione cliente Mexal fallita: ' +
            safeMessage(createResult.message)
          );
        }
        return;
      }

      throw new OrderMexalIntegrationException(
        'Ordine successivo al primo senza Codice Cliente Mexal sull Account.'
      );
    }

    MexalCustomerCreateService.Result updateResult = MexalCustomerCreateService.updateForAccount(
      accountRecord.Id
    );
    if (updateResult.success != true) {
      throw new OrderMexalIntegrationException(
        'Modifica cliente Mexal fallita: ' + safeMessage(updateResult.message)
      );
    }
  }

  public static void runMexalOrderStep(Id orderId) {
    MexalOrderSendService.Result result = MexalOrderSendService.sendOrder(
      orderId
    );
    MexalOrderMappingService.saveCreatedOrderMapping(orderId, result);
    updateOrderIntegrationFields(
      orderId,
      STATUS_SENT,
      result == null ? null : result.mexalOrderNumber
    );
  }

  public static void logFailure(Id orderId, String stepName, Exception error) {
    markOrderFailed(orderId);

    try {
      insert new Integration_Log__c(
        Flow_Name__c = FLOW_NAME,
        Inbound_Outbound__c = 'Outbound',
        Is_Error__c = true,
        Request_Body__c = JSON.serialize(
          new Map<String, Object>{ 'orderId' => orderId, 'step' => stepName }
        ),
        Exception_Message__c = error == null ? null : error.getMessage(),
        Exception_StackTrace__c = error == null
          ? null
          : error.getStackTraceString()
      );
    } catch (Exception ignored) {
      // A failed diagnostic log must not keep the remaining queued orders stuck.
    }
  }

  private static void logNonBlockingAnticipayFailure(
    Id orderId,
    AnticipayAccountService.Result result
  ) {
    try {
      insert new Integration_Log__c(
        Flow_Name__c = FLOW_NAME,
        Inbound_Outbound__c = 'Outbound',
        Is_Error__c = true,
        Request_Body__c = JSON.serialize(
          new Map<String, Object>{
            'orderId' => orderId,
            'step' => 'Anticipay',
            'blocking' => false,
            'message' => 'Anticipay sync did not complete; Mexal integration continues.'
          }
        ),
        Response_State__c = result == null ||
          result.httpStatus == null
          ? null
          : String.valueOf(result.httpStatus),
        Exception_Message__c = 'Anticipay non consolidato: ' +
          safeMessage(result == null ? null : result.message)
      );
    } catch (Exception ignored) {
      // The Mexal chain must continue even if the warning log cannot be saved.
    }
  }

  private static void markOrdersQueued(List<Id> orderIds) {
    List<Order> orderUpdates = new List<Order>();
    for (Id orderId : orderIds) {
      orderUpdates.add(
        new Order(Id = orderId, Mexal_Integration_Status__c = STATUS_QUEUED)
      );
    }

    if (!orderUpdates.isEmpty()) {
      update orderUpdates;
    }
  }

  private static void markOrderFailed(Id orderId) {
    updateOrderIntegrationFields(orderId, STATUS_FAILED, null);
  }

  private static void updateOrderIntegrationFields(
    Id orderId,
    String status,
    String mexalOrderNumber
  ) {
    if (orderId == null) {
      return;
    }

    try {
      Order orderUpdate = new Order(
        Id = orderId,
        Mexal_Integration_Status__c = status
      );
      if (!String.isBlank(mexalOrderNumber)) {
        orderUpdate.Mexal_Order_Number__c = mexalOrderNumber.trim();
      }
      update orderUpdate;
    } catch (Exception ignored) {
      // Integration logs still capture the failure; status writes are diagnostic.
    }
  }

  private static Set<Id> getAccountsWithEarlierOrders(
    Set<Id> accountIds,
    Set<Id> insertedOrderIds
  ) {
    Set<Id> accountsWithEarlierOrders = new Set<Id>();
    if (accountIds.isEmpty()) {
      return accountsWithEarlierOrders;
    }

    for (AggregateResult result : [
      SELECT AccountId accountId
      FROM Order
      WHERE AccountId IN :accountIds AND Id NOT IN :insertedOrderIds
      GROUP BY AccountId
    ]) {
      accountsWithEarlierOrders.add((Id) result.get('accountId'));
    }

    return accountsWithEarlierOrders;
  }

  private static Boolean isSandbox() {
    return [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
  }

  private static Order loadOrderWithAccount(Id orderId) {
    return [
      SELECT
        Id,
        AccountId,
        Account.Id,
        Account.Anticipay_Consolidato__c,
        Account.Codice_Cliente_Mexal__c
      FROM Order
      WHERE Id = :orderId
      LIMIT 1
    ];
  }

  private static String safeMessage(String message) {
    return String.isBlank(message) ? 'nessun dettaglio disponibile' : message;
  }
}
