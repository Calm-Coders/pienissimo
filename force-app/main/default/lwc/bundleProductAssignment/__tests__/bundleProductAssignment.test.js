import { createElement } from "lwc";
import BundleProductAssignment from "c/bundleProductAssignment";
import getBundleContext from "@salesforce/apex/BundleProductAssignmentController.getBundleContext";
import saveComponents from "@salesforce/apex/BundleProductAssignmentController.saveComponents";

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
jest.mock(
  "@salesforce/apex/BundleTranchController.getContext",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/BundleTranchController.saveTranches",
  () => ({ default: jest.fn() }),
  { virtual: true }
);

jest.mock(
  "@salesforce/apex/BundleProductAssignmentController.getBundleContext",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/BundleProductAssignmentController.searchProducts",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/BundleProductAssignmentController.saveComponents",
  () => ({ default: jest.fn() }),
  { virtual: true }
);

// eslint-disable-next-line @lwc/lwc/no-async-operation
const flush = () => new Promise((resolve) => setTimeout(resolve, 0));

function bundleContext() {
  return {
    bundleName: "Test bundle",
    fixedPrice: 1234.56,
    bundleTranches: [],
    components: [
      {
        id: "row1",
        productId: "product1",
        name: "Test product",
        quantity: 2,
        listPrice: 3400,
        spreadPrice: 1234.56,
        bundleTranchId: null
      },
      {
        id: "row2",
        productId: "product2",
        name: "Free product",
        quantity: 1,
        listPrice: 0,
        spreadPrice: 0,
        bundleTranchId: null
      }
    ]
  };
}

async function mount() {
  getBundleContext.mockResolvedValue(bundleContext());
  saveComponents.mockResolvedValue(bundleContext());
  const element = createElement("c-bundle-product-assignment", {
    is: BundleProductAssignment
  });
  element.recordId = "bundle1";
  document.body.appendChild(element);
  await flush();
  return element;
}

afterEach(() => {
  while (document.body.firstChild) {
    document.body.removeChild(document.body.firstChild);
  }
  jest.clearAllMocks();
});

it("shows Italian totals and row prices while keeping numeric row data", async () => {
  const element = await mount();
  expect(element.shadowRoot.querySelector(".figures").textContent).toContain(
    "6.800,00\u00a0\u20ac"
  );
  expect(
    element.shadowRoot.querySelector('[data-id="total"]').textContent
  ).toBe("1.234,56\u00a0\u20ac");
  const table = element.shadowRoot.querySelector('[data-id="components"]');
  expect(table.data[0]).toMatchObject({
    quantity: 2,
    lineListPrice: 6800,
    spreadPrice: 1234.56,
    unitSpread: 617.28,
    lineListPriceLabel: "6.800,00\u00a0\u20ac",
    spreadPriceLabel: "1.234,56\u00a0\u20ac",
    unitSpreadLabel: "617,28\u00a0\u20ac"
  });
  expect(table.data[1].spreadPriceLabel).toBe("0,00\u00a0\u20ac");
});

it("opens the row editor with numeric inputs and formatted price previews", async () => {
  const element = await mount();
  const table = element.shadowRoot.querySelector('[data-id="components"]');
  table.dispatchEvent(
    new CustomEvent("rowaction", {
      detail: { action: { name: "edit" }, row: table.data[0] }
    })
  );
  await flush();
  const price = element.shadowRoot.querySelector(
    'lightning-input[data-field="spreadPrice"]'
  );
  expect(price.type).toBe("number");
  expect(price.formatter).toBe("currency");
  expect(price.value).toBe(1234.56);
  expect(element.shadowRoot.querySelector(".row-editor").textContent).toContain(
    "3.400,00\u00a0\u20ac"
  );
  const quantity = element.shadowRoot.querySelector(
    'lightning-input[data-field="quantity"]'
  );
  quantity.value = "4";
  quantity.dispatchEvent(new CustomEvent("change"));
  await flush();
  element.shadowRoot
    .querySelectorAll("[data-component-editor]")
    .forEach((input) => {
      input.reportValidity = jest.fn(() => true);
    });
  [...element.shadowRoot.querySelectorAll("lightning-button")]
    .find((button) => button.label === "Salva modifica")
    .click();
  await flush();
  expect(
    element.shadowRoot.querySelector('[data-id="components"]').data[0]
  ).toMatchObject({
    quantity: 4,
    spreadPrice: 1234.56,
    unitSpread: 308.64,
    lineListPriceLabel: "13.600,00\u00a0\u20ac",
    unitSpreadLabel: "308,64\u00a0\u20ac"
  });
});

it("sends only the original numeric pricing fields when saving", async () => {
  const element = await mount();
  element.shadowRoot.querySelector('[data-id="bundle-price"]').reportValidity =
    jest.fn(() => true);
  element.shadowRoot.querySelector('[data-id="save"]').click();
  await flush();
  expect(saveComponents).toHaveBeenCalledTimes(1);
  const request = saveComponents.mock.calls[0][0];
  expect(request.bundleId).toBe("bundle1");
  expect(request.fixedPrice).toBe(1234.56);
  expect(JSON.parse(request.componentsJson)).toEqual(
    bundleContext().components.map(
      ({ id, productId, quantity, spreadPrice, bundleTranchId }) => ({
        id,
        productId,
        quantity,
        spreadPrice,
        bundleTranchId
      })
    )
  );
});
