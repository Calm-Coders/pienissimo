import { LightningElement, api, wire } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { getRecord } from "lightning/uiRecordApi";
import OPPORTUNITY_OBJECT from "@salesforce/schema/Opportunity";
import ACCOUNT_NAME from "@salesforce/schema/Account.Name";

const INITIAL_STAGE = "Qualificato";
const PLUS_RECORD_TYPE = "Plus_Attivazione_Rinnovo";
const STANDARD_RECORD_TYPE = "Vendita_Standard";
const WOOCOMMERCE_RECORD_TYPE = "WooCommerce";
const STANDARD_OPPORTUNITY_TYPE = "Vendita da tutor";
const WOOCOMMERCE_OPPORTUNITY_TYPE = "WooCommerce";

export default class AccountNewOpportunity extends NavigationMixin(
  LightningElement
) {
  @api recordId;

  selectedRecordTypeId;
  isSaving = false;
  defaultCloseDate = endOfNextYear();

  @wire(getRecord, { recordId: "$recordId", fields: [ACCOUNT_NAME] })
  account;

  opportunityInfo;

  get isLoading() {
    return !this.account.data || this.recordTypeOptions.length === 0;
  }

  get accountName() {
    return this.account.data?.fields?.Name?.value || "";
  }

  get recordTypeOptions() {
    const infos = this.opportunityInfo?.recordTypeInfos;
    if (!infos) {
      return [];
    }

    const availableTypes = Object.values(infos).filter(
      (recordType) => recordType.available
    );
    const customTypes = availableTypes.filter(
      (recordType) => !recordType.master
    );
    const selectableTypes = customTypes.length ? customTypes : availableTypes;

    return selectableTypes.map((recordType) => ({
      developerName: recordType.developerName,
      label: recordType.name,
      value: recordType.recordTypeId
    }));
  }

  get selectedRecordType() {
    return this.recordTypeOptions.find(
      (option) => option.value === this.selectedRecordTypeId
    );
  }

  get selectedRecordTypeName() {
    return this.selectedRecordType?.label || "";
  }

  get selectedRecordTypeDeveloperName() {
    return this.selectedRecordType?.developerName || "";
  }

  get isWooCommerceRecordType() {
    return (
      this.selectedRecordTypeDeveloperName === WOOCOMMERCE_RECORD_TYPE ||
      this.selectedRecordTypeName === WOOCOMMERCE_RECORD_TYPE
    );
  }

  get isPlusRecordType() {
    return (
      this.selectedRecordTypeDeveloperName === PLUS_RECORD_TYPE ||
      this.selectedRecordTypeName === "Plus Attivazione/Rinnovo"
    );
  }

  get isStandardRecordType() {
    return (
      this.selectedRecordTypeDeveloperName === STANDARD_RECORD_TYPE ||
      this.selectedRecordTypeName === "Vendita Standard"
    );
  }

  get showOpportunityType() {
    return !this.isWooCommerceRecordType && !this.isStandardRecordType;
  }

  get showRecordTypeSelector() {
    return this.recordTypeOptions.length > 1;
  }

  get isSaveDisabled() {
    return this.isSaving || !this.recordId || !this.selectedRecordTypeId;
  }

  @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })
  wiredOpportunityInfo({ data }) {
    if (!data) {
      return;
    }

    this.opportunityInfo = data;
    if (!this.selectedRecordTypeId) {
      this.selectedRecordTypeId =
        data.defaultRecordTypeId || this.recordTypeOptions[0]?.value;
    }
  }

  handleRecordTypeChange(event) {
    this.selectedRecordTypeId = event.detail.value;
  }

  handleSubmit(event) {
    event.preventDefault();
    this.isSaving = true;

    const fields = { ...event.detail.fields };
    fields.AccountId = this.recordId;
    fields.RecordTypeId = this.selectedRecordTypeId;
    fields.StageName = INITIAL_STAGE;
    fields.CloseDate = this.defaultCloseDate;
    fields.Tipo_Opportunita__c = this.hiddenOpportunityTypeValue(
      fields.Tipo_Opportunita__c
    );

    this.template.querySelector("lightning-record-edit-form").submit(fields);
  }

  hiddenOpportunityTypeValue(currentValue) {
    if (this.isWooCommerceRecordType) {
      return WOOCOMMERCE_OPPORTUNITY_TYPE;
    }
    if (this.isStandardRecordType) {
      return STANDARD_OPPORTUNITY_TYPE;
    }
    return currentValue;
  }

  handleSuccess(event) {
    const opportunityId = event.detail.id;
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Opportunità creata",
        message: "La nuova opportunità è stata creata.",
        variant: "success"
      })
    );
    this.dispatchEvent(new CloseActionScreenEvent());

    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId: opportunityId,
        objectApiName: "Opportunity",
        actionName: "view"
      }
    });
  }

  handleError() {
    this.isSaving = false;
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
}

function endOfNextYear() {
  const nextYear = new Date().getFullYear() + 1;
  return `${nextYear}-12-31`;
}
