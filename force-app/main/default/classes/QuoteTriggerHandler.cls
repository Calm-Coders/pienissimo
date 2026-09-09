public with sharing class QuoteTriggerHandler {
  private static final String ACCEPTED_STATUS = 'Accettato';
  private static final String AWAITING_ACCEPTANCE_STATUS = 'In Attesa Accettazione';
  private static final String DRAFT_STATUS = 'Bozza';
  private static final String NEGOTIATION_QUOTE_STATUS = 'In Trattativa';
  private static final String NEW_QUOTE_STATUS = 'Nuovo Preventivo';
  private static final String OPPORTUNITY_QUALIFIED_STAGE = 'Qualificato';
  private static final String OPPORTUNITY_NEGOTIATION_STAGE = 'In trattativa (Prev inviato)';
  private static final String INITIAL_ORDER_STATUS = 'Ordinato';
  private static final String SALESFORCE_ORIGIN = 'Salesforce';
  private static final String LOCALE_MISMATCH_ERROR = 'Il Locale del Preventivo deve coincidere con il Locale dell\'Opportunita.';

  private static final Set<String> OPPORTUNITY_NEGOTIATION_QUOTE_STATUSES = new Set<String>{
    DRAFT_STATUS,
    NEW_QUOTE_STATUS,
    NEGOTIATION_QUOTE_STATUS,
    AWAITING_ACCEPTANCE_STATUS,
    ACCEPTED_STATUS
  };

  public static void beforeSave(List<Quote> quotes) {
    copyLocaleFromOpportunity(quotes);
  }

  public static void afterInsert(List<Quote> quotes) {
    moveQualifiedOpportunitiesToNegotiation(quotes, null);
  }

  public static void afterUpdate(
    List<Quote> quotes,
    Map<Id, Quote> oldQuoteMap
  ) {
    moveQualifiedOpportunitiesToNegotiation(quotes, oldQuoteMap);
    createOrdersForAcceptedQuotes(quotes, oldQuoteMap);
  }

  private static void copyLocaleFromOpportunity(List<Quote> quotes) {
    Set<Id> opportunityIds = new Set<Id>();
    for (Quote quoteRecord : quotes) {
      if (quoteRecord.OpportunityId != null) {
        opportunityIds.add(quoteRecord.OpportunityId);
      }
    }

    if (opportunityIds.isEmpty()) {
      return;
    }

    Map<Id, Opportunity> opportunitiesById = new Map<Id, Opportunity>(
      [
        SELECT Id, Locale__c
        FROM Opportunity
        WHERE Id IN :opportunityIds
      ]
    );

    for (Quote quoteRecord : quotes) {
      Opportunity opportunityRecord = opportunitiesById.get(
        quoteRecord.OpportunityId
      );
      if (opportunityRecord == null) {
        continue;
      }

      if (quoteRecord.Locale__c == null) {
        quoteRecord.Locale__c = opportunityRecord.Locale__c;
        continue;
      }

      if (quoteRecord.Locale__c != opportunityRecord.Locale__c) {
        quoteRecord.Locale__c.addError(LOCALE_MISMATCH_ERROR);
      }
    }
  }

  private static void createOrdersForAcceptedQuotes(
    List<Quote> quotes,
    Map<Id, Quote> oldQuoteMap
  ) {
    Set<Id> acceptedQuoteIds = new Set<Id>();
    for (Quote quoteRecord : quotes) {
      Quote oldQuote = oldQuoteMap.get(quoteRecord.Id);
      if (
        quoteRecord.Status == ACCEPTED_STATUS &&
        oldQuote != null &&
        oldQuote.Status != ACCEPTED_STATUS
      ) {
        acceptedQuoteIds.add(quoteRecord.Id);
      }
    }

    if (acceptedQuoteIds.isEmpty()) {
      return;
    }

    Set<Id> quotedOrderIds = new Set<Id>();
    for (Order existingOrder : [
      SELECT Id, Quote__c
      FROM Order
      WHERE Quote__c IN :acceptedQuoteIds
    ]) {
      quotedOrderIds.add(existingOrder.Quote__c);
    }

    Map<Id, Quote> quotesToConvert = new Map<Id, Quote>();
    for (Quote quoteRecord : [
      SELECT Id, AccountId, OpportunityId, Pricebook2Id, Locale__c
      FROM Quote
      WHERE Id IN :acceptedQuoteIds
    ]) {
      if (!quotedOrderIds.contains(quoteRecord.Id)) {
        quotesToConvert.put(quoteRecord.Id, quoteRecord);
      }
    }

    if (quotesToConvert.isEmpty()) {
      return;
    }

    List<Order> ordersToInsert = new List<Order>();
    for (Quote quoteRecord : quotesToConvert.values()) {
      ordersToInsert.add(
        new Order(
          AccountId = quoteRecord.AccountId,
          OpportunityId = quoteRecord.OpportunityId,
          Pricebook2Id = quoteRecord.Pricebook2Id,
          EffectiveDate = Date.today(),
          Status = INITIAL_ORDER_STATUS,
          Quote__c = quoteRecord.Id,
          Locale__c = quoteRecord.Locale__c,
          Origine__c = SALESFORCE_ORIGIN
        )
      );
    }
    insert ordersToInsert;

    Map<Id, Id> orderIdByQuoteId = new Map<Id, Id>();
    for (Order orderRecord : ordersToInsert) {
      orderIdByQuoteId.put(orderRecord.Quote__c, orderRecord.Id);
    }

    List<OrderItem> orderItemsToInsert = new List<OrderItem>();
    for (QuoteLineItem quoteLine : [
      SELECT
        Id,
        QuoteId,
        PricebookEntryId,
        Quantity,
        UnitPrice,
        Description,
        Tranche__c,
        Data_Scadenza__c
      FROM QuoteLineItem
      WHERE QuoteId IN :orderIdByQuoteId.keySet()
    ]) {
      orderItemsToInsert.add(
        new OrderItem(
          OrderId = orderIdByQuoteId.get(quoteLine.QuoteId),
          PricebookEntryId = quoteLine.PricebookEntryId,
          Quantity = quoteLine.Quantity,
          UnitPrice = quoteLine.UnitPrice,
          Description = quoteLine.Description,
          Tranche__c = quoteLine.Tranche__c,
          Data_Scadenza__c = quoteLine.Data_Scadenza__c
        )
      );
    }

    if (!orderItemsToInsert.isEmpty()) {
      insert orderItemsToInsert;
    }
  }

  private static void moveQualifiedOpportunitiesToNegotiation(
    List<Quote> quotes,
    Map<Id, Quote> oldQuoteMap
  ) {
    Set<Id> opportunityIds = new Set<Id>();
    for (Quote quoteRecord : quotes) {
      if (
        quoteRecord.OpportunityId == null ||
        !OPPORTUNITY_NEGOTIATION_QUOTE_STATUSES.contains(quoteRecord.Status)
      ) {
        continue;
      }

      Quote oldQuote = oldQuoteMap == null
        ? null
        : oldQuoteMap.get(quoteRecord.Id);
      if (oldQuote != null && oldQuote.Status == quoteRecord.Status) {
        continue;
      }

      opportunityIds.add(quoteRecord.OpportunityId);
    }

    if (opportunityIds.isEmpty()) {
      return;
    }

    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    for (Opportunity opportunityRecord : [
      SELECT Id, StageName
      FROM Opportunity
      WHERE Id IN :opportunityIds AND StageName = :OPPORTUNITY_QUALIFIED_STAGE
    ]) {
      opportunitiesToUpdate.add(
        new Opportunity(
          Id = opportunityRecord.Id,
          StageName = OPPORTUNITY_NEGOTIATION_STAGE
        )
      );
    }

    if (!opportunitiesToUpdate.isEmpty()) {
      update opportunitiesToUpdate;
    }
  }
}
