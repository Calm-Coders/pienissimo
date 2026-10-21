import { LightningElement, api, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import {
  decodeDefaultFieldValues,
  encodeDefaultFieldValues
} from "lightning/pageReferenceUtils";
import {
  getRecord,
  getFieldValue,
  getRecordCreateDefaults
} from "lightning/uiRecordApi";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import USER_ID from "@salesforce/user/Id";
import USER_NAME from "@salesforce/schema/User.Name";
import AGENT_CODE from "@salesforce/schema/User.Agente__c";
import COMMISSION_CATEGORY from "@salesforce/schema/User.Categoria_Provvigioni_Cliente__c";

// Azienda FlexiPage sections, trimmed for the Account creation form.
const AZIENDA_SECTIONS = [
  {
    label: "Informazioni principali",
    columns: [
      ["Name", "OwnerId", "RecordTypeId", "Phone", "Type", "Zona__c"],
      ["Email__c", "Industry", "IBAN__c"]
    ]
  },
  {
    label: "Indirizzi",
    columns: [["BillingAddress"], ["ShippingAddress"]]
  },
  {
    label: "Dati MEXAL",
    columns: [
      [
        "Categoria_Statistica_Mexal__c",
        "Codice_Fiscale__c",
        "Codice_Destinatario_SDI__c",
        "Residenza_Fiscale__c"
      ],
      ["Partita_IVA__c", "PEC__c"]
    ]
  },
  {
    label: "Dati Commerciali",
    columns: [
      ["Descrizione_ATECO__c", "Codice_ATECO__c", "Ateco_Stato_Attivita__c"],
      [
        "Azienda_Obsoleta__c",
        "Azienda_Precedente__c",
        "Stato_Azienda__c",
        "Tipologia_Attivita_Globale__c"
      ]
    ]
  },
  {
    label: "MEXAL - Dati per le provvigioni",
    columns: [
      ["Agente__c", "Codice_Agente_Esterno__c"],
      ["Categoria_Provvigioni_Cliente__c"]
    ]
  },
  {
    label: "System Information",
    columns: [["CreatedById"], ["LastModifiedById"]]
  }
];

export default class NuovoAccount extends NavigationMixin(LightningElement) {
  @api recordTypeId;
  userRecord;
  userLoaded = false;
  hasError = false;
  _pageReference;
  navigated = false;
  formOpen = false;
  isLeaving = false;
  formDefaults = {};
  formRecordTypeId;
  navigationState;
  objectInfo;
  createDefaults;
  chosenRecordTypeId;
  selectedAgentId;
  selectedOwnerId;
  ownerFilter = {
    criteria: [{ fieldPath: "IsActive", operator: "eq", value: true }]
  };
  agentCode = "";
  category = "";
  agentLoading = false;
  agentError = "";
  errorMessage = "";
  saving = false;
  initialized = false;
  delegated = false;

  @api
  get pageReference() {
    return this._pageReference;
  }

  set pageReference(value) {
    this.isLeaving = false;
    this._pageReference = value;
    this.navigated = false;
    this.formOpen = false;
    this.openFromOverride();
  }

  get showButton() {
    return (
      !this.isLeaving &&
      (!this._pageReference ||
        this.hasError ||
        this.navigated ||
        Boolean(this._pageReference.state?.nooverride))
    );
  }

  get showReturnButton() {
    return Boolean(this._pageReference);
  }

  get showOpeningSpinner() {
    return !this.isLeaving;
  }

  get modalTitle() {
    const type = this.objectInfo?.recordTypeInfos?.[this.effectiveRecordTypeId];
    return type?.name ? `Nuovo Account: ${type.name}` : "Nuovo Account";
  }

  handleModalKeydown(event) {
    if (event.key === "Escape") {
      event.preventDefault();
      this.handleCancel();
    }
  }

  focusFirstControl() {
    this.template.querySelector("lightning-button-icon")?.focus();
  }

  focusLastControl() {
    const buttons = [...this.template.querySelectorAll("lightning-button")];
    buttons
      .filter((button) => !button.disabled)
      .pop()
      ?.focus();
  }

  returnToAccounts() {
    this.isLeaving = true;
    this.formOpen = false;
    this[NavigationMixin.Navigate](
      {
        type: "standard__objectPage",
        attributes: { objectApiName: "Account", actionName: "list" },
        state: { filterName: "Recent" }
      },
      true
    );
  }

  openFromOverride() {
    if (
      this._pageReference?.attributes?.actionName === "new" &&
      !this._pageReference.state?.nooverride &&
      this.userLoaded &&
      !this.hasError &&
      !this.navigated
    ) {
      this.openAccountForm();
    }
  }

  get isLoading() {
    return !this.userLoaded;
  }

  @wire(getRecord, {
    recordId: USER_ID,
    fields: [USER_NAME],
    optionalFields: [AGENT_CODE, COMMISSION_CATEGORY]
  })
  loadUser({ data, error }) {
    if (data) {
      this.userRecord = data;
      this.userLoaded = true;
      this.hasError = false;
      this.openFromOverride();
    } else if (error) {
      this.userRecord = undefined;
      this.userLoaded = true;
      this.hasError = true;
    }
  }

  openAccountForm() {
    if (!this.userLoaded) {
      return;
    }
    this.isLeaving = false;
    const state = { ...this._pageReference?.state, nooverride: "1" };
    if (this._pageReference) {
      // Keep the list behind the standard modal, rather than the override page.
      state.backgroundContext = "/lightning/o/Account/list?filterName=Recent";
      state.navigationLocation = "LIST_VIEW";
    }
    if (this.recordTypeId && !state.recordTypeId) {
      state.recordTypeId = this.recordTypeId;
    }
    const defaults = state.defaultFieldValues
      ? decodeDefaultFieldValues(state.defaultFieldValues)
      : {};
    const agentCode = this.userRecord
      ? getFieldValue(this.userRecord, AGENT_CODE)
      : null;
    const category = this.userRecord
      ? getFieldValue(this.userRecord, COMMISSION_CATEGORY)
      : null;

    // Both values are required by the Account agent lookup filter.
    if (agentCode?.trim() && category?.trim()) {
      defaults.Agente__c = USER_ID;
    }
    // Derived fields are written by the Account trigger, including for Locale.
    delete defaults.Codice_Agente_Esterno__c;
    delete defaults.Categoria_Provvigioni_Cliente__c;
    if (Object.keys(defaults).length) {
      state.defaultFieldValues = encodeDefaultFieldValues(defaults);
    }
    this.navigated = true;
    this.navigationState = state;
    this.formDefaults = defaults;
    this.formRecordTypeId = state.recordTypeId;
    this.createDefaults = undefined;
    this.chosenRecordTypeId = undefined;
    this.initialized = false;
    this.delegated = false;
    this.errorMessage = "";
    this.agentError = "";
    this.saving = false;
    this.selectedOwnerId = defaults.OwnerId || USER_ID;
    this.selectedAgentId = defaults.Agente__c || undefined;
    this.agentCode = defaults.Codice_Agente_Esterno__c || "";
    this.category = defaults.Categoria_Provvigioni_Cliente__c || "";
    this.agentLoading = Boolean(this.selectedAgentId);
    this.formOpen = true;
  }

  handleCreated(event) {
    this.isLeaving = true;
    this.formOpen = false;
    this[NavigationMixin.Navigate](
      {
        type: "standard__recordPage",
        attributes: {
          recordId: event.detail.id,
          objectApiName: "Account",
          actionName: "view"
        }
      },
      true
    );
  }

  openStandardForm(event) {
    this.isLeaving = true;
    this.formOpen = false;
    const state = {
      ...this.navigationState,
      recordTypeId: event.detail.recordTypeId
    };
    const destination = {
      type: "standard__objectPage",
      attributes: { objectApiName: "Account", actionName: "new" },
      state
    };
    if (this._pageReference) {
      this[NavigationMixin.Navigate](destination, true);
    } else {
      this[NavigationMixin.Navigate](destination);
    }
  }
  @wire(getObjectInfo, { objectApiName: "Account" })
  loadObjectInfo({ data, error }) {
    if (data) this.objectInfo = data;
    else if (error)
      this.errorMessage = "Impossibile caricare i tipi di Account. Riprova.";
  }

  get recordTypeOptions() {
    return Object.values(this.objectInfo?.recordTypeInfos || {})
      .filter((info) => info.available && !info.master)
      .map((info) => ({ label: info.name, value: info.recordTypeId }));
  }

  get needsRecordType() {
    return (
      !this.formRecordTypeId &&
      !this.chosenRecordTypeId &&
      this.recordTypeOptions.length > 1
    );
  }

  get effectiveRecordTypeId() {
    if (this.needsRecordType) return undefined;
    return (
      this.chosenRecordTypeId ||
      this.formRecordTypeId ||
      this.objectInfo?.defaultRecordTypeId
    );
  }

  get defaultsObjectName() {
    return this.formOpen && this.effectiveRecordTypeId ? "Account" : undefined;
  }

  handleRecordTypeChange(event) {
    this.chosenRecordTypeId = event.detail.value;
    this.createDefaults = undefined;
    this.initialized = false;
  }

  @wire(getRecordCreateDefaults, {
    objectApiName: "$defaultsObjectName",
    recordTypeId: "$effectiveRecordTypeId"
  })
  loadDefaults({ data, error }) {
    if (data) {
      const info = data.objectInfos?.Account || this.objectInfo;
      const type = info?.recordTypeInfos?.[this.effectiveRecordTypeId];
      // Locale continues to use its existing standard creation form.
      if (type?.name === "Locale") {
        if (!this.delegated) {
          this.delegated = true;
          this.openStandardForm({
            detail: { recordTypeId: this.effectiveRecordTypeId }
          });
        }
        return;
      }
      this.createDefaults = data;
      this.errorMessage = "";
    } else if (error) {
      this.errorMessage = "Impossibile caricare il modulo Account. Riprova.";
    }
  }

  @wire(getRecord, {
    recordId: "$selectedAgentId",
    fields: [USER_NAME, AGENT_CODE, COMMISSION_CATEGORY]
  })
  loadAgent({ data, error }) {
    if (data && data.id === this.selectedAgentId) {
      this.agentCode = getFieldValue(data, AGENT_CODE) || "";
      this.category = getFieldValue(data, COMMISSION_CATEGORY) || "";
      this.agentLoading = false;
      this.agentError =
        this.agentCode.trim() && this.category.trim()
          ? ""
          : "Seleziona un agente con codice e categoria provvigioni valorizzati.";
    } else if (error) {
      this.agentLoading = false;
      this.agentError =
        "Impossibile leggere i dati dell'agente. Seleziona nuovamente l'agente.";
    }
  }

  handleAgentChange(event) {
    const value = event.detail.value;
    this.selectedAgentId =
      (Array.isArray(value) ? value[0] : value) || undefined;
    this.agentCode = "";
    this.category = "";
    this.agentError = "";
    this.agentLoading = Boolean(this.selectedAgentId);
  }

  get showForm() {
    return (
      Boolean(this.createDefaults) && !this.needsRecordType && !this.delegated
    );
  }

  get formLoading() {
    return !this.showForm && !this.needsRecordType && !this.errorMessage;
  }

  get saveDisabled() {
    return this.saving || this.agentLoading || Boolean(this.agentError);
  }

  get sections() {
    const metadata =
      this.createDefaults?.objectInfos?.Account?.fields ||
      this.objectInfo?.fields ||
      {};
    const layoutRules = new Map();
    for (const section of this.createDefaults?.layout?.sections || []) {
      for (const row of section.layoutRows || []) {
        for (const item of row.layoutItems || []) {
          for (const component of item.layoutComponents || []) {
            if (component.apiName) layoutRules.set(component.apiName, item);
          }
        }
      }
    }
    return AZIENDA_SECTIONS.map((section, sectionIndex) => {
      let columns = section.columns.map((names, columnIndex) => ({
        key: String(columnIndex),
        fields: names
          .filter((name) => {
            const derived =
              name === "Codice_Agente_Esterno__c" ||
              name === "Categoria_Provvigioni_Cliente__c";
            const writableAddress =
              (name === "BillingAddress" || name === "ShippingAddress") &&
              Object.values(metadata).some(
                (field) => field.compoundFieldName === name && field.createable
              );
            return (
              metadata[name] &&
              (derived ||
                writableAddress ||
                (metadata[name].createable &&
                  (name === "OwnerId" ||
                    layoutRules.get(name)?.editableForNew !== false))) &&
              name !== "RecordTypeId"
            );
          })
          .map((name) => ({
            name,
            required: Boolean(
              name !== "Azienda_Obsoleta__c" &&
              (layoutRules.get(name)?.required || metadata[name].required)
            ),
            isOwner: name === "OwnerId",
            isAgent: name === "Agente__c",
            isAgentCode: name === "Codice_Agente_Esterno__c",
            isCategory: name === "Categoria_Provvigioni_Cliente__c"
          }))
      }));
      const visibleFields = columns.flatMap((column) => column.fields);
      const midpoint = Math.ceil(visibleFields.length / 2);
      columns = [
        { key: "0", fields: visibleFields.slice(0, midpoint) },
        { key: "1", fields: visibleFields.slice(midpoint) }
      ];
      return {
        key: String(sectionIndex),
        label: section.label,
        isAgentSection: section.columns.some((names) =>
          names.includes("Agente__c")
        ),
        columns
      };
    }).filter((section) =>
      section.columns.some((column) => column.fields.length)
    );
  }

  handleLoad() {
    if (this.initialized) return;
    this.initialized = true;
    const defaults = { ...this.formDefaults };
    for (const [name, field] of Object.entries(
      this.createDefaults?.record?.fields || {}
    )) {
      if (!(name in defaults) && field.value !== null)
        defaults[name] = field.value;
    }
    this.template.querySelectorAll("lightning-input-field").forEach((input) => {
      if (input.fieldName === "Agente__c") {
        input.value = this.selectedAgentId || null;
      } else if (
        Object.prototype.hasOwnProperty.call(defaults, input.fieldName)
      ) {
        input.value = defaults[input.fieldName];
      }
    });
  }

  handleSubmit(event) {
    event.preventDefault();
    if (this.saveDisabled) return;
    const metadata = this.createDefaults?.objectInfos?.Account?.fields || {};
    const fields = Object.fromEntries(
      Object.entries(this.formDefaults).filter(
        ([name]) => metadata[name]?.createable
      )
    );
    Object.assign(fields, event.detail.fields);
    if (metadata.OwnerId?.createable) fields.OwnerId = this.selectedOwnerId;
    fields.RecordTypeId = this.effectiveRecordTypeId;
    fields.Agente__c = this.selectedAgentId || null;
    delete fields.Codice_Agente_Esterno__c;
    delete fields.Categoria_Provvigioni_Cliente__c;
    this.saving = true;
    this.template.querySelector("lightning-record-edit-form").submit(fields);
  }

  handleError() {
    this.saving = false;
  }

  handleSuccess(event) {
    this.saving = false;
    this.handleCreated(event);
  }

  handleCancel() {
    if (!this.saving) this.returnToAccounts();
  }
}
