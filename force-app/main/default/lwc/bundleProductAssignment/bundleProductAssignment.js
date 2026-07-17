import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import getBundleContext from "@salesforce/apex/BundleProductAssignmentController.getBundleContext";
import saveComponents from "@salesforce/apex/BundleProductAssignmentController.saveComponents";

export default class BundleProductAssignment extends LightningElement {
  duplicateProductMessage =
    "This product is already a component of this bundle. A product can belong to several bundles, but only once per bundle.";

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
    { label: "Row Price", fieldName: "lineListPrice", type: "currency" },
    {
      label: "Row Selling Price",
      fieldName: "spreadPrice",
      type: "currency",
      editable: true
    },
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

  _recordId;

  isLoading = false;
  hasLoaded = false;
  isCreateModalOpen = false;
  keepCreateModalOpen = false;
  createProductError = "";
  createFormError = "";
  bundleName = "";
  fixedPrice = 0;
  calculatedBundlePrice = 0;
  rows = [];

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

  get showMainView() {
    return !this.isCreateModalOpen;
  }

  get showCreateView() {
    return this.isCreateModalOpen;
  }

  get showFooter() {
    return this.hasLoaded && this.showMainView;
  }

  get panelHeader() {
    return this.isCreateModalOpen
      ? "New Bundle Component"
      : "Configure bundle components";
  }

  get showInitialLoader() {
    return !this.hasLoaded && this.isLoading;
  }

  async loadContext() {
    this.isLoading = true;
    try {
      this.applyContext(
        await getBundleContext({ bundleId: this.recordId })
      );
    } catch (error) {
      this.showToast("Error", this.reduceError(error), "error");
    } finally {
      this.hasLoaded = true;
      this.isLoading = false;
    }
  }

  applyContext(context) {
    this.bundleName = context.bundleName;
    this.fixedPrice = context.fixedPrice || 0;
    this.calculatedBundlePrice =
      context.calculatedBundlePrice ?? context.spreadTotal ?? 0;
    this.rows = (context.components || []).map((row) => this.decorate(row));
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
      discountLabel: lineListPrice === 0 ? "-" : `${discount.toFixed(2)}%`
    };
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
  }

  handleAddComponent() {
    this.keepCreateModalOpen = false;
    this.createProductError = "";
    this.createFormError = "";
    this.isCreateModalOpen = true;
  }

  handleCloseCreateModal() {
    this.closeCreateModal();
  }

  handleSaveAndNew() {
    this.keepCreateModalOpen = true;
    const form = this.template.querySelector("lightning-record-edit-form");
    if (form) {
      form.submit();
    }
  }

  async handleCreateSuccess() {
    await this.loadContext();
    this.createProductError = "";
    this.createFormError = "";
    this.showToast("Success", "Bundle component created.", "success");

    if (this.keepCreateModalOpen) {
      this.closeCreateModal();
      requestAnimationFrame(() => {
        this.isCreateModalOpen = true;
      });
      return;
    }

    this.closeCreateModal();
  }

  handleCreateError(event) {
    this.keepCreateModalOpen = false;
    const message = this.reduceError(event.detail);
    if (message.includes(this.duplicateProductMessage)) {
      this.createProductError = this.duplicateProductMessage;
      this.createFormError = "";
      return;
    }
    this.createProductError = "";
    this.createFormError = message;
    console.error(
      "bundleProductAssignment create error",
      event.detail
    );
  }

  closeCreateModal() {
    this.keepCreateModalOpen = false;
    this.isCreateModalOpen = false;
    this.createProductError = "";
    this.createFormError = "";
  }

  handleProductFieldChange() {
    this.createProductError = "";
    this.createFormError = "";
  }

  handleCreateSubmit(event) {
    event.preventDefault();
    this.createProductError = "";
    this.createFormError = "";
    event.target.submit({
      ...event.detail.fields,
      Bundle__c: this.recordId
    });
  }

  serializeRows() {
    return this.rows.map((row) => ({
      id: row.id,
      productId: row.productId,
      quantity: Number(row.quantity) || 1,
      spreadPrice: Number(row.spreadPrice) || 0
    }));
  }

  async handleSave() {
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
      this.applyContext(
        await saveComponents({
          bundleId: this.recordId,
          componentsJson: JSON.stringify(this.serializeRows())
        })
      );

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
      this.closeAndRefresh();
    } catch (error) {
      this.showToast("Error", this.reduceError(error), "error");
    } finally {
      this.isLoading = false;
    }
  }

  handleCancel() {
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
    }).format(value || 0);
  }

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }

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
