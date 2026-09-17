import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";
import getContext from "@salesforce/apex/QuoteManageProductsController.getContext";
import saveProducts from "@salesforce/apex/QuoteManageProductsController.saveProducts";
import searchProducts from "@salesforce/apex/QuoteManageProductsController.searchProducts";

const BUNDLE_TYPE = "Bundle";
const ITEM_TYPE = "Item";
const PLUS_OPPORTUNITY_RECORD_TYPE = "Plus_Attivazione_Rinnovo";
const STANDARD_OPPORTUNITY_RECORD_TYPE = "Standart";

export default class QuoteManageProducts extends LightningElement {
  _recordId;
  searchRequestId = 0;
  saveInProgress = false;

  isLoading = false;
  isSearching = false;
  hasLoaded = false;
  quoteName = "";
  quoteStatus = "";
  isEditable = false;
  hasItemLines = false;
  opportunityRecordTypeDeveloperName = "";
  hasPlusLine = false;
  existingBundleLine;
  productOptions = [];
  selectedProducts = [];
  searchTerm = "";

  @api
  get recordId() {
    return this._recordId;
  }

  set recordId(value) {
    this._recordId = value;
    if (value) {
      this.loadContext();
    }
  }

  get showInitialLoader() {
    return !this.hasLoaded && this.isLoading;
  }

  get hasExistingBundle() {
    return !!this.existingBundleLine;
  }

  get hasProductOptions() {
    return this.productOptions.length > 0;
  }

  get hasSelectedProducts() {
    return this.selectedProducts.length > 0;
  }

  get isFormDisabled() {
    return (
      !this.isEditable ||
      this.hasExistingBundle ||
      (this.isPlusOpportunity && this.hasPlusLine)
    );
  }

  get isSearchDisabled() {
    return this.isFormDisabled;
  }

  get isPrimaryDisabled() {
    return (
      this.isFormDisabled ||
      this.isLoading ||
      this.saveInProgress ||
      !this.hasSelectedProducts ||
      this.selectedProducts.some(
        (product) => !product.quantity || Number(product.quantity) <= 0
      )
    );
  }

  get showTypeHelp() {
    return (
      !this.isPlusOpportunity && !this.hasExistingBundle && !this.hasItemLines
    );
  }

  get isPlusOpportunity() {
    return (
      this.opportunityRecordTypeDeveloperName === PLUS_OPPORTUNITY_RECORD_TYPE
    );
  }

  get isStandardOpportunity() {
    return (
      this.opportunityRecordTypeDeveloperName ===
      STANDARD_OPPORTUNITY_RECORD_TYPE
    );
  }

  get showPlusLineMessage() {
    return this.isPlusOpportunity && this.hasPlusLine;
  }

  get showItemLinesHelp() {
    return !this.isPlusOpportunity && this.hasItemLines;
  }

  get modeMessage() {
    if (this.isPlusOpportunity) {
      return "Questo preventivo puo contenere un solo prodotto Plus.";
    }
    if (this.hasItemLines) {
      return "Questo preventivo contiene prodotti Item. Puoi aggiungere solo altri prodotti Item.";
    }
    if (!this.hasExistingBundle) {
      return "Se selezioni un bundle, il preventivo non potra contenere prodotti Item.";
    }
    return "";
  }

  get hasModeMessage() {
    return !!this.modeMessage && !this.showPlusLineMessage;
  }

  get showNoResultsMessage() {
    return (
      this.hasLoaded &&
      !this.isSearching &&
      !this.hasProductOptions &&
      this.searchTerm.trim().length >= 2 &&
      !this.isFormDisabled
    );
  }

  get statusClass() {
    return this.isEditable ? "status-pill editable" : "status-pill locked";
  }

  async loadContext() {
    this.isLoading = true;
    try {
      const context = await getContext({ quoteId: this.recordId });
      this.quoteName = context.quoteName || "";
      this.quoteStatus = context.quoteStatus || "";
      this.isEditable = context.isEditable === true;
      this.hasItemLines = context.hasItemLines === true;
      this.opportunityRecordTypeDeveloperName =
        context.opportunityRecordTypeDeveloperName || "";
      this.hasPlusLine = context.hasPlusLine === true;
      this.existingBundleLine = context.existingBundleLine || null;
    } catch (error) {
      this.showError(error);
    } finally {
      this.hasLoaded = true;
      this.isLoading = false;
    }
  }

  handleSearchChange(event) {
    this.searchTerm = event.target.value || "";
    this.runSearch();
  }

