import { createElement } from "lwc";
import WooCheckoutEmail from "c/wooCheckoutEmail";
import getContext from "@salesforce/apex/WooCheckoutEmailController.getContext";
import sendCheckoutEmail from "@salesforce/apex/WooCheckoutEmailController.sendCheckoutEmail";

jest.mock(
  "@salesforce/apex/WooCheckoutEmailController.getContext",
  () => {
    const { createApexTestWireAdapter } = require("@salesforce/sfdx-lwc-jest");
    return {
      default: createApexTestWireAdapter(jest.fn())
    };
  },
  { virtual: true }
);
jest.mock(
  "@salesforce/apex/WooCheckoutEmailController.sendCheckoutEmail",
  () => ({
    default: jest.fn()
  }),
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

const OPPORTUNITY_ID = "006MA00000QJduNYAT";
const RECIPIENT_EMAIL = "cliente@example.com";

function buildComponent() {
  const element = createElement("c-woo-checkout-email", {
    is: WooCheckoutEmail
  });
  element.recordId = OPPORTUNITY_ID;
  document.body.appendChild(element);
  return element;
}

async function flush() {
  return Promise.resolve();
}

describe("c-woo-checkout-email", () => {
  beforeEach(() => {
    sendCheckoutEmail.mockResolvedValue(undefined);
  });

  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("sends the shared template to the entered recipient", async () => {
    const element = buildComponent();
    getContext.emit({ opportunityName: "Academy 2026" });
    await flush();
    await flush();

    expect(element.shadowRoot.textContent).not.toContain("Template");
    expect(element.shadowRoot.textContent).toContain(
      `sf_opportunity_id=${OPPORTUNITY_ID}`
    );

    const emailInput = element.shadowRoot.querySelector("lightning-input");
    emailInput.value = RECIPIENT_EMAIL;
    emailInput.reportValidity = jest.fn().mockReturnValue(true);
    emailInput.dispatchEvent(
      new CustomEvent("change", {
        detail: { value: RECIPIENT_EMAIL }
      })
    );
    await flush();

    const sendButton = Array.from(
      element.shadowRoot.querySelectorAll("lightning-button")
    ).find((button) => button.label === "Send Email");
    expect(sendButton.disabled).toBe(false);
    sendButton.dispatchEvent(
      new MouseEvent("click", { bubbles: true, composed: true })
    );
    await flush();
    await flush();

    expect(sendCheckoutEmail).toHaveBeenCalledWith({
      opportunityId: OPPORTUNITY_ID,
      recipientEmail: RECIPIENT_EMAIL
    });
  });
});
