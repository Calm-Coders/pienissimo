import { api, LightningElement, wire } from "lwc";
import { getFieldValue, getRecord } from "lightning/uiRecordApi";
import DOCUSIGN_STATUS_FIELD from "@salesforce/schema/Order.DocuSign_Status__c";
import DOCUSIGN_ERROR_FIELD from "@salesforce/schema/Order.DocuSign_Error__c";
import getLatestErrorDetails from "@salesforce/apex/DocuSignOrderEnvelopeService.getLatestErrorDetails";

const FIELDS = [DOCUSIGN_STATUS_FIELD, DOCUSIGN_ERROR_FIELD];

export default class OrderDocuSignErrorBanner extends LightningElement {
  @api recordId;
  status = "";
  errorMessage = "";
  logErrorMessage = "";
  logId = "";
  logRequestVersion = 0;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  wiredOrder({ data }) {
    const requestVersion = ++this.logRequestVersion;
    this.status = data ? getFieldValue(data, DOCUSIGN_STATUS_FIELD) || "" : "";
    this.errorMessage = data
      ? getFieldValue(data, DOCUSIGN_ERROR_FIELD) || ""
      : "";
    this.logErrorMessage = "";
    this.logId = "";
    if (this.status === "Error") {
      this.loadLogError(this.recordId, requestVersion);
    }
  }

  async loadLogError(orderId, requestVersion) {
    try {
      const details = await getLatestErrorDetails({ orderId });
      if (
        this.recordId === orderId &&
        this.logRequestVersion === requestVersion &&
        this.status === "Error"
      ) {
        this.logErrorMessage = details?.message || "";
        this.logId = details?.logId || "";
      }
    } catch {
      // A failed lookup must not invent an error or display another Order's message.
    }
  }

  get message() {
    return this.errorMessage || this.logErrorMessage;
  }

  get logUrl() {
    return this.logId
      ? `/lightning/r/Integration_Log__c/${this.logId}/view`
      : undefined;
  }

  get hasError() {
    return this.status === "Error" && !!this.message;
  }
}
