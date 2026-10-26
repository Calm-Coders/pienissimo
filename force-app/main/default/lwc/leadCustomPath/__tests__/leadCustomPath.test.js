import { createElement } from "lwc";
import LeadCustomPath from "c/leadCustomPath";
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import { getRecord } from "lightning/uiRecordApi";

jest.mock(
  "lightning/empApi",
  () => ({
    onError: jest.fn(),
    subscribe: jest.fn(() => Promise.resolve({ id: "subscription" })),
    unsubscribe: jest.fn()
  }),
  { virtual: true }
);

const RECORD_TYPE_ID = "012000000000001AAA";
const FIELD_METADATA = {
  Company: { updateable: true },
  Agente__c: { updateable: true },
  Motivazione_Uscita__c: { updateable: true },
  Dettaglio_Motivazione_Uscita__c: { updateable: true },
  Motivazione__c: { updateable: true }
};
const OBJECT_INFO = {
  fields: FIELD_METADATA,
  recordTypeInfos: {
    [RECORD_TYPE_ID]: {
      developerName: "Standard",
      name: "Standard"
    }
  }
};
const LEAD = {
  fields: {
    Status: { value: "New" },
    RecordTypeId: { value: RECORD_TYPE_ID },
    Company: { value: "Example" },
    Agente__c: { value: null },
    Motivazione_Uscita__c: { value: null },
    Dettaglio_Motivazione_Uscita__c: { value: null },
    Motivazione__c: { value: null }
  }
};

const flush = () => Promise.resolve();

async function mount({ objectInfo = OBJECT_INFO, lead = LEAD } = {}) {
  const element = createElement("c-lead-custom-path", {
    is: LeadCustomPath
  });
  element.recordId = "00Q000000000001AAA";
  document.body.appendChild(element);
  getObjectInfo.emit(objectInfo);
  getRecord.emit(lead);
  await flush();
  return element;
}

function keyFieldNames(element) {
  return [...element.shadowRoot.querySelectorAll("lightning-input-field")].map(
    (input) => input.fieldName
  );
}

function selectStage(element, stage) {
  element.shadowRoot.querySelector(`button[data-stage="${stage}"]`).click();
}

describe("Lead key fields", () => {
  afterEach(() => {
    document.body.replaceChildren();
    jest.clearAllMocks();
  });

  it("renders the configured field for each selected stage", async () => {
    const element = await mount();
    const recordConfig = getRecord.getLastConfig();

    expect(recordConfig.fields).toHaveLength(2);
    expect(recordConfig.optionalFields).toHaveLength(6);

    expect(keyFieldNames(element)).toEqual(["Company"]);

    selectStage(element, "Qualificato");
    await flush();
    expect(keyFieldNames(element)).toEqual(["Agente__c"]);

    selectStage(element, "Non qualificato");
    await flush();
    expect(keyFieldNames(element)).toEqual([
      "Motivazione_Uscita__c",
      "Dettaglio_Motivazione_Uscita__c"
    ]);
  });

  it("does not render a field that object metadata marks inaccessible", async () => {
    const element = await mount({
      objectInfo: {
        ...OBJECT_INFO,
        fields: { ...FIELD_METADATA, Agente__c: { updateable: false } }
      }
    });

    selectStage(element, "Qualificato");
    await flush();

    expect(keyFieldNames(element)).toEqual([]);
    expect(
      element.shadowRoot.querySelector('[role="alert"]').textContent
    ).toContain("Agente__c");
  });

  it("surfaces record and record-form initialization errors", async () => {
    const element = await mount();
    getRecord.error({ message: "Accesso al Lead negato" });
    await flush();

    expect(
      element.shadowRoot.querySelector('[role="alert"]').textContent
    ).toContain("Accesso al Lead negato");

    const form = element.shadowRoot.querySelector("lightning-record-edit-form");
    form.dispatchEvent(
      new CustomEvent("error", {
        detail: { message: "Inizializzazione modulo non riuscita" }
      })
    );
    await flush();

    expect(
      element.shadowRoot.querySelector('[role="alert"]').textContent
    ).toContain("Inizializzazione modulo non riuscita");
  });
});
