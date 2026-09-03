import { api, LightningElement, wire } from "lwc";
import { CurrentPageReference } from "lightning/navigation";

const READY = "READY";
const COMPLETED = "COMPLETED";
const FIELD_NAMES = ["firstName", "lastName", "email", "phone"];

export default class ParticipantRegistrationPage extends LightningElement {
  @api heading = "Registrazione partecipanti";
  @api servicePath = "/services/apexrest/participant-registration";

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
    console.log("=== DEBUG CurrentPageReference ===");
    console.log("pageReference:", JSON.stringify(pageReference));

    if (!pageReference) {
      console.warn("DEBUG: pageReference is null");
      return;
    }

    const state = pageReference.state || {};

    console.log("DEBUG state:", JSON.stringify(state));

    this.accountId = state.c__accountId || state.accountId;

    this.campaignId = state.c__campaignId || state.campaignId;

    console.log("DEBUG accountId:", this.accountId);
    console.log("DEBUG campaignId:", this.campaignId);

    const initializationKey = `${this.accountId || ""}-${this.campaignId || ""}`;

    console.log("DEBUG initializationKey:", initializationKey);
    console.log("DEBUG previous initializedFor:", this.initializedFor);

    if (initializationKey !== this.initializedFor) {
      this.initializedFor = initializationKey;

      console.log("DEBUG: calling loadParticipants()");

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

    if (count === 1) {
      return "Confermi il salvataggio di questo partecipante?";
    }

    return `Confermi il salvataggio di ${count} partecipanti?`;
  }

  get submitDisabled() {
    return (
      this.isSubmitting ||
      this.requiredSubmissionCount === 0 ||
      this.completedSubmissionCount !== this.requiredSubmissionCount
    );
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

    const endpoint = `${window.location.origin}${sitePrefix}${normalizedPath}`;

    console.log("DEBUG endpointUrl:", endpoint);
    console.log("DEBUG window.location.pathname:", window.location.pathname);
    console.log("DEBUG sitePrefix:", sitePrefix);

    return endpoint;
  }

  async loadParticipants() {
    console.log("========== DEBUG loadParticipants START ==========");

    this.errorMessage = null;
    this.page = null;
    this.tickets = [];

    console.log("DEBUG accountId:", this.accountId);

    console.log("DEBUG campaignId:", this.campaignId);

    if (!this.accountId || !this.campaignId) {
      console.error("DEBUG: Missing accountId or campaignId", {
        accountId: this.accountId,
        campaignId: this.campaignId
      });

      this.isLoading = false;

      this.errorMessage =
        "Il link non è completo. Apri il collegamento ricevuto via email oppure contatta il tuo referente.";

      return;
    }

    this.isLoading = true;

    try {
      const url = new URL(this.endpointUrl);

      url.searchParams.set("accountId", this.accountId);

      url.searchParams.set("campaignId", this.campaignId);

      console.log("DEBUG GET URL:", url.toString());

      console.log("DEBUG: sending GET request...");

      const response = await fetch(url.toString(), {
        credentials: "same-origin",
        headers: {
          Accept: "application/json"
        },
        method: "GET"
      });

      console.log("DEBUG GET response status:", response.status);

      console.log("DEBUG GET response statusText:", response.statusText);

      console.log("DEBUG GET response ok:", response.ok);

      const payload = await this.readResponse(response);

      console.log("DEBUG GET payload:", JSON.stringify(payload));

      this.applyPage(payload);
    } catch (error) {
      console.error("DEBUG loadParticipants ERROR:", error);

      console.error("DEBUG error message:", error?.message);

      console.error("DEBUG error stack:", error?.stack);

      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isLoading = false;

      console.log("========== DEBUG loadParticipants END ==========");
    }
  }

  applyPage(payload) {
    console.log("DEBUG applyPage payload:", JSON.stringify(payload));

    this.page = payload || {};

    this.tickets = (payload?.tickets || []).map((ticket, index) =>
      this.decorateTicket({
        ...ticket,
        displayNumber: index + 1
      })
    );

    console.log("DEBUG tickets:", JSON.stringify(this.tickets));

    if (
      payload?.state !== READY &&
      payload?.state !== COMPLETED &&
      payload?.message
    ) {
      this.errorMessage = payload.message;
    }
  }

