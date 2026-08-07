# Proposta ROMI (Aurel) — Data model Asset/Biglietto

**Data:** 2026-07-13 · **Autore:** Aurel Mrruku (sessione drill-me) · **Stato: 🟢 IN GRAN PARTE ACCETTATO (06/08/2026) — impianto confermato, macchina a stati MODIFICATA (la firma esce dal flusso biglietti). Vedi Reconciliation log. Ancora da riversare nel data model workbook (#24); revisione dedicata del flusso asset fissata dopo il 17/08**
**English summary at the bottom.**

Basata sui vincoli emersi nelle call: ciclo biglietto a 3 stadi (08/06), partecipanti ≠ contatti (08/06), codice prodotto trasversale agli anni (08/06, 35:35), statistiche per prodotto con prezzi spalmati (07/07), catena di tracciabilità fattura↔lead (16/06), analisi no-show per fonte (27/05).

## Scelta dell'oggetto: Asset standard

**Asset standard, un record = un biglietto** (la quantità della riga si esplode in N record). Motivi:

- lookup nativi già pronti: Account (compratore), Contact (partecipante — valorizzato dopo), Product2;
- ogni biglietto vive una vita propria (firma → QR → check-in individuale);
- Elena l'ha già prototipato su Asset → meno attrito sul blueprint;
- il magazzino movimenti di Zoho NON si replica: Status + **field history tracking** = storico movimenti gratis.

Piano B (se Asset mostrasse limiti in analisi): oggetto custom `Biglietto__c`.

## Schema

```
Product2 (codice UNICO trasversale, cod. Mexal, tipologia)
    │
Campaign = EVENTO (edizione: date, anno competenza, capienza)
    │                                  ▲
Order ──< OrderItem ───────────────────┘   lookup Evento__c sulla riga
    │        │  (1 riga per evento/prodotto; prezzo spalmato se da bundle)
    │        └──< ASSET (1 record = 1 biglietto)
    │                ├── Contact (partecipante, assegnato dopo)
    └── Account      ├── Files: PDF firmato + QR
                     └── sync stato → CampaignMember (check-in / no-show)
```

## Asset — campi chiave

| Campo                                    | Tipo             | Note                                                                                                     |
| ---------------------------------------- | ---------------- | -------------------------------------------------------------------------------------------------------- |
| Status                                   | picklist         | **Caricato → Disponibile → In attesa firma → Emesso (QR) → Utilizzato** + Annullato; history tracking ON |
| Account / Contact                        | std              | compratore / partecipante (vuoto alla creazione)                                                         |
| Product2                                 | std              | il corso — statistiche per prodotto                                                                      |
| Riga_Ordine__c                           | lookup OrderItem | catena di tracciabilità fattura↔lead                                                                     |
| Evento__c                                | lookup Campaign  | denormalizzato per report diretti                                                                        |
| Anno_Competenza__c                       | number/picklist  | deciso 08/06                                                                                             |
| Fonte_Acquisto__c                        | picklist/formula | tour / sponsorizzata / palco / tutor → no-show analytics                                                 |
| Fattura_Rif__c + Fattura_Pagata__c       | text + checkbox  | dal ritorno Mexal → trigger Caricato→Disponibile                                                         |
| QR_Id__c, Data_Firma__c, Data_CheckIn__c |                  |                                                                                                          |

## Automazioni

1. **Ordine attivato** → flow: per ogni OrderItem di tipologia evento crea `quantità` Asset in _Caricato_ (bundle: componenti esplosi col prezzo spalmato).
2. **Callback Mexal fattura pagata** → Asset della riga → _Disponibile_ (manuale massivo da list view finché non c'è l'API).
3. **Referente compila lista partecipanti** (link post-pagamento) → dedup contatto (email O telefono), crea Contact + CampaignMember, assegna Contact all'Asset → invio DocuSign → _In attesa firma_.
4. **Webhook DocuSign firmato** → genera QR, allega file → _Emesso_; CampaignMember → "Firmato".
5. **Scan all'ingresso** (app interna via API) → _Utilizzato_ + CampaignMember → "Partecipato". Batch post-evento: Emesso non scansionato → no-show.

## Vincoli / note tecniche

- ⚠ **Non esistono lookup verso CampaignMember**: la sync Asset↔partecipante va fatta via flow sulla coppia (Contact, Campaign), non con relazione diretta.
- Report magazzino: monte biglietti = count per Account; disponibili = Status ≥ Disponibile ≠ Utilizzato; composizione sala/no-show = CampaignMember per fonte.
- Campo esatto di aggancio riga↔campagna mai fissato in riunione — da confermare nel workbook (#24).
- Verificare con Mirko (#12) che il codice prodotto unico non crei problemi lato fatturazione Mexal.

## Reconciliation log

**2026-08-06 (Chiusura ultimi punti aperti) — impianto ACCETTATO, macchina a stati MODIFICATA.**

✅ **Confermato senza modifiche:**

- **Asset standard, un record = un biglietto**, con la quantità di riga esplosa in N record.
- **Il magazzino movimenti di Zoho non si replica**: "biglietto in magazzino" = Asset in _Ordinato/Disponibile_, esattamente come proposto.
- **Aggancio alla riga d'ordine** (`Riga_Ordine__c`) — anzi rafforzato: il match fattura↔biglietto è chiavizzato sul **numero di riga d'ordine**, deliberatamente non sul nome prodotto (Aurel l'ha segnalato come fragile e la scelta è stata accettata).
- **Evento = Campaign**, con sync verso **CampaignMember** per check-in/no-show. In più: la Campagna viene **creata automaticamente** quando il prodotto evento nasce su Mexal, col sync notturno.
- **Il partecipante ≠ compratore**: il Contact si valorizza dopo, alla compilazione della lista partecipanti, con **creazione del contatto se assente** + aggiunta del CampaignMember. Come da automazione #3.
- **`Fattura_Pagata__c` come trigger di _Disponibile_** — confermato, ma vedi la correzione sotto sulla semantica.

⚠ **Modificato — la firma esce dal flusso biglietti, e con essa due stati.** La firma digitale resta **solo per preventivi/contratti** (Elena: _"la firma digitale c'è solo per i preventivi"_). Di conseguenza la picklist proposta **Caricato → Disponibile → In attesa firma → Emesso (QR) → Utilizzato** diventa:

| Proposta 13/07  | Deciso 06/08                    | Nota                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| --------------- | ------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Caricato        | **Ordinato**                    | solo rinomina                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| Disponibile     | **Disponibile**                 | invariato come nome, semantica precisata (sotto)                                                                                                                                                                                                                                                                                                                                                                                                                           |
| In attesa firma | _(eliminato)_                   | non c'è più DocuSign sui biglietti                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Emesso (QR)     | **Assegnato**                   | = documentazione + QR **inviati via mail** al partecipante, non più "firmato". ⚠ L'auto-summary Gemini della call sostiene che questo stato sia stato eliminato: **è errato**. Sabatino lo dice a metà ragionamento (01:32:57) e si corregge 40 secondi dopo, mantenendolo **per la statistica** — _"ci fa statistica per capire quante persone hanno il biglietto nelle mani"_; Elena chiude con _"documentazione più QR code. Perfetto. Quindi questo non è più rosso."_ |
| Utilizzato      | **Utilizzato / Non utilizzato** | il no-show diventa uno stato esplicito, non solo un batch post-evento                                                                                                                                                                                                                                                                                                                                                                                                      |
| Annullato       | **Annullato**                   | invariato; ora generato anche dalla nota di credito sulla riga d'ordine                                                                                                                                                                                                                                                                                                                                                                                                    |

Ne consegue che **le automazioni #3 e #4 vanno riscritte**: niente invio DocuSign né webhook di firma sul biglietto. Il passaggio a _Assegnato_ è l'**invio della mail con documentazione + QR**; il QR si genera lì, non alla firma. `Data_Firma__c` perde significato sul biglietto (la firma dei partecipanti avviene **su carta al check-in**).

⚠ **Corretta la semantica di `Fattura_Pagata__c`, e fissata la chiave di match.** La proposta diceva "callback Mexal fattura pagata → Asset della riga → Disponibile". La regola vera, imposta da Elisa: il biglietto diventa _Disponibile_ solo quando **la fattura di tranche che contiene quella riga è incassata INTEGRALMENTE** — un pagamento parziale non libera nulla (fattura di tranche da €1.000 su due eventi, €500 pagati ⇒ nessuno dei due biglietti disponibile). La granularità per evento arriva dalla **fatturazione per tranche**, non da logiche di pagamento parziale. Formulazione concordata: **"fattura pagata a livello di rata/tranche"**.

⚠ **La composizione delle tranche non segue gli eventi.** Elisa: _"ci sono tot rate che vengono suddivise sulla base della gestione del cliente, non sulla base dell'evento"_ — una tranche può contenere più eventi, e il biglietto di un evento può stare dietro voci non correlate nella stessa fattura. Chi disegna il trigger non può assumere una corrispondenza 1:1 tranche↔evento.

⚠ **`Riga_Ordine__c` diventa la chiave di integrazione, non un semplice lookup di tracciabilità.** In sessione sono state testate e scartate due chiavi alternative, entrambe da Elisa:

- **match per data** (fattura↔tranche): non funziona perché la data della tranche è la _data di presumibile incasso_ e Pienissimo fattura **in anticipo** — le tranche in scadenza il 31 gennaio si fatturano a inizio gennaio;
- **match per prodotto**: non funziona perché _"un tutor può mettere anche lo stesso codice due volte nello stesso ordine"_.

La fattura Mexal porta **cliente, numero documento, riferimento numero d'ordine, codice articolo e numero di riga d'ordine**; il match va fatto sul **numero di riga d'ordine**, secondo il principio di Elisa: _"è bene lavorare su elementi che sono nascosti ai tutor."_ Aurel osservava che sarebbe bastato un segnale "righe pagate" senza la fattura; **Elena ha imposto il contrario** — la fattura deve arrivare su Salesforce per le logiche di reporting concordate.

**Aggiunte dal 06/08 (non presenti nella proposta, tracciate a parte):**

- **Tipologia biglietto come picklist sull'anagrafica prodotto** (Gold / Silver / Executive …) anziché dedotta dal nome del codice — un evento può avere asset di tipo diverso. Tracker #76; da aggiungere ai campi chiave dell'Asset o da ereditare da Product2.
- ⚠ **Due percorsi distinti per i casi limite — l'automazione #5 va sdoppiata**, non estesa:
  - **Cambio nominativo _prima_ dell'evento**: pulsante sull'account che elenca gli asset di quell'account → annulla il vecchio nominativo, inserisce il nuovo → **si rigenera il QR** (il documento stampa nome partecipante ed evento sopra il codice, quindi non è riutilizzabile) → documentazione aggiornata inviata **all'indirizzo email della nuova persona**. Tracker #78.
  - **Sostituzione o documenti mancanti _al_ check-in**: verifica biglietto+ordine+pagamento all'infopoint → il partecipante **rifirma il modulo cartaceo** → inserimento manuale. **In questo percorso non si emette alcun QR.** Tracker #78.
- 🔴 **Buco aperto sul CampaignMember**: il percorso manuale non ha una specifica di aggiornamento del CampaignMember, quindi un sostituto inserito a mano rischia di non risultare presente. Questo colpisce direttamente il report no-show del §"Vincoli / note tecniche" (che già segnala l'assenza di lookup verso CampaignMember). Tracker #84.
- **Campi asset che Pienissimo tiene oggi** e che Elisa ha rifiutato di congelare prima della revisione del flusso: **evento/edizione, anno accademico, anno di competenza** — quest'ultimo guida il movimento di "magazzino" del biglietto. Da riconciliare con `Anno_Competenza__c` già previsto in questa proposta e con la distinzione **anno solare ≠ anno accademico** fissata il 23/07.
- **Il caso d'uso più frequente non è la sostituzione** ma chi non ha stampato o non ha ricevuto la mail. Causa reale segnalata da Elisa: clienti **disiscritti dalle mail marketing** smettevano di ricevere i biglietti. Il disegno concordato mitiga il problema inviando la mail con QR **da Salesforce** e non da marketing.
- **Nota di credito a livello di ordine** con selezione delle righe da stornare; per i prodotti evento **annulla l'asset** collegato — tracker #54.
- **Funnel di comunicazione a 60 giorni dall'evento** che invia il link di raccolta dati partecipanti, per bundle multi-evento **per singolo evento** — tracker #81.

🟡 **Ancora aperto:** il campo esatto di aggancio riga↔campagna resta da fissare nel workbook (#24), e sia Elisa sia Elena hanno riconosciuto che **il flusso asset richiede una revisione dedicata** — meeting dopo il 17/08 con Rebecca Marmo inclusa (#82). Il piano B `Biglietto__c` non è stato discusso in call, ma in UAT esiste già uno stack Apex `Biglietto__c` privo di test (#66) — da riconciliare con la scelta "Asset standard" di questa proposta.

---

### English summary

ROMI-side draft (Aurel, 2026-07-13, status DRAFT): use **standard Asset, one record per ticket unit**, statuses Caricato→Disponibile→In attesa firma→Emesso→Utilizzato with field history tracking replacing Zoho's movement ledger; lookups to Account/Contact/Product2 + custom lookups to OrderItem and Campaign(=event); Anno_Competenza and Fonte_Acquisto fields for cross-year codes and no-show analytics; five automations (order→load, Mexal-paid→available, participant-list→DocuSign, signed→QR issued, scan→used + post-event no-show batch). Constraint: no lookups to CampaignMember → sync via flow on (Contact, Campaign). Fallback: custom Biglietto__c. To validate with Elena + Andrea and fold into data-model workbook (#24).
