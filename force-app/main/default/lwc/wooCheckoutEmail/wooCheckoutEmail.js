import { api, LightningElement, wire } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getContext from "@salesforce/apex/WooCheckoutEmailController.getContext";
import sendCheckoutEmail from "@salesforce/apex/WooCheckoutEmailController.sendCheckoutEmail";

const CHECKOUT_BASE_URL = "https://www.pienissimo.it/checkout";

export default class WooCheckoutEmail extends LightningElement {
  @api recordId;

  recipientEmail = "";
  validationMessage = "";
  isSending = false;
  context;
  contextError;

  @wire(getContext, { opportunityId: "$recordId" })
  wiredContext({ data, error }) {
    this.context = data;
    this.contextError = error;
  }

  get opportunityName() {
    return this.context?.opportunityName || "";
  }

  get isOpportunityLoading() {
    return !this.context && !this.contextError;
  }

  get opportunityErrorMessage() {
    if (this.contextError) {
      return this.reduceError(this.contextError);
    }
    return "";
  }

  get isOpenEmailDisabled() {
    return (
      this.isOpportunityLoading ||
      this.isSending ||
      !!this.opportunityErrorMessage ||
      !this.recipientEmail
    );
  }

  get sendButtonLabel() {
    return this.isSending ? "Sending" : "Send Email";
  }

  get exampleCheckoutLink() {
    if (!this.recordId) {
      return "";
    }
    return `${CHECKOUT_BASE_URL}?sf_opportunity_id=${encodeURIComponent(
      this.recordId
    )}`;
  }

  handleRecipientEmailChange(event) {
    this.recipientEmail = event.detail.value || "";
    this.validationMessage = "";
  }

  async handleSendEmail() {
    const inputs = [...this.template.querySelectorAll("lightning-input")];
    const isValid = inputs
      .map((input) => input.reportValidity())
      .every(Boolean);

    if (!isValid) {
      return;
    }

    this.isSending = true;
    this.validationMessage = "";
    try {
      await sendCheckoutEmail({
        opportunityId: this.recordId,
        recipientEmail: this.recipientEmail
      });
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Checkout email sent",
          message: `The checkout email was sent to ${this.recipientEmail}.`,
          variant: "success"
        })
      );
      this.handleCancel();
    } catch (error) {
      this.validationMessage = this.reduceError(error);
    } finally {
      this.isSending = false;
    }
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }

  reduceError(error) {
    console.error("wooCheckoutEmail error", error);

    if (!error) {
      return "Unknown error";
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
