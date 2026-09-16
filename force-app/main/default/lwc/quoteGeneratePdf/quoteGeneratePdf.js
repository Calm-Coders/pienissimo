import { LightningElement, api, wire } from "lwc";
import { getRecord, getFieldValue, updateRecord } from "lightning/uiRecordApi";
import STATUS from "@salesforce/schema/Quote.Status";
import PAYMENT from "@salesforce/schema/Quote.Modalita_Pagamento_PDF__c";
import MODIFIED from "@salesforce/schema/Quote.LastModifiedDate";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CloseActionScreenEvent } from "lightning/actions";
import { RefreshEvent } from "lightning/refresh";
import generatePdf from "@salesforce/apex/QuotePdfService.generatePdf";

export default class QuoteGeneratePdf extends NavigationMixin(
  LightningElement
) {
  @api recordId;
  busy = false;
  error;
  documentId;
  paymentMethod = "";
  paymentChanged = false;
  quote;

  @wire(getRecord, {
    recordId: "$recordId",
    fields: [STATUS, PAYMENT, MODIFIED]
  })
  loadQuote({ data, error }) {
    if (data) {
      this.quote = data;
      if (!this.paymentChanged)
        this.paymentMethod = getFieldValue(data, PAYMENT) || "";
      if (getFieldValue(data, STATUS) !== "Bozza") {
        this.error =
          "Il PDF può essere generato solo quando il preventivo è in Bozza.";
      }
    } else if (error) {
      this.quote = undefined;
      this.error = error.body?.message || "Impossibile leggere il preventivo.";
    }
  }

  changePayment(event) {
    this.paymentMethod = event.target.value;
    this.paymentChanged = true;
  }

  get disabled() {
    return (
      this.busy ||
      !this.quote ||
      getFieldValue(this.quote, STATUS) !== "Bozza" ||
      !!this.documentId
    );
  }

  async generate() {
    if (this.disabled) return;
    this.busy = true;
    this.error = undefined;
    try {
      if (this.paymentChanged) {
        await updateRecord(
          {
            fields: {
              Id: this.recordId,
              [PAYMENT.fieldApiName]: this.paymentMethod
            }
          },
          { ifUnmodifiedSince: getFieldValue(this.quote, MODIFIED) }
        );
        this.paymentChanged = false;
      }
      this.documentId = await generatePdf({ quoteId: this.recordId });
      this.dispatchEvent(new RefreshEvent());
      this.dispatchEvent(
        new ShowToastEvent({
          title: "PDF generato",
          message: "Il documento e stato salvato nei File del preventivo.",
          variant: "success"
        })
      );
    } catch (error) {
      this.error =
        error.body?.message || error.message || "Generazione PDF non riuscita.";
    } finally {
      this.busy = false;
    }
  }

  preview() {
    this[NavigationMixin.Navigate]({
      type: "standard__namedPage",
      attributes: { pageName: "filePreview" },
      state: { selectedRecordId: this.documentId }
    });
  }

  close() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
}
