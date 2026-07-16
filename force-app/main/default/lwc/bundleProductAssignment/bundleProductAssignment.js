import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getBundleContext from "@salesforce/apex/BundleProductAssignmentController.getBundleContext";
import saveComponents from "@salesforce/apex/BundleProductAssignmentController.saveComponents";
import searchItems from "@salesforce/apex/BundleProductAssignmentController.searchItems";

export default class BundleProductAssignment extends LightningElement {
  componentColumns = [
    { label: "Name", fieldName: "name" },
    { label: "Code", fieldName: "productCode" },
    {
      label: "Qty",
      fieldName: "quantity",
      type: "number",
      initialWidth: 70,
      editable: true
    },
    { label: "List price", fieldName: "listPrice", type: "currency" },
    { label: "Line list", fieldName: "lineListPrice", type: "currency" },
    {
      label: "Spread (line)",
      fieldName: "spreadPrice",
      type: "currency",
      editable: true
    },
    { label: "Unit spread", fieldName: "unitSpread", type: "currency" },
    { label: "Discount", fieldName: "discountLabel" },
    {
      type: "button-icon",
      fixedWidth: 44,
      typeAttributes: {
        iconName: "utility:delete",
        name: "remove",
        alternativeText: "Remove",
        variant: "bare"
      }
    }
  ];

  searchColumns = [
    { label: "Name", fieldName: "name" },
    { label: "Code", fieldName: "productCode" },
    { label: "List price", fieldName: "productPrice", type: "currency" }
  ];

  _recordId;

  isLoading = false;
  searchTerm = "";
  bundleName = "";
  fixedPrice = 0;
  rows = [];
  searchResults = [];
  selectedIds = new Set();
  searchTimeout;
  resultLimit = 100;

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

  // Totals are recomputed in the browser so the configurator sees the variance
  // move as they type, rather than only after a save.
  get spreadTotal() {
    return this.rows.reduce(
      (sum, row) => sum + (Number(row.spreadPrice) || 0),
      0
    );
  }

  get variance() {
    return (Number(this.fixedPrice) || 0) - this.spreadTotal;
  }

  get isReconciled() {
    return Math.abs(this.variance) < 0.005;
  }

  get varianceClass() {
    return this.isReconciled ? "variance reconciled" : "variance drifted";
  }

  get varianceMessage() {
    if (this.isReconciled) {
      return "Spreads reconcile to the bundle price.";
    }
    return this.variance > 0
      ? `${this.formatCurrency(this.variance)} of the bundle price is not attributed to any product.`
      : `Spreads exceed the bundle price by ${this.formatCurrency(Math.abs(this.variance))}.`;
  }

  get hasRows() {
    return this.rows.length > 0;
  }

  get hasSearchResults() {
    return this.searchResults.length > 0;
  }

  get selectedCount() {
    return this.selectedIds.size;
  }

  get selectedRowIds() {
    return Array.from(this.selectedIds);
  }

  get showEmptySearchState() {
    return !this.isLoading && !this.hasSearchResults;
  }

  async loadContext() {
    this.isLoading = true;
    try {
      const context = await getBundleContext({ bundleId: this.recordId });
      this.bundleName = context.bundleName;
      this.fixedPrice = context.fixedPrice || 0;
      this.rows = (context.components || []).map((row) => this.decorate(row));
      await this.loadSearchResults();
    } catch (error) {
      this.showToast("Error", this.reduceError(error), "error");
    } finally {
      this.isLoading = false;
    }
  }

  async loadSearchResults() {
    try {
      const items = await searchItems({
        bundleId: this.recordId,
        searchTerm: this.searchTerm
      });
      const takenProductIds = new Set(this.rows.map((row) => row.productId));
      this.searchResults = items.filter(
        (item) => !takenProductIds.has(item.id)
      );
    } catch (error) {
      this.showToast("Error", this.reduceError(error), "error");
    }
  }

  decorate(row) {
    const quantity = Number(row.quantity) || 1;
    const listPrice = Number(row.listPrice) || 0;
    const spreadPrice = Number(row.spreadPrice) || 0;
    const lineListPrice = listPrice * quantity;
    const discount =
      lineListPrice === 0 ? 0 : (1 - spreadPrice / lineListPrice) * 100;
    return {
      ...row,
      quantity,
      lineListPrice,
      unitSpread: spreadPrice / quantity,
      key: row.id || `new-${row.productId}`,
      discountLabel: lineListPrice === 0 ? "—" : `${discount.toFixed(2)}%`
    };
  }

  handleSearchChange(event) {
    this.searchTerm = event.target.value;
    window.clearTimeout(this.searchTimeout);
    // eslint-disable-next-line @lwc/lwc/no-async-operation
    this.searchTimeout = window.setTimeout(() => {
      this.loadSearchResults();
    }, 300);
  }

