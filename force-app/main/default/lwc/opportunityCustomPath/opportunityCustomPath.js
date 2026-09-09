import { LightningElement, api, wire } from "lwc";
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { getRecord, updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";

import OPPORTUNITY_OBJECT from "@salesforce/schema/Opportunity";
import ID_FIELD from "@salesforce/schema/Opportunity.Id";
import STAGE_FIELD from "@salesforce/schema/Opportunity.StageName";
import CLOSE_DATE_FIELD from "@salesforce/schema/Opportunity.CloseDate";
import RECALL_REASON_FIELD from "@salesforce/schema/Opportunity.Motivazione_Da_Ricontattare__c";
import LOST_REASON_FIELD from "@salesforce/schema/Opportunity.Motivazione_Chiusa_Persa__c";

const STAGES = [
  "Qualificato",
  "In trattativa (Prev inviato)",
  "Da ricontattare - Prev. inviato",
  "Chiusa/Vinta",
  "Chiusa/Persa"
];

const REASON_BY_STAGE = {
  "Da ricontattare - Prev. inviato": {
    field: RECALL_REASON_FIELD,
    label: "Motivazione Da Ricontattare",
    title: "Move to Da ricontattare",
    guidance:
      "Fill in the recall reason before moving the Opportunity to Da ricontattare.",
    missingMessage: "Select Motivazione Da Ricontattare."
  },
  "Chiusa/Persa": {
    field: LOST_REASON_FIELD,
    label: "Motivazione Chiusa Persa",
    title: "Close Opportunity as lost",
    guidance:
      "Fill in the lost reason before closing the Opportunity as Chiusa/Persa.",
    missingMessage: "Select Motivazione Chiusa Persa."
  }
};

const FIELDS = [
  STAGE_FIELD,
  CLOSE_DATE_FIELD,
  RECALL_REASON_FIELD,
  LOST_REASON_FIELD
];

export default class OpportunityCustomPath extends LightningElement {
  @api recordId;

  currentStage;
  selectedStage;
  closeDate;
  recallReason;
  lostReason;
  isSaving = false;
  showReasonModal = false;

  recallReasonOptions = [];
  lostReasonOptions = [];

  @wire(getObjectInfo, { objectApiName: OPPORTUNITY_OBJECT })
  objectInfo;

  @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
  wiredOpportunity({ data }) {
    if (!data) {
      return;
    }

    this.currentStage = data.fields.StageName.value;
    this.selectedStage = this.selectedStage || this.currentStage;
    this.closeDate = data.fields.CloseDate.value;
    this.recallReason = data.fields.Motivazione_Da_Ricontattare__c.value;
    this.lostReason = data.fields.Motivazione_Chiusa_Persa__c.value;
  }

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: RECALL_REASON_FIELD
  })
  wiredRecallReasons({ data }) {
    if (data) {
      this.recallReasonOptions = data.values;
    }
  }

  @wire(getPicklistValues, {
    recordTypeId: "$objectInfo.data.defaultRecordTypeId",
    fieldApiName: LOST_REASON_FIELD
  })
  wiredLostReasons({ data }) {
    if (data) {
      this.lostReasonOptions = data.values;
    }
  }

  get selectedOrCurrentStage() {
    return this.selectedStage || this.currentStage;
  }

  get stageItems() {
    const currentIndex = STAGES.indexOf(this.currentStage);
    const selectedStage = this.selectedOrCurrentStage;

    return STAGES.map((stage, index) => {
      const classes = ["stage-button"];
      if (stage === this.currentStage) {
        classes.push("current");
      } else if (index < currentIndex) {
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

  get selectedReasonConfig() {
    return REASON_BY_STAGE[this.selectedStage];
  }

  get modalTitle() {
    return this.selectedReasonConfig?.title;
  }

  get modalGuidance() {
    return this.selectedReasonConfig?.guidance;
  }

  get reasonLabel() {
    return this.selectedReasonConfig?.label;
  }

  get reasonMissingMessage() {
    return this.selectedReasonConfig?.missingMessage;
  }

  get reasonOptions() {
    return this.selectedStage === "Chiusa/Persa"
      ? this.lostReasonOptions
      : this.recallReasonOptions;
  }

  get reasonValue() {
    return this.selectedStage === "Chiusa/Persa"
      ? this.lostReason
      : this.recallReason;
  }

  handleStageSelect(event) {
    this.selectedStage = event.currentTarget.dataset.stage;
  }

  handleMarkCurrent() {
    if (this.selectedReasonConfig && !this.reasonValue) {
      this.showReasonModal = true;
      return;
    }

    this.saveStage();
  }

  handleReasonChange(event) {
    if (this.selectedStage === "Chiusa/Persa") {
      this.lostReason = event.detail.value;
    } else {
      this.recallReason = event.detail.value;
    }
  }

  handleReasonSave() {
    const reasonInput = this.template.querySelector(".reason-field");
    if (reasonInput && !reasonInput.reportValidity()) {
      return;
    }

    this.saveStage();
  }

  closeModal() {
    this.showReasonModal = false;
  }

  async saveStage() {
    this.isSaving = true;
    const fields = {
      [ID_FIELD.fieldApiName]: this.recordId,
      [STAGE_FIELD.fieldApiName]: this.selectedStage
    };

    if (this.selectedStage === "Da ricontattare - Prev. inviato") {
      fields[RECALL_REASON_FIELD.fieldApiName] = this.recallReason;
    }

    if (this.selectedStage === "Chiusa/Persa") {
      fields[LOST_REASON_FIELD.fieldApiName] = this.lostReason;
    }

    try {
      await updateRecord({ fields });
      this.currentStage = this.selectedStage;
      this.showReasonModal = false;
      this.dispatchEvent(new RefreshEvent());
      this.showToast("Stage updated", "Opportunity stage updated.", "success");
    } catch (error) {
      this.showToast(
        "Unable to update stage",
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
    return (
      error?.body?.output?.errors?.[0]?.message ||
      error?.body?.message ||
      "An unexpected error occurred."
    );
  }
}
