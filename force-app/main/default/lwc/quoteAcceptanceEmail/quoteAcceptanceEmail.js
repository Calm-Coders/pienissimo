import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getDraft from "@salesforce/apex/QuoteAcceptanceEmailController.getDraft";
import sendEmail from "@salesforce/apex/QuoteAcceptanceEmailController.sendEmail";

export default class QuoteAcceptanceEmail extends LightningElement {
  _recordId;
  recipient = "";
  subject = "";
  body = "";
  acceptanceUrl = "";
  isLoading = true;
  isSending = false;
  loaded = false;
  errorMessage = "";

  @api
  get recordId() {
    return this._recordId;
  }
  set recordId(value) {
    if (value && value !== this._recordId) {
      this._recordId = value;
      this.loadDraft();
    }
  }
  get busy() {
    return this.isLoading || this.isSending;
  }
  get sendDisabled() {
    return this.busy || !this.loaded;
  }
  get missingRecipient() {
    return this.loaded && !this.recipient;
  }
  async loadDraft() {
    const quoteId = this.recordId;
    this.isLoading = true;
    this.loaded = false;
    this.errorMessage = "";
    try {
      const draft = await getDraft({ quoteId });
      if (quoteId !== this.recordId) return;
      this.recipient = draft.recipient || "";
      this.subject = draft.subject;
      this.body = draft.body || "";
      this.acceptanceUrl = draft.acceptanceUrl;
      this.loaded = true;
    } catch (error) {
      if (quoteId === this.recordId) this.errorMessage = this.message(error);
    } finally {
      if (quoteId === this.recordId) this.isLoading = false;
    }
  }
  handleChange(event) {
    this[event.target.name] = event.target.value;
  }
  async handleSend() {
    if (this.sendDisabled) return;
    const inputs = [...this.template.querySelectorAll("lightning-input")];
    if (!inputs.reduce((valid, input) => input.reportValidity() && valid, true))
      return;
    this.errorMessage = "";
    this.isSending = true;
    try {
      await sendEmail({
        quoteId: this.recordId,
        recipient: this.recipient,
        subject: this.subject
      });
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Email inviata",
          message: "Email affidata al servizio di invio Salesforce.",
          variant: "success"
        })
      );
      this.dispatchEvent(new CloseActionScreenEvent());
    } catch (error) {
      this.errorMessage = this.message(error);
    } finally {
      this.isSending = false;
    }
  }
  handleCancel() {
    if (!this.isSending) this.dispatchEvent(new CloseActionScreenEvent());
  }
  message(error) {
    return (
      error?.body?.message ||
      error?.message ||
      "Operazione non riuscita. Riprova."
    );
  }
}
