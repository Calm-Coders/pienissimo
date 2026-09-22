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
  isPickerOpen = false;
  hasLoaded = false;
  quoteName = "";
  quoteStatus = "";
  isEditable = false;
  hasItemLines = false;
  opportunityRecordTypeDeveloperName = "";
  hasPlusLine = false;
  existingBundleLine;
  existingProducts = [];
  productOptions = [];
  selectedProducts = [];
  trancheCount = "";
  plannedTranches = [];
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

  get hasExistingProducts() {
    return this.existingProducts.length > 0;
  }

  get showExistingProducts() {
    return !this.isPickerOpen && this.hasExistingProducts;
  }

  get showNewSelection() {
    return !this.isPickerOpen && this.hasSelectedProducts;
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
      (this.isPlusOpportunity && !this.hasValidPlannedTranches) ||
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
      return "Questo preventivo puo contenere un solo prodotto Item Plus con tranche pianificate.";
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

  get showTranchePlanner() {
    return (
      this.isPlusOpportunity && !this.isPickerOpen && this.hasSelectedProducts
    );
  }

  get hasPlannedTranches() {
    return this.plannedTranches.length > 0;
  }

  get hasValidPlannedTranches() {
    const count = Number(this.trancheCount);
    return (
      Number.isInteger(count) &&
      count > 0 &&
      count <= 20 &&
      this.plannedTranches.length === count &&
      this.plannedTranches.every((tranche) => !!tranche.dueDate)
    );
  }

  get showNoResultsMessage() {
    return (
      this.hasLoaded &&
      !this.isSearching &&
      !this.hasProductOptions &&
      this.isPickerOpen &&
      !this.isFormDisabled
    );
  }

  get addProductsDisabled() {
    return this.isFormDisabled || this.isLoading || this.saveInProgress;
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
      this.existingProducts = this.decorateExistingProducts(
        context.existingLines || []
      );
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

  handleOpenPicker() {
    if (this.addProductsDisabled) {
      return;
    }
    this.isPickerOpen = true;
    this.searchTerm = "";
    this.runSearch();
  }

  handleClosePicker() {
    this.isPickerOpen = false;
    this.closeProductList();
  }

  async runSearch() {
    const currentSearchTerm = this.searchTerm.trim();
    const currentRequestId = ++this.searchRequestId;

    if (this.isSearchDisabled) {
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
      this.productOptions = this.decorateOptions(
        this.excludeExistingProducts(results || [])
      );
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
    if (!option) {
      return;
    }

    if (option.isSelected) {
      this.removeSelectedProduct(pricebookEntryId);
      this.productOptions = this.decorateOptions(this.productOptions);
      return;
    }

    if (option.isDisabled) {
      return;
    }

    if (this.isPlusOpportunity) {
      this.selectedProducts = [
        {
          ...option,
          rowKey: option.pricebookEntryId,
          isExisting: false,
          rowStatus: "Da aggiungere",
          quantity: 1,
          quantityDisabled: true
        }
      ];
      this.rebuildPlannedTranches();
    } else if (option.productType === BUNDLE_TYPE) {
      this.selectedProducts = [
        {
          ...option,
          rowKey: option.pricebookEntryId,
          isExisting: false,
          rowStatus: "Da aggiungere",
          quantity: 1,
          quantityDisabled: true
        }
      ];
    } else {
      this.selectedProducts = [
        ...this.selectedProducts,
        {
          ...option,
          rowKey: option.pricebookEntryId,
          isExisting: false,
          rowStatus: "Da aggiungere",
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
    this.removeSelectedProduct(pricebookEntryId);
    this.productOptions = this.decorateOptions(this.productOptions);
  }

  handleTrancheCountChange(event) {
    this.trancheCount = event.detail.value;
    this.rebuildPlannedTranches();
  }

  handleTrancheDueDateChange(event) {
    const index = Number(event.target.dataset.index);
    this.plannedTranches = this.plannedTranches.map((tranche) => {
      if (tranche.index === index) {
        return { ...tranche, dueDate: event.detail.value };
      }
      return tranche;
    });
  }

  async handleSave() {
    if (this.isPrimaryDisabled || this.saveInProgress) {
      return;
    }

    const inputs = [...this.template.querySelectorAll("lightning-input")];
    if (!inputs.every((input) => input.reportValidity())) {
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
        })),
        tranches: this.isPlusOpportunity
          ? this.plannedTranches.map((tranche) => ({
              dueDate: tranche.dueDate
            }))
          : null
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

  closeProductList() {
    this.searchRequestId += 1;
    this.searchTerm = "";
    this.productOptions = [];
    this.isSearching = false;
  }

  removeSelectedProduct(pricebookEntryId) {
    this.selectedProducts = this.selectedProducts.filter(
      (product) => product.pricebookEntryId !== pricebookEntryId
    );
    if (this.isPlusOpportunity) {
      this.trancheCount = "";
      this.plannedTranches = [];
    }
  }

  excludeExistingProducts(options) {
    const selectedIds = new Set(
      this.existingProducts.map((product) => product.pricebookEntryId)
    );
    return options.filter(
      (option) => !selectedIds.has(option.pricebookEntryId)
    );
  }

  decorateExistingProducts(lines) {
    return lines.map((line) => ({
      pricebookEntryId: line.pricebookEntryId,
      quoteLineItemId: line.quoteLineItemId,
      rowKey: line.quoteLineItemId,
      productName: line.productName || "Prodotto senza nome",
      productCode: line.productCode || "Nessun codice",
      productType: line.productType,
      typeLabel:
        line.isPlus === true
          ? "Plus"
          : line.productType === BUNDLE_TYPE
            ? "Bundle"
            : "Item",
      isPlus: line.isPlus === true,
      unitPrice: line.unitPrice,
      quantity: line.quantity,
      quantityDisabled: true,
      isExisting: true,
      rowStatus: "Gia nel preventivo"
    }));
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
        !isSelected && (typeConflict || plusConflict || pricebookConflict);
      return {
        ...option,
        isSelected,
        isDisabled,
        typeLabel:
          option.isPlus === true
            ? "Plus"
            : option.productType === BUNDLE_TYPE
              ? "Bundle"
              : "Item",
        buttonClass: isSelected ? "option selected removable" : "option"
      };
    });
  }

  rebuildPlannedTranches() {
    const count = Number(this.trancheCount);
    if (!Number.isInteger(count) || count < 1 || count > 20) {
      this.plannedTranches = [];
      return;
    }

    const existingByIndex = new Map(
      this.plannedTranches.map((tranche) => [tranche.index, tranche])
    );
    const amounts = this.splitSelectedProductTotal(count);
    this.plannedTranches = Array.from({ length: count }, (_, index) => {
      const sequence = index + 1;
      return {
        key: `plus-tranche-${sequence}`,
        index,
        sequence,
        amount: amounts[index],
        amountLabel: this.formatAmount(amounts[index]),
        dueDate: existingByIndex.get(index)?.dueDate || ""
      };
    });
  }

  splitSelectedProductTotal(count) {
    const total = Number(this.selectedProducts[0]?.unitPrice || 0);
    const totalCents = Math.round(total * 100);
    const baseCents = Math.floor(totalCents / count);
    const amounts = [];
    for (let index = 0; index < count; index += 1) {
      const cents =
        index === count - 1 ? totalCents - baseCents * (count - 1) : baseCents;
      amounts.push(cents / 100);
    }
    return amounts;
  }

  formatAmount(value) {
    return new Intl.NumberFormat(undefined, {
      style: "currency",
      currency: "EUR"
    }).format(value || 0);
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
      for (const fieldName of Object.keys(body.fieldErrors)) {
        messages.push(
          ...body.fieldErrors[fieldName]
            .map((entry) => entry?.message)
            .filter(Boolean)
        );
      }
    }

    if (Array.isArray(body?.output?.errors)) {
      messages.push(
        ...body.output.errors.map((entry) => entry?.message).filter(Boolean)
      );
    }

    if (body?.output?.fieldErrors) {
      for (const fieldName of Object.keys(body.output.fieldErrors)) {
        messages.push(
          ...body.output.fieldErrors[fieldName]
            .map((entry) => entry?.message)
            .filter(Boolean)
        );
      }
    }

    if (error.message) {
      messages.push(error.message);
    }

    return messages.filter(Boolean).join(" | ") || "Errore inatteso";
  }
}
