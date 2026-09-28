public without sharing class QuoteTriggerHandler {
  private static final String ACCEPTED_STATUS = 'Accettato';
  private static final String AWAITING_ACCEPTANCE_STATUS = 'In Attesa Accettazione';
  private static final String DRAFT_STATUS = 'Bozza';
  private static final String DOCUSIGN_COMPLETED_STATUS = 'Completed';
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
    markCompletedDocuSignQuotesAsSigned(quotes);
    markFirstQuotesAsPrimary(quotes);
  }

  public static void afterInsert(List<Quote> quotes) {
    moveQualifiedOpportunitiesToNegotiation(quotes, null);
    keepOnePrimaryQuotePerOpportunity(quotes, null);
    updatePrimaryQuoteLookups(quotes, null);
  }

  public static void afterUpdate(
    List<Quote> quotes,
    Map<Id, Quote> oldQuoteMap
  ) {
    moveQualifiedOpportunitiesToNegotiation(quotes, oldQuoteMap);
    keepOnePrimaryQuotePerOpportunity(quotes, oldQuoteMap);
    updatePrimaryQuoteLookups(quotes, oldQuoteMap);
    updateOpportunityAmountsFromAcceptedPrimaryQuotes(quotes, oldQuoteMap);
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

  private static void markCompletedDocuSignQuotesAsSigned(List<Quote> quotes) {
    for (Quote quoteRecord : quotes) {
      if (
        quoteRecord.DocuSign_Status__c == DOCUSIGN_COMPLETED_STATUS &&
        quoteRecord.Is_Signed__c != true
      ) {
        quoteRecord.Is_Signed__c = true;
      }
    }
  }

  private static void markFirstQuotesAsPrimary(List<Quote> quotes) {
    Set<Id> opportunityIds = new Set<Id>();
    for (Quote quoteRecord : quotes) {
      if (quoteRecord.Id == null && quoteRecord.OpportunityId != null) {
        opportunityIds.add(quoteRecord.OpportunityId);
      }
    }

    if (opportunityIds.isEmpty()) {
      return;
    }

    Set<Id> opportunityIdsWithExistingQuotes = new Set<Id>();
    for (AggregateResult result : [
      SELECT OpportunityId
      FROM Quote
      WHERE OpportunityId IN :opportunityIds
      GROUP BY OpportunityId
    ]) {
      opportunityIdsWithExistingQuotes.add((Id) result.get('OpportunityId'));
    }

    Set<Id> opportunityIdsMarkedInThisTransaction = new Set<Id>();
    for (Quote quoteRecord : quotes) {
      if (
        quoteRecord.Id != null ||
        quoteRecord.OpportunityId == null ||
        opportunityIdsWithExistingQuotes.contains(quoteRecord.OpportunityId) ||
        opportunityIdsMarkedInThisTransaction.contains(
          quoteRecord.OpportunityId
        )
      ) {
        continue;
      }

      quoteRecord.Is_Primary__c = true;
      opportunityIdsMarkedInThisTransaction.add(quoteRecord.OpportunityId);
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
        quoteRecord.Is_Signed__c == true &&
        oldQuote != null &&
        oldQuote.Is_Signed__c != true
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

  private static void keepOnePrimaryQuotePerOpportunity(
    List<Quote> quotes,
    Map<Id, Quote> oldQuoteMap
  ) {
    Map<Id, Id> primaryQuoteIdByOpportunityId = new Map<Id, Id>();
    for (Quote quoteRecord : quotes) {
      if (
        quoteRecord.OpportunityId == null ||
        quoteRecord.Is_Primary__c != true
      ) {
        continue;
      }

      Quote oldQuote = oldQuoteMap == null
        ? null
        : oldQuoteMap.get(quoteRecord.Id);
      if (oldQuote != null && oldQuote.Is_Primary__c == true) {
        continue;
      }

      primaryQuoteIdByOpportunityId.put(
        quoteRecord.OpportunityId,
        quoteRecord.Id
      );
    }

    if (primaryQuoteIdByOpportunityId.isEmpty()) {
      return;
    }

    List<Quote> quotesToUpdate = new List<Quote>();
    for (Quote quoteRecord : [
      SELECT Id, OpportunityId, Is_Primary__c
      FROM Quote
      WHERE
        OpportunityId IN :primaryQuoteIdByOpportunityId.keySet()
        AND Is_Primary__c = TRUE
        AND Id NOT IN :primaryQuoteIdByOpportunityId.values()
    ]) {
      quotesToUpdate.add(new Quote(Id = quoteRecord.Id, Is_Primary__c = false));
    }

    if (!quotesToUpdate.isEmpty()) {
      update quotesToUpdate;
    }
  }

  private static void updateOpportunityAmountsFromAcceptedPrimaryQuotes(
    List<Quote> quotes,
    Map<Id, Quote> oldQuoteMap
  ) {
    Map<Id, Id> quoteIdByOpportunityId = new Map<Id, Id>();
    for (Quote quoteRecord : quotes) {
      Quote oldQuote = oldQuoteMap == null
        ? null
        : oldQuoteMap.get(quoteRecord.Id);
      if (
        oldQuote == null ||
        quoteRecord.OpportunityId == null ||
        quoteRecord.Status != ACCEPTED_STATUS ||
        oldQuote.Status == ACCEPTED_STATUS ||
        quoteRecord.Is_Primary__c != true
      ) {
        continue;
      }

      quoteIdByOpportunityId.put(quoteRecord.OpportunityId, quoteRecord.Id);
    }

    if (quoteIdByOpportunityId.isEmpty()) {
      return;
    }

    Map<Id, Decimal> grandTotalByOpportunityId = new Map<Id, Decimal>();
    for (Quote quoteRecord : [
      SELECT Id, OpportunityId, GrandTotal
      FROM Quote
      WHERE Id IN :quoteIdByOpportunityId.values()
    ]) {
      grandTotalByOpportunityId.put(
        quoteRecord.OpportunityId,
        quoteRecord.GrandTotal
      );
    }

    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    for (Opportunity opportunityRecord : [
      SELECT Id, Amount
      FROM Opportunity
      WHERE Id IN :grandTotalByOpportunityId.keySet()
    ]) {
      Decimal grandTotal = grandTotalByOpportunityId.get(opportunityRecord.Id);
      if (opportunityRecord.Amount == grandTotal) {
        continue;
      }

      opportunitiesToUpdate.add(
        new Opportunity(Id = opportunityRecord.Id, Amount = grandTotal)
      );
    }

    if (!opportunitiesToUpdate.isEmpty()) {
      update opportunitiesToUpdate;
    }
  }

  private static void updatePrimaryQuoteLookups(
    List<Quote> quotes,
    Map<Id, Quote> oldQuoteMap
  ) {
    Map<Id, Id> primaryQuoteIdByOpportunityId = new Map<Id, Id>();
    for (Quote quoteRecord : quotes) {
      if (
        quoteRecord.OpportunityId == null ||
        quoteRecord.Is_Primary__c != true
      ) {
        continue;
      }

      Quote oldQuote = oldQuoteMap == null
        ? null
        : oldQuoteMap.get(quoteRecord.Id);
      if (
        oldQuote != null &&
        oldQuote.Is_Primary__c == true &&
        oldQuote.OpportunityId == quoteRecord.OpportunityId
      ) {
        continue;
      }

      primaryQuoteIdByOpportunityId.put(
        quoteRecord.OpportunityId,
        quoteRecord.Id
      );
    }

    if (primaryQuoteIdByOpportunityId.isEmpty()) {
      return;
    }

    List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
    for (Opportunity opportunityRecord : [
      SELECT Id, Preventivo_Primario__c
      FROM Opportunity
      WHERE Id IN :primaryQuoteIdByOpportunityId.keySet()
    ]) {
      Id primaryQuoteId = primaryQuoteIdByOpportunityId.get(
        opportunityRecord.Id
      );
      if (opportunityRecord.Preventivo_Primario__c == primaryQuoteId) {
        continue;
      }

      opportunitiesToUpdate.add(
        new Opportunity(
          Id = opportunityRecord.Id,
          Preventivo_Primario__c = primaryQuoteId
        )
      );
    }

    if (!opportunitiesToUpdate.isEmpty()) {
      update opportunitiesToUpdate;
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
