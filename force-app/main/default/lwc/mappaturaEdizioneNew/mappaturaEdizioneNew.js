import { api, LightningElement } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import MappaturaEdizioneNewModal from "c/mappaturaEdizioneNewModal";

// Opens the New Mappatura Edizione form in the standard Salesforce modal, then
// returns to where New was clicked: the campaign when started from its related
// list, otherwise the list view (with its filter) the user came from.
export default class MappaturaEdizioneNew extends NavigationMixin(
  LightningElement
) {
  @api campaignId;
  @api returnUrl;
  currentToken;

  // A new token means a new click on New, even on the cached override page.
  @api
  get openToken() {
    return this.currentToken;
  }
  set openToken(value) {
    if (value && value !== this.currentToken) {
      this.currentToken = value;
      // Deferred so campaignId and returnUrl, set in the same pass, are in.
      Promise.resolve().then(() => this.openModal());
    }
  }

  async openModal() {
    await MappaturaEdizioneNewModal.open({
      size: "medium",
      label: "New Mappatura Edizione",
      campaignId: this.campaignId,
      onsaved: (event) => {
        event.stopPropagation();
        this.showSavedToast(event.detail);
      },
      onfailed: (event) => {
        event.stopPropagation();
        this.dispatchEvent(
          new ShowToastEvent({
            title: event.detail.message,
            variant: "error"
          })
        );
      }
    });
    this.goBack();
  }

  showSavedToast(saved) {
    this.dispatchEvent(
      new ShowToastEvent({
        title: saved.name
          ? `Mappatura Edizione "${saved.name}" was created.`
          : "Mappatura Edizione was created.",
        message: saved.category
          ? `Mappati i prodotti della categoria ${saved.category}.`
          : "",
        variant: "success"
      })
    );
  }

  goBack() {
    if (this.campaignId) {
      this[NavigationMixin.Navigate](
        {
          type: "standard__recordPage",
          attributes: { recordId: this.campaignId, actionName: "view" }
        },
        true
      );
      return;
    }
    if (this.returnUrl) {
      this[NavigationMixin.Navigate](
        { type: "standard__webPage", attributes: { url: this.returnUrl } },
        true
      );
      return;
    }
    // No background page passed: the previous history entry is the list view.
    if (window.history.length > 1) {
      window.history.back();
      return;
    }
    this[NavigationMixin.Navigate](
      {
        type: "standard__objectPage",
        attributes: {
          objectApiName: "Mappatura_Edizione__c",
          actionName: "list"
        },
        state: { filterName: "Recent" }
      },
      true
    );
  }
}
