import { LightningElement, api, wire } from "lwc";
import {
  getRecord,
  getFieldValue,
  notifyRecordUpdateAvailable
} from "lightning/uiRecordApi";
import STATUS from "@salesforce/schema/Quote.Status";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { CloseActionScreenEvent } from "lightning/actions";
import generatePdf from "@salesforce/apex/QuotePdfService.generatePdf";

export default class QuoteGeneratePdf extends LightningElement {
  @api recordId;
  busy = false;
  error;
  documentId;
  quote;

  @wire(getRecord, {
    recordId: "$recordId",
    fields: [STATUS]
  })
  loadQuote({ data, error }) {
    if (data) {
      this.quote = data;
      if (
        getFieldValue(data, STATUS) !== "Bozza" &&
        !this.busy &&
        !this.documentId
      ) {
        this.error =
          "Il PDF puo essere generato solo quando il preventivo e in Bozza.";
      } else {
        this.error = undefined;
      }
    } else if (error) {
      this.quote = undefined;
      this.error = error.body?.message || "Impossibile leggere il preventivo.";
    }
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
      this.documentId = await generatePdf({ quoteId: this.recordId });
      await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
      this.dispatchEvent(
        new ShowToastEvent({
          title: "PDF generato",
          message: "Il documento e stato salvato nei File del preventivo.",
          variant: "success"
        })
      );
      // Reload a clean record URL rather than the current quick-action URL;
      // otherwise Lightning reopens this modal after the reload.
      this.dispatchEvent(new CloseActionScreenEvent());
      window.location.replace(`/lightning/r/Quote/${this.recordId}/view`);
    } catch (error) {
      this.error =
        error.body?.message || error.message || "Generazione PDF non riuscita.";
    } finally {
      this.busy = false;
    }
  }

  close() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
}
