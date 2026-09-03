---
id: MTG-2026-09-03-datamodel-1
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-03
updated: 2026-09-03
source: Drive - "[ROMI-PIENISSIMO] - Data Model: Parte 1 - 2026/09/03 10:59 CEST - Appunti di Gemini", summary, decisions, details and full transcript read 2026-09-03
---

# 2026-09-03 Data Model Parte 1

**Client-facing session, 3 September 2026, 10:59 CEST; the transcript runs
2h08m.** The first of the three deep customer-registry mapping sessions Elisa
Migliano asked for on 2 September and Elena Spini booked the same morning
([OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md)).
Present: **Elena Spini**, **Aurel Mrruku**, **Andrea Di Cicco**, **Elisa
Migliano**, **Fabrizio Paganelli**. Sabatino Rinaldi was invited optional and
does not appear in the transcript.

The Gemini document carried the summary, a **Decisioni** block and the full
transcript on first reading — unlike the 2 September session, where the
transcript landed an hour after the summary. Everything below is from that
document; direct quotations are from the transcript.

⚠ **Scheduled for one hour, it ran to two.** The three Data Model parts were
booked as 60-minute slots; this one overran by 108%, which is worth knowing
before assuming Parte 2 and Parte 3 will cover what was planned for them.

## What the session was for

Elena Spini shared the data-model workbook on screen and walked the Zoho field
lists object by object against the Salesforce target. The customer registry has
**over 150 fields** — the reason Elisa Migliano asked for these sessions at all.

**The Lead table was deliberately skipped** and held for a later session, so
that Sabatino Rinaldi can be in the room for it. The session covered **Account**
and touched **Preventivo**.

## The agreed mechanism: who owns the customer registry, and when

This is the largest thing the session settled, and it was not in the record
before.

1. **The account is created on Salesforce** and pushed to Mexal **immediately
   before the order is created**. (The workbook's own `Flussi` sheet dates F-1's
   trigger differently — _"scatta alla prima opty won"_ — see the discrepancy
   noted below.)
2. **From that moment Mexal is the source of truth for the anagrafica.**
   Subsequent registry changes are made **only on Mexal**.
3. **A nightly batch carries Mexal's changes back into Salesforce** — the
   workbook's `F-2`. Aurel Mrruku, describing it in the room: _"noi lato
   sales[force] abbiamo il get notturno"_.
4. **Salesforce locks the administrative and accounting fields** once the
   account exists on Mexal, leaving them editable only to amministrazione. The
   trigger for the lock is the **`Codice Cliente Mexal`** field being populated,
   and the mechanism is to be a validation rule.

Commercial fields are explicitly **outside** the lock: the `tipologia attività`
class of field stays editable by the tutors on Salesforce after creation.

New rows for the two unbuilt halves of this:
[OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md)
and
[OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md).

## The agent fields, and what it means for OI-110

🟢 **This answers the half of
[OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)
that mattered most, and from an unexpected direction.**

`Classificatore rete`, `Codice agente` and `Zona` are **not fetched from Mexal at
all** — they are **inherited from the Salesforce user (the tutor) assigned to the
account**. Fabrizio Paganelli demonstrated the existing behaviour on screen:
changing the account's owner updates the agent code and its zone and network data
automatically. So the fields originate on the ROMI side and travel outward.

🔴 **On the order they must freeze.** Fabrizio Paganelli, stating the
administrative rule plainly:

> _"Se io sono un tutor e oggi ho generato un ordine, su quell'ordine le
> provvigioni le devo prendere io come tutor. Se domani ... l'agente di quel
> cliente diventa l'Elisa, da domani in poi tutti gli ordini che verranno ...
> confermati su quel cliente, le provvigioni le dovrà prendere l'Elisa."_

And Aurel Mrruku's restatement, which Fabrizio Paganelli confirmed as exactly
right: _"tu puoi cambiare l'agente a livello di account, ma a livello di ordine
deve rimanere quello precedente."_

**Mexal reconciles the two.** On receiving an order, Mexal compares the order's
agent against its own customer registry; if they differ it **updates its
registry** and pushes the change back overnight. Nothing has to be notified from
the Salesforce side — Fabrizio Paganelli: _"va a cambiare il codice agente
nell'anagrafica di Maxal e poi la notte, tramite il flusso di ritorno dei dati,
va a modificare l'abbinamento che c'è tra cliente e agente."_

