import { api } from "lwc";
import LightningModal from "lightning/modal";
import searchProducts from "@salesforce/apex/MappaturaEdizioneProductSearch.searchProducts";
import getCategories from "@salesforce/apex/MappaturaEdizioneProductSearch.getCategories";
import findProductToMap from "@salesforce/apex/MappaturaEdizioneProductSearch.findProductToMap";

const SEARCH_DELAY_MS = 300;
const MAX_RESULTS = 50;

// New Mappatura Edizione form, in the standard Salesforce modal. Prodotto
// searches name, product code and Categoria_Articolo__c while typing;
// Categoria Prodotto lists the distinct Categoria_Articolo__c values, read live
// from Product2 each time the modal opens. A category alone is saved on one of
// its products, and the trigger maps the rest of the category to the campaign.
export default class MappaturaEdizioneNewModal extends LightningModal {
  @api campaignId;
  isActive = true;
  isSaving = false;
  saveAndNew = false;

  productTerm = "";
  productResults = [];
  selectedProduct;
  isProductOpen = false;
  isSearching = false;
  searchTimeout;

  categories = [];
  categoryTerm = "";
  selectedCategory;
  isCategoryOpen = false;

  connectedCallback() {
    this.loadCategories();
  }

  async loadCategories() {
    try {
      const data = await getCategories();
      this.categories = data.map((category) => ({
        code: category.code,
        title: category.description
          ? `${category.code} - ${category.description}`
          : category.code,
        meta: `${category.productCount} prodotti (${category.activeCount} attivi)`,
        searchText:
          `${category.code} ${category.description || ""}`.toLowerCase()
      }));
    } catch {
      this.categories = [];
    }
  }

  // ---------------------------------------------------------------- Prodotto

  get canSearchProducts() {
    return (
      Boolean(this.selectedCategory) || this.productTerm.trim().length >= 2
    );
  }

  get productComboboxClass() {
    return `slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click${
      this.isProductOpen && this.canSearchProducts ? " slds-is-open" : ""
    }`;
  }

  get productExpanded() {
    return String(this.isProductOpen && this.canSearchProducts);
  }

  get productPlaceholder() {
    return this.selectedCategory
      ? `Search Products in ${this.selectedCategory.code}...`
      : "Search Products...";
  }

  get showNoProducts() {
    return !this.isSearching && this.productResults.length === 0;
  }

  get showTooManyProducts() {
    return this.productResults.length >= MAX_RESULTS;
  }

  handleProductInput(event) {
    this.productTerm = event.target.value || "";
    this.isProductOpen = true;
    this.scheduleProductSearch();
  }

  handleProductFocus() {
    this.isProductOpen = true;
    if (this.selectedCategory && this.productResults.length === 0) {
      this.scheduleProductSearch();
    }
  }

  handleProductBlur() {
    this.isProductOpen = false;
  }

  scheduleProductSearch() {
    window.clearTimeout(this.searchTimeout);
    if (!this.canSearchProducts) {
      this.productResults = [];
      return;
    }
    this.isSearching = true;
    const term = this.productTerm;
    // eslint-disable-next-line @lwc/lwc/no-async-operation
    this.searchTimeout = window.setTimeout(() => {
      this.runProductSearch(term);
    }, SEARCH_DELAY_MS);
  }

  async runProductSearch(term) {
    try {
      const products = await searchProducts({
        searchTerm: term,
        category: this.selectedCategory ? this.selectedCategory.code : null
      });
      if (term !== this.productTerm) {
        return;
      }
      this.productResults = products.map((product) => ({
        ...product,
        meta: [
          product.productCode,
          product.category,
          product.isActive ? "attivo" : "non attivo"
        ]
          .filter(Boolean)
          .join(" · ")
      }));
    } catch {
      this.productResults = [];
    } finally {
      this.isSearching = false;
    }
  }

  // mousedown, not click: it fires before the input blur closes the list.
  handleProductSelect(event) {
    const productId = event.currentTarget.dataset.id;
    this.selectedProduct = this.productResults.find(
      (product) => product.id === productId
    );
    this.isProductOpen = false;
  }

  handleClearProduct() {
    this.selectedProduct = undefined;
    this.productTerm = "";
    this.productResults = [];
  }

  // ------------------------------------------------------- Categoria Prodotto

