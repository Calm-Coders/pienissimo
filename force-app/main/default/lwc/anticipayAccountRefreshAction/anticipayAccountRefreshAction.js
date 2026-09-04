import { api, LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";
import refreshRecord from "@salesforce/apex/AnticipayAccountService.refreshRecord";

export default class AnticipayAccountRefreshAction extends LightningElement {
  @api recordId;
  isRunning = false;

  @api
  async invoke() {
    if (this.isRunning) {
      return;
    }

    if (!this.recordId) {
      this.showToast(
        "Aggiornamento Anticipay fallito",
        "L'ID account e obbligatorio.",
        "error"
      );
      return;
    }

    this.isRunning = true;

    try {
      const result = await refreshRecord({ recordId: this.recordId });
      const isSuccess = result?.success === true;
      const message = result?.message || "Aggiornamento Anticipay completato.";

      if (isSuccess) {
        const recordsToRefresh = [{ recordId: this.recordId }];
        if (result?.accountId && result.accountId !== this.recordId) {
          recordsToRefresh.push({ recordId: result.accountId });
        }
        await notifyRecordUpdateAvailable(recordsToRefresh);
      }

      this.showToast(
        isSuccess ? "Anticipay aggiornato" : "Aggiornamento Anticipay fallito",
        message,
        isSuccess ? "success" : "error"
      );
    } catch (error) {
      this.showToast(
        "Aggiornamento Anticipay fallito",
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
    console.error("anticipayAccountRefreshAction error", error);

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
