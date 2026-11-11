import { createElement } from "lwc";
import OrderDocuSignErrorBanner from "c/orderDocuSignErrorBanner";
import { getRecord } from "lightning/uiRecordApi";
import getLatestErrorDetails from "@salesforce/apex/DocuSignOrderEnvelopeService.getLatestErrorDetails";

jest.mock(
  "@salesforce/apex/DocuSignOrderEnvelopeService.getLatestErrorDetails",
  () => ({ default: jest.fn() }),
  { virtual: true }
);

function orderRecord(status, errorMessage) {
  return {
    fields: {
      DocuSign_Status__c: { value: status },
      DocuSign_Error__c: { value: errorMessage }
    }
  };
}

async function mount(status, errorMessage) {
  const element = createElement("c-order-docu-sign-error-banner", {
    is: OrderDocuSignErrorBanner
  });
  element.recordId = "801000000000001AAA";
  document.body.appendChild(element);
  getRecord.emit(orderRecord(status, errorMessage));
  await Promise.resolve();
  return element;
}

describe("c-order-docu-sign-error-banner", () => {
  beforeEach(() => {
    getLatestErrorDetails.mockReset();
    getLatestErrorDetails.mockResolvedValue(null);
  });

  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("shows only the log failure reason as text without extra guidance", async () => {
    const reason =
      "Email mancante sul contatto principale dell Account. <b>test</b>";
    const element = await mount("Error", reason);

    expect(element.shadowRoot.querySelector('[role="alert"]')).not.toBeNull();
    expect(element.shadowRoot.textContent).toContain(reason);
    expect(element.shadowRoot.querySelector("p").textContent).toBe(reason);
    expect(element.shadowRoot.querySelectorAll("p")).toHaveLength(1);
    expect(element.shadowRoot.textContent).not.toContain("Reinvia DocuSign");
    expect(element.shadowRoot.querySelector("b")).toBeNull();
    expect(element.shadowRoot.querySelector("a")).toBeNull();
  });

  it("reads the actual log message for a failure that predates the Order error field", async () => {
    const reason =
      "Configurare un contatto principale sull'Account per inviare il contratto.";
    getLatestErrorDetails.mockResolvedValue({
      message: reason,
      logId: "a05000000000001AAA"
    });
    const element = await mount("Error", null);
    await Promise.resolve();

    expect(getLatestErrorDetails).toHaveBeenCalledWith({
      orderId: "801000000000001AAA"
    });
    expect(element.shadowRoot.querySelector("p").textContent).toBe(reason);
    const link = element.shadowRoot.querySelector("a");
    expect(link.textContent).toContain("a05000000000001AAA");
    expect(link.getAttribute("href")).toBe(
      "/lightning/r/Integration_Log__c/a05000000000001AAA/view"
    );
  });

  it("shows the log link even when the error is already stored on the Order", async () => {
    getLatestErrorDetails.mockResolvedValue({
      message: "Errore invio",
      logId: "a05000000000002AAA"
    });
    const element = await mount("Error", "Errore invio");
    await Promise.resolve();

    expect(element.shadowRoot.querySelector("a").textContent).toContain(
      "a05000000000002AAA"
    );
    expect(element.shadowRoot.querySelector("p").textContent).toBe(
      "Errore invio"
    );
  });

  it("ignores a delayed log result after the Order is no longer in Error", async () => {
    let resolveLookup;
    getLatestErrorDetails.mockImplementation(
      () =>
        new Promise((resolve) => {
          resolveLookup = resolve;
        })
    );
    const element = await mount("Error", null);

    getRecord.emit(orderRecord("Sent", null));
    await Promise.resolve();
    resolveLookup({
      message: "Errore precedente",
      logId: "a05000000000001AAA"
    });
    await Promise.resolve();
    await Promise.resolve();

    expect(element.shadowRoot.querySelector('[role="alert"]')).toBeNull();
  });

  it("removes the warning after a successful send even if old error text remains", async () => {
    const element = await mount("Error", "Errore precedente");

    getRecord.emit(orderRecord("Sent", "Errore precedente"));
    await Promise.resolve();

    expect(element.shadowRoot.querySelector('[role="alert"]')).toBeNull();
  });

  it("does not invent a message when no log error has been saved", async () => {
    const element = await mount("Error", null);

    expect(element.shadowRoot.querySelector('[role="alert"]')).toBeNull();
  });

  it("preserves the actual API error instead of replacing it with an explanation", async () => {
    const reason = 'DocuSign HTTP 400: {"errorCode":"INVALID_EMAIL_ADDRESS"}';
    const element = await mount("Error", reason);

    expect(element.shadowRoot.querySelector("p").textContent).toBe(reason);
  });

  it("does not retain another order's warning when the record cannot be read", async () => {
    const element = await mount("Error", "Errore del primo ordine");

    getRecord.error();
    await Promise.resolve();

    expect(element.shadowRoot.querySelector('[role="alert"]')).toBeNull();
    expect(element.shadowRoot.textContent).not.toContain(
      "Errore del primo ordine"
    );
  });
});
