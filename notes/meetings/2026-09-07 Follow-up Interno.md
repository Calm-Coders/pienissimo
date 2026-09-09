---
id: MTG-2026-09-07-followup-interno
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-09-07
updated: 2026-09-07
source: Drive - "[PIENISSIMO] - Follow-up Interno - 2026/09/07 17:01 CEST - Appunti di Gemini", summary, Decisioni and details read 2026-09-07. No transcript published.
---

# 2026-09-07 Follow-up Interno

**ROMI-internal weekly session, 7 September 2026, 17:01 CEST.** Present:
**Elena Spini**, **Aurel Mrruku**, **Andrea Di Cicco**, **Fabrizio Mastracci**.

⚠ **Read from the Gemini notes only — summary, seven `Concordato` decisions and
fifteen detail bullets. No transcript section exists in the document**, and its
`Allegati` block points at a **13 July** recording, an artifact of the recurring
event. A recording of this session does exist
(`11Vbm2v09VTtoj0YkPcXfW6SIKNKVWDQy`, 553 MB, 16:58:29Z) and was not opened. So
this is a decision list, not a minute, and **no quotation below is verbatim
speech** — the wording is Gemini's.

This is the most consequential session of the run. It moved the go-live date,
parked Fase 2, settled six Mexal integration questions and deferred one to a
second phase.

## 🔴 Go-live moves to 21 September, approval by 13 September

> _"È stato concordato di fissare la data di Go Live al 21 settembre, con
> l'approvazione fissata entro il 13 dello stesso mese."_

The detail bullet frames it as **adding weeks of development and test** to reach
21 September, with **release to production preceding go-live** and **approval by
13 September**.

🔴 **Every governing document in this repository says 6 October 2026** — `CTX-02`
in [REQUIREMENTS.md](../../REQUIREMENTS.md) and
[REQUISITI.it.md](../../REQUISITI.it.md), the milestone tables in both, the
priority definition of `M`, the Fase 2 escalation rule, `MAP.md` and the recaps.
21 September is **two weeks earlier**, not later.

**Nothing has been changed in the register on the strength of this.** A
contractually operative date, in the document the client signs, does not move on
an internal ROMI meeting summary that nobody has reconciled with the published
plan — [OI-124](../items/OI-124%20Go-live%20moved%20to%2021%20October%20and%20the%20register%20still%20says%206%20October.md)
carries the question.

⚠ Aurel Mrruku is recorded as sceptical about the timing and the remaining
workload, naming **the community, DocuSign document handling, lead conversion and
the WooCommerce integration** as still open. Elena Spini's answer was to hold
client demonstration sessions **from 24 September** showing what is ready, and
manage the rest in flight.

## 🔴 Fase 2 is parked until the client confirms payment

> _"È stato deciso di mantenere accantonata la fase due del progetto fino a
> eventuale conferma di pagamento da parte del cliente."_

Elena Spini restated the goal of getting Fase 2 quoted to cover the accumulated
out-of-scope work.

