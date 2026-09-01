import { api, LightningElement, wire } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { NavigationMixin } from "lightning/navigation";
import { encodeDefaultFieldValues } from "lightning/pageReferenceUtils";
import getContext from "@salesforce/apex/WooCheckoutEmailController.getContext";

const DEFAULT_FUNNEL_URL = "https://www.pienissimo.it/checkout";
const EMAIL_SUBJECT = "Completa il tuo ordine Pienissimo";

export default class WooCheckoutEmail extends NavigationMixin(
  LightningElement
) {
  @api recordId;

  funnelUrl = DEFAULT_FUNNEL_URL;
  validationMessage = "";
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

  get checkoutLink() {
    return this.buildCheckoutLink();
  }

  get emailSubject() {
    return EMAIL_SUBJECT;
  }

  get emailBody() {
    return this.buildEmailBody();
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
      !!this.opportunityErrorMessage ||
      !this.funnelUrl ||
      !this.checkoutLink
    );
  }

  handleFunnelUrlChange(event) {
    this.funnelUrl = event.detail.value || "";
    this.validationMessage = "";
  }

  handleOpenEmailComposer() {
    const inputs = [...this.template.querySelectorAll("lightning-input")];
    const isValid = inputs
      .map((input) => input.reportValidity())
      .every(Boolean);

    if (!isValid) {
      return;
    }
    if (!this.checkoutLink) {
      this.validationMessage = "The checkout link could not be generated.";
      return;
    }

    const defaultFieldValues = encodeDefaultFieldValues({
      Subject: EMAIL_SUBJECT,
      HTMLBody: this.emailBody,
      RelatedToId: this.recordId
    });

    this[NavigationMixin.Navigate]({
      type: "standard__quickAction",
      attributes: {
        apiName: "Global.SendEmail"
      },
      state: {
        recordId: this.recordId,
        defaultFieldValues
      }
    });

    this.handleCancel();
  }

  buildCheckoutLink() {
    const baseUrl = (this.funnelUrl || "").trim();
    if (!baseUrl || !this.recordId) {
      return "";
    }

    const opportunityId = this.recordId.substring(0, 15);
    const separator = baseUrl.includes("?") ? "&" : "?";
    return `${baseUrl}${separator}sf_opportunity_id=${encodeURIComponent(
      opportunityId
    )}`;
  }

  buildEmailBody() {
    const escapedLink = this.escapeHtml(this.checkoutLink);

    return [
      "<p>Gentile cliente,</p>",
      "<p>puoi completare l&apos;ordine Pienissimo dal link qui sotto:</p>",
      `<p><a href="${escapedLink}">Completa l&apos;ordine</a></p>`,
      "<p>Grazie.</p>"
    ].join("");
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

  escapeHtml(value) {
    return String(value || "")
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;");
  }
}
