public without sharing class ContactTriggerHandler {
  private static Boolean isClearingOtherPrincipals = false;

  public static void afterInsert(List<Contact> newRecords) {
    handleAfterChange(newRecords, null);
  }

  public static void afterUpdate(
    List<Contact> newRecords,
    Map<Id, Contact> oldMap
  ) {
    handleAfterChange(newRecords, oldMap);
  }

  public static void afterDelete(List<Contact> oldRecords) {
    syncAccountPrincipalEmails(collectAffectedAccountIds(null, oldRecords));
  }

  public static void afterUndelete(List<Contact> newRecords) {
    handleAfterChange(newRecords, null);
  }

  private static void handleAfterChange(
    List<Contact> newRecords,
    Map<Id, Contact> oldMap
  ) {
    if (!isClearingOtherPrincipals) {
      clearOtherPrincipalContacts(newRecords);
    }

    List<Contact> oldRecords = oldMap == null
      ? null
      : new List<Contact>(oldMap.values());
    syncAccountPrincipalEmails(
      collectAffectedAccountIds(newRecords, oldRecords)
    );
  }

  private static void clearOtherPrincipalContacts(List<Contact> newRecords) {
    Map<Id, Id> principalContactIdByAccountId = new Map<Id, Id>();
    for (Contact contactRecord : newRecords) {
      if (
        contactRecord.AccountId != null &&
        contactRecord.Contatto_Principale__c == true
      ) {
        principalContactIdByAccountId.put(
          contactRecord.AccountId,
          contactRecord.Id
        );
      }
    }

    if (principalContactIdByAccountId.isEmpty()) {
      return;
    }

    Set<Id> principalContactIds = new Set<Id>(
      principalContactIdByAccountId.values()
    );
    List<Contact> contactsToClear = new List<Contact>();
    for (Contact contactRecord : [
      SELECT Id
      FROM Contact
      WHERE
        AccountId IN :principalContactIdByAccountId.keySet()
        AND Contatto_Principale__c = TRUE
        AND Id NOT IN :principalContactIds
    ]) {
      contactsToClear.add(
        new Contact(Id = contactRecord.Id, Contatto_Principale__c = false)
      );
    }

    if (contactsToClear.isEmpty()) {
      return;
    }

    isClearingOtherPrincipals = true;
    try {
      update contactsToClear;
    } finally {
      isClearingOtherPrincipals = false;
    }
  }

  private static Set<Id> collectAffectedAccountIds(
    List<Contact> newRecords,
    List<Contact> oldRecords
  ) {
    Set<Id> accountIds = new Set<Id>();
    addPrincipalAccountIds(accountIds, newRecords);
    addPrincipalAccountIds(accountIds, oldRecords);
    return accountIds;
  }

  private static void addPrincipalAccountIds(
    Set<Id> accountIds,
    List<Contact> contacts
  ) {
    if (contacts == null) {
      return;
    }

    for (Contact contactRecord : contacts) {
      if (
        contactRecord.AccountId != null &&
        contactRecord.Contatto_Principale__c == true
      ) {
        accountIds.add(contactRecord.AccountId);
      }
    }
  }

  private static void syncAccountPrincipalEmails(Set<Id> accountIds) {
    if (accountIds == null || accountIds.isEmpty()) {
      return;
    }

    Map<Id, String> principalEmailByAccountId = new Map<Id, String>();
    for (Contact contactRecord : [
      SELECT AccountId, Email
      FROM Contact
      WHERE AccountId IN :accountIds AND Contatto_Principale__c = TRUE
      ORDER BY LastModifiedDate DESC, CreatedDate DESC
    ]) {
      if (!principalEmailByAccountId.containsKey(contactRecord.AccountId)) {
        principalEmailByAccountId.put(
          contactRecord.AccountId,
          contactRecord.Email
        );
      }
    }

    List<Account> accountsToUpdate = new List<Account>();
    for (Account accountRecord : [
      SELECT Id, Email_Contatto_Principale__c
      FROM Account
      WHERE Id IN :accountIds
    ]) {
      String principalEmail = principalEmailByAccountId.get(accountRecord.Id);
      if (accountRecord.Email_Contatto_Principale__c != principalEmail) {
        accountsToUpdate.add(
          new Account(
            Id = accountRecord.Id,
            Email_Contatto_Principale__c = principalEmail
          )
        );
      }
    }

    if (!accountsToUpdate.isEmpty()) {
      update accountsToUpdate;
    }
  }
}
