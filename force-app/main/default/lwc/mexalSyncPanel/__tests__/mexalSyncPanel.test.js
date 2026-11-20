import { createElement } from "lwc";
import MexalSyncPanel from "c/mexalSyncPanel";
import getStatus from "@salesforce/apex/MexalSyncController.getStatus";
import startSync from "@salesforce/apex/MexalSyncController.startSync";

jest.mock(
  "@salesforce/apex/MexalSyncController.getStatus",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/MexalSyncController.startSync",
  () => ({ default: jest.fn() }),
  { virtual: true }
);

const states = () =>
  ["articles", "customers", "invoices"].map((key) => ({
    key,
    status: "Completato",
    running: false,
    configured: true,
    blocked: false,
    lastSuccess: "2026-11-16T09:00:00.000Z"
  }));
const flush = async () => {
  // Drain chained Apex promises and LWC rendering microtasks.
  // eslint-disable-next-line no-await-in-loop
  for (let i = 0; i < 8; i += 1) await Promise.resolve();
};
async function mount() {
  const element = createElement("c-mexal-sync-panel", { is: MexalSyncPanel });
  document.body.appendChild(element);
  await flush();
  return element;
}

describe("Mexal Home sync panel", () => {
  beforeEach(() => {
    jest.useFakeTimers();
    getStatus.mockResolvedValue(states());
    startSync.mockResolvedValue("707000000000001AAA");
  });
  afterEach(() => {
    while (document.body.firstChild)
      document.body.removeChild(document.body.firstChild);
    jest.clearAllMocks();
    jest.clearAllTimers();
    jest.useRealTimers();
  });
  it("launches the chosen sync only once while the request is pending", async () => {
    let resolveStart;
    startSync.mockImplementation(
      () =>
        new Promise((resolve) => {
          resolveStart = resolve;
        })
    );
    const element = await mount();
    const button = element.shadowRoot.querySelector('[data-key="invoices"]');
    button.click();
    button.click();
    await flush();
    expect(startSync).toHaveBeenCalledTimes(1);
    expect(startSync).toHaveBeenCalledWith({ syncType: "invoices" });
    expect(
      [...element.shadowRoot.querySelectorAll("button.sync-button")].every(
        (item) => item.disabled
      )
    ).toBe(true);
    resolveStart("707000000000001AAA");
    await flush();
    expect(getStatus).toHaveBeenCalledTimes(2);
  });
  it("keeps all buttons disabled while any chain step is active", async () => {
    getStatus.mockResolvedValue(
      states().map((state) => ({
        ...state,
        blocked: true,
        running: state.key === "invoices",
        status: state.key === "invoices" ? "In corso" : state.status
      }))
    );
    const element = await mount();
    expect(
      [...element.shadowRoot.querySelectorAll("button.sync-button")].every(
        (item) => item.disabled
      )
    ).toBe(true);
    jest.advanceTimersByTime(5000);
    await flush();
    expect(getStatus).toHaveBeenCalledTimes(2);
    document.body.removeChild(element);
    jest.advanceTimersByTime(60000);
    await flush();
    expect(getStatus).toHaveBeenCalledTimes(2);
  });
  it("blocks stale buttons when polling fails and recovers automatically", async () => {
    const element = await mount();
    getStatus.mockRejectedValueOnce({
      body: { message: "Connessione non disponibile" }
    });
    jest.runOnlyPendingTimers();
    await flush();
    expect(
      element.shadowRoot.querySelector('[role="alert"]').textContent
    ).toContain("Connessione non disponibile");
    expect(
      [...element.shadowRoot.querySelectorAll("button.sync-button")].every(
        (item) => item.disabled
      )
    ).toBe(true);
    jest.runOnlyPendingTimers();
    await flush();
    expect(element.shadowRoot.querySelector('[role="alert"]')).toBeNull();
    expect(
      element.shadowRoot.querySelector("button.sync-button").disabled
    ).toBe(false);
  });
  it("reports a failed start without claiming completion", async () => {
    startSync.mockRejectedValue({
      body: { message: "Sincronizzazione gia in corso" }
    });
    const element = await mount();
    const toast = jest.fn();
    element.addEventListener("lightning__showtoast", toast);
    element.shadowRoot.querySelector('[data-key="articles"]').click();
    await flush();
    expect(toast.mock.calls[0][0].detail.variant).toBe("error");
    expect(toast.mock.calls[0][0].detail.message).toBe(
      "Sincronizzazione gia in corso"
    );
    expect(getStatus).toHaveBeenCalledTimes(2);
  });
  it("uses matching compact buttons with the full Italian action labels", async () => {
    const element = await mount();
    const buttons = [
      ...element.shadowRoot.querySelectorAll("button.sync-button")
    ];
    expect(buttons).toHaveLength(3);
    expect(new Set(buttons.map((button) => button.className)).size).toBe(1);
    expect(buttons.map((button) => button.textContent.trim())).toEqual([
      "Aggiorna articoli",
      "Aggiorna clienti",
      "Aggiorna fatture e scadenzario"
    ]);
    expect(buttons[2].getAttribute("aria-label")).toBe(
      "Aggiorna fatture e scadenzario"
    );
    expect(
      element.shadowRoot.querySelectorAll(".status-description")
    ).toHaveLength(3);
    expect(element.shadowRoot.textContent).toContain(
      "Ultimo aggiornamento Account riuscito"
    );
    expect(element.shadowRoot.textContent).toContain(
      "Ultimi recuperi fatture e scadenze riusciti"
    );
  });
  it("explains failures and shows the supplied reason as text with an error log link", async () => {
    getStatus.mockResolvedValue(
      states().map((state) => {
        return state.key === "articles"
          ? {
              ...state,
              status: "Errore",
              errorReason: "Mexal non ha risposto. <b>Riprovare</b>",
              errorLogId: "a05000000000001AAA"
            }
          : state;
      })
    );
    const element = await mount();
    expect(element.shadowRoot.textContent).toContain(
      "Possibili aggiornamenti parziali"
    );
    expect(
      element.shadowRoot.querySelector(".status-detail").textContent
    ).toContain("<b>Riprovare</b>");
    expect(element.shadowRoot.querySelector("b")).toBeNull();
    expect(
      element.shadowRoot.querySelector("details.status-details").open
    ).toBe(false);
    expect(
      element.shadowRoot.querySelector(".error-log").getAttribute("href")
    ).toBe("/lightning/r/Integration_Log__c/a05000000000001AAA/view");
  });
  it("explains why another sync is waiting and clears stale error details on success", async () => {
    getStatus.mockResolvedValue(
      states().map((state) => ({
        ...state,
        blocked: true,
        running: state.key === "invoices",
        status: state.key === "invoices" ? "In corso" : "Completato",
        errorReason: "Vecchio errore",
        errorLogId: "a05000000000001AAA"
      }))
    );
    const element = await mount();
    expect(element.shadowRoot.textContent).toContain(
      "Attendi la fine dell'altra sincronizzazione"
    );
    expect(element.shadowRoot.textContent).toContain(
      "Recupero di fatture, righe e scadenze"
    );
    expect(element.shadowRoot.textContent).not.toContain("Vecchio errore");
    expect(element.shadowRoot.querySelector(".error-log")).toBeNull();
  });
  it("shows success log links, including both invoice steps, in collapsed details", async () => {
    getStatus.mockResolvedValue(
      states().map((state) => ({
        ...state,
        successLogs:
          state.key === "invoices"
            ? [
                { logId: "a05000000000002AAA", label: "Log fatture" },
                { logId: "a05000000000003AAA", label: "Log scadenzario" }
              ]
            : [
                {
                  logId:
                    state.key === "articles"
                      ? "a05000000000004AAA"
                      : "a05000000000005AAA",
                  label:
                    state.key === "articles" ? "Log articoli" : "Log clienti"
                }
              ]
      }))
    );
    const element = await mount();
    const details = [
      ...element.shadowRoot.querySelectorAll(".success-details")
    ];
    expect(details).toHaveLength(3);
    expect(details.every((item) => !item.open)).toBe(true);
    const links = [...element.shadowRoot.querySelectorAll(".success-log")];
    expect(links).toHaveLength(4);
    expect(links[2].textContent).toContain("Log fatture");
    expect(links[3].textContent).toContain("Log scadenzario");
    expect(links[3].getAttribute("href")).toBe(
      "/lightning/r/Integration_Log__c/a05000000000003AAA/view"
    );
  });
  it("does not display stale success links while a run is active or failed", async () => {
    getStatus.mockResolvedValue(
      states().map((state) => ({
        ...state,
        status: state.key === "invoices" ? "In corso" : "Errore",
        running: state.key === "invoices",
        successLogs: [{ logId: "a05000000000002AAA", label: "Log precedente" }]
      }))
    );
    const element = await mount();
    expect(element.shadowRoot.querySelector(".success-log")).toBeNull();
    expect(element.shadowRoot.textContent).not.toContain("Log precedente");
  });
});
