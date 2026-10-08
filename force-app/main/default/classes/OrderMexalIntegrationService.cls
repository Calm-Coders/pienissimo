public without sharing class OrderMexalIntegrationService {
  private static final Boolean AUTOMATIC_MEXAL_CREATION_ENABLED = true;
  private static final String FLOW_NAME = 'OrderMexalIntegration';
  private static final String STATUS_QUEUED = 'Queued';
  private static final String STATUS_RUNNING = 'Running';
  private static final String STATUS_SENT = 'Sent';
  private static final String STATUS_SENT_LINES_NOT_ALIGNED = 'Sent_Lines_Not_Aligned';
  private static final String STATUS_FAILED = 'Failed';
  private static final String STATUS_EXCLUDED = 'Excluded';
  // UAT testing (2026-10-06): true runs the full integration in sandbox,
  // customer create/update included, against the live Mexal company.
  private static final Boolean ALLOW_MEXAL_QUEUE_IN_SANDBOX = true;
  private static final Set<Id> ORDER_IDS_QUEUED_IN_TRANSACTION = new Set<Id>();

  public class OrderMexalIntegrationException extends Exception {
  }

  public static void enqueueForCreatedOrders(List<Order> newOrders) {
    if (AUTOMATIC_MEXAL_CREATION_ENABLED != true || Test.isRunningTest()) {
      return;
    }

    if (!shouldRunMexalQueue()) {
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

  public static void retryFailedOrder(Id orderId) {
    if (orderId == null) {
      throw new OrderMexalIntegrationException('Ordine obbligatorio.');
    }

    Order orderRecord = [
      SELECT
        Id,
        AccountId,
        Account.Codice_Cliente_Mexal__c,
        Mexal_Integration_Status__c,
        Mexal_Order_Number__c,
        Mexal_Document_Number__c
      FROM Order
      WHERE Id = :orderId
      LIMIT 1
    ];

    if (orderRecord.Mexal_Integration_Status__c != STATUS_FAILED) {
      throw new OrderMexalIntegrationException(
        'Il reinvio e possibile solo per ordini con integrazione Mexal fallita.'
      );
    }

    if (
      !String.isBlank(orderRecord.Mexal_Order_Number__c) ||
      orderRecord.Mexal_Document_Number__c != null
    ) {
      throw new OrderMexalIntegrationException(
        'L ordine risulta gia creato su Mexal: reinvio bloccato per evitare un duplicato.'
      );
    }

    if (orderRecord.AccountId == null) {
      throw new OrderMexalIntegrationException(
        'Ordine senza Account: impossibile inviare a Mexal.'
      );
    }

    if (
      ALLOW_MEXAL_QUEUE_IN_SANDBOX != true &&
      isSandboxOrg() &&
      String.isBlank(orderRecord.Account.Codice_Cliente_Mexal__c)
    ) {
      throw new OrderMexalIntegrationException(
        'In sandbox il reinvio richiede un Account con Codice Cliente Mexal: la creazione clienti Mexal e bloccata.'
      );
    }

    // Without a Mexal customer code the retry must create the customer, as the
    // first order of the account would.
    Set<Id> firstOrderIds = new Set<Id>();
    if (String.isBlank(orderRecord.Account.Codice_Cliente_Mexal__c)) {
      Integer ordersInFlight = [
        SELECT COUNT()
        FROM Order
        WHERE
          AccountId = :orderRecord.AccountId
          AND Id != :orderId
          AND Mexal_Integration_Status__c IN (:STATUS_QUEUED, :STATUS_RUNNING)
      ];
      if (ordersInFlight > 0) {
        throw new OrderMexalIntegrationException(
          'Un altro ordine dello stesso cliente e in invio a Mexal: riprovare tra qualche minuto.'
        );
      }
      firstOrderIds.add(orderId);
    }

    List<Id> orderIds = new List<Id>{ orderId };
    markOrdersQueued(orderIds);
    System.enqueueJob(
      new OrderMexalIntegrationQueueable(orderIds, firstOrderIds, true)
    );
  }

  public static Boolean isAutomaticMexalCreationEnabled() {
    return AUTOMATIC_MEXAL_CREATION_ENABLED;
  }

  public static void markOrderRunning(Id orderId) {
    updateOrderIntegrationFields(orderId, STATUS_RUNNING, null);
  }

  public static Boolean excludeZeroValueOrder(Id orderId) {
    if (orderId == null) {
      return false;
    }

    Order orderRecord = [
      SELECT TotalAmount
      FROM Order
      WHERE Id = :orderId
      LIMIT 1
    ];
    if (orderRecord.TotalAmount != 0) {
      return false;
    }

    updateOrderIntegrationFields(orderId, STATUS_EXCLUDED, null);
    return true;
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

    // Sandbox runs are manual retries: they may create the order on serie 10
    // but must not modify the customer in the live Mexal registry.
    if (ALLOW_MEXAL_QUEUE_IN_SANDBOX != true && isSandboxOrg()) {
      return;
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

  // Never throws: the order already exists on Mexal, so a failure here must
  // not mark it Failed and expose it to a duplicate resend.
  public static void runMexalOrderLinesStep(Id orderId) {
    String failureMessage;
    try {
      MexalOrderLineSyncService.Result result = MexalOrderLineSyncService.syncOrderLines(
        orderId
      );
      if (result.aligned == true) {
        return;
      }
      failureMessage = result.message;
    } catch (Exception error) {
      failureMessage = error.getMessage();
    }

    try {
      MexalOrderLineSyncService.clearLineNumbers(orderId);
    } catch (Exception ignored) {
      // The status below still flags the order for manual alignment.
    }
    String lineAlignmentError =
      'Righe ordine Mexal non allineate: ' + safeMessage(failureMessage);
    updateOrderIntegrationFields(
      orderId,
      STATUS_SENT_LINES_NOT_ALIGNED,
      null,
      lineAlignmentError
    );

    try {
      insert new Integration_Log__c(
        Flow_Name__c = FLOW_NAME,
        Inbound_Outbound__c = 'Outbound',
        Is_Error__c = true,
        Request_Body__c = JSON.serialize(
          new Map<String, Object>{
            'orderId' => orderId,
            'step' => 'Mexal Order Lines',
            'blocking' => false
          }
        ),
        Exception_Message__c = lineAlignmentError
      );
    } catch (Exception ignored) {
      // A failed diagnostic log must not stop the queue.
    }
  }

  public static void logFailure(Id orderId, String stepName, Exception error) {
    String errorMessage = error == null
      ? 'Errore integrazione Mexal senza ulteriori dettagli.'
      : error.getMessage();
    markOrderFailed(orderId, errorMessage);

    try {
      insert new Integration_Log__c(
        Flow_Name__c = FLOW_NAME,
        Inbound_Outbound__c = 'Outbound',
        Is_Error__c = true,
        Request_Body__c = JSON.serialize(
          new Map<String, Object>{ 'orderId' => orderId, 'step' => stepName }
        ),
        Exception_Message__c = errorMessage,
        Exception_StackTrace__c = error == null
          ? null
          : error.getStackTraceString()
      );
    } catch (Exception ignored) {
      // A failed diagnostic log must not keep the remaining queued orders stuck.
    }
  }

  private static Boolean shouldRunMexalQueue() {
    if (ALLOW_MEXAL_QUEUE_IN_SANDBOX == true) {
      return true;
    }

    return !isSandboxOrg();
  }

  private static Boolean isSandboxOrg() {
    return [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox == true;
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
        new Order(
          Id = orderId,
          Mexal_Integration_Status__c = STATUS_QUEUED,
          Mexal_Integration_Error__c = null
        )
      );
    }

    if (!orderUpdates.isEmpty()) {
      update orderUpdates;
    }
  }

  private static void markOrderFailed(Id orderId, String errorMessage) {
    updateOrderIntegrationFields(orderId, STATUS_FAILED, null, errorMessage);
  }

  private static void updateOrderIntegrationFields(
    Id orderId,
    String status,
    String mexalOrderNumber
  ) {
    updateOrderIntegrationFields(orderId, status, mexalOrderNumber, null);
  }

  private static void updateOrderIntegrationFields(
    Id orderId,
    String status,
    String mexalOrderNumber,
    String errorMessage
  ) {
    if (orderId == null) {
      return;
    }

    try {
      Order orderUpdate = new Order(
        Id = orderId,
        Mexal_Integration_Status__c = status,
        Mexal_Integration_Error__c = String.isBlank(errorMessage)
          ? null
          : errorMessage.abbreviate(32768)
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
