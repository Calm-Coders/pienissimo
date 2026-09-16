import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import LightningConfirm from "lightning/confirm";
import getBundleContext from "@salesforce/apex/BundleProductAssignmentController.getBundleContext";
import searchProducts from "@salesforce/apex/BundleProductAssignmentController.searchProducts";
import saveComponents from "@salesforce/apex/BundleProductAssignmentController.saveComponents";
import { validRows } from "./pricing";

const currency = { currencyCode: "EUR", minimumFractionDigits: 2 };
export default class BundleProductAssignment extends LightningElement {
  componentColumns = [
    { label: "Prodotto", fieldName: "name", wrapText: true },
    { label: "Codice", fieldName: "productCode" },
    {
      label: "Quantita",
      fieldName: "quantity",
      type: "number",
      editable: true,
      initialWidth: 95
    },
    {
      label: "Listino riga",
      fieldName: "lineListPrice",
      type: "currency",
      typeAttributes: currency
    },
    {
      label: "Importo assegnato alla riga",
      fieldName: "spreadPrice",
      type: "currency",
      typeAttributes: currency,
      editable: true
    },
    {
      label: "Importo per unita",
      fieldName: "unitSpread",
      type: "currency",
      typeAttributes: currency
    },
    { label: "Sconto", fieldName: "discountLabel" },
    {
      type: "button-icon",
      fixedWidth: 44,
      typeAttributes: {
        iconName: "utility:delete",
        name: "remove",
        alternativeText: "Rimuovi",
        variant: "bare"
      }
    }
  ];
  productColumns = [
    { label: "Prodotto", fieldName: "name", wrapText: true },
    { label: "Codice", fieldName: "productCode" },
    {
      label: "Listino unitario",
      fieldName: "productPrice",
      type: "currency",
      typeAttributes: currency
    },
    {
      type: "button",
      typeAttributes: {
        label: "Scegli",
        name: "choose",
        variant: "brand-outline"
      }
    }
  ];
  _recordId;
  isLoading = false;
  hasLoaded = false;
  isPickerOpen = false;
  isSearching = false;
  errorMessage = "";
  searchError = "";
  bundleName = "";
  fixedPrice = 0;
  rows = [];
  savedRows = [];
  products = [];
  selectedProducts = [];
  searchTerm = "";
  isChoosingProduct = true;
  hasMore = false;
  nextCursor;
  searchVersion = 0;
  contextVersion = 0;
  isDirty = false;

  @api
  get recordId() {
    return this._recordId;
  }
  set recordId(value) {
    if (value && value !== this._recordId) {
      this._recordId = value;
      this.loadContext();
    }
  }

  get spreadTotal() {
    return [...this.rows, ...this.selectedProducts].reduce(
      (sum, row) => sum + (Number(row.spreadPrice) || 0),
      0
    );
  }
  get variance() {
    return Math.round((this.fixedPrice - this.spreadTotal) * 100) / 100;
  }
  get absoluteVariance() {
    return Math.abs(this.variance);
  }
  get isReconciled() {
    return this.variance === 0;
  }
  get varianceLabel() {
    return this.variance < 0 ? "Assegnato in eccesso" : "Da assegnare";
  }
  get varianceClass() {
    return this.isReconciled ? "variance reconciled" : "variance drifted";
  }
  get varianceMessage() {
    if (this.isReconciled)
      return "Il totale assegnato corrisponde al prezzo del bundle.";
    return this.variance > 0
      ? "Resta una parte del prezzo da assegnare ai prodotti."
      : "Gli importi assegnati superano il prezzo del bundle.";
  }
  get hasRows() {
    return this.rows.length > 0;
  }
  get showMainView() {
    return !this.isPickerOpen;
  }
  get panelHeader() {
    return this.isPickerOpen
      ? "Aggiungi prodotti"
      : "Configura componenti bundle";
  }
  get saveDisabled() {
    return this.isLoading || !this.hasLoaded;
  }
  get addSelectionDisabled() {
    return this.selectedProducts.length === 0 || this.isLoading;
  }
  get hasSelection() {
    return this.selectedProducts.length > 0;
  }
  get selectionLabel() {
    return "Aggiungi tutti (" + this.selectedProducts.length + ")";
  }
  get selectedLabel() {
    return "Prodotti da aggiungere (" + this.selectedProducts.length + ")";
  }
  get resultLabel() {
    return this.products.length + " prodotti visualizzati";
  }
  get componentLabel() {
    return "Componenti (" + this.rows.length + ")";
  }
  get hasProducts() {
    return this.products.length > 0;
  }
  get showNoProducts() {
    return !this.isSearching && !this.searchError && !this.hasProducts;
  }
  get pendingLabel() {
    return this.isDirty
      ? "Modifiche da salvare"
      : "Nessuna modifica in sospeso";
  }

