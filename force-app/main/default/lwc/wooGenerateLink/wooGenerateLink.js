import { api, LightningElement, wire } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getFieldValue, getRecord, updateRecord } from "lightning/uiRecordApi";
import ID_FIELD from "@salesforce/schema/Opportunity.Id";
import CHECKOUT_LINK_FIELD from "@salesforce/schema/Opportunity.Checkout_Link__c";

const CHECKOUT_BASE_URL = "https://www.pienissimo.it/checkout";
const OPPORTUNITY_FIELDS = [CHECKOUT_LINK_FIELD];

export default class WooGenerateLink extends LightningElement {
  @api recordId;

  productWooCommerceId = "";
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
      this.productWooCommerceId = this.extractProductId(
        this.existingCheckoutLink
      );
    }
  }

  get hasExistingCheckoutLink() {
    return !!this.existingCheckoutLink;
  }

  get newCheckoutLink() {
    const productId = this.productWooCommerceId.trim();
    if (!this.recordId || !productId) {
      return "";
    }

    const params = new URLSearchParams({
      "add-to-cart": productId,
      sf_opportunity_id: this.recordId
    });
    return `${CHECKOUT_BASE_URL}?${params.toString()}`;
  }

  get isSaveDisabled() {
    return this.isSaving || !this.newCheckoutLink;
  }

  get saveButtonLabel() {
    return this.isSaving ? "Saving" : "Save Link";
  }

  handleProductIdChange(event) {
    this.productWooCommerceId = event.detail.value || "";
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
          title: "Checkout link saved",
          message: "The link is now available for the checkout email.",
          variant: "success"
        })
      );
      this.handleCancel();
    } catch {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Unable to save link",
          message: "Check your field permissions and try again.",
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

  extractProductId(checkoutLink) {
    try {
      return new URL(checkoutLink).searchParams.get("add-to-cart") || "";
    } catch {
      const match = checkoutLink.match(/[?&]add-to-cart=([^&]+)/);
      return match ? decodeURIComponent(match[1].replace(/\+/g, " ")) : "";
    }
  }
}
