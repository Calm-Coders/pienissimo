import { api, LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";
import retryDocuSign from "@salesforce/apex/DocuSignOrderEnvelopeService.retryDocuSign";

export default class OrderDocuSignRetryAction extends LightningElement {
  @api recordId;
  isRunning = false;

  @api
  async invoke() {
    if (this.isRunning) {
      return;
    }

    if (!this.recordId) {
      this.showToast(
        "Reinvio contratto DocuSign fallito",
        "L'ID ordine e obbligatorio.",
        "error"
      );
      return;
    }

    this.isRunning = true;

    try {
      const message = await retryDocuSign({ orderId: this.recordId });
      // The retry is already queued; a refresh failure must not report a failed send.
      await notifyRecordUpdateAvailable([{ recordId: this.recordId }]).catch(
        () => undefined
      );
      this.showToast(
        "Reinvio contratto DocuSign avviato",
        message || "Reinvio contratto DocuSign avviato.",
        "success"
      );
    } catch (error) {
      this.showToast(
        "Reinvio contratto DocuSign fallito",
        this.reduceError(error),
        "error"
      );
    } finally {
      this.isRunning = false;
    }
  }

  showToast(title, message, variant) {
    this.dispatchEvent(
      new ShowToastEvent({
        title,
        message,
        variant
      })
    );
  }

  reduceError(error) {
    console.error("orderDocuSignRetryAction error", error);

    if (!error) {
      return "Errore sconosciuto";
    }
    if (typeof error === "string") {
      return error;
    }

    const body = error.body ?? error;
    if (Array.isArray(body)) {
      const messages = body.map((entry) => entry?.message).filter(Boolean);
      if (messages.length) {
        return messages.join(" | ");
      }
    }
    if (body?.message) {
      return body.message;
    }
    if (error.message) {
      return error.message;
    }

    return JSON.stringify(error).slice(0, 255);
  }
}