⚠ **`OI-110`'s second question is still open.** Whether the Mexal order-creation
call can physically carry the three fields was not tested here; the session
established where the values come from, not that the wire format accepts them.

## Ragione sociale continuity

Fabrizio Paganelli asked for historical continuity when a customer changes its
registered company name. Two mechanisms were agreed, both unbuilt
([OI-118](../items/OI-118%20Ragione%20sociale%20continuity%20on%20the%20customer%20registry.md)):

- **An inner lookup on Account** — a lookup to the same object — labelled
  **`Azienda Precedente`**, chaining backwards to a depth of **five**
  predecessors. Fabrizio Paganelli confirmed five is enough operationally.
- **History Tracking** on the critical fields (partita IVA, ragione sociale),
  within Salesforce's limit of **10 tracked fields per object**.

The previous company's code is to be **passed to Mexal**, where it lands in the
field Mexal calls **`codice alternativo`**.

## Field-by-field outcomes

**Renamed**

- `Codice cliente esterno` → **`Codice Cliente Mexal`**, for legibility. It is
  also the field whose population triggers the administrative lock.
- `Ultima Verifica Credit Safe` → **`Ultima Verifica Anticipay`**. ⚠ Worth
  noticing: **Credit Safe was the predecessor VAT-lookup provider** in Zoho. The
  record has never named it.

**Added**

- **`Azienda obsoleta`** (Dati Commerciali) — a flag, not a deletion.
- **`Azienda Test`** (Dati Tecnici) — internal sales rehearsals, so that test
  data can be **excluded from the commercial statistics**. Assigned to Aurel
  Mrruku.
- **`Azienda Precedente`** — the inner lookup above.
- The **ATECO** fields (`Codice Ateco`, `Ateco Desc`, `Ateco Stato Attivita`)
  classified as Dati Commerciali and editable by tutors. Whether Anticipay
  returns them is
  [OI-112](../items/OI-112%20Whether%20Anticipay%20returns%20the%20ATECO%20code.md).

**Deleted**

- **Email marketing** at company level — it is managed per contact.
- **Telefono commerciale** at company level — same reason. The **telefono
  amministrativo stays and becomes mandatory**.
- **`Livello`** (a legacy Senior/Master classification) — removed, with the door
  left open to reinstating it.
- **`Stato cliente`**, tied to obsolete entry questionnaires — deleted outright.
- A block of legacy platform fields — `Invia Delega`, `Creato da`, `Ultima
  attività`, the RID mandate fields and the old external contract-signature
  fields.
- The **legal-representative block** was struck from the client's template.
  Fabrizio Paganelli: _"per me li potete eliminare tutti e poi li mettete su voi
  in base a come servono"_; Aurel Mrruku will **map whatever the Anticipay call
  actually returns** — _"Li toglierei tutte in base a quello che ci restituisce.
  Faccio io il mapping."_ This is the cleanest thing that has happened to
  [OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)
  and
  [OI-108](../items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md):
  the field list stops being a guess and becomes a consequence of the live
  response.

**Moved**

- **`Tipologia Attività`** leaves the Account and lands on the **Preventivo**, as
  a **non-restrictive picklist**. Elisa Migliano owes the values
  ([OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md)).

**Kept, deliberately**

- **The SDI field stays.** Fabrizio Paganelli's reasoning: it is not needed today
  for San Marino ↔ Italy traffic, where the PEC is used, but _"non si sa mai che
  un domani possa cambiare qualcosa nella normativa e se dopo non ce l'abbiamo
  alimentato e non abbiamo il campo... Se non serve lo lasci vuoto. Se serve
  almeno ce l'abbiamo."_ He asked that **the Mexal integration populate it**.
  ⚠ **This is not a reversal of
  [OI-109](../items/OI-109%20Codice%20destinatario%20SDI%20as%20a%20twelfth%20Anticipay%20field.md)
  but it is next to it**: OI-109 was withdrawn because Elisa Migliano did not
  need the SDI **from Anticipay**. Here the same field is kept and fed **from
  Mexal**. Different source, same field; keep both facts.
- **`Id Zoho`** kept for the duration of the migration, under Dati Tecnici.

**Left pending**

- **Whether Mexal requires both the billing and the shipping address** to create
  an account. This is the session's only formally deferred decision, awaiting a
  technical test with Andrea Di Cicco
  ([OI-113](../items/OI-113%20Whether%20Mexal%20requires%20both%20addresses%20to%20create%20an%20account.md)).
