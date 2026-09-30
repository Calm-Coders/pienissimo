---
id: OI-188
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: Pienissimo
raised: 2026-09-28
updated: 2026-09-30
depends_on: [OI-98]
blocks: [OI-141, OI-168]
severity: gating
source: notes/meetings/2026-09-28 Tema Contratti e Open Point.md
---

# OI-188 - Performance Plus products are identified by the Mexal article category

**Settled at [the 28/09 client session](../meetings/2026-09-28%20Tema%20Contratti%20e%20Open%20Point.md)
(`00:45:00`-`00:52:00`), and it closes an open point that had been open since
17/09.** [OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)
recorded that _"a specific product code on the offer determines whether a contract
is generated automatically"_ and that **the code did not exist**. It did exist —
it is the Mexal `categoria articolo` field, already on the article registry.

## The mapping, confirmed on screen by the client

Read live out of `Articoli Salesforce.xlsx` with Fabrizio Paganelli narrating:

| Category | Meaning                                  | Generates an order + Contract |
| -------- | ---------------------------------------- | ----------------------------- |
| `C10`    | Performance Plus — **attivazione**       | yes                           |
| `C11`    | Performance Plus — **rinnovo**           | yes                           |
| `C20`    | additional / spot services, incl. Google | 🔴 **no** — an ordinary sale  |

> _"il C10 sono tutti codice articolo plus il C11 sono tutti codici articolo plus
> rinnovo."_ — Fabrizio Paganelli

On `C20`: _"servizi spot che vengono venduti, ma … su questi non è che deve essere
generato un ordine, un contratto, eccetera … è una vendita normale."_

🟢 **No new field and no mapping table are needed.** Aurel Mrruku had proposed a
Salesforce table Fabrizio Paganelli would maintain by hand, and **withdrew it**
once the category proved sufficient — _"Quindi non devi fare nessun altro
campo."_ He asked Elena Spini to state in the delivered documentation that every
product arriving with `C10` or `C11` is categorised as a Performance product.

## What the categorisation is for

Filtering the product picker when a tutor builds a Plus offer, so a non-Plus
product cannot be selected. Fabrizio Paganelli checked the purpose explicitly —
_"l'obiettivo è quello di aiutare il tutor nel momento di inserimento
dell'offerta"_ — and Aurel Mrruku confirmed that is all it is. It is also what
lets the order carry the `Plus` opportunity record type, which
[OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md) now
reads `stato` from.

## 🔴 What is still owed, and it has no date

Fabrizio Paganelli intends to **replace the current Plus article codes, not
annotate them**:

- The article will carry a **tranche count**. Using that article on an offer
  auto-creates that many equal instalments, editable afterwards.
- He will create **one article code per tranche count** — his examples were a
  four-tranche and a twelve-tranche variant.
- The roughly **twenty existing `C10` codes go to `annullato`**: _"questi tutti
  questi qua li potrò mettere in stato di annullato … Ti potrò creare un nuovo
  codice articolo … con tranche."_

🔴 **He could not produce them on 28/09** — _"non penso di farcela oggi"_ — because
the codes must be created in Mexal first, and **no date was given**. The
Performance Plus UAT is **Monday 5 October**.

🟢 **An agreed workaround exists for testing**, and it is the client's own
suggestion: Aurel Mrruku edits the existing UAT products instead, one with four
tranches and one with twelve, which Fabrizio Paganelli says covers _"il 95% delle
casistiche."_ ⚠ **That tests the mechanism, not the client's real article data.**

## ⚠ Google services were classified both ways in the same session

At `00:45:00` Fabrizio Paganelli said the Google services follow the same logic as
Performance Plus — _"anche qui c'è un contratto, c'è una data d'inizio, una data a
fine"_, smaller amounts, shorter term. Minutes later he placed them under `C20`
as ordinary sales with no order and no contract.

His own reconciliation: **if a signature flow is wanted for Google, he recodes
those article codes as `C10`/`C11`** and they behave as Plus, Contract included.
Elena Spini checked this back; Aurel Mrruku confirmed.

🔴 **Undecided.** Fabrizio Paganelli: _"Adesso non so … lo segno."_ Until he
exercises it, **the Contract stays Performance Plus only**, as
[OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)
records from 25/09. Nothing needs building for Google today; what is needed is an
answer.

## Open

- 🔴 **Fabrizio Paganelli owes the new Plus article codes with their tranche
  counts.** No date, Mexal work first, UAT on 05/10.
- 🔴 **Nothing in `force-app` reads `categoria articolo` to set a Plus flag yet.**
  Verified against `DevMain` at `55101d2`; this is a decision, not a build.
- 🔴 **Whether Google services join the Plus flow is unanswered**, and the answer
  changes whether four more article codes generate Contracts.
- ⚠ **The retirement of the twenty current `C10` codes is a migration event
  nobody has planned.** Historic orders reference those codes, and
  [OI-172](OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md)
  migrates historic orders.
- ⚠ **No register row covers the categorisation.** It is a mechanism the client
  confirmed, not a requirement anyone has written; allocating a requirement id is
  not a sweep's call.

## ⚠ 2026-09-30 - `Articoli Salesforce.xlsx` moved 75 minutes before the ticket UAT

Fabrizio Paganelli's article workbook (Drive `17pyx0xRtRY7vWXjN5oddAs52XWvkbM7p`,
owner `fabrizio.pienissimo@gmail.com`) was **modified at 12:45:55Z on 30/09**, having
been unchanged since 28/09 08:51Z. **Not opened** — it carries article-code values and
probably catalogue prices, so per `docs/publishing.md` its movement is recorded and
nothing from it is copied.

⚠ **Whether this is the new Plus codes carrying a tranche count is unknown.** That is
what this row is waiting for, it is what Fabrizio Paganelli could not produce on 28/09
_"non penso di farcela oggi"_, and **he gave no date**. The workbook moved on the day
of the ticket UAT, not the Performance Plus UAT, and **the article codes were not
discussed at either 30/09 session** — the UAT read this same workbook live on 28/09,
but on 30/09 the product conversation was about mapping products to editions, not
about creating codes.

🔴 **Performance Plus UAT is 05/10.** A human opening this file would settle in one
minute whether the codes now exist. ⚠ Separately, **Elena Spini owes Aurel Mrruku
the updated product list** for database cleanup, taken as an action item at the 30/09
UAT with no date — a second, overlapping route to the same information.
