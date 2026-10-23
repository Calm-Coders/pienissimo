import { createElement } from "lwc";
import QuoteCreateTranche from "c/quoteCreateTranche";
import getContext from "@salesforce/apex/QuoteTrancheController.getContext";
import createTranches from "@salesforce/apex/QuoteTrancheController.createTranches";
import { MessageContext, publish } from "lightning/messageService";
import { notifyRecordUpdateAvailable } from "lightning/uiRecordApi";

jest.mock(
  "@salesforce/apex/QuoteTrancheController.getContext",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/QuoteTrancheController.createTranches",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/messageChannel/QuoteProductsChanged__c",
  () => ({ default: "QuoteProductsChanged" }),
  { virtual: true }
);
jest.mock(
  "lightning/actions",
  () => ({
    CloseActionScreenEvent: class extends CustomEvent {
      constructor() {
        super("closeactionscreen");
      }
    }
  }),
  { virtual: true }
);
// eslint-disable-next-line @lwc/lwc/no-async-operation
const flush = () => new Promise((resolve) => setTimeout(resolve, 0));
const context = {
  quoteName: "Quote",
  quoteStatus: "Bozza",
  isEditable: true,
  lines: [
    {
      id: "line1",
      productName: "Item",
      trancheId: "tranche1",
      quantity: 1,
      totalPrice: 100
    }
  ],
  tranches: [
    {
      trancheId: "tranche1",
      trancheName: "T1",
      dueDate: "2099-01-01",
      trancheSequence: 1
    }
  ]
};
const button = (element, label) =>
  [...element.shadowRoot.querySelectorAll("lightning-button")].find(
    (input) => input.label === label
  );
async function mount() {
  getContext.mockResolvedValue(context);
  const element = createElement("c-quote-create-tranche", {
    is: QuoteCreateTranche
  });
  element.recordId = "quote1";
  document.body.appendChild(element);
  MessageContext.emit({});
  await flush();
  element.shadowRoot.querySelectorAll("lightning-input").forEach((input) => {
    input.reportValidity = jest.fn(() => true);
  });
  return element;
}
afterEach(() => {
  document.body.replaceChildren();
  jest.clearAllMocks();
});
it("invalidates quote, line and tranche records and broadcasts a refresh after saving", async () => {
  const element = await mount();
  createTranches.mockResolvedValue(context);
  const refreshed = jest.fn();
  const closed = jest.fn();
  element.addEventListener("lightning__refresh", refreshed);
  element.addEventListener("closeactionscreen", closed);
  button(element, "Modifica tranche").click();
  await flush();
  expect(createTranches).toHaveBeenCalledTimes(1);
  expect(notifyRecordUpdateAvailable).toHaveBeenCalledWith([
    { recordId: "quote1" },
    { recordId: "line1" },
    { recordId: "tranche1" }
  ]);
  expect(publish).toHaveBeenCalledWith(
    expect.anything(),
    "QuoteProductsChanged",
    { quoteId: "quote1" }
  );
  expect(refreshed).toHaveBeenCalledTimes(1);
  expect(closed).toHaveBeenCalledTimes(1);
});
it("does not broadcast a data change on cancel", async () => {
  const element = await mount();
  button(element, "Annulla").click();
  expect(createTranches).not.toHaveBeenCalled();
  expect(publish).not.toHaveBeenCalled();
});
