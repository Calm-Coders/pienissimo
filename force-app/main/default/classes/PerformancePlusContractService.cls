public without sharing class PerformancePlusContractService {
  private static final String PLUS_TYPE_PREFIX = 'Performance Plus - ';
  private static final String RENEWAL_OPPORTUNITY_TYPE = 'Performance Plus - Rinnovo';
  private static final String NEW_CONTRACT = 'Nuovo';
  private static final String RENEWAL_CONTRACT = 'Rinnovo';
  private static final String INITIAL_STATUS = 'Draft';
  private static final String STATE_CREATED = 'Creato';
  private static final String STATE_PARTIALLY_COLLECTED = 'Parzialmente Incassato';
  private static final String STATE_COLLECTED = 'Incassato';
  private static final String PAID_PAYMENT_STATUS = 'Paid';
  private static final String UNPAID_PAYMENT_STATUS = 'Unpaid';
  private static final Set<String> INVOICED_PAYMENT_STATUSES = new Set<String>{
    'Invoiced',
    PAID_PAYMENT_STATUS,
    UNPAID_PAYMENT_STATUS
  };

  // One Contract per Performance Plus order, created when the quote is signed.
  // An order is Performance Plus when a line carries a Mexal article category
  // mapped to a "Performance Plus - ..." type in Product_Category_Rule__mdt
  // (C10 attivazione, C11 rinnovo). The Contract lives in Salesforce only.
  public static void createForOrders(Set<Id> orderIds) {
    if (orderIds == null || orderIds.isEmpty()) {
      return;
    }

    Map<String, String> contractTypeByCategory = contractTypeByCategory();
    if (contractTypeByCategory.isEmpty()) {
      return;
    }

    Map<Id, String> contractTypeByOrderId = new Map<Id, String>();
    for (OrderItem line : [
      SELECT OrderId, Product2.Categoria_Articolo__c
      FROM OrderItem
      WHERE
        OrderId IN :orderIds
        AND Product2.Categoria_Articolo__c IN :contractTypeByCategory.keySet()
    ]) {
      String contractType = contractTypeByCategory.get(
        line.Product2.Categoria_Articolo__c
      );
      // A renewal line makes the whole contract a renewal.
      if (
        !contractTypeByOrderId.containsKey(line.OrderId) ||
        contractType == RENEWAL_CONTRACT
      ) {
        contractTypeByOrderId.put(line.OrderId, contractType);
      }
    }

    if (contractTypeByOrderId.isEmpty()) {
      return;
    }

    Set<Id> ordersWithContract = new Set<Id>();
    for (Contract existing : [
      SELECT Ordine__c
      FROM Contract
      WHERE Ordine__c IN :contractTypeByOrderId.keySet()
    ]) {
      ordersWithContract.add(existing.Ordine__c);
    }

    List<Order> orders = new List<Order>();
    List<Contract> contracts = new List<Contract>();
    for (Order orderRecord : [
      SELECT Id, AccountId, EffectiveDate, OrderNumber, ContractId
      FROM Order
      WHERE Id IN :contractTypeByOrderId.keySet()
    ]) {
      if (
        orderRecord.AccountId == null ||
        orderRecord.ContractId != null ||
        ordersWithContract.contains(orderRecord.Id)
      ) {
        continue;
      }

      String contractType = contractTypeByOrderId.get(orderRecord.Id);
      orders.add(orderRecord);
      contracts.add(
        new Contract(
          AccountId = orderRecord.AccountId,
          Ordine__c = orderRecord.Id,
          Name = ('Performance Plus ' +
            contractType +
            ' - Ordine ' +
            orderRecord.OrderNumber)
            .left(80),
          Status = INITIAL_STATUS,
          StartDate = orderRecord.EffectiveDate,
          Tipo_Contratto__c = contractType,
          Fatturato__c = 0,
          Incassato__c = 0,
          Stato_Contratto__c = STATE_CREATED
        )
      );
    }

    if (contracts.isEmpty()) {
      return;
    }

    insert contracts;

    // Account <- Contract <- Order: link the order back to its contract.
    for (Integer i = 0; i < orders.size(); i++) {
      orders[i].ContractId = contracts[i].Id;
    }
    update orders;
  }

  // Invoiced, collected, the oldest unpaid due date and the path state, from the
  // Mexal payment status on the order lines. Kept on the Contract by Apex because a roll-up on
  // Order breaks the Mexal payment update that also writes the Order.
  public static void refreshAmounts(Set<Id> orderIds) {
    if (orderIds == null || orderIds.isEmpty()) {
      return;
    }

    List<Contract> contracts = [
      SELECT
        Id,
        Ordine__c,
        Ordinato__c,
        Fatturato__c,
        Incassato__c,
        Prima_Scadenza_Non_Pagata__c,
        Stato_Contratto__c
      FROM Contract
      WHERE Ordine__c IN :orderIds
    ];
    if (contracts.isEmpty()) {
      return;
    }

    Set<Id> contractOrderIds = new Set<Id>();
    for (Contract contractRecord : contracts) {
      contractOrderIds.add(contractRecord.Ordine__c);
    }

    Map<Id, Decimal> invoicedByOrderId = new Map<Id, Decimal>();
    Map<Id, Decimal> collectedByOrderId = new Map<Id, Decimal>();
    Map<Id, Date> oldestUnpaidByOrderId = new Map<Id, Date>();
    for (OrderItem line : [
      SELECT OrderId, TotalPrice, Mexal_Payment_Status__c, Data_Scadenza__c
      FROM OrderItem
      WHERE
        OrderId IN :contractOrderIds
        AND Mexal_Payment_Status__c IN :INVOICED_PAYMENT_STATUSES
    ]) {
      Decimal amount = line.TotalPrice == null ? 0 : line.TotalPrice;
      addAmount(invoicedByOrderId, line.OrderId, amount);
      if (line.Mexal_Payment_Status__c == PAID_PAYMENT_STATUS) {
        addAmount(collectedByOrderId, line.OrderId, amount);
      }
      if (
        line.Mexal_Payment_Status__c == UNPAID_PAYMENT_STATUS &&
        line.Data_Scadenza__c != null
      ) {
        Date oldest = oldestUnpaidByOrderId.get(line.OrderId);
        if (oldest == null || line.Data_Scadenza__c < oldest) {
          oldestUnpaidByOrderId.put(line.OrderId, line.Data_Scadenza__c);
        }
      }
    }

    List<Contract> contractsToUpdate = new List<Contract>();
    for (Contract contractRecord : contracts) {
      Decimal invoiced = valueOrZero(
        invoicedByOrderId.get(contractRecord.Ordine__c)
      );
      Decimal collected = valueOrZero(
        collectedByOrderId.get(contractRecord.Ordine__c)
      );
      Date oldestUnpaid = oldestUnpaidByOrderId.get(contractRecord.Ordine__c);
      String state = collectionState(contractRecord.Ordinato__c, collected);
      if (
        contractRecord.Fatturato__c != invoiced ||
        contractRecord.Incassato__c != collected ||
        contractRecord.Prima_Scadenza_Non_Pagata__c != oldestUnpaid ||
        contractRecord.Stato_Contratto__c != state
      ) {
        contractsToUpdate.add(
          new Contract(
            Id = contractRecord.Id,
            Fatturato__c = invoiced,
            Incassato__c = collected,
            Prima_Scadenza_Non_Pagata__c = oldestUnpaid,
            Stato_Contratto__c = state
          )
        );
      }
    }

    if (!contractsToUpdate.isEmpty()) {
      update contractsToUpdate;
    }
  }

  // Creato until something is collected, Incassato once the whole order value is.
  private static String collectionState(Decimal ordered, Decimal collected) {
    if (collected <= 0) {
      return STATE_CREATED;
    }
    return ordered != null &&
      collected >= ordered
      ? STATE_COLLECTED
      : STATE_PARTIALLY_COLLECTED;
  }

  private static void addAmount(
    Map<Id, Decimal> amountByOrderId,
    Id orderId,
    Decimal amount
  ) {
    amountByOrderId.put(
      orderId,
      valueOrZero(amountByOrderId.get(orderId)) + amount
    );
  }

  private static Decimal valueOrZero(Decimal value) {
    return value == null ? 0 : value;
  }

  private static Map<String, String> contractTypeByCategory() {
    Map<String, String> contractTypeByCategory = new Map<String, String>();
    for (
      Product_Category_Rule__mdt rule : Product_Category_Rule__mdt.getAll()
        .values()
    ) {
      if (
        String.isBlank(rule.Categoria_Articolo__c) ||
        rule.Tipo_Opportunita__c == null ||
        !rule.Tipo_Opportunita__c.startsWith(PLUS_TYPE_PREFIX)
      ) {
        continue;
      }

      String contractType = rule.Tipo_Opportunita__c == RENEWAL_OPPORTUNITY_TYPE
        ? RENEWAL_CONTRACT
        : NEW_CONTRACT;
      for (String category : rule.Categoria_Articolo__c.split(',')) {
        if (!String.isBlank(category)) {
          contractTypeByCategory.put(category.trim(), contractType);
        }
      }
    }
    return contractTypeByCategory;
  }
}