  get filteredCategories() {
    const term = this.categoryTerm.trim().toLowerCase();
    return term
      ? this.categories.filter((category) => category.searchText.includes(term))
      : this.categories;
  }

  get categoryComboboxClass() {
    return `slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click${
      this.isCategoryOpen ? " slds-is-open" : ""
    }`;
  }

  get categoryExpanded() {
    return String(this.isCategoryOpen);
  }

  get showNoCategories() {
    return this.filteredCategories.length === 0;
  }

  handleCategoryInput(event) {
    this.categoryTerm = event.target.value || "";
    this.isCategoryOpen = true;
  }

  handleCategoryFocus() {
    this.isCategoryOpen = true;
  }

  handleCategoryBlur() {
    this.isCategoryOpen = false;
  }

  handleCategorySelect(event) {
    const code = event.currentTarget.dataset.code;
    this.selectedCategory = this.categories.find(
      (category) => category.code === code
    );
    this.isCategoryOpen = false;
    // A product picked before must belong to the chosen category.
    if (
      this.selectedProduct &&
      (this.selectedProduct.category || "").toUpperCase() !== code
    ) {
      this.handleClearProduct();
    }
    this.productResults = [];
  }

  handleClearCategory() {
    this.selectedCategory = undefined;
    this.categoryTerm = "";
    this.productResults = [];
  }

  // -------------------------------------------------------------------- Save

  handleSave() {
    this.saveAndNew = false;
    this.submit();
  }

  handleSaveAndNew() {
    this.saveAndNew = true;
    this.submit();
  }

  async submit() {
    const inputFields = [
      ...this.template.querySelectorAll("lightning-input-field")
    ];
    const isValid = inputFields.every((field) => field.reportValidity());
    if (!isValid) {
      return;
    }
    const fields = {};
    inputFields.forEach((field) => {
      fields[field.fieldName] = field.value;
    });

    if (this.selectedProduct) {
      fields.Prodotto__c = this.selectedProduct.id;
    } else if (this.selectedCategory) {
      this.setSaving(true);
      try {
        fields.Prodotto__c = await findProductToMap({
          category: this.selectedCategory.code,
          campaignId: fields.Campagna__c
        });
      } catch {
        fields.Prodotto__c = null;
      }
      if (!fields.Prodotto__c) {
        this.setSaving(false);
        this.notifyError(
          `Tutti i prodotti della categoria ${this.selectedCategory.code} sono già mappati su questa campagna o in date sovrapposte.`
        );
        return;
      }
    } else {
      this.notifyError("Scegli un Prodotto oppure una Categoria Prodotto.");
      return;
    }

    this.setSaving(true);
    this.template.querySelector("lightning-record-edit-form").submit(fields);
  }

  setSaving(isSaving) {
    this.isSaving = isSaving;
    this.disableClose = isSaving;
  }

  handleSuccess(event) {
    this.setSaving(false);
    const saved = {
      recordId: event.detail.id,
      name: event.detail.fields?.Name?.value,
      category: this.selectedCategory
        ? this.selectedCategory.code
        : this.selectedProduct.category
    };
    // The opener shows the toast: events from a modal do not reach the page.
    this.dispatchEvent(new CustomEvent("saved", { detail: saved }));

    if (this.saveAndNew) {
      this.handleClearProduct();
      this.handleClearCategory();
      this.template
        .querySelectorAll("lightning-input-field")
        .forEach((field) => field.reset());
      return;
    }
    this.close(saved);
  }

  // Only the reason, in Italian, from the validation or trigger; not the
  // generic English heading the form puts above it.
  handleError(event) {
    this.setSaving(false);
    const output = event.detail?.output;
    const fieldMessages = Object.values(output?.fieldErrors || {})
      .flat()
      .map((error) => error.message);
    const messages = [
      ...(output?.errors || []).map((error) => error.message),
      ...fieldMessages
    ].filter(Boolean);
    this.notifyError(
      messages.length
        ? [...new Set(messages)].join(" ")
        : event.detail?.detail || event.detail?.message
    );
  }

  // The opener shows the toast: events from a modal do not reach the page.
  notifyError(message) {
    this.dispatchEvent(new CustomEvent("failed", { detail: { message } }));
  }

  handleCancel() {
    this.close();
  }
}
