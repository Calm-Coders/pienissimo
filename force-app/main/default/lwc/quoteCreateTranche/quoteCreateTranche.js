import { api, LightningElement } from "lwc";
import { CloseActionScreenEvent } from "lightning/actions";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import createTranches from "@salesforce/apex/QuoteTrancheController.createTranches";
import getContext from "@salesforce/apex/QuoteTrancheController.getContext";

export default class QuoteCreateTranche extends LightningElement {
  _recordId;

  isLoading = false;
  hasLoaded = false;
  quoteName = "";
  quoteStatus = "";
  isEditable = false;
  quoteLines = [];
  existingTranches = [];
  trancheCount = "";
  plannedTranches = [];
  currentTrancheIndex = 0;
  pageValidationMessage = "";
  deletedTrancheIds = [];

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

  get hasExistingTranches() {
    return this.existingTranches.length > 0;
  }

  get isEditMode() {
    return this.hasExistingTranches;
  }

  get saveButtonLabel() {
    return this.isEditMode ? "Edit Tranche" : "Create Tranche";
  }

  get panelHeader() {
    return this.isEditMode ? "Edit Tranche" : "Create Tranche";
  }

  get hasPlannedTranches() {
    return this.plannedTranches.length > 0;
  }

  get editTrancheCards() {
    return this.plannedTranches.map((tranche) => {
      const lineCount = tranche.quoteLineItemIds?.length || 0;
      return {
        ...tranche,
        cardClass:
          tranche.index === this.currentTrancheIndex
            ? "edit-tranche-card selected"
            : "edit-tranche-card",
        dueDateLabel: tranche.dueDate
          ? `Due ${tranche.dueDate}`
          : "No due date",
        lineCountLabel:
          lineCount === 1 ? "1 quote line" : `${lineCount} quote lines`
      };
    });
  }

  get hasQuoteLines() {
    return this.quoteLines.length > 0;
  }

  get currentTranche() {
    return this.plannedTranches[this.currentTrancheIndex] || {};
  }

  get currentTrancheLabel() {
    return `${this.ordinalLabel(
      this.currentTrancheIndex + 1
    )} Tranche (${this.currentTrancheIndex + 1} of ${
      this.plannedTranches.length
    })`;
  }

  get currentSelectedLineIds() {
    return this.currentTranche.quoteLineItemIds || [];
  }

  get selectedElsewhereLineIds() {
    return new Set(
      this.plannedTranches
        .filter((tranche) => tranche.index !== this.currentTrancheIndex)
        .flatMap((tranche) => tranche.quoteLineItemIds || [])
    );
  }

  get currentSelectedLines() {
    const currentIds = new Set(this.currentSelectedLineIds);

    return this.quoteLines
      .filter((line) => currentIds.has(line.id))
      .map((line) => this.decorateQuoteLine(line));
  }

  get availableQuoteLines() {
    const currentIds = new Set(this.currentSelectedLineIds);
    const selectedElsewhere = this.selectedElsewhereLineIds;

    return this.quoteLines
      .filter(
        (line) =>
          (this.isEditMode || !line.trancheId) &&
          !currentIds.has(line.id) &&
          !selectedElsewhere.has(line.id)
      )
      .map((line) => this.decorateQuoteLine(line));
  }

  get hasCurrentSelectedLines() {
    return this.currentSelectedLines.length > 0;
  }

  get hasAvailableQuoteLines() {
    return this.availableQuoteLines.length > 0;
  }

  get hasUnassignedQuoteLines() {
    const selectedLineIds = new Set(
      this.plannedTranches.flatMap((tranche) => tranche.quoteLineItemIds || [])
    );
    return this.quoteLines.some((line) => !selectedLineIds.has(line.id));
  }

  get currentSelectionLabel() {
    const count = this.currentSelectedLineIds.length;
    return count === 1 ? "1 line selected" : `${count} lines selected`;
  }

  get isPreviousDisabled() {
    return this.isSaveDisabledByStatus || this.currentTrancheIndex === 0;
  }

  get isNextDisabled() {
    return (
      this.isSaveDisabledByStatus ||
      this.currentTrancheIndex >= this.plannedTranches.length - 1
    );
  }

  get isDeleteCurrentPageDisabled() {
    return this.isSaveDisabledByStatus || this.plannedTranches.length <= 1;
  }

  get showDeleteCurrentPage() {
    return (
      !this.isEditMode &&
      this.hasPlannedTranches &&
      !this.hasCurrentSelectedLines &&
      !this.hasAvailableQuoteLines &&
      this.plannedTranches.length > 1
    );
  }

