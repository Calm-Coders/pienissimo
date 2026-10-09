/* eslint-disable no-unused-expressions */
({
  // New from a related list carries the parent record in inContextOfRef, a
  // "1." prefixed base64 JSON page reference. New from a list view carries the
  // page behind it in backgroundContext, a relative URL.
  init: function (component) {
    var pageReference = component.get("v.pageReference");
    var state = pageReference && pageReference.state ? pageReference.state : {};
    var contextRef = state.inContextOfRef;
    var backgroundContext = state.backgroundContext;
    var campaignId = null;
    var context;
    var recordId;

    if (contextRef) {
      try {
        context = JSON.parse(
          window.atob(
            contextRef.indexOf("1.") === 0
              ? contextRef.substring(2)
              : contextRef
          )
        );
        recordId = context.attributes ? context.attributes.recordId : null;
        // eslint-disable-next-line no-unused-vars
      } catch (ignored) {
        // An unreadable context just means no campaign is pre-filled.
        recordId = null;
      }
      if (recordId && recordId.indexOf("701") === 0) {
        campaignId = recordId;
      }
    }

    component.set("v.campaignId", campaignId);
    component.set(
      "v.returnUrl",
      backgroundContext && backgroundContext.indexOf("/lightning/") === 0
        ? backgroundContext
        : null
    );
    component.set("v.openToken", String(Date.now()));
  }
});
