---
id: OI-50
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-09-25
blocks: [OI-75, go-live]
severity: gating
requirement: [ORD-02, ORD-03]
source: Aurel Mrruku direct decision, 2026-08-24; meetings/open-items.md row 50
---

# OI-50 - Tranche object

On 2026-08-24 **Aurel Mrruku decided the creation point and mechanics**. "Rate"
is renamed **tranche** and becomes a custom object defined **inside the Quote,
after its products have been selected**.

Creation is guided rather than inferred after the sale. For each tranche the
user selects the Quote Line Items to include and supplies the planned payment
due date. Every selected Quote Line Item stores both the tranche reference and
that date. One line belongs to one tranche; one tranche contains one or more
lines.

When an accepted quote generates the Order, the tranche reference and payment
date propagate to the corresponding Order Items. Those copied values are the
operational keys used to group what was sold and reconcile the lines with
Mexal. **The Order does not create the tranche:** it inherits the commercial
plan already defined on the Quote.

The whole order — all lines — goes Salesforce → Mexal with the **tranche
reference and payment date travelling at line level, not as an object**. Mexal
updates payment status per line; Salesforce aggregates upward to the tranche. **Mexal never
writes the tranche.** At invoicing, n Mexal invoices become n Salesforce
invoices.

**The tranche payment state is derived, never written by Mexal.** Mexal updates
payment status at Order Item / invoice-line level and Salesforce recalculates
the parent tranche. A partial payment closes nothing: only when **every line in
the tranche is fully paid** does the tranche move to its final paid state.

The API name of that final state is still open. Conceptually it is
`Pagata`/`Incassata`; do not implement `CHIUSO/ACQUISITO` merely because the old
diagram uses it. The unresolved label remains tracked in
[OI-69](OI-69%20Order%20state%20model.md).

⚠ **Superseded on 2026-08-25 — `Tranche__c` now exists in both the org and the
repository.** The paragraph that stood here said it existed in neither. See the
org check at the foot of this note. The line-level due date
`OrderItem.Data_Scadenza__c`, committed 4 August and mentioned in no tracker,
remains as described.

This is the most consequential unbuilt object in the project.
[Ticket availability](OI-75%20Ticket%20availability%20rule.md) depends on
tranche-level invoicing, which means the whole
[ticket lifecycle](../flows/The%20ticket%20lifecycle.md) is downstream of an
object nobody has started — and the build restarts
[in the last week of August](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).

## 2026-08-24 - the catalogue blocco is not this tranche

