public with sharing class CommercialAccountResolver {
  private static final String AZIENDA_RECORD_TYPE = 'Azienda';
  private static final String LOCALE_RECORD_TYPE = 'Locale';

  public class CommercialAccountResolverException extends Exception {
  }

  public static Id resolve(Id accountId) {
    if (accountId == null) {
      return null;
    }

    return resolveAll(new Set<Id>{ accountId }).get(accountId);
  }

  public static Map<Id, Id> resolveAll(Set<Id> accountIds) {
    Map<Id, Id> commercialAccountIdByAccountId = new Map<Id, Id>();
    if (accountIds == null || accountIds.isEmpty()) {
      return commercialAccountIdByAccountId;
    }

    for (Account accountRecord : [
      SELECT
        Id,
        ParentId,
        RecordType.DeveloperName,
        Parent.RecordType.DeveloperName
      FROM Account
      WHERE Id IN :accountIds
    ]) {
      commercialAccountIdByAccountId.put(
        accountRecord.Id,
        resolveAccount(accountRecord)
      );
    }

    return commercialAccountIdByAccountId;
  }

  private static Id resolveAccount(Account accountRecord) {
    if (accountRecord.RecordType.DeveloperName == AZIENDA_RECORD_TYPE) {
      return accountRecord.Id;
    }

    if (accountRecord.RecordType.DeveloperName != LOCALE_RECORD_TYPE) {
      return accountRecord.Id;
    }

    if (accountRecord.ParentId == null) {
      throw new CommercialAccountResolverException(
        'Il Locale deve essere collegato a una Azienda.'
      );
    }

    if (
      accountRecord.Parent == null ||
      accountRecord.Parent.RecordType.DeveloperName != AZIENDA_RECORD_TYPE
    ) {
      throw new CommercialAccountResolverException(
        'Il parent del Locale deve essere una Azienda.'
      );
    }

    return accountRecord.ParentId;
  }
}