- **`Stato Azienda`**, the RFM classification (dormant/active). Elisa Migliano
  and Elena Spini will consult **Marco Montesi** on whether it migrates at all
  ([OI-114](../items/OI-114%20Whether%20the%20RFM%20company%20state%20migrates.md)).

## Two smaller rulings

- **Codice fiscale is pre-populated from the partita IVA** when the account is
  created on Salesforce, replicating Mexal's own behaviour. Fabrizio Paganelli
  noted the two **can diverge after a change of ragione sociale**, so it is a
  default, not a mirror.
- **Multiple premises under one ragione sociale**: keep what Zoho does today —
  **one Account record**, with the name of the individual locale typed by hand
  into the **note field on the quote**. No account hierarchy, no child records.
  This is a deliberate refusal of structure, and it is the second time the
  project has chosen a free-text field over a modelled one this week.

## A whole-system decision made in passing

🔴 **Every label and every state on Salesforce will be translated into Italian** —
offers and orders included. It is recorded as agreed, by all participants, and it
touches every layout, picklist and state machine already built. Nothing in the
session estimated it.

## Discrepancies and things nobody raised

- ⚠ **F-1's trigger is stated two ways.** The room said the account goes to Mexal
  _immediately before the order is created_; the workbook's `Flussi` sheet says
  _"scatta alla prima opty won"_. These are not the same moment — an opportunity
  can be won before its order exists. Worth one sentence of confirmation at
  Parte 2.
- ⚠ **The residence-splitting contradiction from 2 September was not raised.**
  [OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)
  agreed to model the legal representative's address as **one free-text field**
  while Zoho already holds it split into five. The record flagged this as
  something to raise at Parte 1. It was not raised — though the decision to drop
  the whole legal-rep block and re-derive it from the live Anticipay response
  arguably makes the question moot. **Confirm rather than assume.**
- ⚠ **The `data_di_dascita` typo, the Anticipay error bodies and the pass-through
  date were not raised either**, and Andrea Parmeggiani was not in the room.
- ⚠ Elena Spini, in passing, on the marketing forms: _"uno degli 800 form che
  deve replicare"_. The record carries **100+** from the client's own
  spreadsheet ([OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md)).
  Almost certainly exasperated hyperbole in a call, **not a new count** — noted
  here so nobody later cites it as one.

## Actions leaving the room

| Owner                | Action                                                              |
| -------------------- | ------------------------------------------------------------------- |
| Fabrizio Paganelli   | Ask Andrea Parmeggiani whether Anticipay returns the ATECO code      |
| Fabrizio Paganelli   | Ask Andrea Parmeggiani whether Mexal needs both addresses            |
| Fabrizio Paganelli   | Check that `Azienda Proprietario` and `owner` correspond             |
| Elisa Migliano       | Consult Marco Montesi on the RFM `Stato Azienda`                     |
| Elisa Migliano       | Supply the `Tipologia Attività` picklist values                      |
| Elena Spini          | Classify ATECO and `Azienda obsoleta` under Dati Commerciali         |
| Elena Spini          | Move `Tipologia Attività` to the quote as a non-restrictive picklist |
| Elena Spini          | Strip the template of the fields deleted here                        |
| Elena Spini          | Rename `codice cliente esterno` to `codice cliente Mexal`            |
| Aurel Mrruku         | Put the external code on every Salesforce user                       |
| Aurel Mrruku         | Automate creator-as-tutor on account creation                        |
| Aurel Mrruku         | Build the `Azienda Test` flag                                        |
| Aurel Mrruku         | Map the Anticipay technical fields onto the registry                 |
| Aurel Mrruku         | Build the `Azienda Precedente` inner lookup, depth 5                 |
| Aurel Mrruku         | Pre-populate codice fiscale from partita IVA                         |
| Andrea Di Cicco      | Carry `Codice Destinatario` into the Salesforce ↔ Mexal integration  |

🟢 **Elena Spini acted on her own template actions within four minutes** — the
workbook was modified at 11:11:04Z, minutes after the call ended
([OI-24](../items/OI-24%20Data%20model%20workbook.md)).

⚠ **Nine of the sixteen actions are build tasks on Aurel Mrruku or integration
work on Andrea Di Cicco, and Fase 1 development ends on 10 September** — inside
[the ROMI company event of 9–11 September](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).
Nobody in the session mentioned the deadline.
