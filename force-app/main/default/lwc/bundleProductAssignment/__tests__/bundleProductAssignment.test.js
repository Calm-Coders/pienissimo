import { createElement } from "lwc";
import BundleProductAssignment from "c/bundleProductAssignment";
import getBundleContext from "@salesforce/apex/BundleProductAssignmentController.getBundleContext";
import saveComponents from "@salesforce/apex/BundleProductAssignmentController.saveComponents";

jest.mock(
  "@salesforce/apex/BundleProductAssignmentController.getBundleContext",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/BundleProductAssignmentController.saveComponents",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "lightning/actions",
  () => ({
    CloseActionScreenEvent: class extends CustomEvent {
      constructor() {
        super("lightningactionsclose");
      }
    }
  }),
  { virtual: true }
);

const BUNDLE_ID = "01tMA00000F5CBLYA3";

// Mirrors ACADEMY 2026: a fixed price that the spreads add up to exactly.
const CONTEXT = {
  bundleName: "ACADEMY 2026",
  fixedPrice: 9800,
  calculatedBundlePrice: 9800,
  spreadTotal: 9800,
  variance: 0,
  components: [
    {
      id: "a01000000000001",
      productId: "01t000000000001",
      name: "CAMERIERI VENDITORI EXECUTIVE OMAGGIO",
      productCode: "CS-00001",
      quantity: 2,
      listPrice: 1200,
      spreadPrice: 1900
    },
    {
      id: "a01000000000002",
      productId: "01t000000000002",
      name: "SOLD OUT OMAGGIO",
      productCode: "CS-00002",
      quantity: 1,
      listPrice: 1500,
      spreadPrice: 7900
    }
  ]
};

function buildComponent() {
  const element = createElement("c-bundle-product-assignment", {
    is: BundleProductAssignment
  });
  element.recordId = BUNDLE_ID;
  document.body.appendChild(element);
  return element;
}

async function flush() {
  return Promise.resolve();
}

describe("c-bundle-product-assignment", () => {
  let toastHandler;

  beforeEach(() => {
    getBundleContext.mockResolvedValue(JSON.parse(JSON.stringify(CONTEXT)));
    saveComponents.mockResolvedValue(JSON.parse(JSON.stringify(CONTEXT)));
    toastHandler = jest.fn();
  });

  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  function listenForToast(element) {
    element.addEventListener("lightning__showtoast", toastHandler);
  }

  it("loads the bundle and its components", async () => {
    const element = buildComponent();
    await flush();
    await flush();

    expect(getBundleContext).toHaveBeenCalledWith({ bundleId: BUNDLE_ID });
    const table = element.shadowRoot.querySelector('[data-id="components"]');
    expect(table.data).toHaveLength(2);
  });

  it("derives unit spread and a line-level discount from the quantity", async () => {
    const element = buildComponent();
    await flush();
    await flush();

    const rows = element.shadowRoot.querySelector(
      '[data-id="components"]'
    ).data;
    const pair = rows.find((row) => row.productCode === "CS-00001");

    // 2 x 1200 = 2400 list; 1900 spread => 950 per unit, 20.83% off the LINE.
    expect(pair.lineListPrice).toBe(2400);
    expect(pair.unitSpread).toBe(950);
    expect(pair.discountLabel).toBe("20.83%");
  });

  it("sends every remaining row when one is removed", async () => {
    const element = buildComponent();
    await flush();
    await flush();

    const table = element.shadowRoot.querySelector('[data-id="components"]');
    table.dispatchEvent(
      new CustomEvent("rowaction", {
        detail: { action: { name: "remove" }, row: table.data[1] }
      })
    );
    await flush();

    const buttons = element.shadowRoot.querySelectorAll("lightning-button");
    const save = Array.from(buttons).find((b) => b.label === "Save");
    save.click();
    await flush();

    expect(saveComponents).toHaveBeenCalledTimes(1);
    const payload = saveComponents.mock.calls[0][0];
    expect(payload.bundleId).toBe(BUNDLE_ID);
    expect(payload.components).toBeUndefined();
    const components = JSON.parse(payload.componentsJson);
    expect(components).toHaveLength(1);
    expect(components[0]).toEqual({
      id: "a01000000000001",
      productId: "01t000000000001",
      quantity: 2,
      spreadPrice: 1900
    });
  });

  // The bug that reached the user: a row with no productId reached the server, where the
  // Product_Required rule rejected it with a message naming nothing.
  it("refuses to save a row that has no product, and names it", async () => {
    getBundleContext.mockResolvedValue({
      ...CONTEXT,
      components: [
        {
          id: null,
          productId: null,
          name: "GHOST ROW",
          productCode: null,
          quantity: 1,
          listPrice: 0,
          spreadPrice: 0
        }
      ]
    });

    const element = buildComponent();
    listenForToast(element);
    await flush();
    await flush();

    const buttons = element.shadowRoot.querySelectorAll("lightning-button");
    const save = Array.from(buttons).find((b) => b.label === "Save");
    save.click();
    await flush();

    expect(saveComponents).not.toHaveBeenCalled();
    expect(toastHandler).toHaveBeenCalled();
    const toast = toastHandler.mock.calls[0][0].detail;
    expect(toast.variant).toBe("error");
    expect(toast.message).toContain("GHOST ROW");
  });

  it('reports the real message instead of "Unexpected error"', async () => {
    saveComponents.mockRejectedValue({
      body: {
        pageErrors: [{ message: "A bundle component must point to a product." }]
      }
    });

    const element = buildComponent();
    listenForToast(element);
    await flush();
    await flush();

    const buttons = element.shadowRoot.querySelectorAll("lightning-button");
    const save = Array.from(buttons).find((b) => b.label === "Save");
    save.click();
    await flush();
    await flush();

    const toast = toastHandler.mock.calls[0][0].detail;
    expect(toast.message).toBe("A bundle component must point to a product.");
  });
});