This is the first movement in the record on
[the phase 2 dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
since **24 July**, and it is a **ROMI-side posture, not a client answer**:
Daniela Morgese has still not been told, and
[OI-83](../items/OI-83%20No%20phase%202%20estimate.md) still records that the
decision-maker was never approached. What changed is that ROMI has now decided
what it does while waiting.

⚠ It sits directly against a Fase 1 dependency: a Fase 1 integration already
depends on the disputed entity, and the item below moves work **into** the parked
phase.

## Project delay and estimation

The session opened on **accumulated delay in the project plan**, caused by
workload and by unforeseen marketing requirements — the rinuncia button in the
event invitation emails is named as the example. Aurel Mrruku raised the impact of
the workload on the schedule and that **requirements keep changing**. Elena Spini
is recorded as acknowledging the initial oversight in how the marketing flows were
scoped.

Andrea Di Cicco's proposal: produce **approximate estimates** and **pre-warn
Gianpaolo Motta**, given the October deadline. A `Stima Task` spreadsheet and a
`Jira.csv` export, both owned by `d.losco@romicompany.com`, were created in Drive
at **10:21–10:22Z** and last modified **12:28Z** — before this session. ⚠ **They
are in a folder this run did not identify as Pienissimo's and were not opened**;
whether they are this project's estimates is unverified.

## Concordato — the Mexal integration

Six decisions, all of which sharpen
[the Mexal integration](../flows/The%20Mexal%20integration.md):

### Authentication and static management coordinates

The *coordinate gestionali* go in the API call header as **`azienda = PE`** and
**`anno = 2025`**, set **statically in code**. Authorization is a **base64 string
of user then password**. Andrea Di Cicco owes Aurel Mrruku the documentation
fragment for it.

🔴 **`anno = 2025` is hardcoded and this project goes live in 2026.** Nothing in
the session addresses what happens at a year boundary, or whether the value is a
Mexal fiscal-year selector that must change. **Nobody raised it.**

⚠ **No credential value is recorded here.** The mechanism is basic auth over a
base64 user:password pair; that pair is not in this repository and must not be.

### Customer search must be filtered

The customer lookup is a **POST returning customers modified in the last 24
hours**. Aurel Mrruku raised that the response carries so many unneeded fields
that the **JSON risks exceeding size limits**. Agreed: **apply a field filter on
retrieval**, and evaluate **pagination** for large volumes. Andrea Di Cicco
confirmed the filters will be applied.

### Customer update needs PUT, not POST

🔴 **Sending an existing account by POST fails** — Mexal returns a *partita IVA
already exists* error. **PUT or PATCH is required.** Andrea Di Cicco is to study
and implement PUT. New row —
[OI-125](../items/OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md).

Agreed alongside it: **the customer is sent to Mexal on every order creation**,
as an **empty update** when nothing has changed commercially. That is a concrete
refinement of the ownership model settled in Parte 1
([OI-116](../items/OI-116%20Nightly%20Mexal%20to%20Salesforce%20anagrafica%20sync.md),
[OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)) —
the push is unconditional, not change-triggered.

### Invoices are generated manually

**Invoice generation and line fulfilment on Mexal are done by hand by Fabrizio
Paganelli, not automated.** Salesforce retrieves the progress of non-final
invoices by a **GET over documents modified in the last 24 hours**.

### Agent lookup is manual

After weighing automation against manual, **manual was chosen** — to avoid
Salesforce user licence and permission problems. ⚠ This is a design consequence of
the permission problem the org checks keep finding, and it bears on
[OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md).

### The shipping address is not read back from Mexal

**Salesforce sends the shipping address to Mexal** at account or order creation
and **owns changes to it**; it is never retrieved from Mexal. Aurel Mrruku agreed.

That is the missing half of the Parte 2 *hidden shipping mirror*
([OI-113](../items/OI-113%20Whether%20Mexal%20requires%20both%20addresses%20to%20create%20an%20account.md)):
the mirror is one-directional by decision, so a mirrored address that is wrong is
wrong on **both** systems and no return path corrects it.

## 🔴 Deferred to Fase 2 — the scadenzario correction path

Fabrizio Paganelli asked for asset status to follow **unpaid invoices**, and for
**incassi and tranche errors to be correctable** through the Mexal scadenzario API
calls. Andrea Di Cicco assessed it as complex: it needs a **sequence of calls
deleting and recreating orders and invoices**. **Agreed to defer to a second
phase.**

⚠ **Fase 2 is parked pending payment, so this is deferred into something that has
no date and no quote.** The two decisions were taken in the same session and the
notes do not connect them. It touches
[OI-50](../items/OI-50%20Tranche%20object.md).

## Products, mapping and migration

- **Initial product load by Excel file**, then **manual product-to-campaign
  mapping with start and end dates, planned for the days immediately before
  go-live.** 🟢 That is the first statement in the record of **when**
  `Mappatura_Edizione__c` gets populated
  ([OI-121](../items/OI-121%20The%20edition%20mapping%20table%20has%20no%20rows%20and%20no%20owner.md)) —
  though still **not by whom**, and go-live has just moved two weeks earlier.
- **Migration of historical customers, accounts and in-flight orders raised
  concerns and no plan.** Agreed only that **in-flight orders must be closed
  directly from Salesforce**.
- Andrea Di Cicco asked whether migration should precede user acceptance testing
  so the tests run on realistic data. Aurel Mrruku and Elena Spini answered that
  migration is planned against the data provided, to suit development needs — the
  question was not settled.

## Passaggi successivi

| Owner            | Action                                                                |
| ---------------- | --------------------------------------------------------------------- |
| Andrea Di Cicco  | Study and configure the PUT method for customer modification           |
| Andrea Di Cicco  | Send the authentication documentation fragment                         |
| Andrea Di Cicco  | Update the order fields and share the revised file                     |
| Andrea Di Cicco  | Verify the technical changes made in the production environment        |
| Aurel Mrruku     | Publish the documentation links on Slack                               |
| Aurel Mrruku     | Send the WooCommerce integration mail                                  |
| Aurel Mrruku     | Prepare the end-to-end tests                                           |
| Elena Spini      | Ask Sabatino Rinaldi what the product ID field is to contain           |
| Elena Spini      | Organise the sales training meetings set for **24 September**          |
| Elena Spini      | Mail the client for information on the event and data availability     |
| The group        | Configure users and access permissions for the bundles                 |
| The group        | Define the agenda for the first sales meeting                          |

🟢 **The WooCommerce integration mail is finally an assigned action with an
owner** — [OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)
has recorded since 4 September that the endpoint and its authentication exist and
Sabatino Rinaldi has never been sent them. It was still unsent at the end of this
run.

## Also recorded

⚠ **Aurel Mrruku reported uploading component changes and asked Andrea Di Cicco to
verify them directly in production.** The component name is transcribed as
_"alz"_, which matches nothing in the repository, and **production** is where the
verification was asked for — the My Domain was provisioned on 3 September and the
record has had no deployment to it. **Not identified; ask before assuming.**

**Romi Week** — the offsite. Four days, **Wednesday to Saturday morning**, in a
villa near Assisi holding fifty people; activities open Wednesday 16:00 with
pipeline and budget, TED talks Thursday morning. ⚠ The record has carried the
offsite as **9–11 September**
([the compressed calendar](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md));
Wednesday to Saturday morning is **9–12 September**. Andrea Di Cicco expects to
need a laptop there. **The Fase 1 development deadline of 10 September still falls
inside it**, and now so does one more day.
