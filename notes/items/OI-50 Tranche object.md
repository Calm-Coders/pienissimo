---
id: OI-50
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-07-22
updated: 2026-08-26
blocks: [OI-75, go-live]
severity: gating
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
