import { api, LightningElement, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";
import pienissimoLogo from "@salesforce/resourceUrl/QuotePdfLogo";
import findContact from "@salesforce/apex/ParticipantRegistrationController.findContact";
import loadPage from "@salesforce/apex/ParticipantRegistrationController.loadPage";
import markParticipationGroupRinuncia from "@salesforce/apex/ParticipantRegistrationController.markParticipationGroupRinuncia";
import savePage from "@salesforce/apex/ParticipantRegistrationController.savePage";

const READY = "READY";
const COMPLETED = "COMPLETED";
const FIELD_NAMES = ["firstName", "lastName", "email", "phone"];

export default class ParticipantRegistrationPage extends LightningElement {
  @api heading = "Registrazione partecipanti";
  @api servicePath;

  logoUrl = pienissimoLogo;
  token;
  page;
  groups = [];
  assignedTickets = [];
  waivedTickets = [];
  tickets = [];
  isLoading = true;
  rinunciaAssetId;
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
    this.token = state.c__token || state.token;

    const initializationKey = this.token || "";
    if (initializationKey !== this.initializedFor) {
      this.initializedFor = initializationKey;
      this.loadParticipants();
    }
  }

  get showPageContent() {
    return Boolean(this.page) && !this.isLoading;
  }

  get showTickets() {
    return this.groups.length > 0;
  }

  get showAssignedTickets() {
    return this.assignedTickets.length > 0;
  }

  get showWaivedTickets() {
    return this.waivedTickets.length > 0;
  }

  get showFormActions() {
    return (
      this.page?.state === READY && this.tickets.some((row) => row.editable)
    );
  }

  get showFinalMessage() {
    return this.page?.state === COMPLETED && this.page?.message;
  }

  get finalMessageHeading() {
    return this.waivedTickets.length > 0 && this.assignedTickets.length === 0
      ? "Rinuncia registrata"
      : "Partecipanti confermati";
  }

  get requiredSubmissionCount() {
    return this.tickets.filter((row) => row.editable).length;
  }

  get completedSubmissionCount() {
    return this.tickets.filter((row) => row.pendingSave).length;
  }

  get confirmationMessage() {
    const count = this.completedSubmissionCount;
    return count === 1
      ? "Confermi il salvataggio di questo partecipante?"
      : `Confermi il salvataggio di ${count} partecipanti?`;
  }

  get submitDisabled() {
    return (
      this.isSubmitting ||
      Boolean(this.rinunciaAssetId) ||
      this.requiredSubmissionCount === 0
    );
  }

  get rinunciaActionDisabled() {
    return this.isSubmitting || Boolean(this.rinunciaAssetId);
  }

  get accountLabel() {
    return this.page?.accountName || "-";
  }

  get orderLabel() {
    return this.page?.orderNumber || "-";
  }

  async loadParticipants() {
    this.errorMessage = null;
    this.page = null;
    this.groups = [];
    this.assignedTickets = [];
    this.waivedTickets = [];
    this.tickets = [];

    if (!this.token) {
      this.isLoading = false;
      this.errorMessage =
        "Il link non e completo. Apri il collegamento ricevuto via email oppure contatta il tuo referente.";
      return;
    }

    this.isLoading = true;

    try {
      const payload = await loadPage({
        token: this.token
      });
      this.applyPage(payload);
    } catch (error) {
      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isLoading = false;
    }
  }

  applyPage(payload, participantDrafts = new Map()) {
    this.page = payload || {};
    const sourceGroups = payload?.groups || [];
    const displayNumberByAssetId = new Map();
    sourceGroups.forEach((group) => {
      (group.tickets || []).forEach((ticket, index) => {
        displayNumberByAssetId.set(ticket.assetId, index + 1);
      });
    });
    const decoratedTickets = (payload?.tickets || []).map((ticket, index) => {
      const participantDraft = ticket.editable
        ? participantDrafts.get(ticket.assetId) || {}
        : {};

      return this.decorateTicket({
        ...ticket,
        ...participantDraft,
        displayNumber: displayNumberByAssetId.get(ticket.assetId) || index + 1
      });
    });
    const ticketsById = new Map(
      decoratedTickets.map((ticket) => [ticket.assetId, ticket])
    );
    this.groups = sourceGroups.map((group) =>
      this.decorateGroup({
        ...group,
        tickets: (group.tickets || []).map(
          (ticket) =>
            ticketsById.get(ticket.assetId) || this.decorateTicket(ticket)
        )
      })
    );
    this.tickets = decoratedTickets;
    this.assignedTickets = decoratedTickets.filter((ticket) => ticket.assigned);
    this.waivedTickets = decoratedTickets.filter((ticket) => ticket.isRinuncia);

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
    const serverCanRinuncia =
      ticket.serverCanRinuncia ?? Boolean(ticket.canRinuncia);
    const hasAnyParticipantValue = FIELD_NAMES.some((fieldName) =>
      Boolean(this.normalizeValue(currentValues[fieldName]))
    );
    const hasCompleteParticipant = FIELD_NAMES.every((fieldName) =>
      Boolean(this.normalizeValue(currentValues[fieldName]))
    );
    const hasPartialInput =
      editable && hasAnyParticipantValue && !hasCompleteParticipant;
    const pendingSave = editable && hasCompleteParticipant;

    let badgeLabel = ticket.status || "Non disponibile";
    let badgeClass = "status-badge open-badge";

    if (pendingSave) {
      badgeLabel = "Pronto";
      badgeClass = "status-badge save-badge";
    } else if (editable) {
      badgeLabel = "Da compilare";
    } else if (assigned) {
      badgeLabel = "Assegnato";
      badgeClass = "status-badge assigned-badge";
    } else if (ticket.status === "Rinuncia") {
      badgeLabel = "Rinuncia";
      badgeClass = "status-badge rinuncia-badge";
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
      canRinuncia: serverCanRinuncia,
      editable,
      hasPartialInput,
      isRinuncia: ticket.status === "Rinuncia",
      isSavingRinuncia: this.rinunciaAssetId === ticket.assetId,
      pendingSave,
      rowRequiresFields: hasAnyParticipantValue
    };
  }

  handleInput(event) {
    const assetId = event.target.dataset.assetId;
    const fieldName = event.target.dataset.field;
    let value = event.detail?.value ?? event.target.value ?? "";

    if (fieldName === "phone") {
      value = this.normalizePhoneInput(value);
      event.target.value = value;
    }

    const changes = {
      [fieldName]: value
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
        token: this.token,
        email
      });
      const currentTicket = this.tickets.find(
        (ticket) => ticket.assetId === assetId
      );

      this.updateTicket(assetId, {
        firstName:
          match?.found && !this.normalizeValue(currentTicket?.firstName)
            ? match.firstName || ""
            : undefined,
        lastName:
          match?.found && !this.normalizeValue(currentTicket?.lastName)
            ? match.lastName || ""
            : undefined,
        phone:
          match?.found && !this.normalizeValue(currentTicket?.phone)
            ? match.phone || ""
            : undefined,
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
    this.syncGroupTickets();
  }

  compactChanges(changes) {
    return Object.fromEntries(
      Object.entries(changes).filter(([, value]) => value !== undefined)
    );
  }

  syncParticipantInputs(inputs) {
    const changesByAssetId = new Map();

    inputs.forEach((input) => {
      const assetId = input.dataset.assetId;
      const fieldName = input.dataset.field;
      if (!assetId || !FIELD_NAMES.includes(fieldName)) {
        return;
      }

      let value = input.value || "";
      if (fieldName === "phone") {
        value = this.normalizePhoneInput(value);
        input.value = value;
      }

      const changes = changesByAssetId.get(assetId) || {};
      changes[fieldName] = value;
      changesByAssetId.set(assetId, changes);
    });

    this.tickets = this.tickets.map((ticket) => {
      const changes = changesByAssetId.get(ticket.assetId);
      if (!changes) {
        return ticket;
      }

      return this.decorateTicket({
        ...ticket,
        ...changes,
        contactRecognized:
          changes.email !== undefined && changes.email !== ticket.email
            ? false
            : ticket.contactRecognized
      });
    });
    this.syncGroupTickets();
  }

  captureParticipantDrafts() {
    return new Map(
      this.tickets
        .filter(
          (ticket) =>
            ticket.editable &&
            FIELD_NAMES.some((fieldName) =>
              Boolean(this.normalizeValue(ticket[fieldName]))
            )
        )
        .map((ticket) => [
          ticket.assetId,
          {
            ...Object.fromEntries(
              FIELD_NAMES.map((fieldName) => [fieldName, ticket[fieldName]])
            ),
            contactRecognized: ticket.contactRecognized
          }
        ])
    );
  }

  openConfirmation() {
    this.errorMessage = null;

    const inputs = [...this.template.querySelectorAll("lightning-input")];
    this.syncParticipantInputs(inputs);
    const isValid = inputs.reduce((valid, input) => {
      input.reportValidity();
      return input.checkValidity() && valid;
    }, true);

    if (this.completedSubmissionCount === 0) {
      this.errorMessage = "Non ci sono partecipanti da salvare.";
      return;
    }

    if (!isValid || this.tickets.some((ticket) => ticket.hasPartialInput)) {
      this.errorMessage =
        "Completa nome, cognome, email e telefono per ogni partecipante iniziato, oppure svuota la riga.";
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
      .filter((ticket) => ticket.pendingSave)
      .map((ticket) => ({
        assetId: ticket.assetId,
        firstName: (ticket.firstName || "").trim(),
        lastName: (ticket.lastName || "").trim(),
        email: (ticket.email || "").trim(),
        phone: (ticket.phone || "").trim()
      }));

    try {
      const payload = await savePage({
        token: this.token,
        participants
      });
      this.applyPage(payload);
    } catch (error) {
      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isSubmitting = false;
    }
  }

  async handleMarkParticipationGroupRinuncia(event) {
    const groupAssetId = event.currentTarget.dataset.groupId;
    if (!groupAssetId) {
      return;
    }

    const participantDrafts = this.captureParticipantDrafts();
    this.rinunciaAssetId = groupAssetId;
    this.errorMessage = null;
    this.refreshTicketDecorations();

    try {
      const payload = await markParticipationGroupRinuncia({
        token: this.token,
        groupAssetId
      });
      this.applyPage(payload, participantDrafts);
    } catch (error) {
      this.errorMessage = this.normalizeError(error);
    } finally {
      this.rinunciaAssetId = null;
      this.refreshTicketDecorations();
    }
  }

  refreshTicketDecorations() {
    this.tickets = this.tickets.map((ticket) => this.decorateTicket(ticket));
    this.syncGroupTickets();
  }

  decorateGroup(group) {
    return {
      ...group,
      showRinunciaAction: Boolean(group.canRinuncia),
      rinunciaDisabled: this.rinunciaActionDisabled
    };
  }

  syncGroupTickets() {
    const ticketsById = new Map(
      this.tickets.map((ticket) => [ticket.assetId, ticket])
    );
    this.groups = this.groups.map((group) =>
      this.decorateGroup({
        ...group,
        tickets: group.tickets.map(
          (ticket) => ticketsById.get(ticket.assetId) || ticket
        )
      })
    );
    this.assignedTickets = this.tickets.filter((ticket) => ticket.assigned);
    this.waivedTickets = this.tickets.filter((ticket) => ticket.isRinuncia);
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

  normalizePhoneInput(value) {
    const rawValue = value || "";
    const prefix = rawValue.startsWith("+") ? "+" : "";
    const digits = rawValue.replace(/\D/g, "").slice(0, 15);
    return `${prefix}${digits}`;
  }
}
