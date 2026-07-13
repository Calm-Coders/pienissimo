# [ROMI-PIENISSIMO] Focus Requisiti: Ticketing & Compliance — 08/06/2026

**Fonti:** meetings/2026-06-08-ticketing-compliance-transcript.it.md (trascrizione originale in italiano, 70 min)

**Partecipanti:** Elena Spini, Andrea Di Cicco (ROMI); Sabatino Rinaldi, Fabrizio Paganelli (Pienissimo); Daniela Morgese entrata ~40:56. Etichette dei parlanti molto imprecise (molto contenuto "Sabatino" è di Fabrizio o Daniela); ricostruito dal contesto.

Scopo: approfondimento dedicato sul flusso biglietti/Asset abbozzato nella demo del 3 giugno — chiude la fase demo; da qui partono i meeting tecnici di analisi.

## Decisioni / Accordi

- **Prende forma il ciclo di vita del biglietto in tre stadi** (riconcilia quella che il 30/06 sembrerà una contraddizione):
  1. **Ordine inserito** → il movimento biglietto/magazzino viene *caricato* (parcheggiato, non utilizzabile);
  2. **Fattura integralmente pagata** → il movimento diventa *disponibile* (oggi: procedura notturna automatica legge lo scadenziario Mexal e aggiorna la disponibilità su Zoho — da replicare nell'integrazione Mexal);
  3. **Documenti firmati restituiti** (privacy, non concorrenza, ecc., via DocuSign o simile) → **solo allora si genera il QR code (= il biglietto utilizzabile)**;
  4. All'evento: scansione QR → movimento di scarico → somma algebrica per cliente = 0; i no-show restano visibili come biglietti disponibili.
  Il vincolo-firma (stadio 3) è la proposta ROMI — a Pienissimo piace ("l'idea non è male") ma resta l'OK finale della direzione (ancora pendente il 16/06, confermato prima del 30/06).
- **Partecipanti ≠ contatti dell'account.** Chi compra (spesso titolare o amministrazione) prende N biglietti; i partecipanti ruotano (turnover camerieri), si decidono anche il giorno prima e possono non esistere nel CRM. Pattern adottato (esperienza di Andrea su progetto precedente): dopo il pagamento → mail al referente con link → il referente compila la **lista partecipanti** → i contatti si creano automaticamente in Salesforce → richiesta firma per partecipante → QR emesso alla firma. Funnel di reminder per i biglietti non compilati (già oggi girano un funnel WhatsApp a 60-30-15-1 giorni); **fallback il giorno dell'evento**: bottone per lo staff che invia la mail istantanea / verifica l'identità (nome/mail/telefono) ed emette il QR sul posto — già fanno qualcosa di simile per gli eventi gratuiti con un link sviluppato internamente.
- **Oggetto Campagna = evento.** Ogni evento è una Campaign; i membri campagna = partecipanti con stato check-in (partecipato / no-show) → alimenta le analisi su composizione sala e no-show. Gli ordini multi-evento (un ordine con righe per eventi di set/nov/dic) si spacchettano naturalmente: una riga ordine per evento, ognuna collegata alla sua campagna; i codici prodotto restano trasversali agli anni (l'anno si gestisce con le date campagna + anno di competenza sui movimenti biglietti).
- **Reality-check sulla timeline (acceso):** **Zoho scade il 31 ottobre** (corregge il "fine settembre" del kickoff); Food Marketing Festival = 29 settembre; tour = 7–19 settembre. Realtà concordata: **dual-run fino a fine ottobre** — la fatturazione delle vendite da palco resta su Zoho fino al Food Marketing incluso, i dati biglietti in doppio inserimento su entrambi i sistemi durante la transizione; l'integrazione Mexal↔Salesforce deve partire ben prima di settembre (Fabrizio allarmato per lo sblocco manuale dei biglietti a volumi Food Marketing: 100–150 fatture/giorno). Elena: date molto strette; scope consegnabile da confermare dopo i meeting di analisi; obiettivo = il massimo possibile entro il 31/10.
- **Storage verificato live: 35,2 GB di file storage** (non 5 TB come sperato). PDF firmati + QR si accumuleranno → prevedere una pulizia (es. batch che elimina i file 30 giorni dopo l'evento, previo backup su cloud del cliente). Dove vivono i file (per contatto vs per campagna/evento) da decidere nella proposta definitiva.
- **Contratti Performance Plus rimandati a sessione dedicata:** contratti agenzia annuali (~24k€, 3–4 tranche), ordine manuale del commerciale, rinnovabili ogni anno; serve un pannello contratti (date inizio/fine/rinnovo, fatturato vs incassato per contratto) che alimenti il reparto erogazione (blocco servizio su scaduto grave). Base = oggetto Contract standard + logiche custom di ordine/reminder.
- **Fase demo chiusa.** Prossimi passi: Pienissimo consolida internamente in settimana; poi meeting di analisi (sales + marketing in parallelo); Sabatino invia i link dei form lead/opportunità (pendenti dal 03/06).

## Azioni

| Attività | Responsabile | Stato |
|---|---|---|
| OK della direzione sulla proposta QR vincolato alla firma | Sabatino → Daniela | Fatto tra il 16/06 e il 30/06 (flusso "confermato e validato" secondo la call del 30/06) |
| Progettare oggetto partecipante-campagna + collocazione File/QR + piano storage/pulizia | ROMI | Aperta — alimenta il blueprint |
| Fissare sessioni di analisi sales + marketing; poi sessioni integrazione Mexal + contratti/abbonamenti | Sabatino + Elena | Fatta (tech sales #1 tenuta il 16/06) |
| Inviare i link dei form lead/opportunità | Sabatino | Aperta — rivisti live il 16/06, lista completa pendente |
| Inviare la minuta | Sabatino | Fatta |

## Domande aperte / Rischi

- Gli eventi gratuiti distorcono gli incentivi: forzare la burocrazia su biglietti omaggio aumenta il rischio no-show ("ciò che costa poco restituisce poco") — calibrare la pressione dei reminder per tipo evento.
- La verifica di disponibilità biglietto sarà **manuale** finché non esiste l'integrazione Mexal (specie sui bonifici — l'automazione dei bonifici non è fattibile); a volumi Food Marketing è dolorosa, da qui la pressione sui tempi dell'integrazione.
- Gli acquisti continuano ad arrivare fino al giorno prima dell'evento — il flusso deve accettare ordini, firme ed emissione QR last-minute, anche in ingresso.

## Note

- Scansione oggi: app interna su telefono scansiona il QR → tagga il contatto "arrivato" → scarico di magazzino. Lo staff verifica le firme all'ingresso.
- L'attuale "magazzino biglietti" su Zoho è un archivio parallelo con movimenti carico/disponibile/scarico — il modello che Salesforce deve riprodurre (Asset/oggetto custom + Campaign).
- Zoho resta comunque attivo per Pienissimo Software SRL (vedi 16/06).
