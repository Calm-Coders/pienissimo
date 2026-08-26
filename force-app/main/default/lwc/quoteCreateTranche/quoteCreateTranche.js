import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import LightningConfirm from "lightning/confirm";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import createTranche from "@salesforce/apex/QuoteTrancheController.createTranche";
import deleteTranche from "@salesforce/apex/QuoteTrancheController.deleteTranche";
import getContext from "@salesforce/apex/QuoteTrancheController.getContext";

export default class QuoteCreateTranche extends LightningElement {
  lineColumns = [
    { label: "Prodotto", fieldName: "productName" },
    { label: "Codice", fieldName: "productCode", initialWidth: 130 },
    {
      label: "Quantita",
      fieldName: "quantity",
      type: "number",
      initialWidth: 90
    },
    { label: "Totale", fieldName: "totalPrice", type: "currency" }
  ];

  assignedColumns = [
    { label: "Prodotto", fieldName: "productName" },
    { label: "Codice", fieldName: "productCode", initialWidth: 130 },
    { label: "Tranche", fieldName: "trancheName", initialWidth: 120 },
    {
      label: "Sequenza",
      fieldName: "trancheSequence",
      type: "number",
      initialWidth: 100
    },
    { label: "Data scadenza", fieldName: "dueDate", type: "date" },
    {
      type: "button-icon",
      initialWidth: 56,
      typeAttributes: {
        alternativeText: "Elimina tranche",
        disabled: { fieldName: "deleteDisabled" },
        iconName: "utility:delete",
        name: "delete_tranche",
        title: "Elimina tranche",
        variant: "bare"
      }
    }
  ];

  _recordId;

  isLoading = false;
  hasLoaded = false;
  quoteName = "";
  quoteStatus = "";
  isEditable = false;
  lines = [];
  sequence = "";
  dueDate = "";
  selectedLineIds = [];

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

  get selectableLines() {
    return this.lines.filter((line) => !line.trancheId);
  }

  get assignedLines() {
    return this.lines.filter((line) => line.trancheId);
  }

  get hasNoLines() {
    return this.lines.length === 0;
  }

  get hasSelectableLines() {
    return this.selectableLines.length > 0;
  }

  get hasAssignedLines() {
    return this.assignedLines.length > 0;
  }

  get hasOnlyAssignedLines() {
    return this.lines.length > 0 && !this.hasSelectableLines;
  }

  get isSaveDisabledByStatus() {
    return !this.isEditable || this.isLoading;
  }

  get isSaveDisabled() {
    return (
      this.isSaveDisabledByStatus ||
      !this.sequence ||
      !this.dueDate ||
      this.selectedLineIds.length === 0
    );
  }

  get selectedCountLabel() {
    const count = this.selectedLineIds.length;
    return count === 1 ? "1 riga selezionata" : `${count} righe selezionate`;
  }

  get statusClass() {
    return this.isEditable ? "status editable" : "status locked";
  }

  async loadContext() {
    this.isLoading = true;
    try {
      this.applyContext(await getContext({ quoteId: this.recordId }));
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
    } finally {
      this.hasLoaded = true;
      this.isLoading = false;
    }
  }

  applyContext(context) {
    this.quoteName = context.quoteName || "";
    this.quoteStatus = context.quoteStatus || "";
    this.isEditable = context.isEditable === true;
    this.lines = (context.lines || []).map((line) => ({
      ...line,
      deleteDisabled: !this.isEditable || !line.trancheId
    }));
    const selectableIds = new Set(this.selectableLines.map((line) => line.id));
    this.selectedLineIds = this.selectedLineIds.filter((id) =>
      selectableIds.has(id)
    );
  }

  handleDueDateChange(event) {
    this.dueDate = event.detail.value;
  }

  handleSequenceChange(event) {
    this.sequence = event.detail.value;
  }

  handleRowSelection(event) {
    this.selectedLineIds = event.detail.selectedRows.map((row) => row.id);
  }

  async handleSave() {
    const inputs = [...this.template.querySelectorAll("lightning-input")];
    if (!inputs.every((input) => input.reportValidity())) {
      return;
    }

    this.isLoading = true;
    try {
      this.applyContext(
        await createTranche({
          quoteId: this.recordId,
          dueDate: this.dueDate,
          sequence: Number(this.sequence),
          quoteLineItemIdsJson: JSON.stringify(this.selectedLineIds)
        })
      );
      this.showToast("Successo", "Tranche creata.", "success");
      this.closeAndRefresh();
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
    } finally {
      this.isLoading = false;
    }
  }

  async handleAssignedRowAction(event) {
    const { action, row } = event.detail;
    if (action.name !== "delete_tranche" || !row.trancheId) {
      return;
    }

    const confirmed = await LightningConfirm.open({
      label: "Elimina tranche",
      message:
        "Eliminare questa tranche? Le righe collegate torneranno senza tranche e senza data scadenza.",
      theme: "warning"
    });
    if (!confirmed) {
      return;
    }

    this.isLoading = true;
    try {
      this.applyContext(
        await deleteTranche({
          quoteId: this.recordId,
          trancheId: row.trancheId
        })
      );
      this.showToast("Successo", "Tranche eliminata.", "success");
      this.dispatchEvent(new RefreshEvent());
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
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

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }

  reduceError(error) {
    console.error("quoteCreateTranche error", error);

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

    return messages.length
      ? messages.join(" | ")
      : JSON.stringify(error).slice(0, 255);
  }
}
