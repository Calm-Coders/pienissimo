import { createElement } from "lwc";
import QuoteLineItemsWithBundles from "c/quoteLineItemsWithBundles";
import getContext from "@salesforce/apex/QuoteLineItemsController.getContext";
import deleteLine from "@salesforce/apex/QuoteLineItemsController.deleteLine";
import { refreshApex } from "@salesforce/apex";
import {
  MessageContext,
  subscribe,
  unsubscribe
} from "lightning/messageService";
import LightningConfirm from "lightning/confirm";

jest.mock(
  "@salesforce/apex/QuoteLineItemsController.getContext",
  () => {
    const { createApexTestWireAdapter } = require("@salesforce/sfdx-lwc-jest");
    return { default: createApexTestWireAdapter(jest.fn()) };
  },
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/QuoteLineItemsController.deleteLine",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/QuoteLineItemsController.deleteBundle",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock("@salesforce/apex", () => ({ refreshApex: jest.fn() }), {
  virtual: true
});
jest.mock(
  "@salesforce/messageChannel/QuoteProductsChanged__c",
  () => ({ default: "QuoteProductsChanged" }),
  { virtual: true }
);
jest.mock("lightning/confirm", () => ({
  __esModule: true,
  default: { open: jest.fn() }
}));

const QUOTE_ID = "0Q0000000000001AAA";
const row = (id) => ({
  id,
  key: id,
  productName: id,
  quantity: 1,
  unitPrice: 10,
  totalPrice: 10
});
const context = (rows) => ({
  quoteName: "Test quote",
  quoteStatus: "Bozza",
  canDeleteLines: true,
  rows
});
// Flush wire deliveries and rendering before inspecting the test DOM.
// eslint-disable-next-line @lwc/lwc/no-async-operation
const flush = () => new Promise((resolve) => setTimeout(resolve, 0));

async function mount(rows = []) {
  const element = createElement("c-quote-line-items-with-bundles", {
    is: QuoteLineItemsWithBundles
  });
  element.recordId = QUOTE_ID;
  document.body.appendChild(element);
  MessageContext.emit({});
  getContext.emit(context(rows));
  await flush();
  return element;
}

describe("quote product refresh", () => {
  beforeEach(() => {
    subscribe.mockReturnValue({ id: "subscription" });
    refreshApex.mockResolvedValue(undefined);
    LightningConfirm.open.mockResolvedValue(true);
  });

  afterEach(() => {
    while (document.body.firstChild)
      document.body.removeChild(document.body.firstChild);
    jest.resetAllMocks();
  });

  it("refreshes on successive saves for this quote and ignores other quotes", async () => {
    const element = await mount();
    const onProductsChanged = subscribe.mock.calls[0][2];
    onProductsChanged({ quoteId: "another-quote" });
    expect(refreshApex).not.toHaveBeenCalled();

    refreshApex.mockImplementationOnce(async () =>
      getContext.emit(context([row("first")]))
    );
    onProductsChanged({ quoteId: QUOTE_ID });
    await flush();
    expect(
      element.shadowRoot.querySelector("lightning-tree-grid").data
    ).toHaveLength(1);

    refreshApex.mockImplementationOnce(async () =>
      getContext.emit(context([row("first"), row("second")]))
    );
    onProductsChanged({ quoteId: QUOTE_ID });
    await flush();
    expect(
      element.shadowRoot.querySelector("lightning-tree-grid").data
    ).toHaveLength(2);
    expect(refreshApex).toHaveBeenCalledTimes(2);

    element.remove();
    expect(unsubscribe).toHaveBeenCalledWith({ id: "subscription" });
  });

  it("refreshes the Apex cache after deleting and shows a later addition", async () => {
    const element = await mount([row("first")]);
    const onProductsChanged = subscribe.mock.calls[0][2];
    deleteLine.mockResolvedValue(context([]));
    refreshApex.mockImplementationOnce(async () =>
      getContext.emit(context([]))
    );
    element.shadowRoot.querySelector("lightning-tree-grid").dispatchEvent(
      new CustomEvent("rowaction", {
        detail: { action: { name: "delete" }, row: row("first") }
      })
    );
    await flush();
    expect(refreshApex).toHaveBeenCalledTimes(1);
    expect(element.shadowRoot.querySelector("lightning-tree-grid")).toBeNull();

    refreshApex.mockImplementationOnce(async () =>
      getContext.emit(context([row("first")]))
    );
    onProductsChanged({ quoteId: QUOTE_ID });
    await flush();
    expect(
      element.shadowRoot.querySelector("lightning-tree-grid").data[0].id
    ).toBe("first");
    expect(refreshApex).toHaveBeenCalledTimes(2);
  });
});
