import { LightningElement, api, wire } from "lwc";
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import { getFieldValue, getRecord, updateRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { RefreshEvent } from "lightning/refresh";
import { onError, subscribe, unsubscribe } from "lightning/empApi";
import { NavigationMixin } from "lightning/navigation";

import LEAD_OBJECT from "@salesforce/schema/Lead";
import AGENT_FIELD from "@salesforce/schema/Lead.Agente__c";
import COMPANY_FIELD from "@salesforce/schema/Lead.Company";
import ID_FIELD from "@salesforce/schema/Lead.Id";
import STATUS_FIELD from "@salesforce/schema/Lead.Status";
import RECORD_TYPE_ID_FIELD from "@salesforce/schema/Lead.RecordTypeId";
import RECORD_TYPE_DEVELOPER_NAME_FIELD from "@salesforce/schema/Lead.RecordType.DeveloperName";
import EXIT_REASON_FIELD from "@salesforce/schema/Lead.Motivazione_Uscita__c";
import EXIT_REASON_DETAIL_FIELD from "@salesforce/schema/Lead.Dettaglio_Motivazione_Uscita__c";
import MOTIVAZIONE_FIELD from "@salesforce/schema/Lead.Motivazione__c";

const STANDARD_STAGES = [
  "New",
  "In Lavorazione",
  "Non Risponde",
  "Primo contatto",
  "Qualificato",
  "Non qualificato"
];

const DIRETTA_STAGES = ["New", "Qualificato", "Non qualificato"];
const QUALIFIED_STAGE = "Qualificato";
const LEAD_CONVERSION_CHANNEL = "/event/Lead_Conversion_Completed__e";

const KEY_FIELDS_BY_STAGE = {
  New: [COMPANY_FIELD],
  Qualificato: [AGENT_FIELD],
  "Non qualificato": [EXIT_REASON_FIELD, EXIT_REASON_DETAIL_FIELD]
};

const FIELDS = [
  STATUS_FIELD,
  RECORD_TYPE_ID_FIELD,
  RECORD_TYPE_DEVELOPER_NAME_FIELD,
  COMPANY_FIELD,
  AGENT_FIELD,
  EXIT_REASON_FIELD,
  EXIT_REASON_DETAIL_FIELD,
  MOTIVAZIONE_FIELD
];

export default class LeadCustomPath extends NavigationMixin(LightningElement) {
  @api recordId;

  leadObjectApiName = LEAD_OBJECT;
  currentStage;
  selectedStage;
  leadRecordTypeId;
  leadRecordTypeDeveloperName;
  company;
  agentId;
  exitReason;
  exitReasonDetail;
  motivazione;
  isSaving = false;
  isWaitingForConversion = false;
  showExitReasonModal = false;
  conversionSubscription;
  conversionSubscriptionPromise;

  exitReasonOptions = [];
  exitReasonDetailOptions = [];
  exitReasonDetailControllerValues = {};

  @wire(getObjectInfo, { objectApiName: LEAD_OBJECT })
  objectInfo;

  connectedCallback() {
    this.conversionSubscriptionPromise = this.subscribeToConversionEvents();
    onError(() => {
      if (this.isWaitingForConversion) {
        this.isWaitingForConversion = false;
        this.isSaving = false;
        this.showToast(
          "Aggiornamento automatico non disponibile",
          "La conversione continua in background. Aggiorna la pagina tra poco.",
          "warning"
        );
      }
    });
  }

  disconnectedCallback() {
    if (this.conversionSubscription) {
      unsubscribe(this.conversionSubscription, () => {});
      this.conversionSubscription = undefined;
    }
  }

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
    this.company = data.fields.Company.value;
    this.agentId = data.fields.Agente__c.value;
    this.exitReason = data.fields.Motivazione_Uscita__c.value;
    this.exitReasonDetail = data.fields.Dettaglio_Motivazione_Uscita__c.value;
    this.motivazione = getFieldValue(data, MOTIVAZIONE_FIELD);
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

  get keyFields() {
    return (KEY_FIELDS_BY_STAGE[this.selectedOrCurrentStage] || []).map(
      (field) => ({
        fieldName: field.fieldApiName,
        required: true
      })
    );
  }

  get showKeyFields() {
    return this.keyFields.length > 0;
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
    if (this.isWaitingForConversion) {
      return "Conversione Lead in corso...";
    }

    return this.isSaving
      ? "Aggiornamento fase..."
      : `Stato: ${this.currentStage || ""}`;
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

  get requiresMotivazione() {
    return (
      this.exitReason === "Perso" && this.exitReasonDetail === "Non interessato"
    );
  }

  get showMotivazione() {
    return (
      this.selectedOrCurrentStage === "Non qualificato" &&
      this.requiresMotivazione
    );
  }

  handleStageSelect(event) {
    this.selectedStage = event.currentTarget.dataset.stage;
  }

  handleMarkCurrent() {
    if (!this.reportKeyFieldValidity()) {
      return;
    }

    this.saveStage();
  }

  handleKeyFieldChange(event) {
    this.assignKeyFieldValue(
      event.target.dataset.fieldName || event.target.fieldName,
      event.detail.value
    );
  }

  handleExitReasonChange(event) {
    this.exitReason = event.detail.value;
    this.exitReasonDetail = undefined;
    this.motivazione = "";
  }

  handleExitReasonDetailChange(event) {
    this.exitReasonDetail = event.detail.value;
    if (!this.requiresMotivazione) {
      this.motivazione = "";
    }
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
    const shouldWaitForConversion = this.selectedStage === QUALIFIED_STAGE;
    this.isWaitingForConversion = shouldWaitForConversion;
    const fields = {
      [ID_FIELD.fieldApiName]: this.recordId,
      [STATUS_FIELD.fieldApiName]: this.selectedStage,
      ...this.collectKeyFieldValues()
    };

    if (this.selectedStage === "Non qualificato") {
      fields[EXIT_REASON_FIELD.fieldApiName] = this.exitReason;
      fields[EXIT_REASON_DETAIL_FIELD.fieldApiName] = this.exitReasonDetail;
      fields[MOTIVAZIONE_FIELD.fieldApiName] = this.motivazione;
    }

    try {
      if (shouldWaitForConversion) {
        const subscription = await this.conversionSubscriptionPromise;
        if (!subscription) {
          throw new Error(
            "Impossibile ascoltare il completamento della conversione. Riprova."
          );
        }
      }

      await updateRecord({ fields });
      this.currentStage = this.selectedStage;
      this.showExitReasonModal = false;

      if (shouldWaitForConversion) {
        return;
      }

      this.dispatchEvent(new RefreshEvent());
      this.showToast(
        "Fase aggiornata",
        "Lo stato del Lead e stato aggiornato.",
        "success"
      );
    } catch (error) {
      this.isWaitingForConversion = false;
      this.showToast(
        "Impossibile aggiornare la fase",
        this.errorMessage(error),
        "error"
      );
    } finally {
      if (!this.isWaitingForConversion) {
        this.isSaving = false;
      }
    }
  }

  subscribeToConversionEvents() {
    return subscribe(LEAD_CONVERSION_CHANNEL, -1, (message) => {
      this.handleConversionEvent(message);
    })
      .then((subscription) => {
        this.conversionSubscription = subscription;
        return subscription;
      })
      .catch(() => null);
  }

  handleConversionEvent(message) {
    const payload = message?.data?.payload;
    if (payload?.Lead_Id__c !== this.recordId) {
      return;
    }

    this.isWaitingForConversion = false;
    this.isSaving = false;

    if (payload.Succeeded__c === true) {
      this.showToast(
        "Lead convertito",
        "La conversione del Lead e stata completata.",
        "success"
      );

      if (payload.Account_Id__c) {
        this[NavigationMixin.Navigate](
          {
            type: "standard__recordPage",
            attributes: {
              recordId: payload.Account_Id__c,
              objectApiName: "Account",
              actionName: "view"
            }
          },
          true
        );
        return;
      }
    } else {
      this.showToast(
        "Conversione non completata",
        "La conversione non e riuscita. Lo stato precedente e stato ripristinato.",
        "error"
      );
      window.location.reload();
      return;
    }

    this.dispatchEvent(new RefreshEvent());
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
      error?.message ||
      "Si e verificato un errore imprevisto."
    );
  }

  reportKeyFieldValidity() {
    const inputs = this.template.querySelectorAll(".key-field");
    return [...inputs].reduce(
      (valid, input) => input.reportValidity() && valid,
      true
    );
  }

  collectKeyFieldValues() {
    const fields = {};
    const inputs = this.template.querySelectorAll(".key-field");

    inputs.forEach((input) => {
      const fieldName = input.dataset.fieldName || input.fieldName;
      if (fieldName) {
        const value = this.normalizeFieldValue(input.value);
        fields[fieldName] = value;
        this.assignKeyFieldValue(fieldName, value);
      }
    });

    return fields;
  }

  assignKeyFieldValue(fieldName, value) {
    const normalizedValue = this.normalizeFieldValue(value);

    if (fieldName === COMPANY_FIELD.fieldApiName) {
      this.company = normalizedValue;
    } else if (fieldName === AGENT_FIELD.fieldApiName) {
      this.agentId = normalizedValue;
    } else if (fieldName === EXIT_REASON_FIELD.fieldApiName) {
      this.exitReason = normalizedValue;
      this.exitReasonDetail = undefined;
    } else if (fieldName === EXIT_REASON_DETAIL_FIELD.fieldApiName) {
      this.exitReasonDetail = normalizedValue;
    } else if (fieldName === MOTIVAZIONE_FIELD.fieldApiName) {
      this.motivazione = normalizedValue?.trim();
    }
  }

  normalizeFieldValue(value) {
    return Array.isArray(value) ? value[0] : value;
  }
}
