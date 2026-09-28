public with sharing class OrderMexalIntegrationQueueable implements Queueable, Database.AllowsCallouts {
  private static final String STEP_MARK_RUNNING = 'Mark Running';
  private static final String STEP_ANTICIPAY = 'Anticipay';
  private static final String STEP_MEXAL_CUSTOMER = 'Mexal Customer';
  private static final String STEP_MEXAL_ORDER = 'Mexal Order';

  private final Id orderId;
  private final String stepName;
  private final Boolean firstOrder;
  private final List<Id> remainingOrderIds;
  private final Set<Id> firstOrderIds;

  public OrderMexalIntegrationQueueable(
    List<Id> orderIds,
    Set<Id> firstOrderIds
  ) {
    List<Id> safeOrderIds = orderIds == null ? new List<Id>() : orderIds;
    this.orderId = safeOrderIds.isEmpty() ? null : safeOrderIds[0];
    this.stepName = initialStep(this.orderId, firstOrderIds);
    this.firstOrderIds = firstOrderIds == null
      ? new Set<Id>()
      : new Set<Id>(firstOrderIds);
    this.firstOrder = this.firstOrderIds.contains(this.orderId);
    this.remainingOrderIds = new List<Id>();

    for (Integer index = 1; index < safeOrderIds.size(); index++) {
      this.remainingOrderIds.add(safeOrderIds[index]);
    }
  }

  private OrderMexalIntegrationQueueable(
    Id orderId,
    String stepName,
    Boolean firstOrder,
    List<Id> remainingOrderIds,
    Set<Id> firstOrderIds
  ) {
    this.orderId = orderId;
    this.stepName = stepName;
    this.firstOrder = firstOrder == true;
    this.remainingOrderIds = remainingOrderIds == null
      ? new List<Id>()
      : new List<Id>(remainingOrderIds);
    this.firstOrderIds = firstOrderIds == null
      ? new Set<Id>()
      : new Set<Id>(firstOrderIds);
  }

  public void execute(QueueableContext context) {
    if (orderId == null) {
      enqueueNextOrder();
      return;
    }

    try {
      runCurrentStep();
      enqueueNextStepOrOrder();
    } catch (Exception error) {
      OrderMexalIntegrationService.logFailure(orderId, stepName, error);
      enqueueNextOrder();
    }
  }

  private void runCurrentStep() {
    if (stepName == STEP_MARK_RUNNING) {
      OrderMexalIntegrationService.markOrderRunning(orderId);
      return;
    }

    if (stepName == STEP_ANTICIPAY) {
      OrderMexalIntegrationService.runAnticipayStep(orderId);
      return;
    }

    if (stepName == STEP_MEXAL_CUSTOMER) {
      OrderMexalIntegrationService.runMexalCustomerStep(orderId, firstOrder);
      return;
    }

    if (stepName == STEP_MEXAL_ORDER) {
      OrderMexalIntegrationService.runMexalOrderStep(orderId);
    }
  }

  private void enqueueNextStepOrOrder() {
    String nextStep = nextStepName();
    if (nextStep != null) {
      System.enqueueJob(
        new OrderMexalIntegrationQueueable(
          orderId,
          nextStep,
          firstOrder,
          remainingOrderIds,
          firstOrderIds
        )
      );
      return;
    }

    enqueueNextOrder();
  }

  private void enqueueNextOrder() {
    if (!remainingOrderIds.isEmpty()) {
      System.enqueueJob(
        new OrderMexalIntegrationQueueable(remainingOrderIds, firstOrderIds)
      );
    }
  }

  private String nextStepName() {
    if (stepName == STEP_MARK_RUNNING) {
      return firstOrder ? STEP_ANTICIPAY : STEP_MEXAL_CUSTOMER;
    }

    if (stepName == STEP_ANTICIPAY) {
      return STEP_MEXAL_CUSTOMER;
    }

    if (stepName == STEP_MEXAL_CUSTOMER) {
      return STEP_MEXAL_ORDER;
    }

    return null;
  }

  private static String initialStep(Id orderId, Set<Id> firstOrderIds) {
    return STEP_MARK_RUNNING;
  }
}
