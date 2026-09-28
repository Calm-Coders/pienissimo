---
id: meet-2026-09-16-data-model-parte-5
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-16
updated: 2026-09-16
depends_on: [OI-24]
blocks: [OI-50, OI-59, OI-110, OI-115, OI-121, OI-138]
source: Drive - "[ROMI-PIENISSIMO] - Data Model: Parte 5 - 2026/09/16 11:00 CEST - Appunti di Gemini" (19DNxe_bQKgiZI7u7y__jaiG4X-n8N0FcsTmTbz1ris0)
---

# 2026-09-16 Data Model Parte 5

**Client-facing, 16 September 2026, 11:00 CEST, 2h21m30s against a two-hour
booking.** The fifth data-model session, and the first to open the **product
registry, the quote and the order header**.

## Who was there

| Person               | Role in the session                                               |
| -------------------- | ----------------------------------------------------------------- |
| **Elena Spini**      | ROMI, ran the session field by field (573 turns)                  |
| **Elisa Migliano**   | Pienissimo amministrazione, the domain authority (557 turns)      |
| **Aurel Mrruku**     | ROMI, decided the Salesforce shape (542 turns)                    |
| **Fabrizio Paganelli** | joined, greeted, announced Elisa was arriving, **dropped off at ~00:06** (_"mi distac[co]"_, 4 turns) |

**Sabatino Rinaldi did not attend** — he was invited and is on the client's tour
with the direction (below). No other Pienissimo attendee appears in the
transcript.

⚠ A **Salesforce platform incident** ran through the morning. Aurel Mrruku
opened the call with _"Oggi proprio disastro. Mai visto una cosa del genere su
Sales Force... giù tutto il mondo"_, describing UI failures from ~09:00 CEST.
It is corroborated in `#team-romi-tech` the same afternoon. It did not change
any decision here; it is recorded because it cost the team a working morning
seven days before UAT opens.

## What was agreed

Ten rulings, from the notes' own `Concordato` block, each traceable to a
timestamped passage in the transcript.

### Product registry

1. **Superfluous product fields are deleted** — `tassabile`, `costo
   commissione`, the quantity fields, and the sales start/end dates. Elisa
   Migliano's reason for `tassabile`: under **San Marino** rules VAT does not
   apply and the Mexal article registry uses fixed exemption codes, so the flag
   carries nothing. Everything from row 7 of the workbook onward goes; `Name`
   (row 2) and `Description` (row 16) stay because Salesforce requires them.
2. **Unit of measure is `NR`, whole numbers only** — seats or tickets on a
   course, never fractional. Aurel Mrruku will nonetheless configure the
   Salesforce field as a standard decimal for headroom.
3. **Product active state is owned by Salesforce, not Mexal.** Mexal remains
   master of the article, but products are **always created active** and any
   later deactivation is done by hand in Salesforce and **never pushed to
   Mexal, nor overwritten by a Mexal update**. A deactivated product disappears
   from new quotes and bundles but **stays visible on historical orders**.
4. **`natura` from Mexal maps to two Salesforce checkboxes** — `genera
   biglietto` and `is bundle` — through a custom transformation. Elisa Migliano
   has already identified the source codes and will send them with descriptions.
5. **`tipo biglietto` takes `Executive`, `Gold`, `Diamond`.** `Academy` is not a
   ticket type; it belongs to `categoria statistica`. The field is **not
   mandatory and may stay empty**.
6. **`gruppo merceologico` survives as an empty picklist** — it comes from Mexal,
   nobody uses it today, and it is kept with a null default for future use.
7. **Reclassification `livelli 0–6` become picklists.** Elisa Migliano created
   them for sales analysis because reclassification is requested often. Level
   zero gets provisional values from her; the rest are owed.
   ⚠ The notes say _"quattro valori"_ and then list **eventi, consulenze,
   prodotti, software e addebiti** — four or five depending on whether
   _"software e addebiti"_ is one value or two. **Not resolved here; do not
   guess when building the picklist.**

### Quote and order

8. 🔑 **A won quote and its order are frozen.** Elisa Migliano asked whether a
   tutor can change an article code inside an order once the quote has become
   one. Aurel Mrruku:

   > _"Se l'offerta è stata vinta viene creato l'ordine e poi viene sigillato
   > sia l'offerta che l'ordine. […] Quando dico sigillato l'offerta vuol dire
   > che l'offerta proprio non la puoi toccare, non puoi fare nessuna modifica."_

   No line may be added or removed, no price and no article code changed.
   Editing happens **only at opportunity and quote stage**. This is a new rule
   and it is unbuilt — [OI-138](../items/OI-138%20Quotes%20and%20orders%20freeze%20once%20the%20order%20is%20accepted.md).
9. **`Tipologia attività` is pre-filled on the quote from the _locale_.** It
   becomes a **global, non-restrictive picklist on the Locale-record-type
   Account**, is copied onto the quote, and stays manually editable — which
   makes selecting a locale **mandatory on the quote**. Values owed by Elisa
   Migliano. This moves [OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md).
10. **Quote name = quote number + the company's partita IVA**, dropping the word
    _ordine_, to stay inside Salesforce's character limit. The quote number is a
    system-generated progressive and **is the same code Mexal invoices and
    searches against**.
11. **Quote expiry is fixed at five days** from the moment the offer enters
    _trattativa_ (i.e. is emailed), tutor-editable.
12. **A lost primary quote closes its opportunity as lost**, inheriting the same
    loss reason, by trigger.