  handleSearchSelection(event) {
    this.selectedIds = new Set(event.detail.selectedRows.map((row) => row.id));
  }

  // Newly added components start at a spread of 0 rather than the list price:
  // the bundle price is fixed, so the spread is a deliberate allocation, never a default.
  handleAddSelected() {
    if (this.selectedIds.size === 0) {
      this.showToast("Info", "Select at least one product to add.", "info");
      return;
    }

    const picked = this.searchResults.filter((item) =>
      this.selectedIds.has(item.id)
    );

    // A row without a product id is unsaveable. Never let one into the table.
    const unusable = picked.filter((item) => !item.id);
    if (unusable.length) {
      console.error(
        "bundleProductAssignment: search rows with no id",
        unusable
      );
      this.showToast(
        "Error",
        `${unusable.length} selected product(s) could not be read and were not added. ` +
          "Reload the page and try again.",
        "error"
      );
    }

    const additions = picked
      .filter((item) => item.id)
      .map((item) =>
        this.decorate({
          id: null,
          productId: item.id,
          name: item.name,
          productCode: item.productCode,
          quantity: 1,
          listPrice: item.productPrice,
          spreadPrice: 0
        })
      );

    if (additions.length) {
      this.rows = [...this.rows, ...additions];
    }
    this.selectedIds = new Set();
    this.loadSearchResults();
  }

  handleCellChange(event) {
    const drafts = new Map(
      event.detail.draftValues.map((draft) => [draft.key, draft])
    );
    this.rows = this.rows.map((row) => {
      const draft = drafts.get(row.key);
      if (!draft) {
        return row;
      }
      return this.decorate({
        ...row,
        quantity:
          draft.quantity === undefined
            ? row.quantity
            : Math.max(1, Number(draft.quantity) || 1),
        spreadPrice:
          draft.spreadPrice === undefined
            ? row.spreadPrice
            : Number(draft.spreadPrice) || 0
      });
    });
    // The table is gone from the DOM once the last row is removed, so this can be null.
    const table = this.template.querySelector('[data-id="components"]');
    if (table) {
      table.draftValues = [];
    }
  }

  handleRowAction(event) {
    if (event.detail.action.name !== "remove") {
      return;
    }
    const removed = event.detail.row;
    this.rows = this.rows.filter((row) => row.key !== removed.key);
    this.loadSearchResults();
  }

  async handleSave() {
    // Refuse to send a row the server cannot store, and name it, rather than letting
    // the Product_Required rule fire with a message that identifies nothing.
    const orphans = this.rows.filter((row) => !row.productId);
    if (orphans.length) {
      console.error(
        "bundleProductAssignment: rows with no productId",
        orphans,
        this.rows
      );
      const described = orphans
        .map((row) => row.name || row.productCode || "(unnamed row)")
        .join(", ");
      this.showToast(
        "Error",
        `${orphans.length} row(s) have no product and cannot be saved: ${described}. ` +
          "Remove them, or reload the page to start from the saved state.",
        "error"
      );
      return;
    }

    this.isLoading = true;
    try {
      const components = this.rows.map((row) => ({
        id: row.id,
        productId: row.productId,
        quantity: Number(row.quantity) || 1,
        spreadPrice: Number(row.spreadPrice) || 0
      }));
      const context = await saveComponents({
        bundleId: this.recordId,
        // Explicit JSON avoids the LWC/Apex bridge constructing blank instances of
        // this nested wrapper class, which loses productId before Apex can save it.
        componentsJson: JSON.stringify(components)
      });

      this.fixedPrice = context.fixedPrice || 0;
      this.rows = (context.components || []).map((row) => this.decorate(row));

      const message = this.isReconciled
        ? "Components saved."
        : `Components saved, but the spread does not reconcile (${this.formatCurrency(
            this.variance
          )}).`;
      this.showToast(
        "Success",
        message,
        this.isReconciled ? "success" : "warning"
      );
      this.dispatchEvent(new CloseActionScreenEvent());
    } catch (error) {
      this.showToast("Error", this.reduceError(error), "error");
    } finally {
      this.isLoading = false;
    }
  }

  handleCancel() {
    this.dispatchEvent(new CloseActionScreenEvent());
  }

  formatCurrency(value) {
    return new Intl.NumberFormat("it-IT", {
      style: "currency",
      currency: "EUR"
    }).format(value || 0);
  }

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }

  // Aura/LDS errors arrive in several shapes, and a plain JS error in this component
  // arrives in none of them. Collapsing them all to "Unexpected error" hides the cause,
  // so unpack every known shape and fall back to the raw message.
  reduceError(error) {
    console.error("bundleProductAssignment error", error);

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
    if (!messages.length && body?.enhancedErrorType) {
      messages.push(body.enhancedErrorType);
    }

    return messages.length
      ? messages.join(" | ")
      : JSON.stringify(error).slice(0, 255);
  }
}
