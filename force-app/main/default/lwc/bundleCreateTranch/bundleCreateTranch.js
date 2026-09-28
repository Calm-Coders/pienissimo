import { api, LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getContext from "@salesforce/apex/BundleTranchController.getContext";
import saveTranches from "@salesforce/apex/BundleTranchController.saveTranches";

export default class BundleCreateTranch extends LightningElement {
  _recordId;

  isLoading = false;
  hasLoaded = false;
  bundleName = "";
  components = [];
  existingTranches = [];
  tranchCount = "";
  plannedTranches = [];
  currentTranchIndex = 0;
  pageValidationMessage = "";
  deletedTranchIds = [];

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

  get componentCount() {
    return this.components.length;
  }

  get hasComponents() {
    return this.components.length > 0;
  }

  get hasExistingTranches() {
    return this.existingTranches.length > 0;
  }

  get isEditMode() {
    return this.hasExistingTranches;
  }

  get saveButtonLabel() {
    return this.isEditMode ? "Modifica tranch" : "Crea tranch";
  }

  get hasPlannedTranches() {
    return this.plannedTranches.length > 0;
  }

  get editTranchCards() {
    return this.plannedTranches.map((tranch) => {
      const componentCount = tranch.componentIds?.length || 0;
      return {
        ...tranch,
        cardClass:
          tranch.index === this.currentTranchIndex
            ? "edit-tranche-card selected"
            : "edit-tranche-card",
        dueDateLabel: tranch.dueDate
          ? `Scadenza ${this.formatDate(tranch.dueDate)}`
          : "Nessuna scadenza",
        componentCountLabel:
          componentCount === 1 ? "1 componente" : `${componentCount} componenti`
      };
    });
  }

  get currentTranch() {
    return this.plannedTranches[this.currentTranchIndex] || {};
  }

  get currentTranchLabel() {
    return `${this.ordinalLabel(this.currentTranchIndex + 1)} tranch (${
      this.currentTranchIndex + 1
    } di ${this.plannedTranches.length})`;
  }

  get currentSelectedComponentIds() {
    return this.currentTranch.componentIds || [];
  }

  get selectedElsewhereComponentIds() {
    return new Set(
      this.plannedTranches
        .filter((tranch) => tranch.index !== this.currentTranchIndex)
        .flatMap((tranch) => tranch.componentIds || [])
    );
  }

  get currentSelectedComponents() {
    const currentIds = new Set(this.currentSelectedComponentIds);
    return this.components
      .filter((component) => currentIds.has(component.id))
      .map((component) => this.decorateComponent(component));
  }

  get availableComponents() {
    const currentIds = new Set(this.currentSelectedComponentIds);
    const selectedElsewhere = this.selectedElsewhereComponentIds;
    return this.components
      .filter(
        (component) =>
          (this.isEditMode || !component.bundleTranchId) &&
          !currentIds.has(component.id) &&
          !selectedElsewhere.has(component.id)
      )
      .map((component) => this.decorateComponent(component));
  }

  get hasCurrentSelectedComponents() {
    return this.currentSelectedComponents.length > 0;
  }

  get hasAvailableComponents() {
    return this.availableComponents.length > 0;
  }

  get hasUnassignedComponents() {
    const selectedComponentIds = new Set(
      this.plannedTranches.flatMap((tranch) => tranch.componentIds || [])
    );
    return this.components.some(
      (component) => !selectedComponentIds.has(component.id)
    );
  }

  get currentSelectionLabel() {
    const count = this.currentSelectedComponentIds.length;
    return count === 1
      ? "1 componente selezionato"
      : `${count} componenti selezionati`;
  }

  get isPreviousDisabled() {
    return this.isLoading || this.currentTranchIndex === 0;
  }

  get isNextDisabled() {
    return (
      this.isLoading ||
      this.currentTranchIndex >= this.plannedTranches.length - 1
    );
  }

  get isDeleteCurrentPageDisabled() {
    return this.isLoading || this.plannedTranches.length <= 1;
  }

  get showDeleteCurrentPage() {
    if (
      this.isEditMode &&
      this.hasPlannedTranches &&
      this.currentTranch.id &&
      !this.hasCurrentSelectedComponents
    ) {
      return true;
    }

    return (
      !this.isEditMode &&
      this.hasPlannedTranches &&
      !this.hasCurrentSelectedComponents &&
      !this.hasAvailableComponents &&
      this.plannedTranches.length > 1
    );
  }

  get isSaveDisabled() {
    return (
      this.isLoading ||
      !this.hasPlannedTranches ||
      this.plannedTranches.some(
        (tranch) =>
          !tranch.name?.trim() ||
          !tranch.dueDate ||
          !tranch.componentIds?.length
      )
    );
  }

  async loadContext() {
    this.isLoading = true;
    try {
      this.applyContext(await getContext({ bundleId: this.recordId }));
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
    } finally {
      this.hasLoaded = true;
      this.isLoading = false;
    }
  }

  applyContext(context) {
    this.bundleName = context.bundleName || "";
    this.components = context.components || [];
    this.existingTranches = context.tranches || [];
    if (this.existingTranches.length) {
      this.plannedTranches = this.existingTranches.map((tranch, index) =>
        this.buildExistingPlannedTranch(tranch, index)
      );
      this.tranchCount = String(this.plannedTranches.length);
      this.currentTranchIndex = Math.min(
        this.currentTranchIndex,
        this.plannedTranches.length - 1
      );
    } else {
      this.plannedTranches = [];
      this.tranchCount = "";
      this.currentTranchIndex = 0;
    }
    this.deletedTranchIds = [];
    this.pageValidationMessage = "";
  }

  handleTranchCountChange(event) {
    const count = Number(event.detail.value);
    this.tranchCount = event.detail.value;
    if (!Number.isInteger(count) || count < 1) {
      this.plannedTranches = [];
      this.currentTranchIndex = 0;
      return;
    }

    const normalizedCount = Math.min(count, 20);
    const removedExistingIds = this.plannedTranches
      .slice(normalizedCount)
      .map((tranch) => tranch.id)
      .filter(Boolean);
    if (removedExistingIds.length) {
      this.deletedTranchIds = [
        ...new Set([...this.deletedTranchIds, ...removedExistingIds])
      ];
    }
    this.plannedTranches = Array.from({ length: normalizedCount }, (_, i) =>
      this.buildPlannedTranch(i)
    );
    this.currentTranchIndex = Math.min(
      this.currentTranchIndex,
      this.plannedTranches.length - 1
    );
  }

  handlePlannedNameChange(event) {
    this.pageValidationMessage = "";
    this.updatePlannedTranch(event, "name");
  }

  handlePlannedDueDateChange(event) {
    this.pageValidationMessage = "";
    this.updatePlannedTranch(event, "dueDate");
  }

  handleAssignComponent(event) {
    const componentId = event.target.dataset.id;
    const selectedIds = new Set(this.currentSelectedComponentIds);
    selectedIds.add(componentId);
    this.updateCurrentSelectedComponentIds([...selectedIds]);
  }

  handleRemoveComponent(event) {
    const componentId = event.target.dataset.id;
    const selectedIds = new Set(this.currentSelectedComponentIds);
    selectedIds.delete(componentId);
    this.updateCurrentSelectedComponentIds([...selectedIds]);
  }

  handleSelectEditTranch(event) {
    this.currentTranchIndex = Number(event.currentTarget.dataset.index);
    this.pageValidationMessage = "";
  }

  updateCurrentSelectedComponentIds(componentIds) {
    this.plannedTranches = this.plannedTranches.map((tranch) => {
      if (tranch.index === this.currentTranchIndex) {
        return { ...tranch, componentIds };
      }
      return tranch;
    });
  }

  handlePreviousTranch() {
    if (!this.validateCurrentTranch()) {
      return;
    }
    this.pageValidationMessage = "";
    this.currentTranchIndex = Math.max(0, this.currentTranchIndex - 1);
  }

  handleNextTranch() {
    if (!this.validateCurrentTranch()) {
      return;
    }
    this.pageValidationMessage = "";
    this.currentTranchIndex = Math.min(
      this.plannedTranches.length - 1,
      this.currentTranchIndex + 1
    );
  }

  handleDeleteCurrentPage() {
    if (this.isDeleteCurrentPageDisabled) {
      return;
    }

    const nextPlannedTranches = this.plannedTranches
      .filter((tranch) => tranch.index !== this.currentTranchIndex)
      .map((tranch, index) => this.renumberPlannedTranch(tranch, index));
    if (this.currentTranch.id) {
      this.deletedTranchIds = [...this.deletedTranchIds, this.currentTranch.id];
    }

    this.plannedTranches = nextPlannedTranches;
    this.tranchCount = String(nextPlannedTranches.length);
    this.currentTranchIndex = Math.min(
      this.currentTranchIndex,
      nextPlannedTranches.length - 1
    );
    this.pageValidationMessage = "";
  }

  validateCurrentTranch() {
    const inputs = [
      ...this.template.querySelectorAll("[data-current-tranch-due-date]")
    ];
    const isValid = inputs.every((input) => input.reportValidity());
    this.pageValidationMessage = isValid
      ? ""
      : "Completa la data di scadenza prima di passare a un'altra tranch.";
    return isValid;
  }

  updatePlannedTranch(event, fieldName) {
    const index = Number(event.target.dataset.index);
    this.plannedTranches = this.plannedTranches.map((tranch) => {
      if (tranch.index === index) {
        return { ...tranch, [fieldName]: event.detail.value };
      }
      return tranch;
    });
  }

  buildPlannedTranch(index) {
    const existing = this.plannedTranches[index] || {};
    const sequence = index + 1;
    return {
      key: `planned-${sequence}`,
      index,
      sequence,
      name: existing.name || `BT${sequence} - ${this.bundleName}`,
      dueDate: existing.dueDate || "",
      componentIds: existing.componentIds || []
    };
  }

  buildExistingPlannedTranch(tranch, index) {
    return {
      key: `planned-${tranch.tranchId}`,
      id: tranch.tranchId,
      index,
      sequence: index + 1,
      name: tranch.tranchName,
      dueDate: tranch.dueDate || "",
      componentIds: this.components
        .filter((component) => component.bundleTranchId === tranch.tranchId)
        .map((component) => component.id)
    };
  }

  renumberPlannedTranch(tranch, index) {
    const sequence = index + 1;
    const generatedNamePattern = /^(B)?T\d+ - /;
    const shouldRefreshName =
      !tranch.name || generatedNamePattern.test(tranch.name);
    return {
      ...tranch,
      key: `planned-${sequence}`,
      index,
      sequence,
      name: shouldRefreshName
        ? `BT${sequence} - ${this.bundleName}`
        : tranch.name
    };
  }

  async handleSave() {
    const inputs = [...this.template.querySelectorAll("lightning-input")];
    if (!inputs.every((input) => input.reportValidity())) {
      return;
    }
    if (this.hasUnassignedComponents) {
      this.pageValidationMessage =
        "Assegna ogni componente del bundle a una tranch prima di salvare.";
      this.showToast("Errore", this.pageValidationMessage, "error");
      return;
    }

    const wasEditMode = this.isEditMode;
    this.isLoading = true;
    try {
      this.applyContext(
        await saveTranches({
          bundleId: this.recordId,
          tranchInputsJson: JSON.stringify(
            this.plannedTranches.map((tranch) => ({
              name: tranch.name.trim(),
              tranchId: tranch.id,
              dueDate: tranch.dueDate,
              sequence: tranch.sequence,
              componentIds: tranch.componentIds
            }))
          ),
          deletedTranchIdsJson: JSON.stringify(this.deletedTranchIds)
        })
      );
      this.showToast(
        "Successo",
        wasEditMode ? "Tranch aggiornate." : "Tranch create correttamente.",
        "success"
      );
      this.dispatchEvent(new CustomEvent("saved"));
    } catch (error) {
      this.showToast("Errore", this.reduceError(error), "error");
    } finally {
      this.isLoading = false;
    }
  }

  handleCancel() {
    this.dispatchEvent(new CustomEvent("cancel"));
  }

  ordinalLabel(numberValue) {
    const labels = [
      "Prima",
      "Seconda",
      "Terza",
      "Quarta",
      "Quinta",
      "Sesta",
      "Settima",
      "Ottava",
      "Nona",
      "Decima"
    ];
    return labels[numberValue - 1] || `${numberValue}a`;
  }

  decorateComponent(component) {
    return {
      ...component,
      productCode: component.productCode || "Nessun codice",
      productName: component.productName || "Prodotto senza nome",
      spreadLabel: this.formatAmount(component.spreadPrice)
    };
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