  async runSearch() {
    const currentSearchTerm = this.searchTerm.trim();
    const currentRequestId = ++this.searchRequestId;

    if (this.isSearchDisabled || currentSearchTerm.length < 2) {
      this.productOptions = [];
      return;
    }

    this.isSearching = true;
    try {
      const results = await searchProducts({
        quoteId: this.recordId,
        searchTerm: currentSearchTerm
      });
      if (currentRequestId !== this.searchRequestId) {
        return;
      }
      this.productOptions = this.decorateOptions(results || []);
    } catch (error) {
      this.showError(error);
    } finally {
      if (currentRequestId === this.searchRequestId) {
        this.isSearching = false;
      }
    }
  }

  handleSelectProduct(event) {
    const pricebookEntryId = event.currentTarget.dataset.id;
    const option = this.productOptions.find(
      (candidate) => candidate.pricebookEntryId === pricebookEntryId
    );
    if (!option || option.isDisabled) {
      return;
    }

    if (this.isPlusOpportunity) {
      this.selectedProducts = [
        {
          ...option,
          quantity: 1,
          quantityDisabled: true
        }
      ];
    } else if (option.productType === BUNDLE_TYPE) {
      this.selectedProducts = [
        {
          ...option,
          quantity: 1,
          quantityDisabled: true
        }
      ];
    } else {
      this.selectedProducts = [
        ...this.selectedProducts,
        {
          ...option,
          quantity: 1,
          quantityDisabled: false
        }
      ];
    }

    this.productOptions = this.decorateOptions(this.productOptions);
  }

  handleQuantityChange(event) {
    const pricebookEntryId = event.target.dataset.id;
    const quantity = event.target.value;
    this.selectedProducts = this.selectedProducts.map((product) => {
      if (product.pricebookEntryId === pricebookEntryId) {
        return { ...product, quantity };
      }
      return product;
    });
  }

  handleRemoveProduct(event) {
    const pricebookEntryId = event.currentTarget.dataset.id;
    this.selectedProducts = this.selectedProducts.filter(
      (product) => product.pricebookEntryId !== pricebookEntryId
    );
    this.productOptions = this.decorateOptions(this.productOptions);
  }

  async handleSave() {
    if (this.isPrimaryDisabled || this.saveInProgress) {
      return;
    }

    this.saveInProgress = true;
    this.isLoading = true;
    try {
      await saveProducts({
        quoteId: this.recordId,
        products: this.selectedProducts.map((product) => ({
          pricebookEntryId: product.pricebookEntryId,
          quantity: Number(product.quantity)
        }))
      });

      this.dispatchEvent(
        new ShowToastEvent({
          title: "Prodotti salvati",
          message: "I prodotti sono stati aggiunti al preventivo.",
          variant: "success"
        })
      );
      await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
      this.dispatchEvent(new RefreshEvent());
      this.dispatchEvent(new CloseActionScreenEvent());
    } catch (error) {
      this.showError(error);
    } finally {
      this.isLoading = false;
      this.saveInProgress = false;
    }
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }

  decorateOptions(options) {
    const selectedIds = new Set(
      this.selectedProducts.map((product) => product.pricebookEntryId)
    );
    const hasSelectedBundle = this.selectedProducts.some(
      (product) => product.productType === BUNDLE_TYPE
    );
    const hasSelectedItems = this.selectedProducts.some(
      (product) => product.productType === ITEM_TYPE
    );
    const hasSelectedPlus = this.selectedProducts.some(
      (product) => product.isPlus === true
    );
    const selectedPricebook2Id = this.selectedProducts[0]?.pricebook2Id;

    return options.map((option) => {
      const isSelected = selectedIds.has(option.pricebookEntryId);
      const typeConflict =
        (hasSelectedBundle && option.productType === ITEM_TYPE) ||
        (hasSelectedItems && option.productType === BUNDLE_TYPE);
      const plusConflict = this.isPlusOpportunity && hasSelectedPlus;
      const pricebookConflict =
        selectedPricebook2Id && option.pricebook2Id !== selectedPricebook2Id;
      const isDisabled =
        isSelected || typeConflict || plusConflict || pricebookConflict;
      return {
        ...option,
        isDisabled,
        typeLabel:
          option.isPlus === true
            ? "Plus"
            : option.productType === BUNDLE_TYPE
              ? "Bundle"
              : "Item",
        buttonClass: isSelected ? "option selected" : "option"
      };
    });
  }

  showError(error) {
    this.dispatchEvent(
      new ShowToastEvent({
        title: "Errore",
        message: this.reduceError(error),
        variant: "error"
      })
    );
  }

  reduceError(error) {
    if (Array.isArray(error?.body)) {
      return error.body.map((entry) => entry.message).join(", ");
    }
    return error?.body?.message || error?.message || "Errore inatteso";
  }
}
