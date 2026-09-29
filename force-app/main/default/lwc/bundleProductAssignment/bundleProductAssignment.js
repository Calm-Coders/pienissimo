import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";
import LightningConfirm from "lightning/confirm";
import getBundleContext from "@salesforce/apex/BundleProductAssignmentController.getBundleContext";
import searchProducts from "@salesforce/apex/BundleProductAssignmentController.searchProducts";
import saveComponents from "@salesforce/apex/BundleProductAssignmentController.saveComponents";
import { validRows } from "./pricing";

const currency = { currencyCode: "EUR", minimumFractionDigits: 2 };
export default class BundleProductAssignment extends LightningElement {
  productColumns = [
    { label: "Prodotto", fieldName: "name", wrapText: true },
    { label: "Codice", fieldName: "productCode" },
    {
      label: "Listino unitario",
      fieldName: "productPriceDisplay",
      initialWidth: 150
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
  isTranchView = false;
  isSearching = false;
  errorMessage = "";
  searchError = "";
  bundleName = "";
  fixedPrice = null;
  bundleTranches = [];
  rows = [];
  savedRows = [];
  products = [];
  selectedProducts = [];
  selectedSearchProducts = [];
  editingComponentKey = null;
  editingComponentDraft = null;
  pendingPriceErrors = {};
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
    return [
      ...this.rowsForTotals,
      ...this.selectedProducts.map((row) => this.resolvePendingRow(row))
    ].reduce((sum, row) => sum + (Number(row.spreadPrice) || 0), 0);
  }
  get listTotal() {
    return [...this.rowsForTotals, ...this.selectedProducts].reduce(
      (sum, row) =>
        sum + (Number(row.listPrice) || 0) * Number(row.quantity || 0),
      0
    );
  }
  get hasMissingListPrices() {
    return [...this.rowsForTotals, ...this.selectedProducts].some(
      (row) => row.listPrice == null
    );
  }
  get rowsForTotals() {
    if (!this.hasEditingComponent) return this.rows;
    return this.rows.map((row) => {
      return row.key === this.editingComponentKey
        ? this.editingComponentDraft
        : row;
    });
  }
  get hasRows() {
    return this.rows.length > 0;
  }
  get hasBundleTranches() {
    return this.bundleTranches.length > 0;
  }
  get bundleTranchOptions() {
    return this.bundleTranches.map((tranch) => ({
      label: this.formatTranchOption(tranch),
      value: tranch.id
    }));
  }
  get componentColumns() {
    const columns = [
      { label: "Prodotto", fieldName: "name", wrapText: true },
      { label: "Codice", fieldName: "productCode" }
    ];
    if (this.hasBundleTranches) {
      columns.push({
        label: "Tranch",
        fieldName: "bundleTranchName",
        wrapText: true
      });
    }
    columns.push(
      {
        label: "Quantita",
        fieldName: "quantity",
        type: "number",
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
        typeAttributes: currency
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
          iconName: "utility:edit",
          name: "edit",
          alternativeText: "Modifica",
          title: "Modifica",
          variant: "border-filled"
        }
      },
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
    );
    return columns;
  }
  get showMainView() {
    return !this.isPickerOpen;
  }
  get panelHeader() {
    if (this.isTranchView) {
      return "Crea Tranch";
    }
    return this.isPickerOpen ? "Aggiungi prodotti" : "Configura bundle";
  }
  get showBundleFooter() {
    return !this.isTranchView;
  }
  get saveDisabled() {
    return this.isLoading || !this.hasLoaded;
  }
  get createTranchDisabled() {
    return this.saveDisabled || !this.hasRows;
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
  get selectedSearchProductIds() {
    return this.selectedSearchProducts.map((product) => product.id);
  }
  get addSearchSelectionDisabled() {
    return this.isSearching || this.selectedSearchProducts.length === 0;
  }
  get searchSelectionLabel() {
    return "Aggiungi selezionati (" + this.selectedSearchProducts.length + ")";
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
  get editingComponent() {
    return this.editingComponentDraft;
  }
  get hasEditingComponent() {
    return this.editingComponent != null;
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
    this.fixedPrice = context.fixedPrice;
    this.bundleTranches = context.bundleTranches || [];
    this.rows = (context.components || []).map((row) => this.decorate(row));
    this.savedRows = this.rows.map((row) => ({ ...row }));
    this.isDirty = false;
  }
  handleFixedPriceChange(event) {
    const value = event.target.value;
    this.fixedPrice = value === "" || value == null ? null : Number(value);
    this.isDirty = true;
  }
  decorate(row) {
    const quantity = Number(row.quantity);
    const spreadPrice =
      row.spreadPrice == null ? null : Number(row.spreadPrice);
    const lineListPrice = (Number(row.listPrice) || 0) * quantity;
    const discountPercent =
      row.discountPercent == null && spreadPrice != null && lineListPrice > 0
        ? Math.round((1 - spreadPrice / lineListPrice) * 10000) / 100
        : row.discountPercent;
    return {
      ...row,
      quantity,
      spreadPrice,
      discountPercent,
      lineListPrice,
      unitSpread:
        quantity > 0 && spreadPrice != null ? spreadPrice / quantity : null,
      key: row.id || "new-" + row.productId,
      bundleTranchName: this.resolveBundleTranchName(row.bundleTranchId),
      discountDisabled: row.listPrice == null || Number(row.listPrice) <= 0,
      discountLabel:
        lineListPrice === 0 || discountPercent == null
          ? "-"
          : discountPercent.toFixed(2) + "%"
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
    if (event.detail.action.name === "edit") {
      this.editingComponentKey = event.detail.row.key;
      this.editingComponentDraft = { ...event.detail.row };
      return;
    }
    if (event.detail.action.name === "remove") {
      this.rows = this.rows.filter((row) => row.key !== event.detail.row.key);
      if (this.editingComponentKey === event.detail.row.key) {
        this.editingComponentKey = null;
        this.editingComponentDraft = null;
      }
      this.isDirty = true;
    }
  }
  handleComponentEditChange(event) {
    const { field } = event.target.dataset;
    const value = event.target.value;
    const updated = {
      ...this.editingComponentDraft,
      [field]:
        field === "bundleTranchId"
          ? value || null
          : value === "" || value == null
            ? null
            : Number(value)
    };
    if (field === "discountPercent") {
      updated.spreadPrice =
        updated.discountPercent == null
          ? null
          : this.calculateDiscountedTotal(updated);
    }
    if (field === "spreadPrice") {
      updated.discountPercent =
        updated.spreadPrice == null
          ? null
          : this.calculateDiscountPercent(updated);
    }
    this.editingComponentDraft = this.decorate(updated);
  }
  handleSaveComponentEdit() {
    const inputs = [
      ...this.template.querySelectorAll("[data-component-editor]")
    ];
    const validInputs = inputs.reduce(
      (valid, input) => input.reportValidity() && valid,
      true
    );
    if (!validInputs || !validRows([this.editingComponentDraft])) {
      this.showToast(
        "Controlla la riga",
        "La riga deve avere una quantita intera positiva e un importo non negativo con massimo due decimali.",
        "error"
      );
      return;
    }
    this.rows = this.rows.map((row) => {
      return row.key === this.editingComponentKey
        ? this.editingComponentDraft
        : row;
    });
    this.isDirty = true;
    this.handleCloseComponentEditor();
  }
  handleCloseComponentEditor() {
    this.editingComponentKey = null;
    this.editingComponentDraft = null;
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
    this.selectedSearchProducts = [];
    this.pendingPriceErrors = {};
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
      this.selectedSearchProducts = [];
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
      const items = result.items.map((item) => ({
        ...item,
        productPriceDisplay:
          item.productPrice == null
            ? "Non disponibile"
            : this.formatCurrency(item.productPrice)
      }));
      this.products = append ? [...this.products, ...items] : items;
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
    this.addProductsFromSearch([event.detail.row]);
  }
  handleProductSelection(event) {
    this.selectedSearchProducts = event.detail.selectedRows || [];
  }
  handleAddSearchSelection() {
    if (this.addSearchSelectionDisabled) return;
    this.addProductsFromSearch(this.selectedSearchProducts);
  }
  addProductsFromSearch(products) {
    const pendingRows = products
      .map((product) => this.buildPendingRow(product))
      .filter((row) => row != null);
    if (pendingRows.length === 0) return;
    const addedProductIds = new Set(pendingRows.map((row) => row.productId));
    const decoratedRows = pendingRows.map((row) => this.decoratePending(row));
    this.selectedProducts = [...this.selectedProducts, ...decoratedRows];
    this.products = this.products.filter(
      (product) => !addedProductIds.has(product.id)
    );
    this.selectedSearchProducts = [];
  }
  buildPendingRow(product) {
    if (
      [...this.rows, ...this.selectedProducts].some(
        (row) => row.productId === product.id
      )
    )
      return null;
    const saved = this.savedRows.find((row) => row.productId === product.id);
    return saved
      ? { ...saved }
      : {
          productId: product.id,
          name: product.name,
          productCode: product.productCode,
          listPrice: product.productPrice,
          quantity: 1,
          spreadPrice: null,
          bundleTranchId: null,
          key: "new-" + product.id
        };
  }
  handlePendingChange(event) {
    const { key, field } = event.target.dataset;
    const value = event.target.value;
    event.target.setCustomValidity("");
    this.clearPendingPriceErrorStateForRow(key);
    if (field === "discountPercent" || field === "spreadPrice") {
      this.clearPendingPriceErrorsForRow(key);
    } else {
      event.target.reportValidity();
    }
    this.selectedProducts = this.selectedProducts.map((row) => {
      if (row.key !== key) return row;
      const updated = {
        ...row,
        [field]:
          field === "bundleTranchId"
            ? value || null
            : value === "" || value == null
              ? null
              : Number(value)
      };
      if (field === "discountPercent") {
        updated.spreadPrice =
          updated.discountPercent == null
            ? null
            : this.calculateDiscountedTotal(updated);
      }
      if (field === "spreadPrice") {
        updated.discountPercent =
          updated.spreadPrice == null
            ? null
            : this.calculateDiscountPercent(updated);
      }
      return this.decoratePending(updated);
    });
  }
  decoratePending(row) {
    const hasListPrice = row.listPrice != null;
    const needsChoice =
      Number(row.listPrice) > 0 &&
      row.discountPercent == null &&
      row.spreadPrice == null;
    const resolved = this.resolvePendingRow(row);
    return {
      ...row,
      pendingPriceError: this.pendingPriceErrors[row.key],
      bundleTranchName: this.resolveBundleTranchName(row.bundleTranchId),
      hasListPrice,
      listPriceDisplay: hasListPrice
        ? this.formatCurrency(row.listPrice)
        : "Non disponibile",
      quantityDisplay: Number(row.quantity) || 0,
      selectedPriceDisplay:
        resolved.spreadPrice == null
          ? "-"
          : this.formatCurrency(resolved.spreadPrice),
      selectedDiscountDisplay:
        row.discountPercent == null ? "-" : row.discountPercent + "%",
      discountDisabled: !hasListPrice || Number(row.listPrice) <= 0,
      discountRequired: needsChoice,
      rowPriceRequired:
        !hasListPrice || Number(row.listPrice) <= 0 || needsChoice
    };
  }
  resolvePendingRow(row) {
    if (row.discountPercent == null) return row;
    return { ...row, spreadPrice: this.calculateDiscountedTotal(row) };
  }
  calculateDiscountedTotal(row) {
    const total =
      Number(row.listPrice) *
      Number(row.quantity) *
      (1 - Number(row.discountPercent) / 100);
    return Math.round(total * 100) / 100;
  }
  calculateDiscountPercent(row) {
    const listTotal = Number(row.listPrice) * Number(row.quantity);
    if (listTotal <= 0 || row.spreadPrice == null) return null;
    return Math.round((1 - Number(row.spreadPrice) / listTotal) * 10000) / 100;
  }
  handleRemovePending(event) {
    const key = event.currentTarget.dataset.key;
    this.selectedProducts = this.selectedProducts.filter(
      (row) => row.key !== key
    );
    this.clearPendingPriceErrorStateForRow(key);
    if (!this.hasSelection) this.isChoosingProduct = true;
    if (this.isChoosingProduct) this.fetchProducts();
  }
  validateSelection({ requireTranch } = { requireTranch: false }) {
    const inputs = [...this.template.querySelectorAll("[data-pending]")];
    this.clearPendingPriceErrors(inputs);
    const validInputs = inputs.reduce(
      (valid, input) => input.reportValidity() && valid,
      true
    );
    const validPricing = this.validatePendingPricing(inputs);
    return (
      validInputs &&
      validPricing &&
      (!requireTranch ||
        !this.hasBundleTranches ||
        this.selectedProducts.every((row) => row.bundleTranchId)) &&
      validRows(this.selectedProducts.map((row) => this.resolvePendingRow(row)))
    );
  }
  clearPendingPriceErrors(inputs) {
    inputs
      .filter(
        (input) =>
          input.dataset.field === "discountPercent" ||
          input.dataset.field === "spreadPrice"
      )
      .forEach((input) => {
        input.setCustomValidity("");
      });
  }
  clearPendingPriceErrorsForRow(key) {
    this.template
      .querySelectorAll(
        `[data-key="${key}"][data-field="discountPercent"], ` +
          `[data-key="${key}"][data-field="spreadPrice"]`
      )
      .forEach((input) => {
        input.setCustomValidity("");
        input.reportValidity();
      });
  }
  clearPendingPriceErrorStateForRow(key) {
    if (!this.pendingPriceErrors[key]) return;
    const remainingErrors = { ...this.pendingPriceErrors };
    delete remainingErrors[key];
    this.pendingPriceErrors = remainingErrors;
  }
  refreshPendingDecorations() {
    this.selectedProducts = this.selectedProducts.map((row) =>
      this.decoratePending(row)
    );
  }
  validatePendingPricing(inputs) {
    const priceInputsByKey = new Map();
    inputs
      .filter(
        (input) =>
          input.dataset.field === "discountPercent" ||
          input.dataset.field === "spreadPrice"
      )
      .forEach((input) => {
        const key = input.dataset.key;
        const fields = priceInputsByKey.get(key) || {};
        fields[input.dataset.field] = input;
        priceInputsByKey.set(key, fields);
      });

    let isValid = true;
    const nextErrors = {};
    this.selectedProducts.forEach((row) => {
      const resolved = this.resolvePendingRow(row);
      const hasValidPrice =
        Number.isFinite(resolved.spreadPrice) &&
        resolved.spreadPrice >= 0 &&
        Math.abs(
          resolved.spreadPrice * 100 - Math.round(resolved.spreadPrice * 100)
        ) < 0.00001;
      if (hasValidPrice) return;

      isValid = false;
      const fields = priceInputsByKey.get(row.key) || {};
      const message =
        row.discountDisabled === true
          ? "Inserisci il prezzo totale della riga."
          : "Inserisci uno sconto oppure il prezzo totale della riga.";
      nextErrors[row.key] = message;
      if (fields.discountPercent && row.discountDisabled !== true) {
        fields.discountPercent.setCustomValidity(message);
        fields.discountPercent.reportValidity();
      }
      if (fields.spreadPrice) {
        fields.spreadPrice.setCustomValidity(message);
        fields.spreadPrice.reportValidity();
      }
    });
    this.pendingPriceErrors = nextErrors;
    if (!isValid) {
      this.refreshPendingDecorations();
    }
    return isValid;
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
      ...this.selectedProducts.map((row) =>
        this.decorate(this.resolvePendingRow(row))
      )
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
    await this.saveBundle({ closeAfterSave: true });
  }
  async handleCreateTranch() {
    if (this.createTranchDisabled) return;
    if (!validRows(this.rows) || this.rows.some((row) => !row.productId)) {
      this.showToast(
        "Controlla le righe",
        "Salva righe valide prima di creare una tranch.",
        "error"
      );
      return;
    }

    if (this.isDirty) {
      this.isLoading = true;
      try {
        const confirmed = await LightningConfirm.open({
          label: "Salvare il bundle?",
          message:
            "Le modifiche ai prodotti devono essere salvate prima di creare una tranch.",
          theme: "warning"
        });
        if (!confirmed) return;
      } finally {
        this.isLoading = false;
      }

      const saved = await this.saveBundle({
        closeAfterSave: false,
        allowMissingTranch: true
      });
      if (!saved) return;
    }

    this.isTranchView = true;
  }
  async saveBundle({ closeAfterSave, allowMissingTranch = false }) {
    if (this.saveDisabled) return false;
    if (this.hasEditingComponent) {
      this.showToast(
        "Salva la modifica",
        "Salva o chiudi la modifica del prodotto aperto prima di salvare il bundle.",
        "error"
      );
      return false;
    }
    const bundlePriceInput = this.template.querySelector(
      '[data-id="bundle-price"]'
    );
    if (
      !bundlePriceInput?.reportValidity() ||
      !Number.isFinite(this.fixedPrice) ||
      this.fixedPrice < 0 ||
      Math.abs(this.fixedPrice * 100 - Math.round(this.fixedPrice * 100)) >=
        0.00001
    ) {
      this.showToast(
        "Prezzo bundle non valido",
        "Inserisci un prezzo bundle non negativo con massimo due decimali.",
        "error"
      );
      return false;
    }
    if (
      !allowMissingTranch &&
      this.hasBundleTranches &&
      this.rows.some((row) => !row.bundleTranchId)
    ) {
      this.showToast(
        "Tranch mancante",
        "Assegna ogni prodotto del bundle a una tranch prima di salvare.",
        "error"
      );
      return false;
    }
    if (!validRows(this.rows) || this.rows.some((row) => !row.productId)) {
      this.showToast(
        "Controlla le righe",
        "Ogni riga deve avere un prodotto, una quantita intera positiva e un importo non negativo con massimo due decimali.",
        "error"
      );
      return false;
    }
    if (this.hasRows && !this.bundleTotalsMatch()) {
      this.showToast(
        "Totale non coerente",
        "Il Totale assegnato deve essere uguale al Prezzo prodotto bundle prima di salvare.",
        "error"
      );
      return false;
    }
    this.isLoading = true;
    try {
      this.applyContext(
        await saveComponents({
          bundleId: this.recordId,
          fixedPrice: this.fixedPrice,
          componentsJson: JSON.stringify(
            this.rows.map((row) => ({
              id: row.id,
              productId: row.productId,
              quantity: row.quantity,
              spreadPrice: row.spreadPrice,
              bundleTranchId: row.bundleTranchId
            }))
          ),
          allowMissingTranch
        })
      );
      this.showToast(
        "Salvataggio completato",
        "Componenti salvati.",
        "success"
      );
      if (closeAfterSave) {
        await this.refreshAndClose();
      } else {
        await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
        this.dispatchEvent(new RefreshEvent());
      }
      return true;
    } catch (error) {
      this.showToast(
        "Salvataggio non riuscito",
        this.reduceError(error),
        "error"
      );
      return false;
    } finally {
      this.isLoading = false;
    }
  }
  async handleTranchSaved() {
    this.isTranchView = false;
    await this.loadContext();
    await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
    this.dispatchEvent(new RefreshEvent());
  }
  handleTranchCancel() {
    this.isTranchView = false;
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
    this.closeWithoutRefresh();
  }
  async refreshAndClose() {
    await notifyRecordUpdateAvailable([{ recordId: this.recordId }]);
    this.dispatchEvent(new RefreshEvent());
    this.closeWithoutRefresh();
  }
  closeWithoutRefresh() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }
  bundleTotalsMatch() {
    if (this.fixedPrice == null) {
      return false;
    }
    return (
      this.toCurrencyCents(this.fixedPrice) ===
      this.toCurrencyCents(this.spreadTotal)
    );
  }
  toCurrencyCents(value) {
    return Math.round((Number(value) || 0) * 100);
  }
  formatCurrency(value) {
    return new Intl.NumberFormat("it-IT", {
      style: "currency",
      currency: "EUR"
    }).format(value);
  }
  formatTranchOption(tranch) {
    const dueDate = tranch.dueDate
      ? " - " + this.formatDate(tranch.dueDate)
      : "";
    const sequence =
      tranch.sequence === null || tranch.sequence === undefined
        ? ""
        : tranch.sequence + " - ";
    return sequence + tranch.name + dueDate;
  }
  resolveBundleTranchName(bundleTranchId) {
    if (!bundleTranchId) {
      return "";
    }
    const tranch = this.bundleTranches.find(
      (candidate) => candidate.id === bundleTranchId
    );
    return tranch ? this.formatTranchOption(tranch) : "";
  }
  formatDate(value) {
    if (!value) {
      return "";
    }
    const [year, month, day] = value.split("-");
    return `${day}/${month}/${year}`;
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
