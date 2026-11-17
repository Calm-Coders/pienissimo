import { LightningElement } from "lwc";
import getStatus from "@salesforce/apex/MexalSyncController.getStatus";
import startSync from "@salesforce/apex/MexalSyncController.startSync";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

const LABELS = {
  articles: "Aggiorna articoli",
  customers: "Aggiorna clienti",
  invoices: "Aggiorna fatture e scadenzario"
};
const POLL_INTERVAL = 5000;
const IDLE_INTERVAL = 60000;
const SYNC_CONTENT = {
  articles: {
    running: "Aggiornamento del catalogo prodotti.",
    completed: "Ultimo recupero articoli riuscito."
  },
  customers: {
    running: "Aggiornamento degli Account corrispondenti.",
    completed: "Ultimo aggiornamento Account riuscito."
  },
  invoices: {
    running: "Recupero di fatture, righe e scadenze.",
    completed: "Ultimi recuperi fatture e scadenze riusciti."
  }
};

function statusDescription(state) {
  if (state.running) return SYNC_CONTENT[state.key].running;
  switch (state.status) {
    case "Completato":
      return SYNC_CONTENT[state.key].completed;
    case "Errore":
      return "Ultimo tentativo con errori. Possibili aggiornamenti parziali.";
    case "Non configurato":
      return "Configurazione mancante. Contatta un amministratore.";
    default:
      return "Nessun recupero riuscito registrato.";
  }
}

export default class MexalSyncPanel extends LightningElement {
  states = [];
  loading = true;
  starting = false;
  error;
  pollTimer;
  connected = false;
  requestVersion = 0;
  authorized = false;

  get rows() {
    return this.states.map((state) => ({
      ...state,
      label: LABELS[state.key],
      hasSuccessLogs:
        state.status === "Completato" && Boolean(state.successLogs?.length),
      successLogs:
        state.status === "Completato"
          ? (state.successLogs || []).map((log) => ({
              ...log,
              url: `/lightning/r/Integration_Log__c/${log.logId}/view`
            }))
          : [],
      hasErrorDetails:
        state.status === "Errore" &&
        Boolean(state.errorReason || state.errorLogId),
      description: statusDescription(state),
      errorReason: state.status === "Errore" ? state.errorReason : undefined,
      errorLogUrl:
        state.status === "Errore" && state.errorLogId
          ? `/lightning/r/Integration_Log__c/${state.errorLogId}/view`
          : undefined,
      waiting:
        state.blocked && !state.running && state.configured && !this.error,
      disabled:
        this.loading || this.starting || state.blocked || !state.configured,
      statusClass: `status ${state.running ? "running" : state.status === "Errore" ? "failed" : state.status === "Completato" ? "completed" : ""}`
    }));
  }

  get refreshDisabled() {
    return this.loading || this.starting;
  }

  connectedCallback() {
    this.connected = true;
    this.refreshStatus();
  }

  disconnectedCallback() {
    this.connected = false;
    this.requestVersion += 1;
    clearTimeout(this.pollTimer);
  }

  async refreshStatus() {
    clearTimeout(this.pollTimer);
    const version = ++this.requestVersion;
    try {
      const states = await getStatus();
      if (!this.connected || version !== this.requestVersion) return;
      // Apex class access is granted by the existing Full_Permission set.
      // Keep the card hidden unless the server permits the status request.
      this.authorized = true;
      this.states = states;
      this.error = undefined;
    } catch (error) {
      if (!this.connected || version !== this.requestVersion) return;
      this.error = this.errorMessage(error);
      // Stale state must never leave an enabled start button after a failed poll.
      this.states = this.states.map((state) => ({ ...state, blocked: true }));
    } finally {
      if (this.connected && version === this.requestVersion) {
        this.loading = false;
        // Also discover jobs launched elsewhere while this panel stays open.
        if (this.authorized) {
          // eslint-disable-next-line @lwc/lwc/no-async-operation
          this.pollTimer = setTimeout(
            () => this.refreshStatus(),
            this.states.some((state) => state.running)
              ? POLL_INTERVAL
              : IDLE_INTERVAL
          );
        }
      }
    }
  }

  async handleStart(event) {
    if (this.starting || this.loading) return;
    const syncType = event.currentTarget.dataset.key;
    this.starting = true;
    // Invalidate any poll already in flight before changing the running state.
    this.requestVersion += 1;
    clearTimeout(this.pollTimer);
    try {
      await startSync({ syncType });
      if (!this.connected) return;
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Sincronizzazione avviata",
          message: `${LABELS[syncType]}: elaborazione in corso.`,
          variant: "success"
        })
      );
    } catch (error) {
      if (!this.connected) return;
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Avvio non riuscito",
          message: this.errorMessage(error),
          variant: "error"
        })
      );
    } finally {
      this.starting = false;
      if (this.connected) await this.refreshStatus();
    }
  }

  errorMessage(error) {
    return (
      error?.body?.message ||
      error?.message ||
      "Impossibile leggere lo stato Mexal."
    );
  }
}