  async loadContext() {
    const version = ++this.contextVersion;
    this.isLoading = true;
    this.hasLoaded = false;
    this.errorMessage = "";
    try {
      const context = await getBundleContext({ bundleId: this.recordId });
      if (version !== this.contextVersion) return;
      this.applyContext(context);
      this.hasLoaded = true;
    } catch (error) {
      if (version === this.contextVersion)
        this.errorMessage = this.reduceError(error);
    } finally {
      if (version === this.contextVersion) this.isLoading = false;
    }
  }
  applyContext(context) {
    this.bundleName = context.bundleName;
    this.fixedPrice = Number(context.fixedPrice) || 0;
    this.rows = (context.components || []).map((row) => this.decorate(row));
    this.savedRows = this.rows.map((row) => ({ ...row }));
    this.isDirty = false;
  }
  decorate(row) {
    const quantity = Number(row.quantity);
    const spreadPrice = Number(row.spreadPrice);
    const lineListPrice = (Number(row.listPrice) || 0) * quantity;
    return {
      ...row,
      quantity,
      spreadPrice,
      lineListPrice,
      unitSpread: quantity > 0 ? spreadPrice / quantity : 0,
      key: row.id || "new-" + row.productId,
      discountLabel:
        lineListPrice === 0
          ? "-"
          : ((1 - spreadPrice / lineListPrice) * 100).toFixed(2) + "%"
    };
  }
  handleCellChange(event) {
    const drafts = new Map(
      event.detail.draftValues.map((draft) => [draft.key, draft])
    );
    this.rows = this.rows.map((row) =>
      this.decorate({ ...row, ...(drafts.get(row.key) || {}) })
    );
    this.isDirty = true;
    const table = this.template.querySelector('[data-id="components"]');
    if (table) table.draftValues = [];
  }
  handleRowAction(event) {
    if (event.detail.action.name === "remove") {
      this.rows = this.rows.filter((row) => row.key !== event.detail.row.key);
      this.isDirty = true;
    }
  }
  handleAddComponent() {
    this.isPickerOpen = true;
    this.selectedProducts = [];
    this.searchTerm = "";
    this.isChoosingProduct = true;
    this.fetchProducts();
  }
  async handleBack() {
    if (this.isLoading) return;
    if (this.hasSelection) {
      this.isLoading = true;
      try {
        const confirmed = await LightningConfirm.open({
          label: "Scartare i prodotti da aggiungere?",
          message:
            "Le quantita e i prezzi inseriti in questa pagina saranno persi.",
          theme: "warning"
        });
        if (!confirmed) return;
      } finally {
        this.isLoading = false;
      }
    }
    this.closePicker();
  }
  closePicker() {
    ++this.searchVersion;
    this.isSearching = false;
    this.isPickerOpen = false;
    this.selectedProducts = [];
  }
  handleSearchInput(event) {
    this.searchTerm = event.target.value;
    this.fetchProducts();
  }
  handleRetrySearch() {
    this.fetchProducts();
  }
  handleLoadMore() {
    this.fetchProducts(true);
  }
  async fetchProducts(append = false) {
    const version = ++this.searchVersion;
    this.isSearching = true;
    this.searchError = "";
    if (!append) {
      this.products = [];
      this.hasMore = false;
      this.nextCursor = null;
    }
    try {
      const result = await searchProducts({
        searchTerm: this.searchTerm,
        bundleOnly: true,
        generatesTicket: null,
        excludedProductIds: [...this.rows, ...this.selectedProducts].map(
          (row) => row.productId
        ),
        afterId: append ? this.nextCursor : null
      });
      if (version !== this.searchVersion || !this.isPickerOpen) return;
      this.products = append
        ? [...this.products, ...result.items]
        : result.items;
      this.hasMore = result.hasMore;
      this.nextCursor = result.nextCursor;
    } catch (error) {
      if (version === this.searchVersion)
        this.searchError = this.reduceError(error);
    } finally {
      if (version === this.searchVersion) this.isSearching = false;
    }
  }
  handleChooseProduct(event) {
    if (this.isLoading || event.detail.action.name !== "choose") return;
    const product = event.detail.row;
    if (
      [...this.rows, ...this.selectedProducts].some(
        (row) => row.productId === product.id
      )
    )
      return;
    const saved = this.savedRows.find((row) => row.productId === product.id);
    const row = saved
      ? { ...saved }
      : {
          productId: product.id,
          name: product.name,
          productCode: product.productCode,
          listPrice: product.productPrice || 0,
          quantity: 1,
          spreadPrice: null,
          key: "new-" + product.id
        };
    this.selectedProducts = [...this.selectedProducts, row];
    this.isChoosingProduct = false;
    ++this.searchVersion;
    this.isSearching = false;
  }
  handlePendingChange(event) {
    const { key, field } = event.target.dataset;
    const value = event.target.value;
    this.selectedProducts = this.selectedProducts.map((row) => {
      if (row.key !== key) return row;
      return { ...row, [field]: value === "" ? null : Number(value) };
    });
  }
  handleRemovePending(event) {
    this.selectedProducts = this.selectedProducts.filter(
      (row) => row.key !== event.currentTarget.dataset.key
    );
    if (!this.hasSelection) this.isChoosingProduct = true;
    if (this.isChoosingProduct) this.fetchProducts();
  }
  validateSelection() {
    const inputs = [...this.template.querySelectorAll("[data-pending]")];
    const validInputs = inputs.reduce(
      (valid, input) => input.reportValidity() && valid,
      true
    );
    return validInputs && validRows(this.selectedProducts);
  }
  handleAddAnother() {
    if (this.isLoading || !this.validateSelection()) return;
    this.isChoosingProduct = true;
    this.searchTerm = "";
    this.fetchProducts();
  }
  stageSelection() {
    if (this.addSelectionDisabled || !this.validateSelection()) return false;
    this.rows = [
      ...this.rows,
      ...this.selectedProducts.map((row) => this.decorate(row))
    ];
    this.isDirty = true;
    this.closePicker();
    return true;
  }
  handleAddSelected() {
    this.stageSelection();
  }
  async handleSaveSelected() {
    if (this.stageSelection()) await this.handleSave();
  }
  async handleSave() {
    if (this.saveDisabled) return;
    if (!validRows(this.rows) || this.rows.some((row) => !row.productId)) {
      this.showToast(
        "Controlla le righe",
        "Ogni riga deve avere un prodotto, una quantita intera positiva e un importo non negativo con massimo due decimali.",
        "error"
      );
      return;
    }
    this.isLoading = true;
    try {
      if (!this.isReconciled) {
        const confirmed = await LightningConfirm.open({
          label: "Salvare con una differenza?",
          theme: "warning",
          message:
            this.varianceLabel +
            ": " +
            this.formatCurrency(this.absoluteVariance) +
            ". Gli importi dei prodotti non corrispondono al prezzo del bundle. Vuoi salvare comunque?"
        });
        if (!confirmed) return;
      }
      this.applyContext(
        await saveComponents({
          bundleId: this.recordId,
          componentsJson: JSON.stringify(
            this.rows.map((row) => ({
              id: row.id,
              productId: row.productId,
              quantity: row.quantity,
              spreadPrice: row.spreadPrice
            }))
          )
        })
      );
      this.showToast(
        "Salvataggio completato",
        this.isReconciled
          ? "Componenti salvati."
          : "Componenti salvati con una differenza di " +
              this.formatCurrency(this.absoluteVariance) +
              ".",
        this.isReconciled ? "success" : "warning"
      );
      this.closeAndRefresh();
    } catch (error) {
      this.showToast(
        "Salvataggio non riuscito",
        this.reduceError(error),
        "error"
      );
    } finally {
      this.isLoading = false;
    }
  }
  async handleCancel() {
    if (this.isLoading) return;
    if (this.isDirty) {
      this.isLoading = true;
      try {
        const confirmed = await LightningConfirm.open({
          label: "Annullare le modifiche?",
          theme: "warning",
          message:
            "Le aggiunte, le modifiche e le rimozioni non salvate saranno perse."
        });
        if (!confirmed) return;
      } finally {
        this.isLoading = false;
      }
    }
    this.closeAndRefresh();
  }
  closeAndRefresh() {
    this.dispatchEvent(new CloseActionScreenEvent());
    this.dispatchEvent(new RefreshEvent());
  }
  formatCurrency(value) {
    return new Intl.NumberFormat("it-IT", {
      style: "currency",
      currency: "EUR"
    }).format(value);
  }
  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }
  reduceError(error) {
    const body = error?.body || error;
    const messages = [
      ...(Array.isArray(body) ? body.map((entry) => entry.message) : []),
      body?.message,
      ...(body?.pageErrors || []).map((entry) => entry.message),
      ...Object.values(body?.fieldErrors || {})
        .flat()
        .map((entry) => entry.message)
    ].filter(Boolean);
    const message = messages.join(" ? ") || "Operazione non riuscita. Riprova.";
    return message.includes("already a component")
      ? "Questo prodotto e gia presente nel bundle. Modifica la quantita della riga esistente."
      : message;
  }
}
