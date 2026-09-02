import { api, LightningElement, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";

const READY = "READY";
const COMPLETED = "COMPLETED";

export default class ParticipantRegistrationPage extends LightningElement {
  @api heading = "Registrazione partecipanti";
  @api servicePath = "/services/apexrest/participant-registration";

  accountId;
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

    const initializationKey = this.accountId || "";
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
    return this.page?.state === COMPLETED;
  }

  get submitDisabled() {
    return this.isSubmitting || !this.showFormActions;
  }

  get accountLabel() {
    return this.page?.accountName || "—";
  }

  get campaignLabel() {
    return this.page?.campaignName || "—";
  }

  get endpointUrl() {
    const normalizedPath = this.servicePath.startsWith("/")
      ? this.servicePath
      : `/${this.servicePath}`;
    const currentPath = window.location.pathname;
    const siteRouteIndex = currentPath.indexOf("/s/");
    const sitePrefix =
      siteRouteIndex >= 0 ? currentPath.substring(0, siteRouteIndex) : "";
    return `${window.location.origin}${sitePrefix}${normalizedPath}`;
  }

  async loadParticipants() {
    this.errorMessage = null;
    this.page = null;
    this.tickets = [];

    if (!this.accountId) {
      this.isLoading = false;
      this.errorMessage =
        "Il link non è completo. Apri il collegamento ricevuto via email oppure contatta il tuo referente.";
      return;
    }

    this.isLoading = true;
    try {
      const url = new URL(this.endpointUrl);
      url.searchParams.set("accountId", this.accountId);

      const response = await fetch(url.toString(), {
        credentials: "same-origin",
        headers: { Accept: "application/json" },
        method: "GET"
      });
      const payload = await this.readResponse(response);
      this.applyPage(payload);
    } catch (error) {
      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isLoading = false;
    }
  }

  applyPage(payload) {
    this.page = payload || {};
    this.tickets = (payload?.tickets || []).map((ticket, index) => ({
      ...ticket,
      displayNumber: index + 1,
      editable: Boolean(ticket.editable),
      firstName: ticket.firstName || "",
      lastName: ticket.lastName || "",
      email: ticket.email || "",
      phone: ticket.phone || "",
      cardClass: ticket.editable ? "ticket-card" : "ticket-card assigned"
    }));

    if (payload?.state !== READY && payload?.message) {
      this.errorMessage = payload.message;
    }
  }

  handleInput(event) {
    const assetId = event.target.dataset.assetId;
    const fieldName = event.target.dataset.field;
    const value = event.detail.value;
    this.updateTicket(assetId, { [fieldName]: value });
  }

  async handleEmailBlur(event) {
    const assetId = event.target.dataset.assetId;
    const email = event.target.value?.trim();
    if (!email || !event.target.checkValidity()) {
      return;
    }

    this.updateTicket(assetId, { isLookingUp: true });
    try {
      const url = new URL(`${this.endpointUrl}/contact`);
      url.searchParams.set("accountId", this.accountId);
      url.searchParams.set("email", email);

      const response = await fetch(url.toString(), {
        credentials: "same-origin",
        headers: { Accept: "application/json" },
        method: "GET"
      });
      const match = await this.readResponse(response);
      if (match?.found) {
        this.updateTicket(assetId, {
          firstName: match.firstName || "",
          lastName: match.lastName || "",
          phone: match.phone || "",
          contactRecognized: true,
          isLookingUp: false
        });
      } else {
        this.updateTicket(assetId, {
          contactRecognized: false,
          isLookingUp: false
        });
      }
    } catch (error) {
      this.updateTicket(assetId, { isLookingUp: false });
      this.errorMessage = this.normalizeError(error);
    }
  }

  updateTicket(assetId, changes) {
    this.tickets = this.tickets.map((ticket) => {
      if (ticket.assetId === assetId) {
        return { ...ticket, ...changes };
      }
      return ticket;
    });
  }

  openConfirmation() {
    this.errorMessage = null;
    const inputs = [...this.template.querySelectorAll("lightning-input")];
    const isValid = inputs.reduce((valid, input) => {
      input.reportValidity();
      return input.checkValidity() && valid;
    }, true);

    if (isValid) {
      this.showConfirmation = true;
    } else {
      this.errorMessage =
        "Completa nome, cognome, email e telefono per ogni partecipante.";
    }
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
      const response = await fetch(this.endpointUrl, {
        body: JSON.stringify({
          accountId: this.accountId,
          participants
        }),
        credentials: "same-origin",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json"
        },
        method: "POST"
      });
      const payload = await this.readResponse(response);
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

  async readResponse(response) {
    const text = await response.text();
    let payload = {};
    if (text) {
      try {
        payload = JSON.parse(text);
      } catch {
        throw new Error(
          "Il servizio ha restituito una risposta non valida. Riprova più tardi."
        );
      }
    }

    if (!response.ok) {
      throw new Error(
        payload.message ||
          "Non è stato possibile completare la richiesta. Riprova più tardi."
      );
    }
    return payload;
  }

  normalizeError(error) {
    return (
      error?.message ||
      "Non è stato possibile completare la richiesta. Riprova più tardi."
    );
  }
}