  decorateTicket(ticket) {
    const firstName = ticket.firstName || "";

    const lastName = ticket.lastName || "";

    const email = ticket.email || "";

    const phone = ticket.phone || "";

    const currentValues = {
      firstName,
      lastName,
      email,
      phone
    };

    const assigned = Boolean(ticket.assigned);

    const editable = Boolean(ticket.editable);

    const hasAnyParticipantValue = FIELD_NAMES.some((fieldName) =>
      Boolean(this.normalizeValue(currentValues[fieldName]))
    );

    const hasCompleteParticipant = FIELD_NAMES.every((fieldName) =>
      Boolean(this.normalizeValue(currentValues[fieldName]))
    );

    const rowRequiresFields = editable;

    const hasPartialInput =
      rowRequiresFields && hasAnyParticipantValue && !hasCompleteParticipant;

    const pendingSave = rowRequiresFields && hasCompleteParticipant;

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
      assigned,
      badgeClass,
      badgeLabel,
      cardClass: cardClasses.join(" "),
      contactRecognized: Boolean(ticket.contactRecognized),
      editable,
      email,
      firstName,
      hasPartialInput,
      lastName,
      pendingSave,
      phone,
      rowRequiresFields
    };
  }

  handleInput(event) {
    const assetId = event.target.dataset.assetId;

    const fieldName = event.target.dataset.field;

    const value = event.detail.value;

    console.log("DEBUG handleInput:", {
      assetId,
      fieldName,
      value
    });

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

    console.log("========== DEBUG contact lookup ==========");

    console.log("DEBUG assetId:", assetId);

    console.log("DEBUG email:", email);

    if (!email || !event.target.checkValidity()) {
      console.warn("DEBUG: invalid or empty email");

      return;
    }

    this.updateTicket(assetId, {
      isLookingUp: true
    });

    try {
      const url = new URL(`${this.endpointUrl}/contact`);

      url.searchParams.set("accountId", this.accountId);

      url.searchParams.set("campaignId", this.campaignId);

      url.searchParams.set("email", email);

      console.log("DEBUG CONTACT URL:", url.toString());

      const response = await fetch(url.toString(), {
        credentials: "same-origin",

        headers: {
          Accept: "application/json"
        },

        method: "GET"
      });

      console.log("DEBUG CONTACT status:", response.status);

      const match = await this.readResponse(response);

      console.log("DEBUG CONTACT response:", JSON.stringify(match));

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
      console.error("DEBUG contact lookup ERROR:", error);

      this.updateTicket(assetId, {
        isLookingUp: false
      });

      this.errorMessage = this.normalizeError(error);
    }
  }

  updateTicket(assetId, changes) {
    this.tickets = this.tickets.map((ticket) => {
      if (ticket.assetId === assetId) {
        return this.decorateTicket({
          ...ticket,
          ...changes
        });
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
    console.log("========== DEBUG POST START ==========");

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

    const requestBody = {
      accountId: this.accountId,

      campaignId: this.campaignId,

      participants
    };

    console.log("DEBUG POST endpoint:", this.endpointUrl);

    console.log("DEBUG POST request body:", JSON.stringify(requestBody));

    try {
      const response = await fetch(this.endpointUrl, {
        body: JSON.stringify(requestBody),

        credentials: "same-origin",

        headers: {
          Accept: "application/json",

          "Content-Type": "application/json"
        },

        method: "POST"
      });

      console.log("DEBUG POST status:", response.status);

      console.log("DEBUG POST statusText:", response.statusText);

      console.log("DEBUG POST ok:", response.ok);

      const payload = await this.readResponse(response);

      console.log("DEBUG POST response payload:", JSON.stringify(payload));

      this.applyPage(payload);
    } catch (error) {
      console.error("DEBUG POST ERROR:", error);

      console.error("DEBUG POST error message:", error?.message);

      console.error("DEBUG POST error stack:", error?.stack);

      this.errorMessage = this.normalizeError(error);
    } finally {
      this.isSubmitting = false;

      console.log("========== DEBUG POST END ==========");
    }
  }

  handleModalKeydown(event) {
    if (event.key === "Escape") {
      this.closeConfirmation();
    }
  }

  async readResponse(response) {
    console.log("========== DEBUG readResponse ==========");

    console.log("DEBUG status:", response.status);

    console.log("DEBUG statusText:", response.statusText);

    console.log(
      "DEBUG headers:",
      Object.fromEntries(response.headers.entries())
    );

    const text = await response.text();

    console.log("DEBUG RAW RESPONSE:");

    console.log(text);

    let payload = {};

    if (text) {
      try {
        payload = JSON.parse(text);

        console.log("DEBUG parsed JSON:", payload);
      } catch (parseError) {
        console.error("DEBUG JSON parse error:", parseError);

        console.error("DEBUG invalid response text:", text);

        throw new Error(
          "Il servizio ha restituito una risposta non valida. Riprova più tardi."
        );
      }
    }

    if (!response.ok) {
      console.error("DEBUG HTTP ERROR", {
        status: response.status,
        statusText: response.statusText,
        payload
      });

      throw new Error(
        payload.message ||
          `Errore HTTP ${response.status}: Non è stato possibile completare la richiesta.`
      );
    }

    return payload;
  }

  normalizeError(error) {
    console.error("DEBUG normalizeError:", error);

    return (
      error?.message ||
      "Non è stato possibile completare la richiesta. Riprova più tardi."
    );
  }

  normalizeValue(value) {
    return (value || "").trim();
  }
}
