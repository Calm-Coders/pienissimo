import { createElement } from "lwc";
import QuoteManageProducts from "c/quoteManageProducts";
import getContext from "@salesforce/apex/QuoteManageProductsController.getContext";
import searchProducts from "@salesforce/apex/QuoteManageProductsController.searchProducts";
import saveProducts from "@salesforce/apex/QuoteManageProductsController.saveProducts";

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
  "@salesforce/apex/QuoteManageProductsController.getContext",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/QuoteManageProductsController.searchProducts",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/QuoteManageProductsController.saveProducts",
  () => ({ default: jest.fn() }),
  { virtual: true }
);
jest.mock(
  "@salesforce/messageChannel/QuoteProductsChanged__c",
  () => ({ default: "QuoteProductsChanged" }),
  { virtual: true }
);

// eslint-disable-next-line @lwc/lwc/no-async-operation
const flush = () => new Promise((resolve) => setTimeout(resolve, 0));
const item = (id, price = 200) => ({
  pricebookEntryId: id,
  productName: id,
  productType: "Item",
  unitPrice: price,
  trancheCount: 2
});
const queryInput = (element, label, id = "item1") =>
  [...element.shadowRoot.querySelectorAll("lightning-input")].find(
    (input) => input.label === label && input.dataset.id === id
  );
const button = (element, label) =>
  [...element.shadowRoot.querySelectorAll("lightning-button")].find(
    (candidate) => candidate.label === label
  );
async function change(input, value) {
  input.value = value;
  input.dispatchEvent(new CustomEvent("change"));
  await flush();
}
async function mount(
  recordType = "Vendita_Standard",
  products = [item("item1"), item("item2", 80)],
  existingLines = []
) {
  getContext.mockResolvedValue({
    isEditable: true,
    opportunityRecordTypeDeveloperName: recordType,
    existingLines
  });
  searchProducts.mockResolvedValue(products);
  const element = createElement("c-quote-manage-products", {
    is: QuoteManageProducts
  });
  element.recordId = "quote1";
  document.body.appendChild(element);
  await flush();
  button(element, "Aggiungi prodotti").click();
  await flush();
  element.shadowRoot
    .querySelector(`button[data-id="${products[0].pricebookEntryId}"]`)
    .click();
  await flush();
  return element;
}

describe("Standard Item pricing", () => {
  afterEach(() => {
    document.body.replaceChildren();
    jest.resetAllMocks();
  });

  it("updates each Item independently and preserves pricing outside the picker", async () => {
    const element = await mount();
    element.shadowRoot.querySelector('button[data-id="item2"]').click();
    await flush();
    await change(queryInput(element, "Sconto %"), "12.5");
    expect(queryInput(element, "Nuovo prezzo").value).toBe(175);
    expect(queryInput(element, "Nuovo prezzo", "item2").value).toBe(80);
    button(element, "Torna indietro").click();
    await flush();
    expect(queryInput(element, "Sconto %").value).toBe(12.5);
    await change(queryInput(element, "Nuovo prezzo"), "150");
    expect(queryInput(element, "Sconto %").value).toBe(25);
    [...element.shadowRoot.querySelectorAll("lightning-input")].forEach(
      (input) => {
        input.reportValidity = jest.fn(() => true);
      }
    );
    saveProducts.mockRejectedValue({ body: { message: "Test save" } });
    button(element, "Salva").click();
    await flush();
    expect(saveProducts).toHaveBeenCalledWith({
      quoteId: "quote1",
      products: [
        {
          pricebookEntryId: "item1",
          quantity: 1,
          trancheId: null,
          discountPercent: 25,
          newPrice: 150
        },
        {
          pricebookEntryId: "item2",
          quantity: 1,
          trancheId: null,
          discountPercent: 0,
          newPrice: 80
        }
      ],
      tranches: null
    });
  });

  it("saves discounted Items with their selected existing tranche and quantity", async () => {
    const element = await mount(
      "Vendita_Standard",
      [item("item1")],
      [
        {
          pricebookEntryId: "existing1",
          quoteLineItemId: "line1",
          productType: "Item",
          trancheId: "tranche1",
          trancheName: "T1",
          trancheSequence: 1,
          trancheDueDate: "2026-12-01",
          trancheAmount: 200
        }
      ]
    );
    await change(queryInput(element, "Sconto %"), "10");
    await change(queryInput(element, "Quantita"), "3");
    expect(button(element, "Salva").disabled).toBe(true);
    element.shadowRoot
      .querySelector('button[data-tranche-id="tranche1"]')
      .click();
    await flush();
    expect(button(element, "Salva").disabled).toBe(false);
    [...element.shadowRoot.querySelectorAll("lightning-input")].forEach(
      (input) => {
        input.reportValidity = jest.fn(() => true);
      }
    );
    saveProducts.mockRejectedValue({ body: { message: "Test save" } });
    button(element, "Salva").click();
    await flush();
    expect(saveProducts).toHaveBeenCalledWith({
      quoteId: "quote1",
      products: [
        {
          pricebookEntryId: "item1",
          quantity: 3,
          trancheId: "tranche1",
          discountPercent: 10,
          newPrice: 180
        }
      ],
      tranches: null
    });
  });

  it("blocks blank, excessive and negative pricing", async () => {
    const element = await mount();
    await change(queryInput(element, "Sconto %"), "");
    expect(button(element, "Salva").disabled).toBe(true);
    await change(queryInput(element, "Sconto %"), "101");
    expect(button(element, "Salva").disabled).toBe(true);
    await change(queryInput(element, "Nuovo prezzo"), "-1");
    expect(button(element, "Salva").disabled).toBe(true);
    await change(queryInput(element, "Nuovo prezzo"), "0");
    expect(queryInput(element, "Sconto %").value).toBe(100);
    expect(button(element, "Salva").disabled).toBe(false);
  });

  it("handles a zero catalogue price without invalid percentages", async () => {
    const element = await mount("Vendita_Standard", [item("item1", 0)]);
    await change(queryInput(element, "Nuovo prezzo"), "10");
    expect(queryInput(element, "Sconto %").value).toBe(0);
    expect(button(element, "Salva").disabled).toBe(false);
  });

  it("does not add Item pricing to Standard bundles", async () => {
    const element = await mount("Vendita_Standard", [
      { ...item("bundle1"), productType: "Bundle" }
    ]);
    expect(queryInput(element, "Sconto %", "bundle1")).toBeUndefined();
  });

  it("keeps Plus pricing on its tranche inputs", async () => {
    const element = await mount("Plus_Attivazione_Rinnovo");
    expect(queryInput(element, "Sconto %")).toBeUndefined();
    const discounts = [
      ...element.shadowRoot.querySelectorAll("lightning-input")
    ].filter((input) => input.label === "Sconto %");
    expect(discounts).toHaveLength(2);
    expect(discounts[0].dataset.index).toBe("0");
  });
});
