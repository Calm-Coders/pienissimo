import { api, LightningElement, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";
import loadPage from "@salesforce/apex/QuoteAcceptanceController.loadPage";
import submitAction from "@salesforce/apex/QuoteAcceptanceController.submitAction";

const READY = "READY";
const ACCEPT_ACTION = "accept";
const REJECT_ACTION = "reject";

export default class QuoteAcceptancePage extends LightningElement {
  @api heading = "Gestione preventivo";
  @api servicePath;

  quoteId;
  page;
  lines = [];
  isLoading = true;
  isSubmitting = false;
  errorMessage;
  confirmationAction;
  initializedFor;

  @wire(CurrentPageReference)
  setPageReference(pageReference) {
    if (!pageReference) {
      return;
    }

    const state = pageReference.state || {};
    this.quoteId = state.c__quoteId || state.quoteId || state.recordId;

    const initializationKey = this.quoteId || "";
    if (initializationKey !== this.initializedFor) {
      this.initializedFor = initializationKey;
      this.loadQuote();
    }
  }

  get showPageContent() {
    return Boolean(this.page) && !this.isLoading;
  }

  get showLines() {
    return this.lines.length > 0;
  }

  get showActions() {
    return this.page?.state === READY && this.page?.canAct;
  }

  get showStatusMessage() {
    return Boolean(this.page?.message) && !this.showActions;
  }

  get actionDisabled() {
    return this.isSubmitting || !this.showActions;
  }

  get quoteLabel() {
    return this.page?.quoteName || this.page?.quoteNumber || "-";
  }

  get accountLabel() {
    return this.page?.accountName || "-";
  }

  get opportunityLabel() {
    return this.page?.opportunityName || "-";
  }

  get statusClass() {
    const state = this.page?.state || "";
    return `status-badge ${state.toLowerCase()}`;
  }

  get confirmTitle() {
    return this.confirmationAction === ACCEPT_ACTION
      ? "Conferma preventivo"
      : "Annulla preventivo";
  }

  get confirmMessage() {
    return this.confirmationAction === ACCEPT_ACTION
      ? "Vuoi confermare questo preventivo?"
      : "Vuoi annullare questo preventivo?";
  }

  get confirmButtonLabel() {
    return this.confirmationAction === ACCEPT_ACTION ? "Conferma" : "Annulla";
  }

  get confirmButtonVariant() {
    return this.confirmationAction === ACCEPT_ACTION ? "brand" : "destructive";
  }

  get showConfirmation() {
    return Boolean(this.confirmationAction);
  }

  async loadQuote() {
    this.errorMessage = null;
    this.page = null;
    this.lines = [];

    if (!this.quoteId) {
      this.isLoading = false;
      this.errorMessage =
        "Il link non e completo. Apri il collegamento ricevuto via email oppure contatta il tuo referente.";
      return;
    }

    this.isLoading = true;
    try {
      this.applyPage(await loadPage({ quoteId: this.quoteId }));
    } catch (error) {
      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isLoading = false;
    }
  }

  applyPage(payload) {
    this.page = payload || {};
    this.lines = (payload?.lines || []).map((line, index) => ({
      ...line,
      displayNumber: index + 1,
      productCode: line.productCode || "-"
    }));
  }

  openAcceptConfirmation() {
    this.confirmationAction = ACCEPT_ACTION;
  }

  openRejectConfirmation() {
    this.confirmationAction = REJECT_ACTION;
  }

  closeConfirmation() {
    this.confirmationAction = null;
  }

  async confirmAction() {
    const action = this.confirmationAction;
    this.closeConfirmation();
    if (!action) {
      return;
    }

    this.isSubmitting = true;
    this.errorMessage = null;
    try {
      this.applyPage(
        await submitAction({
          quoteId: this.quoteId,
          action
        })
      );
    } catch (error) {
      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isSubmitting = false;
    }
  }

  handleModalKeydown(event) {
    if (event.key === "Escape") {
      this.closeConfirmation();
    }
  }

  normalizeError(error) {
    return (
      error?.body?.message ||
      error?.message ||
      "Non e stato possibile completare la richiesta. Riprova piu tardi."
    );
  }
}
