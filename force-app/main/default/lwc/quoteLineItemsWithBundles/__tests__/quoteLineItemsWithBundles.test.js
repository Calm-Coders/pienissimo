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

  it("shows saved discounts even when they differ from a price calculation", async () => {
    const element = await mount([
      {
        ...row("discounted"),
        listPrice: 200,
        discountPercent: 15,
        unitPrice: 175
      },
      { ...row("free"), listPrice: 0, discountPercent: 0, unitPrice: 0 },
      row("legacy")
    ]);
    const grid = element.shadowRoot.querySelector("lightning-tree-grid");
    expect(grid.columns.map((column) => column.label)).toEqual(
      expect.arrayContaining(["Prezzo listino", "Sconto %", "Prezzo unitario"])
    );
    const currency = (value) =>
      new Intl.NumberFormat(undefined, {
        style: "currency",
        currency: "EUR"
      }).format(value);
    expect(grid.data[0]).toMatchObject({
      listPriceLabel: currency(200),
      discountPercentLabel: "15%",
      unitPriceLabel: currency(175)
    });
    expect(grid.data[1]).toMatchObject({
      listPriceLabel: currency(0),
      discountPercentLabel: "0%"
    });
    expect(grid.data[2]).toMatchObject({
      listPriceLabel: "-",
      discountPercentLabel: "-"
    });
  });

  it("shows the total list price in the bundle summary and keeps child discounts", async () => {
    const element = await mount([
      {
        ...row("child"),
        bundleName: "Test bundle",
        listPrice: 100,
        unitPrice: 98,
        totalPrice: 98,
        discountPercent: -392.46
      }
    ]);
    const summary = element.shadowRoot.querySelector("lightning-tree-grid")
      .data[0];
    expect(summary).toMatchObject({
      listPriceLabel: new Intl.NumberFormat(undefined, {
        style: "currency",
        currency: "EUR"
      }).format(100),
      discountPercentLabel: "2%"
    });
    expect(summary._children[0].discountPercentLabel).toBe("-392.46%");
  });

  it("totals list prices using quantities separately for each bundle without double counting nested components", async () => {
    const element = await mount([
      { ...row("first"), bundleName: "A", listPrice: 100, quantity: 3 },
      { ...row("second"), bundleName: "A", listPrice: 50, quantity: 2 },
      {
        ...row("nested"),
        isComponent: true,
        parentLineId: "first",
        listPrice: 900,
        quantity: 1
      },
      { ...row("other"), bundleName: "B", listPrice: 20, quantity: 2 },
      { ...row("unknown"), bundleName: "C", listPrice: null },
      { ...row("known"), bundleName: "C", listPrice: 10 }
    ]);
    const summaries = element.shadowRoot.querySelector(
      "lightning-tree-grid"
    ).data;
    expect(summaries.map((summary) => summary.listPrice)).toEqual([
      400,
      40,
      null
    ]);
    expect(summaries[2].listPriceLabel).toBe("-");
    expect(summaries[0]._children[0].listPrice).toBe(100);
  });

  it("calculates the overall discount from bundle totals instead of averaging child discounts", async () => {
    const element = await mount([
      {
        ...row("first"),
        bundleName: "Weighted",
        listPrice: 100,
        quantity: 3,
        unitPrice: 50,
        discountPercent: 50,
        totalPrice: 150
      },
      {
        ...row("second"),
        bundleName: "Weighted",
        listPrice: 50,
        quantity: 2,
        unitPrice: 50,
        discountPercent: 0,
        totalPrice: 100
      },
      { ...row("missing"), bundleName: "Unknown", listPrice: null },
      {
        ...row("zero"),
        bundleName: "Zero",
        listPrice: 0,
        unitPrice: 0,
        totalPrice: 0
      }
    ]);
    const summaries = element.shadowRoot.querySelector(
      "lightning-tree-grid"
    ).data;
    expect(summaries[0]).toMatchObject({
      listPrice: 400,
      totalPrice: 250,
      discountPercentLabel: "37.5%"
    });
    expect(
      summaries[0]._children.map((child) => child.discountPercentLabel)
    ).toEqual(["50%", "0%"]);
    expect(summaries[1].discountPercentLabel).toBe("-");
    expect(summaries[2].discountPercentLabel).toBe("0%");
  });

  it("formats saved percentages and leaves missing discounts blank", async () => {
    const element = await mount([
      { ...row("free"), listPrice: 100, unitPrice: 0, discountPercent: 100 },
      {
        ...row("markup"),
        listPrice: 100,
        unitPrice: 120,
        discountPercent: -20
      },
      { ...row("zero-list"), listPrice: 0, unitPrice: 10 },
      { ...row("rounded"), listPrice: 3, unitPrice: 2, discountPercent: 33.33 }
    ]);
    const data = element.shadowRoot.querySelector("lightning-tree-grid").data;
    expect(data.map((entry) => entry.discountPercentLabel)).toEqual([
      "100%",
      "-20%",
      "-",
      "33.33%"
    ]);
  });

  it("refreshes on successive saves for this quote and ignores other quotes", async () => {
    const element = await mount();
    const pageRefresh = jest.fn();
    element.addEventListener("lightning__refresh", pageRefresh);
    const onProductsChanged = subscribe.mock.calls[0][2];
    onProductsChanged({ quoteId: "another-quote" });
    expect(refreshApex).not.toHaveBeenCalled();
    expect(pageRefresh).not.toHaveBeenCalled();

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
    expect(pageRefresh).toHaveBeenCalledTimes(2);
    expect(pageRefresh.mock.calls[0][0].bubbles).toBe(true);
    expect(pageRefresh.mock.calls[0][0].composed).toBe(true);

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
