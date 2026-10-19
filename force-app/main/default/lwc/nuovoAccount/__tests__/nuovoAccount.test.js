import { createElement } from "lwc";
import NuovoAccount from "c/nuovoAccount";
import USER_ID from "@salesforce/user/Id";
import { decodeDefaultFieldValues } from "lightning/pageReferenceUtils";
import { mockNavigate as navigate } from "lightning/navigation";
jest.mock("lightning/navigation", () => {
  const mockNavigate = jest.fn();
  const symbol = Symbol("Navigate");
  const NavigationMixin = (Base) =>
    class extends Base {
      [symbol](...args) {
        mockNavigate(...args);
      }
    };
  NavigationMixin.Navigate = symbol;
  return { NavigationMixin, mockNavigate };
});
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { getRecord, getRecordCreateDefaults } from "lightning/uiRecordApi";

const metadata = {
  defaultRecordTypeId: "AZIENDA",
  recordTypeInfos: {
    AZIENDA: { name: "Azienda", recordTypeId: "AZIENDA", available: true },
    LOCALE: { name: "Locale", recordTypeId: "LOCALE", available: true }
  },
  fields: {
    Name: { createable: true, required: true },
    Phone: { createable: true },
    Agente__c: { createable: true },
    Codice_Agente_Esterno__c: { createable: true },
    Categoria_Provvigioni_Cliente__c: { createable: true },
    Secret__c: { createable: false }
  }
};
const defaults = {
  objectInfos: { Account: metadata },
  record: { fields: { Phone: { value: "DEFAULT" } } },
  layout: {
    sections: [
      {
        id: "info",
        heading: "Informazioni Account",
        layoutRows: [
          {
            layoutItems: [
              { required: true, layoutComponents: [{ apiName: "Name" }] },
              { layoutComponents: [{ apiName: "Phone" }] },
              { layoutComponents: [{ apiName: "Secret__c" }] },
              { layoutComponents: [{ apiName: "Agente__c" }] },
              { layoutComponents: [{ apiName: "Codice_Agente_Esterno__c" }] }
            ]
          }
        ]
      }
    ]
  }
};
async function mount(recordTypeId = "AZIENDA", initialDefaults = {}) {
  const element = createElement("c-nuovo-account", {
    is: NuovoAccount
  });
  decodeDefaultFieldValues.mockReturnValue(initialDefaults);
  element.pageReference = {
    attributes: { actionName: "new" },
    state: { recordTypeId, defaultFieldValues: "incoming" }
  };
  document.body.appendChild(element);
  getRecord.emit(
    { id: USER_ID, fields: { Name: { value: "Creator" } } },
    (config) => config.recordId === USER_ID
  );
  getObjectInfo.emit(metadata);
  await Promise.resolve();
  getRecordCreateDefaults.emit(defaults);
  await Promise.resolve();
  return element;
}
function selectAgent(element, id) {
  [...element.shadowRoot.querySelectorAll("lightning-input-field")]
    .find((input) => input.fieldName === "Agente__c")
    .dispatchEvent(
      new CustomEvent("change", { detail: { value: id ? [id] : [] } })
    );
}
function emitAgent(id, code, category) {
  getRecord.emit(
    {
      id,
      fields: {
        Name: { value: "Agent" },
        Agente__c: { value: code },
        Categoria_Provvigioni_Cliente__c: { value: category }
      }
    },
    (config) => config.recordId === id
  );
}
function inputs(element) {
  return [...element.shadowRoot.querySelectorAll("lightning-input")];
}
function saveButton(element) {
  return [...element.shadowRoot.querySelectorAll("lightning-button")].find(
    (button) => button.label === "Salva"
  );
}

beforeEach(() => {
  jest.clearAllMocks();
});

afterEach(() => {
  while (document.body.firstChild)
    document.body.removeChild(document.body.firstChild);
});

