import { api, LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";
import createForAccount from "@salesforce/apex/MexalCustomerCreateService.createForAccount";

export default class MexalCustomerCreateAction extends LightningElement {
  @api recordId;
  isRunning = false;

  @api
  async invoke() {
    if (this.isRunning) {
      return;
    }

    if (!this.recordId) {
      this.showToast(
        "Creazione cliente Mexal fallita",
        "L'ID account e obbligatorio.",
        "error"
      );
      return;
    }

    this.isRunning = true;

    try {
      const result = await createForAccount({ accountId: this.recordId });
      const isHandled =
        result?.success === true || result?.duplicatePartitaIva === true;
      const message = result?.message || "Creazione cliente Mexal completata.";

      if (result?.accountUpdated === true) {
        await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
      }

      this.showToast(
        isHandled
          ? "Cliente Mexal aggiornato"
          : "Creazione cliente Mexal fallita",
        message,
        isHandled ? "success" : "error"
      );
    } catch (error) {
      this.showToast(
        "Creazione cliente Mexal fallita",
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
    console.error("mexalCustomerCreateAction error", error);

    if (!error) {
      return "Errore sconosciuto";
    }
    if (typeof error === "string") {
      return error;
    }

    const messages = [];
    const body = error.body ?? error;

    if (Array.isArray(body)) {
      messages.push(...body.map((entry) => entry?.message).filter(Boolean));
    }
    if (body?.message) {
      messages.push(body.message);
    }
    if (Array.isArray(body?.pageErrors)) {
      messages.push(
        ...body.pageErrors.map((entry) => entry?.message).filter(Boolean)
      );
    }
    if (body?.fieldErrors) {
      for (const field of Object.keys(body.fieldErrors)) {
        messages.push(
          ...body.fieldErrors[field]
            .map((entry) => entry?.message)
            .filter(Boolean)
        );
      }
    }
    if (body?.output?.errors?.length) {
      messages.push(
        ...body.output.errors.map((entry) => entry?.message).filter(Boolean)
      );
    }
    if (!messages.length && error.message) {
      messages.push(error.message);
    }

    return messages.length
      ? messages.join(" | ")
      : JSON.stringify(error).slice(0, 255);
  }
}
