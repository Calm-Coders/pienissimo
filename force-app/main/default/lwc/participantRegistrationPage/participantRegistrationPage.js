import { api, LightningElement, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";
import findContact from "@salesforce/apex/ParticipantRegistrationController.findContact";
import loadPage from "@salesforce/apex/ParticipantRegistrationController.loadPage";
import savePage from "@salesforce/apex/ParticipantRegistrationController.savePage";

const READY = "READY";
const COMPLETED = "COMPLETED";
const FIELD_NAMES = ["firstName", "lastName", "email", "phone"];

export default class ParticipantRegistrationPage extends LightningElement {
  @api heading = "Registrazione partecipanti";
  @api servicePath;

  accountId;
  campaignId;
  page;
  tickets = [];
  isLoading = true;
  isSubmitting = false;
  showConfirmation = false;
  errorMessage;
  initializedFor;

  @wire(CurrentPageReference)
  setPageReference(pageReference) {
    if (!pageReference) {
      return;
    }

    const state = pageReference.state || {};
    this.accountId = state.c__accountId || state.accountId;
    this.campaignId = state.c__campaignId || state.campaignId;

    const initializationKey = `${this.accountId || ""}-${this.campaignId || ""}`;
    if (initializationKey !== this.initializedFor) {
      this.initializedFor = initializationKey;
      this.loadParticipants();
    }
  }

  get showPageContent() {
    return Boolean(this.page) && !this.isLoading;
  }

  get showTickets() {
    return this.tickets.length > 0;
  }

  get showFormActions() {
    return (
      this.page?.state === READY && this.tickets.some((row) => row.editable)
    );
  }

  get showFinalMessage() {
    return this.page?.state === COMPLETED && this.page?.message;
  }

  get requiredSubmissionCount() {
    return this.tickets.filter((row) => row.editable).length;
  }

  get completedSubmissionCount() {
    return this.tickets.filter((row) => row.pendingSave).length;
  }

  get confirmationMessage() {
    const count = this.requiredSubmissionCount;
    return count === 1
      ? "Confermi il salvataggio di questo partecipante?"
      : `Confermi il salvataggio di ${count} partecipanti?`;
  }

  get submitDisabled() {
    return (
      this.isSubmitting ||
      this.requiredSubmissionCount === 0 ||
      this.completedSubmissionCount !== this.requiredSubmissionCount
    );
  }

  get accountLabel() {
    return this.page?.accountName || "-";
  }

  get campaignLabel() {
    return this.page?.campaignName || "-";
  }

  async loadParticipants() {
    this.errorMessage = null;
    this.page = null;
    this.tickets = [];

    if (!this.accountId || !this.campaignId) {
      this.isLoading = false;
      this.errorMessage =
        "Il link non e completo. Apri il collegamento ricevuto via email oppure contatta il tuo referente.";
      return;
    }

    this.isLoading = true;

    try {
      const payload = await loadPage({
        accountId: this.accountId,
        campaignId: this.campaignId
      });
      this.applyPage(payload);
    } catch (error) {
      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isLoading = false;
    }
  }

  applyPage(payload) {
    this.page = payload || {};
    this.tickets = (payload?.tickets || []).map((ticket, index) =>
      this.decorateTicket({
        ...ticket,
        displayNumber: index + 1
      })
    );

    if (
      payload?.state !== READY &&
      payload?.state !== COMPLETED &&
      payload?.message
    ) {
      this.errorMessage = payload.message;
    }
  }

  decorateTicket(ticket) {
    const currentValues = {
      firstName: ticket.firstName || "",
      lastName: ticket.lastName || "",
      email: ticket.email || "",
      phone: ticket.phone || ""
    };

    const assigned = Boolean(ticket.assigned);
    const editable = Boolean(ticket.editable);
    const hasAnyParticipantValue = FIELD_NAMES.some((fieldName) =>
      Boolean(this.normalizeValue(currentValues[fieldName]))
    );
    const hasCompleteParticipant = FIELD_NAMES.every((fieldName) =>
      Boolean(this.normalizeValue(currentValues[fieldName]))
    );
    const hasPartialInput =
      editable && hasAnyParticipantValue && !hasCompleteParticipant;
    const pendingSave = editable && hasCompleteParticipant;

    let badgeLabel = "Da compilare";
    let badgeClass = "status-badge open-badge";

    if (pendingSave) {
      badgeLabel = "Pronto";
      badgeClass = "status-badge save-badge";
    } else if (assigned) {
      badgeLabel = "Assegnato";
      badgeClass = "status-badge assigned-badge";
    } else if (hasAnyParticipantValue) {
      badgeLabel = "In compilazione";
      badgeClass = "status-badge draft-badge";
    }

    const cardClasses = ["ticket-card"];
    if (assigned) {
      cardClasses.push("assigned");
    }
    if (hasPartialInput) {
      cardClasses.push("incomplete");
    }
    if (pendingSave) {
      cardClasses.push("ready-to-save");
    }

    return {
      ...ticket,
      ...currentValues,
      assigned,
      badgeClass,
      badgeLabel,
      cardClass: cardClasses.join(" "),
      contactRecognized: Boolean(ticket.contactRecognized),
      editable,
      hasPartialInput,
      pendingSave,
      rowRequiresFields: editable
    };
  }

  handleInput(event) {
    const assetId = event.target.dataset.assetId;
    const fieldName = event.target.dataset.field;
    const changes = {
      [fieldName]: event.detail.value
    };

    if (fieldName === "email") {
      changes.contactRecognized = false;
    }

    this.updateTicket(assetId, changes);
  }

  async handleEmailBlur(event) {
    const assetId = event.target.dataset.assetId;
    const email = event.target.value?.trim();

    if (!email || !event.target.checkValidity()) {
      return;
    }

    this.updateTicket(assetId, { isLookingUp: true });

    try {
      const match = await findContact({
        accountId: this.accountId,
        campaignId: this.campaignId,
        email
      });

      this.updateTicket(assetId, {
        firstName: match?.found ? match.firstName || "" : undefined,
        lastName: match?.found ? match.lastName || "" : undefined,
        phone: match?.found ? match.phone || "" : undefined,
        contactRecognized: Boolean(match?.found),
        isLookingUp: false
      });
    } catch (error) {
      this.updateTicket(assetId, { isLookingUp: false });
      this.errorMessage = this.normalizeError(error);
    }
  }

  updateTicket(assetId, changes) {
    this.tickets = this.tickets.map((ticket) => {
      if (ticket.assetId === assetId) {
        return this.decorateTicket({
          ...ticket,
          ...this.compactChanges(changes)
        });
      }

      return ticket;
    });
  }

  compactChanges(changes) {
    return Object.fromEntries(
      Object.entries(changes).filter(([, value]) => value !== undefined)
    );
  }

  openConfirmation() {
    this.errorMessage = null;

    const inputs = [...this.template.querySelectorAll("lightning-input")];
    const isValid = inputs.reduce((valid, input) => {
      input.reportValidity();
      return input.checkValidity() && valid;
    }, true);

    if (this.requiredSubmissionCount === 0) {
      this.errorMessage = "Non ci sono partecipanti da salvare.";
      return;
    }

    if (
      !isValid ||
      this.completedSubmissionCount !== this.requiredSubmissionCount
    ) {
      this.errorMessage =
        "Completa nome, cognome, email e telefono per tutti i biglietti non ancora assegnati.";
      return;
    }

    this.showConfirmation = true;
  }

  closeConfirmation() {
    this.showConfirmation = false;
  }

  async confirmSubmission() {
    this.showConfirmation = false;
    this.isSubmitting = true;
    this.errorMessage = null;

    const participants = this.tickets
      .filter((ticket) => ticket.editable)
      .map((ticket) => ({
        assetId: ticket.assetId,
        firstName: (ticket.firstName || "").trim(),
        lastName: (ticket.lastName || "").trim(),
        email: (ticket.email || "").trim(),
        phone: (ticket.phone || "").trim()
      }));

    try {
      const payload = await savePage({
        accountId: this.accountId,
        campaignId: this.campaignId,
        participants
      });
      this.applyPage(payload);
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

  normalizeValue(value) {
    return (value || "").trim();
  }
}
