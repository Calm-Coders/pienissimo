public without sharing class FiscalResidenceResolver {
  private static Map<String, Residenza_Fiscale__mdt> rowsByCountryKey;
  private static Residenza_Fiscale__mdt defaultRow;

  // The Residenza_Fiscale__mdt row for a country value: matched on the two-letter
  // ISO code, the three-letter one, the Mexal country name or any of the row's
  // Nomi_Alternativi__c (e.g. "Italy" from the address search). An unlisted country
  // gets the Predefinito row; a blank country gets null.
  public static Residenza_Fiscale__mdt forCountry(String country) {
    if (String.isBlank(country)) {
      return null;
    }

    loadRows();
    Residenza_Fiscale__mdt row = rowsByCountryKey.get(normalize(country));
    return row == null ? defaultRow : row;
  }

  public static void applyToAccounts(List<Account> accounts) {
    for (Account accountRecord : accounts) {
      Residenza_Fiscale__mdt row = forCountry(accountRecord.BillingCountry);
      accountRecord.Residenza_Fiscale__c = row == null
        ? null
        : row.Codice_Residenza_Fiscale__c;
    }
  }

  private static void loadRows() {
    if (rowsByCountryKey != null) {
      return;
    }

    rowsByCountryKey = new Map<String, Residenza_Fiscale__mdt>();
    for (
      Residenza_Fiscale__mdt row : Residenza_Fiscale__mdt.getAll().values()
    ) {
      if (row.Predefinito__c) {
        defaultRow = row;
        continue;
      }

      List<String> keys = new List<String>{
        row.Codice_Paese__c,
        row.Codice_ISO3__c,
        row.Descrizione_Paese__c
      };
      if (!String.isBlank(row.Nomi_Alternativi__c)) {
        keys.addAll(row.Nomi_Alternativi__c.split(','));
      }

      for (String key : keys) {
        if (!String.isBlank(key)) {
          rowsByCountryKey.put(normalize(key), row);
        }
      }
    }
  }

  private static String normalize(String value) {
    return value.trim().toUpperCase();
  }
}
