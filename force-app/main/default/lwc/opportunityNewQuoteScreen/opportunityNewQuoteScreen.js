import { api, LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import createQuote from "@salesforce/apex/OpportunityQuoteDefaultsController.createQuote";
import getDefaults from "@salesforce/apex/OpportunityQuoteDefaultsController.getDefaults";

export default class OpportunityNewQuoteScreen extends NavigationMixin(
  LightningElement
) {
  _recordId;
  hasLoaded = false;
  form = {};
  errorMessage = "";
  isLoading = true;
  isSaving = false;

  @api
  get recordId() {
    return this._recordId;
  }

  set recordId(value) {
    this._recordId = value;
    this.loadDefaults();
  }

  async loadDefaults() {
    if (!this._recordId || this.hasLoaded) {
      return;
    }

    this.hasLoaded = true;
    this.isLoading = true;
    try {
      const defaults = await getDefaults({ opportunityId: this._recordId });
      this.form = {
        quoteName: defaults?.quoteName || "",
        opportunityName: defaults?.opportunityName || "",
        accountName: defaults?.accountName || "",
        status: defaults?.status || "",
        isPrimary: defaults?.isPrimary === true,
        expirationDate: "",
        localeId: defaults?.localeId || null,
        billingStreet: defaults?.billingStreet || "",
        billingCity: defaults?.billingCity || "",
        billingState: defaults?.billingState || "",
        billingPostalCode: defaults?.billingPostalCode || "",
        billingCountry: defaults?.billingCountry || "",
        shippingStreet: defaults?.shippingStreet || "",
        shippingCity: defaults?.shippingCity || "",
        shippingState: defaults?.shippingState || "",
        shippingPostalCode: defaults?.shippingPostalCode || "",
        shippingCountry: defaults?.shippingCountry || ""
      };
    } catch (error) {
      this.errorMessage = this.reduceError(error);
    } finally {
      this.isLoading = false;
    }
  }

  get saveButtonLabel() {
    return this.isSaving ? "Saving" : "Save";
  }

  get isSaveDisabled() {
    return (
      this.isLoading || this.isSaving || !this._recordId || !this.form.quoteName
    );
  }

  handleInputChange(event) {
    const fieldName = event.target.dataset.field;
    this.form = {
      ...this.form,
      [fieldName]:
        event.target.type === "checkbox"
          ? event.target.checked
          : (event.detail?.value ?? event.target.value ?? "")
    };
  }

  async handleSave() {
    this.syncFormFromInputs();
    const inputs = [
      ...this.template.querySelectorAll("lightning-input, lightning-textarea")
    ];
    const isValid = inputs
      .map((input) => input.reportValidity())
      .every(Boolean);

    if (!isValid) {
      return;
    }

    this.isSaving = true;
    try {
      const quoteId = await createQuote({
        opportunityId: this._recordId,
        input: this.buildQuoteInput()
      });
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Preventivo creato",
          message: "Il preventivo e stato creato.",
          variant: "success"
        })
      );
      this.dispatchEvent(new CloseActionScreenEvent());
      this[NavigationMixin.Navigate]({
        type: "standard__recordPage",
        attributes: {
          recordId: quoteId,
          objectApiName: "Quote",
          actionName: "view"
        }
      });
    } catch (error) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Nuovo Preventivo",
          message: this.reduceError(error),
          variant: "error"
        })
      );
    } finally {
      this.isSaving = false;
    }
  }

  syncFormFromInputs() {
    const values = { ...this.form };
    const fields = [...this.template.querySelectorAll("[data-field]")];
    fields.forEach((field) => {
      const fieldName = field.dataset?.field;
      if (fieldName) {
        values[fieldName] =
          field.type === "checkbox" ? field.checked : (field.value ?? "");
      }
    });
    this.form = values;
  }

  buildQuoteInput() {
    return {
      quoteName: this.form.quoteName,
      isPrimary: this.form.isPrimary === true,
      expirationDate: this.form.expirationDate || null,
      accountName: this.form.accountName,
      localeId: this.form.localeId,
      billingStreet: this.form.billingStreet,
      billingCity: this.form.billingCity,
      billingState: this.form.billingState,
      billingPostalCode: this.form.billingPostalCode,
      billingCountry: this.form.billingCountry,
      shippingStreet: this.form.shippingStreet,
      shippingCity: this.form.shippingCity,
      shippingState: this.form.shippingState,
      shippingPostalCode: this.form.shippingPostalCode,
      shippingCountry: this.form.shippingCountry
    };
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }

  reduceError(error) {
    const body = error?.body ?? error;
    if (body?.message) {
      return body.message;
    }
    if (error?.message) {
      return error.message;
    }
    return "Impossibile aprire il nuovo preventivo.";
  }
}
