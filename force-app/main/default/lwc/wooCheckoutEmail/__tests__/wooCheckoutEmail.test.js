import { createElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { encodeDefaultFieldValues } from "lightning/pageReferenceUtils";
import WooCheckoutEmail from "c/wooCheckoutEmail";
import getContext from "@salesforce/apex/WooCheckoutEmailController.getContext";

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
  let navigate;

  beforeEach(() => {
    navigate = jest.fn();
    WooCheckoutEmail.prototype[NavigationMixin.Navigate] = navigate;
    encodeDefaultFieldValues.mockImplementation((values) =>
      JSON.stringify(values)
    );
  });

  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    jest.clearAllMocks();
  });

  it("opens the email composer without preselecting a recipient", async () => {
    const element = buildComponent();
    element.context = { opportunityName: "Academy 2026" };
    getContext.emit(element.context);
    await flush();
    await flush();

    const openComposer = Array.from(
      element.shadowRoot.querySelectorAll("lightning-button")
    ).find((button) => button.label === "Open Email Composer");
    element.shadowRoot.querySelector("lightning-input").reportValidity = jest
      .fn()
      .mockReturnValue(true);

    expect(openComposer.disabled).toBe(false);
    openComposer.dispatchEvent(
      new MouseEvent("click", { bubbles: true, composed: true })
    );
    await flush();

    expect(encodeDefaultFieldValues).toHaveBeenCalledWith({
      Subject: "Completa il tuo ordine Pienissimo",
      HTMLBody: expect.stringContaining(
        `sf_opportunity_id=${OPPORTUNITY_ID.substring(0, 15)}`
      ),
      RelatedToId: OPPORTUNITY_ID
    });
    expect(encodeDefaultFieldValues.mock.calls[0][0]).not.toHaveProperty(
      "ToAddress"
    );
    expect(navigate).toHaveBeenCalledWith({
      type: "standard__quickAction",
      attributes: {
        apiName: "Global.SendEmail"
      },
      state: {
        recordId: OPPORTUNITY_ID,
        defaultFieldValues: JSON.stringify(
          encodeDefaultFieldValues.mock.calls[0][0]
        )
      }
    });
  });
});
