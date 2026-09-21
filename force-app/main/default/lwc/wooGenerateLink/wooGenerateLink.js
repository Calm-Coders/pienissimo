import { api, LightningElement, wire } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getFieldValue, getRecord, updateRecord } from "lightning/uiRecordApi";
import ID_FIELD from "@salesforce/schema/Opportunity.Id";
import CHECKOUT_LINK_FIELD from "@salesforce/schema/Opportunity.Checkout_Link__c";

const CHECKOUT_BASE_URL = "https://shop.pienissimo.com/checkouts/";
const OPPORTUNITY_FIELDS = [CHECKOUT_LINK_FIELD];

export default class WooGenerateLink extends LightningElement {
  @api recordId;

  funnelWooCommerce = "";
  existingCheckoutLink = "";
  hasLoadedExistingLink = false;
  isSaving = false;

  @wire(getRecord, { recordId: "$recordId", fields: OPPORTUNITY_FIELDS })
  wiredOpportunity({ data }) {
    if (!data || this.hasLoadedExistingLink) {
      return;
    }

    this.hasLoadedExistingLink = true;
    this.existingCheckoutLink =
      getFieldValue(data, CHECKOUT_LINK_FIELD)?.trim() || "";

    if (this.existingCheckoutLink) {
      this.funnelWooCommerce = this.extractFunnel(this.existingCheckoutLink);
    }
  }

  get hasExistingCheckoutLink() {
    return !!this.existingCheckoutLink;
  }

  get newCheckoutLink() {
    const funnelPath = this.normalizeFunnelPath(this.funnelWooCommerce);
    if (!this.recordId || !funnelPath) {
      return "";
    }

    const params = new URLSearchParams({
      sf_opp_id: this.recordId
    });
    return `${CHECKOUT_BASE_URL}${funnelPath}/?${params.toString()}`;
  }

  get isSaveDisabled() {
    return this.isSaving || !this.newCheckoutLink;
  }

  get saveButtonLabel() {
    return this.isSaving ? "Salvataggio..." : "Salva link";
  }

  handleProductIdChange(event) {
    this.funnelWooCommerce = event.detail.value || "";
  }

  async handleSave() {
    const input = this.template.querySelector("lightning-input");
    if (!input.reportValidity()) {
      return;
    }

    this.isSaving = true;
    try {
      await updateRecord({
        fields: {
          [ID_FIELD.fieldApiName]: this.recordId,
          [CHECKOUT_LINK_FIELD.fieldApiName]: this.newCheckoutLink
        }
      });
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Link checkout salvato",
          message: "Il link e ora disponibile per l'email di checkout.",
          variant: "success"
        })
      );
      this.handleCancel();
    } catch {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Impossibile salvare il link",
          message: "Controlla i permessi sul campo e riprova.",
          variant: "error"
        })
      );
    } finally {
      this.isSaving = false;
    }
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }

  normalizeFunnelPath(funnel) {
    return funnel
      .trim()
      .replace(/^https?:\/\/[^/]+\/checkouts\//i, "")
      .replace(/[?#].*$/, "")
      .replace(/^\/+|\/+$/g, "")
      .split("/")
      .filter(Boolean)
      .map((pathPart) => encodeURIComponent(decodeURIComponent(pathPart)))
      .join("/");
  }

  extractFunnel(checkoutLink) {
    try {
      const url = new URL(checkoutLink);
      const match = url.pathname.match(/\/checkouts\/([^?#]+)/i);
      if (match) {
        return decodeURIComponent(match[1].replace(/\/+$/g, ""));
      }

      return url.searchParams.get("add-to-cart") || "";
    } catch {
      const funnelMatch = checkoutLink.match(/\/checkouts\/([^?#]+)/i);
      if (funnelMatch) {
        return decodeURIComponent(funnelMatch[1].replace(/\/+$/g, ""));
      }

      const productMatch = checkoutLink.match(/[?&]add-to-cart=([^&]+)/);
      return productMatch
        ? decodeURIComponent(productMatch[1].replace(/\+/g, " "))
        : "";
    }
  }
}
