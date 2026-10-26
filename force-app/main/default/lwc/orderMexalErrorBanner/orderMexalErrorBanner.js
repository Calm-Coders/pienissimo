import { api, LightningElement, wire } from "lwc";
import { getFieldValue, getRecord } from "lightning/uiRecordApi";
import MEXAL_ERROR_FIELD from "@salesforce/schema/Order.Mexal_Integration_Error__c";

const FIELDS = [MEXAL_ERROR_FIELD];

export default class OrderMexalErrorBanner extends LightningElement {
  @api recordId;
  errorMessage = "";

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  wiredOrder({ data }) {
    this.errorMessage = data
      ? getFieldValue(data, MEXAL_ERROR_FIELD) || ""
      : "";
  }

  get hasError() {
    return !!this.errorMessage;
  }
}
