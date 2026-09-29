import { LightningElement, api, wire } from "lwc";
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { getFieldValue, getRecord, updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";

import LEAD_OBJECT from "@salesforce/schema/Lead";
import ID_FIELD from "@salesforce/schema/Lead.Id";
import STATUS_FIELD from "@salesforce/schema/Lead.Status";
import RECORD_TYPE_ID_FIELD from "@salesforce/schema/Lead.RecordTypeId";
import RECORD_TYPE_DEVELOPER_NAME_FIELD from "@salesforce/schema/Lead.RecordType.DeveloperName";
import EXIT_REASON_FIELD from "@salesforce/schema/Lead.Motivazione_Uscita__c";
import EXIT_REASON_DETAIL_FIELD from "@salesforce/schema/Lead.Dettaglio_Motivazione_Uscita__c";

const STANDARD_STAGES = [
  "New",
  "In Lavorazione",
  "Non Risponde",
  "Primo contatto",
  "Qualificato",
  "Non qualificato"
];

const DIRETTA_STAGES = ["New", "Qualificato"];

const FIELDS = [
  STATUS_FIELD,
  RECORD_TYPE_ID_FIELD,
  RECORD_TYPE_DEVELOPER_NAME_FIELD,
  EXIT_REASON_FIELD,
  EXIT_REASON_DETAIL_FIELD
];

export default class LeadCustomPath extends LightningElement {
  @api recordId;

  currentStage;
  selectedStage;
  leadRecordTypeId;
  leadRecordTypeDeveloperName;
  exitReason;
  exitReasonDetail;
  isSaving = false;
  showExitReasonModal = false;

  exitReasonOptions = [];
  exitReasonDetailOptions = [];
  exitReasonDetailControllerValues = {};

  @wire(getObjectInfo, { objectApiName: LEAD_OBJECT })
  objectInfo;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  wiredLead({ data }) {
    if (!data) {
      return;
    }

    this.currentStage = data.fields.Status.value;
    this.selectedStage = this.selectedStage || this.currentStage;
    this.leadRecordTypeId = data.fields.RecordTypeId.value;
    this.leadRecordTypeDeveloperName = getFieldValue(
      data,
      RECORD_TYPE_DEVELOPER_NAME_FIELD
    );
    this.exitReason = data.fields.Motivazione_Uscita__c.value;
    this.exitReasonDetail = data.fields.Dettaglio_Motivazione_Uscita__c.value;
  }

  @wire(getPicklistValues, {
    recordTypeId: "$leadRecordTypeId",
    fieldApiName: EXIT_REASON_FIELD
  })
  wiredExitReasons({ data }) {
    if (data) {
      this.exitReasonOptions = data.values;
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$leadRecordTypeId",
    fieldApiName: EXIT_REASON_DETAIL_FIELD
  })
  wiredExitReasonDetails({ data }) {
    if (data) {
      this.exitReasonDetailOptions = data.values;
      this.exitReasonDetailControllerValues = data.controllerValues || {};
    }
  }

  get stages() {
    return this.leadRecordTypeDeveloperName === "Diretta"
      ? DIRETTA_STAGES
      : STANDARD_STAGES;
  }

  get selectedOrCurrentStage() {
    return this.selectedStage || this.currentStage;
  }

  get stageItems() {
    const stages = this.stages;
    const currentIndex = stages.indexOf(this.currentStage);
    const selectedStage = this.selectedOrCurrentStage;

    return stages.map((stage, index) => {
      const classes = ["stage-button"];
      if (stage === this.currentStage) {
        classes.push("current");
      } else if (currentIndex >= 0 && index < currentIndex) {
        classes.push("complete");
      }
      if (stage === selectedStage) {
        classes.push("selected");
      }

      return {
        className: classes.join(" "),
        label: stage,
        value: stage
      };
    });
  }

  get markDisabled() {
    return (
      this.isSaving ||
      !this.selectedStage ||
      this.selectedStage === this.currentStage
    );
  }

  get statusClass() {
    return this.isSaving ? "status saving" : "status";
  }

  get statusText() {
    return this.isSaving
      ? "Updating stage..."
      : `Status: ${this.currentStage || ""}`;
  }

  get filteredExitReasonDetailOptions() {
    if (!this.exitReason) {
      return [];
    }

    const controllerIndex =
      this.exitReasonDetailControllerValues[this.exitReason];

    return this.exitReasonDetailOptions.filter((option) =>
      option.validFor?.includes(controllerIndex)
    );
  }

  get exitReasonDetailDisabled() {
    return !this.exitReason;
  }

  handleStageSelect(event) {
    this.selectedStage = event.currentTarget.dataset.stage;
  }

  handleMarkCurrent() {
    if (
      this.selectedStage === "Non qualificato" &&
      (!this.exitReason || !this.exitReasonDetail)
    ) {
      this.showExitReasonModal = true;
      return;
    }

    this.saveStage();
  }

  handleExitReasonChange(event) {
    this.exitReason = event.detail.value;
    this.exitReasonDetail = undefined;
  }

  handleExitReasonDetailChange(event) {
    this.exitReasonDetail = event.detail.value;
  }

  handleExitReasonSave() {
    const inputs = this.template.querySelectorAll(".exit-reason-field");
    const isValid = [...inputs].reduce(
      (valid, input) => input.reportValidity() && valid,
      true
    );

    if (!isValid) {
      return;
    }

    this.saveStage();
  }

  closeModal() {
    this.showExitReasonModal = false;
  }

  async saveStage() {
    this.isSaving = true;
    const fields = {
      [ID_FIELD.fieldApiName]: this.recordId,
      [STATUS_FIELD.fieldApiName]: this.selectedStage
    };

    if (this.selectedStage === "Non qualificato") {
      fields[EXIT_REASON_FIELD.fieldApiName] = this.exitReason;
      fields[EXIT_REASON_DETAIL_FIELD.fieldApiName] = this.exitReasonDetail;
    }

    try {
      await updateRecord({ fields });
      this.currentStage = this.selectedStage;
      this.showExitReasonModal = false;
      this.dispatchEvent(new RefreshEvent());
      this.showToast(
        "Fase aggiornata",
        "Lo stato del Lead e stato aggiornato.",
        "success"
      );
    } catch (error) {
      this.showToast(
        "Impossibile aggiornare la fase",
        this.errorMessage(error),
        "error"
      );
    } finally {
      this.isSaving = false;
    }
  }

  showToast(title, message, variant) {
    this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
  }

  errorMessage(error) {
    const fieldErrors = error?.body?.output?.fieldErrors || {};
    const fieldErrorMessages = Object.values(fieldErrors)
      .flat()
      .map((fieldError) => fieldError.message);

    return (
      error?.body?.output?.errors?.[0]?.message ||
      fieldErrorMessages[0] ||
      error?.body?.message ||
      "Si e verificato un errore imprevisto."
    );
  }
}