13. 🔑 **`Codice agente`, `classificatore rete` and `codice zona` are
    historicised on the quote and on the order.** Elisa Migliano:

    > _"ogni ordine deve avere il codice agente, il codice classificatore rete e
    > il codice di zona dell'azienda associata nel momento in cui viene immesso
    > l'ordine"_

    Aurel Mrruku's restatement, confirmed: a later change on the Account is
    **not** carried onto existing orders. The company registry always holds the
    current agent; quotes and orders keep the one they were created with,
    forever. See [OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md) —
    this is the third independent statement of the freeze rule and the Mexal
    order call still has nowhere to put it.
14. **The order header takes the quote's field structure**, plus some extra
    states for line and payment updates. Only the **header** was covered; order
    **lines** were deferred.

### Layout pruning

Commission percentages, VAT-derived fields, the bundle auto-invoicing flag, the
VAT check, the total-in-words, the 40% deposit percentage, the quote's product
list and the legal-representative request fields are all removed. Kept: subtotal,
total and an `IVA` field defaulted to zero (San Marino has no VAT, so subtotal
and total coincide — the field is kept for a possible future need); the
quote-won date for statistics; billing fields pre-filled from the company and
still editable; notes renamed **note per il cliente**; fixed contractual terms
and conditions; the platform activation date; and the `condizioni` field
(`nuova vendita`, `stagionale`, `cambio ragione sociale`), whose exact values
Elisa Migliano will confirm with the software house.

## What was left open

- 🔴 **Post-event tutor sales may be bundles only** — the session's one explicit
  `Da approfondire`, pending **Sabatino Rinaldi's** confirmation.
- 🔴 **Complex tutor quotes have no tranche mechanism.** Elisa Migliano asked for
  a summary table of due dates and amounts on the quote screen, because tutors
  build multi-line quotes whose per-line due dates do not line up with the
  monthly Mexal invoices, and today they explain the instalments by hand in the
  notes field of the PDF. Aurel Mrruku named the structural limit — the date
  hangs off the individual product line — and Elena Spini raised the concrete
  case of a ~€20,000 contract split into tranches. Elisa Migliano proposed
  pre-configured standard bundles valid year-round for generic tutor sales.
  **Deferred to Friday.** See [OI-50](../items/OI-50%20Tranche%20object.md).
- 🔴 **WooCommerce checkout links for multi-product, non-bundle offers.** Aurel
  Mrruku doubts the link mechanism holds when an offer carries several products
  not wrapped in one bundle. Links sent to event attendees reference
  **predefined bundle ids** (_bundle 1_, _bundle 2_). Needs Sabatino Rinaldi —
  see [OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md).
- 🔴 **Sabatino Rinaldi is unreachable.** He is on tour with the client's
  direction; Elena Spini and Aurel Mrruku confirmed they got **no WhatsApp reply
  the previous week either**. Elisa Migliano suggested chasing him on WhatsApp or
  waiting for Monday.

## Who owes what

| Owner                      | Owed                                                                        | When            |
| -------------------------- | --------------------------------------------------------------------------- | --------------- |
| **Elisa Migliano**         | `categoria statistica` and `gruppo merceologico` values, by email           | —               |
| **Elisa Migliano**         | `natura` transformation codes with descriptions                             | —               |
| **Elisa Migliano**         | `livelli 0–6` values                                                        | —               |
| **Elisa Migliano**         | `tipologia attività` picklist values, by email                              | —               |
| **Elisa Migliano**         | complete `categoria` / `sottocategoria` information                         | **Monday 21/09** |
| **Elisa Migliano**         | `condizioni` values, confirmed with the software house                      | —               |
| **Aurel Mrruku**           | the `natura` → two-checkbox transformation                                  | —               |
| **Aurel Mrruku**           | products always created active, never overwritten by Mexal                  | —               |
| **Aurel Mrruku, Elena Spini** | review bundles and complex tutor payments                                | **Friday 18/09** |
| **Aurel Mrruku**           | contact Sabatino Rinaldi on WhatsApp about the opportunity↔order link       | —               |
| **Elena Spini**            | chase the e-commerce question on WhatsApp                                   | —               |
| **Elena Spini, Elisa Migliano** | ask Sabatino Rinaldi whether the product id in the Salesforce link is always the bundle id | — |
| **The group**              | **a further session on Friday** for order lines and the remaining points    | **18/09**       |

⚠ **Only one of these carries a date the owner stated themselves** (Elisa
Migliano's Monday). The rest are undated, and five of the six Elisa Migliano
items are picklist values that block field creation.

## What this session did not touch

**Utenti, Profili, the initial-load plan and the Lead table** were not opened —
a **sixth** consecutive data-model session without them
([OI-24](../items/OI-24%20Data%20model%20workbook.md)). Order **lines** were
deferred to Friday, so the order object is half specified.

⚠ The client's workbook
(`Campi Oggetti, Flussi e Utenti Salesforce - Pienissimo.xlsx`) was **saved at
11:20:06Z**, during the session, as it was during Parte 2. **The file was not
opened by this sweep**, so what changed in it is recorded as unread, not as
nothing.

## Calendar conflict worth resolving

[Data Model Parte 4](2026-09-08%20Data%20Model%20Parte%204.md) recorded **Parte 6
booked for 18/09 on Campagne/Lead with Rebecca Marmo**. This session booked
**Friday 18/09 for order lines**. No source says which one Friday holds, or
whether both do. **Ask Elena Spini** — the Lead table would be deferred a
**sixth** time if order lines take the slot.