describe("live agent fields in custom Account form", () => {
  it("shows compound address inputs when their underlying fields are createable", async () => {
    const element = await mount();
    getRecordCreateDefaults.emit({
      ...defaults,
      objectInfos: {
        Account: {
          ...metadata,
          fields: {
            ...metadata.fields,
            BillingAddress: { createable: false, compound: true },
            ShippingAddress: { createable: false, compound: true },
            BillingStreet: {
              createable: true,
              compoundFieldName: "BillingAddress"
            },
            ShippingStreet: {
              createable: true,
              compoundFieldName: "ShippingAddress"
            }
          }
        }
      }
    });
    await Promise.resolve();
    const addressSection = [
      ...element.shadowRoot.querySelectorAll(".form-section")
    ].find(
      (section) => section.querySelector("h3").textContent === "Indirizzi"
    );
    expect(
      [...addressSection.querySelectorAll("lightning-input-field")].map(
        (input) => input.fieldName
      )
    ).toEqual(["BillingAddress", "ShippingAddress"]);
  });
  it("keeps Account Owner disabled and saves the default owner", async () => {
    const element = await mount();
    getRecordCreateDefaults.emit({
      ...defaults,
      objectInfos: {
        Account: {
          ...metadata,
          fields: {
            ...metadata.fields,
            OwnerId: { createable: true, required: true }
          }
        }
      }
    });
    await Promise.resolve();
    const picker = element.shadowRoot.querySelector("lightning-record-picker");
    expect(picker.value).toBe(USER_ID);
    expect(picker.disabled).toBe(true);
    const form = element.shadowRoot.querySelector("lightning-record-edit-form");
    const submit = jest.spyOn(form, "submit");
    form.dispatchEvent(
      new CustomEvent("submit", {
        cancelable: true,
        detail: { fields: { Name: "Company" } }
      })
    );
    expect(submit).toHaveBeenCalledWith(
      expect.objectContaining({ OwnerId: USER_ID })
    );
  });
  it("renders createable layout fields and the derived fields as read-only", async () => {
    const element = await mount();
    expect(
      [...element.shadowRoot.querySelectorAll("lightning-input-field")].map(
        (input) => input.fieldName
      )
    ).toEqual(["Name", "Phone", "Agente__c"]);
    expect(inputs(element)).toHaveLength(2);
    inputs(element).forEach((input) => expect(input.readOnly).toBe(true));
  });
  it("updates both values immediately and blocks Save while agent data loads", async () => {
    const element = await mount();
    selectAgent(element, "AGENT1");
    await Promise.resolve();
    expect(saveButton(element).disabled).toBe(true);
    emitAgent("AGENT1", "CODE1", "CAT1");
    await Promise.resolve();
    expect(inputs(element).map((input) => input.value)).toEqual([
      "CODE1",
      "CAT1"
    ]);
    expect(saveButton(element).disabled).toBe(false);
    selectAgent(element, "AGENT2");
    await Promise.resolve();
    emitAgent("AGENT1", "STALE", "STALE");
    await Promise.resolve();
    expect(inputs(element).map((input) => input.value)).toEqual(["", ""]);
    emitAgent("AGENT2", "CODE2", "CAT2");
    await Promise.resolve();
    expect(inputs(element).map((input) => input.value)).toEqual([
      "CODE2",
      "CAT2"
    ]);
  });
  it("clears both values when the agent is removed", async () => {
    const element = await mount("AZIENDA", { Agente__c: "AGENT1" });
    emitAgent("AGENT1", "CODE", "CAT");
    await Promise.resolve();
    selectAgent(element, null);
    await Promise.resolve();
    expect(inputs(element).map((input) => input.value)).toEqual(["", ""]);
  });
  it("submits the agent and leaves derived fields to the trigger", async () => {
    const element = await mount("AZIENDA", {
      Agente__c: "AGENT1",
      Codice_Agente_Esterno__c: "OLD",
      Categoria_Provvigioni_Cliente__c: "OLD"
    });
    emitAgent("AGENT1", "CODE", "CAT");
    await Promise.resolve();
    const form = element.shadowRoot.querySelector("lightning-record-edit-form");
    const submit = jest.spyOn(form, "submit");
    form.dispatchEvent(
      new CustomEvent("submit", {
        cancelable: true,
        detail: { fields: { Name: "New company", Phone: "Entered" } }
      })
    );
    expect(submit).toHaveBeenCalledWith({
      Name: "New company",
      Phone: "Entered",
      RecordTypeId: "AZIENDA",
      Agente__c: "AGENT1"
    });
  });
  it("requires retry after an agent read fails", async () => {
    const element = await mount("AZIENDA", { Agente__c: "AGENT1" });
    getRecord.error();
    await Promise.resolve();
    expect(saveButton(element).disabled).toBe(true);
    expect(element.shadowRoot.querySelector('[role="alert"]')).not.toBeNull();
  });
  it("delegates Locale creation without rendering the custom form", async () => {
    const element = await mount("LOCALE");
    expect(navigate).toHaveBeenCalledTimes(1);
    expect(navigate.mock.calls[0][0].state).toMatchObject({
      recordTypeId: "LOCALE",
      nooverride: "1"
    });
    expect(
      element.shadowRoot.querySelector("lightning-record-edit-form")
    ).toBeNull();
  });
  it("offers record type selection when none was supplied", async () => {
    const element = await mount(null);
    expect(
      element.shadowRoot.querySelector("lightning-combobox")
    ).not.toBeNull();
  });
  it("Cancel returns directly to the Account list", async () => {
    const element = await mount();

    [...element.shadowRoot.querySelectorAll("lightning-button")]
      .find((button) => button.label === "Annulla")
      .click();
    expect(navigate).toHaveBeenCalledWith(
      {
        type: "standard__objectPage",
        attributes: { objectApiName: "Account", actionName: "list" },
        state: { filterName: "Recent" }
      },
      true
    );
  });
  it("prefills the creator as agent when both commercial values exist", async () => {
    const element = createElement("c-nuovo-account", { is: NuovoAccount });
    element.pageReference = {
      attributes: { actionName: "new" },
      state: { recordTypeId: "AZIENDA" }
    };
    document.body.appendChild(element);
    getRecord.emit(
      {
        id: USER_ID,
        fields: {
          Name: { value: "Creator" },
          Agente__c: { value: "OWNCODE" },
          Categoria_Provvigioni_Cliente__c: { value: "OWNCAT" }
        }
      },
      (config) => config.recordId === USER_ID
    );
    getObjectInfo.emit(metadata);
    await Promise.resolve();
    getRecordCreateDefaults.emit(defaults);
    await Promise.resolve();
    emitAgent(USER_ID, "OWNCODE", "OWNCAT");
    await Promise.resolve();
    expect(
      [...element.shadowRoot.querySelectorAll("lightning-input-field")].find(
        (input) => input.fieldName === "Agente__c"
      ).value
    ).toBe(USER_ID);
    expect(inputs(element).map((input) => input.value)).toEqual([
      "OWNCODE",
      "OWNCAT"
    ]);
  });
  it("opens the saved Account after successful creation", async () => {
    const element = await mount();
    element.shadowRoot
      .querySelector("lightning-record-edit-form")
      .dispatchEvent(new CustomEvent("success", { detail: { id: "ACCOUNT" } }));
    await Promise.resolve();
    expect(element.shadowRoot.querySelector("lightning-card")).toBeNull();
    expect(element.shadowRoot.querySelector("lightning-spinner")).toBeNull();
    expect(navigate).toHaveBeenCalledWith(
      {
        type: "standard__recordPage",
        attributes: {
          recordId: "ACCOUNT",
          objectApiName: "Account",
          actionName: "view"
        }
      },
      true
    );
  });
  it("shows a standard-style dialog and closes with Escape", async () => {
    const element = await mount();
    const dialog = element.shadowRoot.querySelector('[role="dialog"]');
    expect(dialog.getAttribute("aria-modal")).toBe("true");
    expect(element.shadowRoot.querySelector("h2").textContent).toBe(
      "Nuovo Account: Azienda"
    );
    expect(
      element.shadowRoot.querySelector(".slds-modal__footer")
    ).not.toBeNull();
    expect(
      element.shadowRoot.querySelector("lightning-button-icon").alternativeText
    ).toBe("Chiudi");
    dialog.dispatchEvent(
      new KeyboardEvent("keydown", {
        key: "Escape",
        bubbles: true,
        cancelable: true
      })
    );
    expect(navigate.mock.calls[0][0].attributes.actionName).toBe("list");
  });
});
