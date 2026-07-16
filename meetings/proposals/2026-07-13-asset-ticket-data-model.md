# Proposta ROMI (Aurel) — Data model Asset/Biglietto

**Data:** 2026-07-13 · **Autore:** Aurel Mrruku (sessione drill-me) · **Stato: 🟡 BOZZA — da validare con Elena + Andrea Di Cicco, poi da riversare nel data model workbook (#24)**
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

_(compilato dal drill quando il tema verrà discusso in una call)_

- —

---

### English summary

ROMI-side draft (Aurel, 2026-07-13, status DRAFT): use **standard Asset, one record per ticket unit**, statuses Caricato→Disponibile→In attesa firma→Emesso→Utilizzato with field history tracking replacing Zoho's movement ledger; lookups to Account/Contact/Product2 + custom lookups to OrderItem and Campaign(=event); Anno_Competenza and Fonte_Acquisto fields for cross-year codes and no-show analytics; five automations (order→load, Mexal-paid→available, participant-list→DocuSign, signed→QR issued, scan→used + post-event no-show batch). Constraint: no lookups to CampaignMember → sync via flow on (Contact, Campaign). Fallback: custom Biglietto__c. To validate with Elena + Andrea and fold into data-model workbook (#24).
