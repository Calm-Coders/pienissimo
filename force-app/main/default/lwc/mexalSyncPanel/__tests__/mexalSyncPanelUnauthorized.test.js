import { createElement } from "lwc";
import MexalSyncPanel from "c/mexalSyncPanel";
import getStatus from "@salesforce/apex/MexalSyncController.getStatus";

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

it("hides the panel when Salesforce denies Apex class access", async () => {
  getStatus.mockRejectedValue({ body: { message: "Access denied" } });
  const element = createElement("c-mexal-sync-panel", { is: MexalSyncPanel });
  try {
    document.body.appendChild(element);
    await Promise.resolve();
    await Promise.resolve();
    expect(element.shadowRoot.querySelector("lightning-card")).toBeNull();
    expect(getStatus).toHaveBeenCalledTimes(1);
  } finally {
    element.remove();
  }
});