  get isSaveDisabledByStatus() {
    return !this.isEditable || this.isLoading;
  }

  get isSaveDisabled() {
    return (
      this.isSaveDisabledByStatus ||
      !this.hasPlannedTranches ||
      this.plannedTranches.some(
        (tranche) =>
          !tranche.name?.trim() ||
          !tranche.dueDate ||
          !tranche.quoteLineItemIds?.length
      )
    );
  }

  get statusClass() {
    return this.isEditable ? "status editable" : "status locked";
  }

  async loadContext() {
    this.isLoading = true;
    try {
      this.applyContext(await getContext({ quoteId: this.recordId }));
    } catch (error) {
      this.showToast("Error", this.reduceError(error), "error");
    } finally {
      this.hasLoaded = true;
      this.isLoading = false;
    }
  }

  applyContext(context) {
    this.quoteName = context.quoteName || "";
    this.quoteStatus = context.quoteStatus || "";
    this.isEditable = context.isEditable === true;
    this.quoteLines = context.lines || [];
    this.existingTranches = (context.tranches || []).map((tranche) => ({
      ...tranche,
      deleteDisabled: !this.isEditable
    }));
    if (this.existingTranches.length) {
      this.plannedTranches = this.existingTranches.map((tranche, index) =>
        this.buildExistingPlannedTranche(tranche, index)
      );
      this.trancheCount = String(this.plannedTranches.length);
      this.currentTrancheIndex = Math.min(
        this.currentTrancheIndex,
        this.plannedTranches.length - 1
      );
    } else {
      this.plannedTranches = [];
      this.trancheCount = "";
      this.currentTrancheIndex = 0;
    }
    this.deletedTrancheIds = [];
    this.pageValidationMessage = "";
  }

  handleTrancheCountChange(event) {
    const count = Number(event.detail.value);
    this.trancheCount = event.detail.value;
    if (!Number.isInteger(count) || count < 1) {
      this.plannedTranches = [];
      this.currentTrancheIndex = 0;
      return;
    }
    const normalizedCount = Math.min(count, 20);
    const removedExistingIds = this.plannedTranches
      .slice(normalizedCount)
      .map((tranche) => tranche.id)
      .filter(Boolean);
    if (removedExistingIds.length) {
      this.deletedTrancheIds = [
        ...new Set([...this.deletedTrancheIds, ...removedExistingIds])
      ];
    }
    this.plannedTranches = Array.from({ length: normalizedCount }, (_, i) =>
      this.buildPlannedTranche(i)
    );
    this.currentTrancheIndex = Math.min(
      this.currentTrancheIndex,
      this.plannedTranches.length - 1
    );
  }

  handlePlannedNameChange(event) {
    this.pageValidationMessage = "";
    this.updatePlannedTranche(event, "name");
  }

  handlePlannedDueDateChange(event) {
    this.pageValidationMessage = "";
    this.updatePlannedTranche(event, "dueDate");
  }

  handleAssignLine(event) {
    const lineId = event.target.dataset.id;
    const selectedIds = new Set(this.currentSelectedLineIds);
    selectedIds.add(lineId);

    this.updateCurrentSelectedLineIds([...selectedIds]);
  }

  handleRemoveLine(event) {
    const lineId = event.target.dataset.id;
    const selectedIds = new Set(this.currentSelectedLineIds);
    selectedIds.delete(lineId);

    this.updateCurrentSelectedLineIds([...selectedIds]);
  }

  handleSelectEditTranche(event) {
    this.currentTrancheIndex = Number(event.currentTarget.dataset.index);
    this.pageValidationMessage = "";
  }

  updateCurrentSelectedLineIds(lineIds) {
    this.plannedTranches = this.plannedTranches.map((tranche) => {
      if (tranche.index === this.currentTrancheIndex) {
        return { ...tranche, quoteLineItemIds: lineIds };
      }
      return tranche;
    });
  }

  handlePreviousTranche() {
    if (!this.validateCurrentTranche()) {
      return;
    }
    this.pageValidationMessage = "";
    this.currentTrancheIndex = Math.max(0, this.currentTrancheIndex - 1);
  }

  handleNextTranche() {
    if (!this.validateCurrentTranche()) {
      return;
    }
    this.pageValidationMessage = "";
    this.currentTrancheIndex = Math.min(
      this.plannedTranches.length - 1,
      this.currentTrancheIndex + 1
    );
  }

