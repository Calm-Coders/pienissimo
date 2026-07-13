# [ROMI-PIENISSIMO] Integrazione Mexal (Fatturazione) — 02/07/2026

**Fonti:** meetings/2026-07-02-mexal-invoicing-integration-transcript.it.md (trascrizione originale in italiano, 104 min)

**Partecipanti:** Elena Spini (ROMI), Andrea Di Cicco (ROMI), Sabatino Rinaldi, Fabrizio Paganelli, Marco (Pienissimo — più persone nella stessa stanza con una sola camera, cadute di connessione ricorrenti). Nota: le etichette dei parlanti sono molto imprecise — gran parte dei contenuti etichettati "Marco" è chiaramente Fabrizio (dettagli Mexal/amministrazione), e alcuni segmenti "Sabatino" sono anch'essi di Fabrizio; ricostruito dal contesto.

> **Aggiornamento cross-meeting:** la decisione provvisoria presa qui di mantenere l'integrazione Mexal via file CSV/FTP è stata **ribaltata il 07/07/2026** (vedi [risultato 07/07](2026-07-07-lead-opty-flow-integrations.it.md)): dopo l'analisi della documentazione API consegnata, è stata scelta la REST API.

## Decisioni

- **Integrazione Mexal (provvisoria, poi superata):** mantenere lo scambio CSV/FTP esistente per risparmiare tempo di analisi visti i tempi stretti, e rivalutare le API in seguito. Andrea non poteva stimare la via API senza documentazione. Pienissimo si è impegnata a inviare **gli 8 file CSV + il manuale API di Mexal** il giorno dopo — ed è ciò che ha permesso il ribaltamento verso le REST API il 07/07.
- **Mexal PUÒ fatturare un singolo ordine in più tranche.** Confermato con Passepartout: se ogni riga ordine ha una data di scadenza, la fatturazione differita di Mexal filtra le righe per intervallo di date e le fattura progressivamente. La vecchia regola "un ordine = una fattura" era una policy interna (del precedente responsabile amministrativo), non un limite tecnico. Tutte le righe rata si possono inviare a Mexal in una volta; Mexal restituisce fatture/incassi man mano. → Decade il vecchio workaround degli ordini figli.
- **Modello ordine futuro:** un ordine master + righe rata con scadenza — niente più ordini figli per rata (oggi Zoho crea ordine bundle + N ordini figli: il primo "chiuso/acquisito" per l'acconto, gli altri "creato").
- **I codici "BLO" vanno in pensione.** I bundle attuali si basano su codici articolo blocco (BLO…) e codici "omaggio" a prezzo zero; la direzione non vuole più né gli uni né gli altri. I nuovi pacchetti conterranno **solo codici prodotto reali con prezzi e sconti reali** (l'omaggio diventa un codice reale scontato al 100%, così il cliente vede il valore regalato, non "0 €"). I codici BLO non verranno migrati su Salesforce.
- **Meccanica dei pacchetti confermata:** configurati per evento (3–5 a evento), identici per tutti gli acquirenti, mai modificati dopo la vendita, mai riutilizzati dopo l'evento (~102 pacchetti e 350+ codici blocco accumulati storicamente — su Salesforce si gestisce con attiva/disattiva). Bundle ≈ 40–45% del fatturato. La stessa logica servirà per le campagne commerciali spot (vendite tutor combo).
- **Integrazione WooCommerce via API** (non il plugin del marketplace — pessima esperienza col plugin Zoho). Il team di Sabatino controlla WooCommerce internamente e può fornire chiavi API/webhook/qualsiasi cosa; Andrea verifica se le API standard di Salesforce bastano a ricevere gli ordini (costo quasi zero lato ROMI). Scoperta: esistono **due istanze WooCommerce** (una per libri/prodotti marketing, una per eventi/vendite da palco). Il dedup sugli ordini in ingresso va fatto per **email + partita IVA**. Il bug Zoho del "2x1" (quantità/totale incoerenti) su Salesforce si gestisce con lo sconto (qtà 2 al 50%).
- **Prossima riunione (martedì 07/07):** follow-up integrazioni + flusso Lead/Opportunity ridisegnato da ROMI (Elena si è impegnata a consegnarlo entro il 7) + avvio del **data model** (Excel per oggetto Salesforce; Pienissimo estrae le liste campi da Zoho e le sfoltisce). Invitare Daniela — Pienissimo sottolinea di NON aver pre-accettato il flusso di ROMI; l'ultima parola è della direzione. Timeline blueprint: quadro chiaro settimana prossima, documento scritto la settimana successiva, poi approvazione e partenza build.

## Azioni

| Attività | Responsabile | Stato |
|---|---|---|
| Inviare gli 8 file CSV Mexal + documentazione API a Elena + Andrea (cartella zippata) | Fabrizio / Sabatino | Fatto entro il 07/07 (ROMI ha analizzato le API in quella call) |
| Verificare se le licenze Salesforce attuali supportano bundle/CPQ; riferire | Andrea Di Cicco | Superata → confluita nell'analisi custom vs Revenue Cloud del 07/07 |
| Inviare documentazione Anticipay (ex CreditSafe) + riferimento alla registrazione della demo del 3 giugno | Sabatino | Aperta |
| Inviare le chiavi API WooCommerce (CK/CS) prima della call dedicata | Sabatino | Aperta |
| Richiedere il preventivo licenze DocuSign | Sabatino | Fatto entro il 07/07 (trial attivo, commerciale contattato) |
| Inviare gli altri template documentali (moduli piattaforma, servizio marketing) — scadenza 7 luglio | Elisa | Aperta — verificare ricezione |
| Predisporre la scheda di partecipazione completamente digitale e condividerla con Elena/Andrea | Sabatino | Aperta |
| Consegnare la proposta di flusso Lead/Opty ridisegnato (scadenza 7 luglio) | Elena | Trascinata — rimandata nella call del 07/07, spostata a giovedì |
| Preparare l'Excel del data model (per oggetto Salesforce) per la call di martedì; poi Pienissimo compila le liste campi da estrazione Zoho | Elena / ROMI, poi Pienissimo | Aperta |
| Invitare Daniela alla call di martedì | Sabatino | Fatto (presente il 07/07) |

## Domande aperte / Rischi

- **Verifica partita IVA con Anticipay (ex CreditSafe):** scatta a ogni nuova partita IVA nel CRM, alert in-CRM se la P.IVA è invalida o inesistente; recupera i dati del legale rappresentante (necessari per contratti/firma elettronica). Per Pienissimo è vitale — ~70% dei clienti sbaglia la P.IVA su WooCommerce, e una P.IVA errata blocca l'import ordini su Mexal. Elena propone la fase 2; Pienissimo insiste che vada **insieme all'integrazione Mexal** (i dati che arrivano a Mexal devono già essere puliti). ROMI risponde alla prossima call. Sotto-domanda aperta: Anticipay gestisce le anagrafiche estere o il controllo va skippato per i non-italiani? (probabilmente solo P.IVA italiane — verificare con Andrea Parmigiani/sviluppo).
- **Rischio dual-run:** finché Zoho e Salesforce girano in parallelo, i file FTP sovrascritti ogni notte possono perdere/sovrascrivere dati — la sincronizzazione va progettata esplicitamente (sollevato da Andrea; rilevante anche con la via API per la finestra di transizione).
- **Le due istanze WooCommerce** vanno mappate: quali flussi arrivano da quale istanza, e se entrambe si integrano al go-live.
- **La verifica licenze pacchetti/bundle** è il germe dell'escalation vista il 07/07 — in questa call era ancora un "verifico" di Andrea.
- Dettaglio stampe: i preventivi includono sempre le condizioni generali (identiche per tutti i corsi/eventi) + il riepilogo economico in un unico documento; la scheda di partecipazione (inviata col biglietto) include policy d'ingresso + consenso privacy/foto e sarà ridisegnata quando arriva il flusso digitale.

## Note

- Meccanica FTP attuale: gli ordini in stato "chiuso/acquisito" finiscono nella cartella FTP; Fabrizio lancia manualmente l'import su Mexal; il batch notturno (~3:30) scrive i dati contabili (fatture, incassi, anagrafiche clienti/agenti/prodotti) nella stessa cartella dove il CRM li legge. File a nome fisso sovrascritti ogni notte; il file ordini viene spostato in un'altra cartella dopo l'import.
- Zoho aveva un modulo CPQ; Pienissimo non l'ha mai usato — oggi i pacchetti si configurano su Mexal.
- Preoccupazione dichiarata di Fabrizio: tempi stretti; riusare lo scambio file esistente sembrava più sicuro. Contrappunto di Andrea: l'API è più semplice nel lungo periodo ma richiede coinvolgimento lato Mexal; il compromesso ("mandatemi i file E la documentazione API, analizzo io") è ciò che ha prodotto la decisione del 07/07.
- Osservazione di Elena sullo scope: "mi state aggiungendo mille cose — pacchetti, Anticipay…" — la tensione da scope creep è visibile; risponderà sui tempi di Anticipay dopo la ripianificazione interna.
