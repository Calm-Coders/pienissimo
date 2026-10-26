import { api, LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";
import retryMexalIntegration from "@salesforce/apex/OrderMexalRetryController.retryMexalIntegration";

export default class OrderMexalRetryAction extends LightningElement {
  @api recordId;
  isRunning = false;

  @api
  async invoke() {
    if (this.isRunning) {
      return;
    }

    if (!this.recordId) {
      this.showToast(
        "Reinvio a Mexal fallito",
        "L'ID ordine e obbligatorio.",
        "error"
      );
      return;
    }

    this.isRunning = true;

    try {
      const message = await retryMexalIntegration({ orderId: this.recordId });
      await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
      this.showToast(
        "Reinvio a Mexal avviato",
        message || "Reinvio a Mexal avviato.",
        "success"
      );
    } catch (error) {
      this.showToast(
        "Reinvio a Mexal fallito",
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
    console.error("orderMexalRetryAction error", error);

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