  handleDeleteCurrentPage() {
    if (this.isDeleteCurrentPageDisabled) {
      return;
    }

    const nextPlannedTranches = this.plannedTranches
      .filter((tranche) => tranche.index !== this.currentTrancheIndex)
      .map((tranche, index) => this.renumberPlannedTranche(tranche, index));
    if (this.currentTranche.id) {
      this.deletedTrancheIds = [
        ...this.deletedTrancheIds,
        this.currentTranche.id
      ];
    }

    this.plannedTranches = nextPlannedTranches;
    this.trancheCount = String(nextPlannedTranches.length);
    this.currentTrancheIndex = Math.min(
      this.currentTrancheIndex,
      nextPlannedTranches.length - 1
    );
    this.pageValidationMessage = "";
  }

  validateCurrentTranche() {
    const inputs = [
      ...this.template.querySelectorAll("[data-current-tranche-due-date]")
    ];
    const isValid = inputs.every((input) => input.reportValidity());
    this.pageValidationMessage = isValid
      ? ""
      : "Complete the due date before moving to another tranche.";
    return isValid;
  }

  updatePlannedTranche(event, fieldName) {
    const index = Number(event.target.dataset.index);
    this.plannedTranches = this.plannedTranches.map((tranche) => {
      if (tranche.index === index) {
        return { ...tranche, [fieldName]: event.detail.value };
      }
      return tranche;
    });
  }

  buildPlannedTranche(index) {
    const existing = this.plannedTranches[index] || {};
    const sequence = index + 1;
    return {
      key: `planned-${sequence}`,
      index,
      sequence,
      name: existing.name || `T${sequence} - ${this.quoteName}`,
      dueDate: existing.dueDate || "",
      quoteLineItemIds: existing.quoteLineItemIds || []
    };
  }

  buildExistingPlannedTranche(tranche, index) {
    return {
      key: `planned-${tranche.trancheId}`,
      id: tranche.trancheId,
      index,
      sequence: index + 1,
      name: tranche.trancheName,
      dueDate: tranche.dueDate || "",
      quoteLineItemIds: this.quoteLines
        .filter((line) => line.trancheId === tranche.trancheId)
        .map((line) => line.id)
    };
  }

  renumberPlannedTranche(tranche, index) {
    const sequence = index + 1;
    const generatedNamePattern = /^T\d+ - /;
    const shouldRefreshName =
      !tranche.name || generatedNamePattern.test(tranche.name);

    return {
      ...tranche,
      key: `planned-${sequence}`,
      index,
      sequence,
      name: shouldRefreshName
        ? `T${sequence} - ${this.quoteName}`
        : tranche.name
    };
  }

  ordinalLabel(numberValue) {
    const labels = [
      "First",
      "Second",
      "Third",
      "Fourth",
      "Fifth",
      "Sixth",
      "Seventh",
      "Eighth",
      "Ninth",
      "Tenth"
    ];
    return labels[numberValue - 1] || `${numberValue}th`;
  }

  formatAmount(value) {
    if (value === null || value === undefined) {
      return "-";
    }
    return new Intl.NumberFormat(undefined, {
      style: "currency",
      currency: "EUR"
    }).format(value);
  }

  decorateQuoteLine(line) {
    return {
      ...line,
      productCode: line.productCode || "No code",
      productName: line.productName || "Unnamed product",
      totalLabel: this.formatAmount(line.totalPrice)
    };
  }

  async handleSave() {
    const inputs = [...this.template.querySelectorAll("lightning-input")];
    if (!inputs.every((input) => input.reportValidity())) {
      return;
    }
    if (this.hasUnassignedQuoteLines) {
      this.pageValidationMessage =
        "Assign every quote line to a tranche before saving.";
      this.showToast("Error", this.pageValidationMessage, "error");
      return;
    }

    const wasEditMode = this.isEditMode;
    this.isLoading = true;
    try {
      this.applyContext(
        await createTranches({
          quoteId: this.recordId,
          trancheInputsJson: JSON.stringify(
            this.plannedTranches.map((tranche) => ({
              name: tranche.name.trim(),
              trancheId: tranche.id,
              dueDate: tranche.dueDate,
              sequence: tranche.sequence,
              quoteLineItemIds: tranche.quoteLineItemIds
            }))
          ),
          deletedTrancheIdsJson: JSON.stringify(this.deletedTrancheIds)
        })
      );
      this.showToast(
        "Success",
        wasEditMode ? "Tranches updated." : "Tranches created.",
        "success"
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

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }

  reduceError(error) {
    console.error("quoteCreateTranche error", error);

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

    return messages.length
      ? messages.join(" | ")
      : JSON.stringify(error).slice(0, 255);
  }
}
