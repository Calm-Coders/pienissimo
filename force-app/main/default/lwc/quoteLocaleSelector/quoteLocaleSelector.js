import { api, LightningElement, wire } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { getRecord, getFieldValue, updateRecord } from "lightning/uiRecordApi";
import { getRelatedListRecords } from "lightning/uiRelatedListApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
import QUOTE_ACCOUNT_ID from "@salesforce/schema/Quote.AccountId";
import QUOTE_ACCOUNT_NAME from "@salesforce/schema/Quote.Account.Name";
import QUOTE_LOCALE from "@salesforce/schema/Quote.Locale__c";
import QUOTE_STATUS from "@salesforce/schema/Quote.Status";

const DRAFT_STATUS = "Bozza";
const QUOTE_FIELDS = [
  QUOTE_ACCOUNT_ID,
  QUOTE_ACCOUNT_NAME,
  QUOTE_LOCALE,
  QUOTE_STATUS
];
const LOCALE_FIELDS = [
  "Account.Id",
  "Account.Name",
  "Account.Nome_Locale__c",
  "Account.RecordTypeId"
];
const OPTIONAL_LOCALE_FIELDS = ["Account.Tipologia_Attivita_Globale__c"];
const COLUMNS = [
  { label: "Nome locale", fieldName: "localeName", type: "text" },
  { label: "Nome Account", fieldName: "accountName", type: "text" },
  {
    label: "Tipologia attività",
    fieldName: "activityType",
    type: "text",
    wrapText: true
  }
];

export default class QuoteLocaleSelector extends LightningElement {
  @api recordId;

  columns = COLUMNS;
  quoteRecord;
  childAccounts = [];
  selectedLocaleId;
  quoteLoaded = false;
  localesLoaded = false;
  isSaving = false;
  errorMessage;

  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
  accountObjectInfo;

  @wire(getRecord, { recordId: "$recordId", fields: QUOTE_FIELDS })
  wiredQuote({ data, error }) {
    if (data) {
      this.quoteRecord = data;
      this.selectedLocaleId = getFieldValue(data, QUOTE_LOCALE) || null;
      this.errorMessage = null;
    } else if (error) {
      this.errorMessage = this.reduceError(error);
    }
    this.quoteLoaded = Boolean(data || error);
  }

  @wire(getRelatedListRecords, {
    parentRecordId: "$accountId",
    relatedListId: "ChildAccounts",
    fields: LOCALE_FIELDS,
    optionalFields: OPTIONAL_LOCALE_FIELDS,
    sortBy: ["Account.Name"]
  })
  wiredChildAccounts({ data, error }) {
    if (!this.accountId) {
      return;
    }

    if (data) {
      this.childAccounts = data.records || [];
      this.errorMessage = null;
    } else if (error) {
      this.errorMessage = this.reduceError(error);
    }
    this.localesLoaded = Boolean(data || error);
  }

  get accountId() {
    return this.quoteRecord
      ? getFieldValue(this.quoteRecord, QUOTE_ACCOUNT_ID)
      : undefined;
  }

  get accountName() {
    return this.quoteRecord
      ? getFieldValue(this.quoteRecord, QUOTE_ACCOUNT_NAME) || "-"
      : "-";
  }

  get localeRecordTypeId() {
    const recordTypeInfos = this.accountObjectInfo.data?.recordTypeInfos || {};
    return Object.values(recordTypeInfos).find(
      (recordType) =>
        recordType.developerName === "Locale" || recordType.name === "Locale"
    )?.recordTypeId;
  }

  get localeRows() {
    return this.childAccounts
      .filter(
        (record) =>
          record.fields.RecordTypeId?.value === this.localeRecordTypeId
      )
      .map((record) => ({
        id: record.id,
        accountName: record.fields.Name?.value || "",
        localeName:
          record.fields.Nome_Locale__c?.value ||
          record.fields.Name?.value ||
          "",
        activityType: (
          record.fields.Tipologia_Attivita_Globale__c?.value || ""
        ).replace(/;/g, ", ")
      }));
  }

  get isDraft() {
    return getFieldValue(this.quoteRecord, QUOTE_STATUS) === DRAFT_STATUS;
  }

  get isLoading() {
    return (
      !this.quoteLoaded ||
      (!this.accountObjectInfo.data && !this.accountObjectInfo.error) ||
      (Boolean(this.accountId) && !this.localesLoaded)
    );
  }

  get hasLocales() {
    return this.localeRows.length > 0;
  }

  get selectedRows() {
    return this.selectedLocaleId ? [this.selectedLocaleId] : [];
  }

  get saveDisabled() {
    return (
      this.isLoading || this.isSaving || !this.isDraft || !this.selectedLocaleId
    );
  }

  handleRowSelection(event) {
    this.selectedLocaleId = event.detail.selectedRows[0]?.id || null;
  }

  async handleSave() {
    if (this.saveDisabled) {
      return;
    }

    this.isSaving = true;
    this.errorMessage = null;
    try {
      await updateRecord({
        fields: {
          Id: this.recordId,
          Locale__c: this.selectedLocaleId
        }
      });
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Successo",
          message: "Locale aggiornato sul preventivo.",
          variant: "success"
        })
      );
      this.dispatchEvent(new CloseActionScreenEvent());
      this.dispatchEvent(new RefreshEvent());
    } catch (error) {
      this.errorMessage = this.reduceError(error);
    } finally {
      this.isSaving = false;
    }
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }

  reduceError(error) {
    return (
      error?.body?.output?.errors?.[0]?.message ||
      error?.body?.message ||
      error?.message ||
      "Non e stato possibile completare la richiesta."
    );
  }
}