[`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md), read
on 2026-08-24, shows a bundle composed of five `BLO-` **blocchi**, and its own
headings call their contents _"i componenti **delle tranche**"_. So `BLOCCO` is
the client's word for tranche, and it exists **in the catalogue, before any
order** — with its own article code.

Aurel's decision separates the two meanings. A `BLO-` record is a
**catalogue-side bundle block**; it does not create `Tranche__c` during product
import. The operational payment tranche is created later, on the Quote, from an
explicit selection of Quote Line Items and a payment due date. Detail:
[a bundle is two levels deep](../objects/A%20bundle%20is%20two%20levels%20deep.md).

## 2026-08-24 - decided: the tranche is created on the Quote, by hand

The [24 August Lead/Opty session](../meetings/2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md) ruled on where `Tranche__c` comes from,
which is the question this item has carried since it was raised.

**Tranches are created and managed manually by the user at Quote (offerta) level,
before the order is generated.** Not derived from order-line due dates after the
sale, and not created at import.

With it, a constraint that decides the UI:

- **Products and tranches may only be edited while the quote is in `Bozza`.**
  Once the quote is "in attesa di accettazione", neither can change.

Aurel Mrruku holds two open actions from the same session — **define the initial
state and the due dates for tranches**, and implement the creation/update logic
on the quote draft. Both were largely executed between 24 and 25 August; what
remains is recorded below.

This settles the _sales-side_ tranche. It does **not** settle the collision
recorded above with the client's **product-side** `BLO-` blocco tranche from
`Prodotti e Bundle.xlsx`, which sits in the catalogue before any order exists.
Two different things still share the name, and only one of them now has a
creation rule.

The chronological payment rule that consumes tranches is confirmed at
[OI-75](OI-75%20Ticket%20availability%20rule.md).

## 2026-08-25 - org check: the tranche is substantially built

Verified read-only against **Pienissimo UAT** (`a.mrruku@pienissimo.uat`,
`00DMA000004nMMr2AM`). This item's central claim — that the object exists
nowhere — was **wrong at the time of reading**, and the build landed between the
24 August decision and this check.

**In the org and in `force-app/`:** `Tranche__c` with `Stato__c`
(`Aperta · Parzialmente Pagata · Pagata`), `Data_Scadenza__c`,
`Completamente_Pagata__c` and the `Quote__c` lookup; `QuoteLineItem.Tranche__c`,
the Quote-side reference the design rests on, and `QuoteLineItem.Data_Scadenza__c`.

**In the org only** — modified **2026-08-25**, hours before this check, by
Aurel Mrruku:

| Component                            | Note                                                                   |
| ------------------------------------ | ---------------------------------------------------------------------- |
| `QuoteTrancheController` (144 lines) | the creation/update logic, **zero coverage**                           |
| `quoteCreateTranche` LWC             | the guided selection UI                                                |
| `Quote.Crea_Tranche` quick action    | how the user reaches it                                                |
| `Tranche__c.Importo_Previsto__c`     | planned amount                                                         |
| `Tranche__c.Sequenza__c`             | ordering, which [OI-75](OI-75%20Ticket%20availability%20rule.md) needs |
| `Tranche_Management` permission set  | —                                                                      |
| `Tranche__c-Tranche Layout`          | —                                                                      |

Six `Tranche__c` records exist, all in `Aperta`, across two quotes — so the
creation path has been exercised by hand. `Sequenza__c` and `Importo_Previsto__c`
are null on the three oldest, populated on the three newest.

**Three gaps keep this item open and gating:**

1. 🔴 **`OrderItem.Tranche__c` is in `force-app/` but not in the org.** The
   propagation step — tranche reference travelling from the accepted Quote to
   the Order Item — is the operational key for Mexal reconciliation
   ([DM-17](../../requirements/pienissimo-requirements.yaml), ORD-01), and it
   **cannot run in UAT today**. This is the one place the repository is ahead of
   the org rather than behind it.
2. 🔴 **The aggregation mechanism is unverified.** `Completamente_Pagata__c`
   exists as a checkbox; nothing observed proves Salesforce recalculates the
   parent tranche when every line is paid.
3. **`QuoteTrancheController` has no test class and no coverage** — it is now
   the largest uncovered class in the org. Feeds
   [OI-66](OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md) and
   [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

The final state label is **unaffected** — `Stato__c` uses `Pagata`, not
`CHIUSO/ACQUISITO`, which is what [OI-69](OI-69%20Order%20state%20model.md)
asked for. That question is now only about the _Order_, not the tranche.

## 2026-08-25 - how Mexal tells us a tranche is paid

Gap 2 above — _"the aggregation mechanism is unverified"_ — now has its **input**
identified, though still no implementation.

Working through the Mexal data on Slack at 17:56 CEST, Andrea Di Cicco found that
**a single invoice carries the list of its items**, and concluded: _"quindi per
le trance sappiamo come capire quando sono state pagate"_. So the per-line
payment status this note depends on is reachable from the invoice, which is what
[OI-58](OI-58%20Mexal%20integration%20mechanics.md) had open as the hard part.

Two things this does **not** do:

- It does not build the aggregation. `Completamente_Pagata__c` still exists as a
  checkbox with nothing proving Salesforce recalculates the parent when every
  line is paid. Aurel Mrruku's reply was _"poi capiamo come strutturare le
  chiamate"_ — the call structure is still to be designed.
- It does not settle **how tranches are created on the Mexal side**. That is
  Andrea Di Cicco's own stated next unknown — _"ora devo capire come si creano le
  trance"_. The Salesforce-side creation rule is decided (by hand on the Quote);
  what the Mexal counterpart looks like is not.

Gap 1 — `OrderItem.Tranche__c` committed but not deployed — and gap 3, the
missing coverage, are **unchanged**.

## 2026-08-26 - org check: two of the three gaps changed shape

Verified read-only against **Pienissimo UAT**. The three gaps recorded above
were re-checked one by one. Gap 1 was **misdiagnosed** and gap 3 has a new
number; the source-control problem is largely fixed.

### 🟢 The creation stack is in source control now

`QuoteTrancheController`, the `quoteCreateTranche` LWC, `Quote.Crea_Tranche`,
`Tranche__c.Importo_Previsto__c`, `Tranche__c.Sequenza__c` and the
`Tranche_Management` permission set were merged to `DevMain` on **2026-08-26**
in PR #12 (`dc513c6`, from `DevAnitaSeptember`; the work is Anita Aga's commit
`38dc7b6`). The committed `QuoteTrancheController` is **byte-identical to the
org copy** apart from a leading byte-order mark, so the retrieve was faithful.

Six of the seven components listed as org-only on 25 August are now tracked.
**One is still org-only: the `Tranche__c-Tranche Layout`.**

### 🔴 Gap 1 was wrong — the field is deployed, and nobody can see it

The 25 August reading that `OrderItem.Tranche__c` is _"in `force-app/` but not
in the org"_ **does not survive re-checking**. Tooling `FieldDefinition` lists
the field; it was created 2026-08-24T15:18:02Z, one minute after its Quote-side
twin. `sf sobject describe` missed it because **describe is filtered by the
running user's field-level security** and the field is granted to nobody —
its only `FieldPermissions` row is the Salesforce-internal
`sfdc_a360_sfcrm_data_extract`. The `Tranche_Management` permission set grants
the `QuoteLineItem` twin read and edit and **omits the `OrderItem` side
entirely**.

The conclusion is unchanged and the cause is not: propagation cannot run,
because no user can read the field **and** because nothing in `force-app/`
references it — not the classes, not the triggers, not the LWC. Full diagnosis
and the corrected method:
[the risk](../risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md)
and [how to read the org schema](../How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).

### Gap 2 unchanged, and one tranche moved by hand

`Completamente_Pagata__c` is still a checkbox nothing computes. `TR-0009` now
reads `Parzialmente Pagata` where all six were `Aperta` on 25 August — set
manually, since no Flow, trigger or scheduled job touches `Tranche__c` and
`Integration_Log__c` is empty. Do not read it as roll-up working.

New, and it constrains [OI-75](OI-75%20Ticket%20availability%20rule.md):
`Sequenza__c` runs **1, 4, 3** on one quote and is null on the other three
records, with nothing enforcing uniqueness or contiguity —
[the sequence risk](../risks/Risk%20-%20the%20tranche%20sequence%20has%20no%20integrity%20control.md).

### Gap 3 unchanged, and larger

`QuoteTrancheController` still has no test class. It is **185 uncovered lines**,
the largest uncovered class in the org, against 144 recorded on 25 August; the
class body has not changed since 2026-08-25T12:50:07Z, so the figure moved with
the coverage snapshot rather than the code.

## 2026-09-02 — the tranche reaches the Mexal order line

**Every order line pushed to Mexal must carry a `data di scadenza`, and it is the
tranche due date.** Stated at the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md)
by Elisa Migliano while reading the Mexal order screen:

> _"ogni riga ordine dovrà avere la data di scadenza… su Mexal sarebbe la data di
> scadenza della tranche. Oggi noi non la gestiamo, però un domani andrà messa."_

Andrea Di Cicco confirmed the purpose in one word — _"è per le tranche"_ — and
said he already has the field on his side. Elena Spini checked that it was not
something else: _"mi stavo preoccupando che fosse un'altra cosa."_

### Why this matters to the remainder

This note already records that the object and the Quote-side creation are built
and that **propagation to Order Item and payment aggregation are not**. That
remainder now has a **second consumer**: it is not only Salesforce reporting that
needs the tranche on the order line, it is the ERP tracciato. A tranche that
never reaches `OrderItem` cannot reach Mexal either.

⚠ Note also that `OrderItem.Tranche__c` exists and is deployed, and that **no
Apex in `force-app/` writes it**
([the build](../objects/The%20build%20ahead%20of%20the%20record.md)). So the field
the Mexal line date would be derived from is, today, always empty.

⚠ _"Oggi noi non la gestiamo"_ — Pienissimo does not manage line due dates in
Mexal today either. This is new behaviour on **both** sides of the integration,
agreed eight days before the end of Fase 1 development and **unestimated**.

## 2026-09-09 - 🟢 the propagation is built, and the standing gap closes

**`OrderItem.Tranche__c` finally has a writer.** Commit **`a53345a`** (Anita Aga,
PR **#37**, merged 18:41 CEST) adds
`QuoteTriggerHandler.createOrdersForAcceptedQuotes`, which fires on a Quote
transition into `Accettato` and copies every `QuoteLineItem` to an `OrderItem`
carrying **`Tranche__c` and `Data_Scadenza__c`** alongside the price, quantity
and description
([the build](../objects/The%20commercial%20process%20automation.md)).

That is precisely the mechanic this note has described since 24 August —
_"When an accepted quote generates the Order, the tranche reference and payment
date propagate to the corresponding Order Items"_ — and the **first code that
performs it**. It also supplies the `data di scadenza` the 2 September Mexal
tracciato requires on every order line.

**Two of the three 25 August gaps are now closed or superseded:**

- **Gap 1 — propagation cannot run.** ✅ **Closed in the repository.** The field
  was already deployed and its visibility was granted on 2 September
  ([the resolved risk](../risks/Risk%20-%20OrderItem%20Tranche%20is%20invisible%20to%20every%20user.md));
  the missing half was that _"no Apex in `force-app/` writes it"_. It does now.
- **Gap 3 — no coverage.** Unchanged and larger; the same commit adds **+729
  uncovered Apex lines**. Recorded in
  [the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md),
  **not acted on**.

**Gap 2 — the aggregation — is untouched.** `Completamente_Pagata__c` is still a
checkbox nothing computes, and nothing in `a53345a` recalculates a parent tranche
from its lines. **This is now the only gap of the three that is genuinely
unbuilt**, and it is the one Mexal's per-line payment status feeds.

🔴 **Three things this does not do, and they keep the item open:**

1. **Only quote-born orders carry a tranche.** WooCommerce orders and
   hand-created orders get no `Tranche__c` and no `Data_Scadenza__c`. The Mexal
   tracciato requires the date on **every** order line.
2. **Nothing was verified against the org.** This is a repository reading at
   `0fe07f6`. Whether UAT runs the same code was not checked, and the last org
   check (08/09) predates the merge.
3. **`OrderItem.Tranche__c` field-level security was granted; the writer runs in
   `with sharing` Apex** — but no test has exercised the path and **no
   `Tranche__c` record has ever reached an order line** in any observation this
   record holds.

## 🟢🔴 2026-09-10 - the Mexal end of the tranche has a wire shape at last

`Mexal Dev v.2.postman_collection` shows how an instalment is actually settled on
Mexal, and it is not what this row assumed
([the wire facts](../flows/The%20Mexal%20integration.md#2026-09-10---the-wire-facts-arrive-and-the-first-apex-is-written)).

**A tranche is a partial fulfilment of named order rows on a date.** One `OC`
order is created with all its lines; each instalment is then a separate **`FT`**
document posting only that instalment's rows with `tipo_stato_riga: "E"` and ten
back-reference fields to the originating order. The collection's own request
names are explicit: _"Evasione Riga 1 e 2 il 30 Settembre"_, _"Evasione Riga 3 e 4
il 31 Ottobre"_.

🟢 **That is a buildable mechanism**, and it matches the model this row has
carried since 14 July — the tranche is a grouping of order lines, Mexal updates
payment status per line, Salesforce aggregates upward.

🔴 **But the order-creation body carries no per-line `data di scadenza`.** The
2 September tracciato said every order line must carry one, and it is why
`Data_Scadenza__c` was propagated to `OrderItem` by PR #37 on 9 September. In the
collection the due date is not a field on the order at all — it is the
`data_documento` of the fulfilment call, sent later.

**Unreconciled, and it matters to what was just built.** Either the collection is
an incomplete export, or the tracciato described the _fulfilment_ date rather than
an order-line field, in which case `Data_Scadenza__c` is populated for a wire
field that does not exist. **Ask before building the outbound leg.**

⚠ **`serie: 10` throughout the collection** — the test series. Production is
`serie 1`.

**Gap 2, the aggregation, is still the one genuinely unbuilt gap.**
`Completamente_Pagata__c` remains a checkbox nothing computes, and nothing in
`bc2ed5d` touches it — that commit is inbound-read only. What it _does_ add is
the first evidence of how the per-line payment status will arrive:
`POST /risorse/scadenzario/ricerca`, filterable **by customer code**, exists and
is reachable.

## 2026-09-15 - gap 2 is built, on an open PR

`400c195` (Anita Aga, PR #45, **open**) adds `OrderItemTriggerHandler` and
`OrderItem.Mexal_Payment_Status__c`, and the aggregation this note has called the
one genuinely unbuilt gap now exists
([the build](../objects/The%20Mexal%20payment%20return%20and%20tranche%20roll-up.md)).

A tranche recalculates whenever a line's `Tranche__c` or
`Mexal_Payment_Status__c` changes — on the old tranche and the new one, so a line
moved between tranches fixes both — and it reaches `Pagata` **only when every
line on it is `Paid`**. That is `ORD-03` and `AC-06` as written. The per-line
status arrives from Mexal through `MexalScadenzarioSearchService` and
`MexalInvoiceOrderLineMappingService`, which is the mechanism `bc2ed5d` had only
shown to be reachable.

🔴 **Not merged**, so `DevMain` at `f51365b` still has nothing that computes it.
🔴 **Nothing schedules the invoice/payment pass.** The nightly scheduler runs the
customer, article and warehouse batches; how the scadenzario read is triggered is
not visible in the commit.
⚠ The 2026-09-15 `org-status-check` still reads the org as it was this morning:
**29 tranches, 5 of 38 Order Items carrying tranche and due date, 0 fully paid.**

## 🔴 2026-09-16 - the roll-up merged, and the client named a gap it does not cover

**PR #45 merged at 08:21:19Z (`0d2b779`).** The `OrderItemTriggerHandler`
roll-up — `Tranche__c.Pagata__c` true only when every line is `Paid`, fed by the
Mexal scadenzario — is on `DevMain`
([the build](../objects/The%20Mexal%20payment%20return%20and%20tranche%20roll-up.md)).
**Gap 2, the aggregation, is closed in source.** It has never run.

🔴 **[Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md)
then opened a gap the tranche object does not address: quotes that are not
bundles.**

Elisa Migliano's case is the ordinary one, not an edge:

- Tutors build **standard multi-line quotes** whose per-line due dates **do not
  line up with the monthly invoices Mexal issues**.
- Today they explain the instalments to the customer **in the notes field of the
  quote PDF**, by hand, because the payment terms are not otherwise legible.
- She asked for a **summary table on the quote screen** — due dates against
  amounts — so the tutor stops recalculating by hand.

Aurel Mrruku named the structural reason it is hard: **the due date hangs off
the individual product line**, which is exactly what PR #37 built on 09/09 and
what the Mexal tracciato requires. Elena Spini put the concrete case: a **~€20,000
contract** (_Performance Plus_ / _anno con Pienissimo_) that tutors routinely
split into tranches.

Elisa Migliano's proposal was to **pre-configure standard bundles** for generic
tutor sales, valid year-round — i.e. to force the non-bundle case back into the
bundle machinery rather than build a second mechanism.

**Deferred to Friday 18/09** for Aurel Mrruku and Elena Spini to review bundles
and complex tutor payments.

### What this row should hold on to

⚠ **The record has assumed tranches are a bundle property.** Both ROMI voices
said so in the room — _"le tranche sono presenti nei bundle"_ — and Elisa
Migliano corrected it: tutors produce complex instalment plans **outside**
bundles, routinely, and have been doing it in free text. That is a requirement
this project has been carrying in a notes field.

⚠ A **payment-instructions field for the quote PDF**
(`Quote.Modalita_Pagamento_PDF__c`) was built on a branch the same day —
`DEV_ComponentBundle`, unmerged, see
[the quote PDF note on that branch](../traces/Source%20trace%202026-09-16.md).
It automates the free-text workaround; it does not give the tranches structure.
The two efforts have not met.

## 🔑 2026-09-17 - ROMI settled a line-level shape internally, and proposed a second, different mechanism

At [the 17/09 internal follow-up](../meetings/2026-09-17%20Follow-up%20Interno.md)
— **ROMI only, no Pienissimo attendee** — two answers were given to the gap
Elisa Migliano opened the day before, and they are not the same answer.

### The line-level shape (`01:15:36`)

Tranches are represented as **separate order lines carrying the same product
code with the price divided**, with **start and end dates entered by hand for
each tranche**, for the calculation and for the send to Mexal. That is the first
time the record holds a concrete shape for the multi-line tutor quote.

### The product-registry shape (`00:34:58`, approved `00:38:21`)

Separately, **fractional product records** in the anagrafica — halves, thirds,
quarters of the parent course — each tied to its own Mexal invoice.
→ [OI-142](OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md)

⚠ **The session carries both and reconciles neither.** One splits the product
registry; the other splits order lines under a single product code. The notes'
own `Da approfondire` block records that instalments-as-order-lines and their
transmission to Mexal still need _"una verifica congiunta con i referenti"_ —
so ROMI does not treat the line shape as settled either.

🔴 **Aurel Mrruku owns building it**: the minuted action is to create the Plus
order template and _"integrare la logica per la suddivisione delle tranche nel
sistema di gestione preventivi"_, and he flagged the complexity himself
(`01:21:47`).

⚠ **Friday 18/09 was where 16/09 deferred this.** That slot now holds
`[PIENISSIMO] - Temi Mexal` at 10:00 and Data Model Parte 6 at 11:00, and
**neither is booked for tranches or order lines** — see
[OI-24](OI-24%20Data%20model%20workbook.md).

## 🔴 2026-09-21 - the Mexal side cannot receive the tranche date

**The mechanism this row describes works on the Salesforce side and has no
counterpart on the Mexal side.** Established at
[the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md).

Mexal exposes **no field through which Salesforce can set an invoice due date**.
`data scadenza riga` (order line, sent by Salesforce) and `Data scadenza PG`
(scadenziario / invoice, computed by Mexal from the payment method) are **not
related one-to-one**. Because Fabrizio Paganelli ruled that invoices are created
by hand, **the invoice due date does not exist until a person types it** — and the
tranche date is the only key that joins an invoice back to a tranche.

So the design stands, and the **reconciliation it exists to enable now depends on
manual re-keying**:
→ [OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)

🔴 **And a bundle cannot carry its tranches at all as one line**, so bundles must
be split into n order lines, changing how the bundle total is computed:
→ [OI-144](OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)

### 2026-09-18 - Elisa Migliano proposed exactly this, and it is defeated

At [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`02:21:11`) Elisa Migliano proposed **dedicated Salesforce fields for the
instalments and their invoice dates**, mirroring what tutors type by hand today, so
that Mexal could receive the payment plan. Aurel Mrruku confirmed it was feasible
on the Salesforce side and left the Mexal-side verification open. **That
verification came back negative three days later, and she has not been told.**

The same session also recorded her objection to child products for high-value
instalment courses — they would alter the structure of the accounting movements
(`02:12:47`) — which cuts against
[OI-142](OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md).
**Later evidence, and a client objection to a ROMI position.**

⚠ **The definitive tranche agreement was deferred to a dedicated session**, which
became `Logiche Spacchettamento Righe`, **22/09 11:00–12:00**, with Elisa Migliano
and Fabrizio Paganelli invited. It is followed at 15:00 by `Test Mexal` with Mirko
Merendi. **Those two hours are where this row is decided.**

## 🟢 2026-09-22 — the roll-up's input is defined, and it is not the date

Two client sessions on 22/09 settled how a payment is matched back to a tranche, and it
is **not** by comparing due dates:

**scadenziario** (codice cliente, serie documento, numero documento, data documento) →
**invoice** → **order** (Mexal's own sigla + progressive number, returned on save) →
**order line**.

Mirko Merendi named those fields at
[Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md). Aurel Mrruku will extract the
scadenziario **in bulk every evening** to refresh Salesforce, with **two calls across a
year boundary** because orders and warehouse movements filter by header year while the
scadenziario is ultra-annual.

🔴 **Matching on the due date is now explicitly forbidden**, not merely unnecessary:
scadenziario dates move when a Ri.Ba. comes back unpaid or a recovery plan is agreed.
Fabrizio Paganelli: _"sulle date di scadenza è bene non fare nessun tipo di automatismo
di programma perché è un casino."_

🔴 **The one hop still open is the last one** — which Salesforce order _line_ a payment
settles, given a Plus order is n lines of the same article code distinguished only by due
date. See
[OI-166](OI-166%20The%20order%20line%20needs%20a%20shared%20identifier%20for%20Mexal.md).

⚠ This supersedes the premise of
[OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md);
cite 21/09 and 22/09 together.

## 🔴 2026-09-25 — tranches also need to exist on the bundle

At [UAT Recall Tutor e Bundle](../meetings/2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md): a **stage sale has no quote**, so the quote-only
creation point decided on 24/08 cannot give a WooCommerce order its tranches. Agreed:
tranches can also be **defined at bundle creation** and are inherited, editable, by any
quote that uses the bundle. About one week of work. Tracked as [OI-181](OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md). The
quote-side mechanism shown on 24/09 is unchanged and was accepted.

## 🔑 2026-09-25 evening - the status picklist read live out of the org, and a second origin exists

Aurel Mrruku opened the org during
[the 17:00 internal session](../meetings/2026-09-25%20Interna%20post%20UAT%20Contratto%20e%20Fase%20Due.md)
(`00:35:00`) and read the `Tranche__c` status picklist aloud, because Elena Spini's
Business Blueprint gave different values:

| Business Blueprint             | 🔑 The org                                   |
| ------------------------------ | -------------------------------------------- |
| `creato` / `chiuso` / `acquisito` | **`aperto` · `parzialmente pagato` · `pagato`** |

**Three values, and the document was wrong in all three.** He undertook to send her
the list rather than let her re-type it. `parzialmente pagato` means **only some of
that tranche's items are paid** — Aurel Mrruku: _"vuol dire che solo alcuni item di
quella tranche sono state pagate."_

⚠ **Read from the org by a person in a screen share, not by an org query in this
sweep.** He himself hedged the provenance of the names — _"sto parlando di un mese e
mezzo fa, forse l'hanno cambiato"_ — then read them live. **Treat as org-confirmed
for 25/09, and re-verify at the next `org-status-check`.**

### 🔑 The order transition is "all tranches", not "the last tranche"

Aurel Mrruku corrected himself mid-sentence and was explicit: the order reaches
**`Incassato` when every tranche is `pagato`** — _"quando tutte le trance… perché
l'ultima trance non è corretta."_ Elena Spini wrote it down that way. The full chain
as restated: **`Ordinato` → `Fatturato`** (first invoice issued in Mexal) **→
`Incassato`** (all invoices paid), with the **opportunity going Closed Won at
`Incassato`** — _"la chiude il pagamento, non la firma"_.

### A second origin, and it is now built

Aurel Mrruku corrected Elena Spini's quote-only wording — _"non è vero, che vi
generati anche il livello di prodotto bundle"_ — and confirmed the org carries two
objects: _"abbiamo il tranch e abbiamo anche i bundle tranch"_. 🟢 `Bundle_Tranch__c`
merged to `DevMain` the same evening, with `Tranche__c.Bundle_Tranch__c` joining a
quote tranche back to the template that generated it
([OI-181](OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md)).

Two further confirmations of the existing record, both from Elena Spini's text as
corrected in the call:

- Per tranche the user selects **which quote lines belong to it** and gives it a
  **due date**; each line stores the tranche reference and that date. Lines sharing
  a due date group into the same tranche.
- 🟢 **A tranche may be a single order line.** Elena Spini had written that it never
  coincides with one; Aurel Mrruku: _"Può coincidere… se tu hai tre prodotti li puoi
  dividere in tre trance."_ She deleted the sentence.
