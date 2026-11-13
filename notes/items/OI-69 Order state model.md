---
id: OI-69
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-11-13
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-69 - Order state model

Order states are **Ordinato → Fatturato → Incassato**. The old **"Chiuso
acquisito" is deleted** — Fabrizio Paganelli: _"non serve più."_

> **Superseded 2026-11-13 — see the section of that date below.** The
> Opportunity now goes Closed Won at the **first** payment received on its
> order, no longer at `Incassato`. The paragraph that follows is kept as the
> original 6 August decision.

**The Opportunity goes Closed Won only when the order reaches _Incassato_.**
Payment closes the opportunity, not signature. This binds the older
"closed-won driven by payment" principle to an explicit state, and it means
opportunity closure now depends on the invoice arriving back from Mexal.

Decided; configuration pending. `Order` carries **no custom fields** in the
repository, so nothing of this exists yet.

🔴 **The requirement register still carries the old order states, and this is
the one real state-machine gap.** `order.states` reads
**`[CREATO, CHIUSO/ACQUISITO]`** — the values from
[the diagram](../The%20newest%20design%20diagram.md), with the rule that
`CHIUSO/ACQUISITO` is _"set manually by administration within max 5 days of
confirmed payment"_. The 6 August session replaced that with
`Ordinato → Fatturato → Incassato`.

**Nobody has stated whether `Incassato` is `CHIUSO/ACQUISITO` renamed or a
different milestone.** It matters because
[the tranche](OI-50%20Tranche%20object.md) still uses `CHIUSO/ACQUISITO`, the
register documents the name as a deliberate Order/Tranche collision, and
`REQUIREMENTS.md` carries both vocabularies. **Confirm with Elena Spini, then
update the register** — configuring before that means configuring twice.

## 2026-08-20 - the diagram caught up, and still did not answer the question

`Flows & Objects.drawio` was re-decoded at its **2026-08-20T15:36:24Z** version
and now **draws `Ordinato · Fatturato · Incasato`** (one `s`, as drawn) — on the
LEAD-OPTY page as a new `ORDINE` block, and again on the Ordini page — together
with the rule _"Status Order == Incassato >> Aggiornamento dell'Opty in **Chiusa
Vinta**"_. That is exactly the 06 August decision, and it is the first time the
drawing has carried it. It also confirms the second half of this note: the
Opportunity closes on `Incassato`, not on signature.

🔴 **But `CHIUSO/ACQUISITO` was not struck.** `Order Status SF ==
CHIUSO/ACQUISITO` and `Order Status SF == CREATO` are still on the Ordini page,
and the tranche rule still sends the first tranche to `CHIUSO/ACQUISITO`. **The
diagram now shows both vocabularies at once**, which is worse than showing only
the old one: it can no longer be dismissed as a drawing that predates the
decision, and it still does not say whether `Incassato` and `CHIUSO/ACQUISITO`
are the same milestone.

One weak signal, not enough to act on: the client's own
[`Workflow Pienissimo 23-7-26.drawio`](../The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md),
edited the same afternoon, labels its closed-won box **"Chiuso Vinto /
Incassato"** — while still defining `CHIUSO/ACQUISITO` separately elsewhere on
the same page. Suggestive of a rename; **not a ruling**.

**The state-name ask is unchanged.** Elena Spini: is `Incassato`
`CHIUSO/ACQUISITO` renamed, or a different milestone? Aurel Mrruku's 2026-08-24
decision now settles how the tranche is created and how payment rolls up, so
that mechanism can be built. The final tranche-state label and the Order state
machine must not be configured until this sentence exists.

⚠ The set may also be incomplete. Fabrizio floated a fourth state **_Perso_**
driven by credit notes and Elena Spini called three states thin — see
[OI-85](OI-85%20Order%20state%20set%20may%20be%20incomplete.md). Configuring
before both points are settled means configuring twice.

Sits in the middle of
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md).

## 2026-08-25 - org check: neither vocabulary is configured

Verified read-only against **Pienissimo UAT**. The argument recorded above —
`Ordinato · Fatturato · Incassato` versus `CREATO · CHIUSO/ACQUISITO` — has not
reached the org in either form.

- `Order.Status` holds the **stock Salesforce values `Draft` and `Activated`**.
- `Order` carries **zero custom fields**, in the org and in `force-app/`.
- Three Order records exist: one `Draft`, two `Activated`.

So the unresolved naming question has cost nothing yet, and the note's advice
holds exactly: **do not configure before Elena Spini answers whether `Incassato`
is `CHIUSO/ACQUISITO` renamed or a different milestone.** Nothing has been built
twice, because nothing has been built once.

⚠ The same is true one level down, and it is a bigger gap:
`Opportunity.StageName` is stock (`Qualification · Needs Analysis · Proposal ·
Negotiation · Closed Won · Closed Lost`), so the rule this item turns on — the
Opportunity going Closed Won **when the order reaches `Incassato`** — has
neither a source state nor a target state configured, and **no automation of any
kind** to carry it. See the flow finding at
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md).

## 2026-09-25 - decided: the order is Incassato when every tranche is paid

**Aurel Mrruku, direct decision:** _"quando tutte tranche vanno in pagato l'ordine va
in incassato."_ This answers the question left open by the 24/09 UAT ruling ("Closed Won
only at incasso"): with several tranches, the order is collected at the **last** paid
tranche, not the first.

- **The mechanism is automatic.** Mexal marks each order line paid; the line roll-up sets
  the tranche to `Pagata`
  ([OI-50](OI-50%20Tranche%20object.md)); once **every tranche on the order's lines** is
  `Pagata`, the order goes to `Incassato`, and the existing `OrderTriggerHandler` then
  closes the Opportunity `Chiusa/Vinta`.
- **Built in source, not deployed.** `OrderItemTriggerHandler.markOrdersCollectedForFullyPaidTranches`,
  written the same session on `DevMain`, uncommitted. No test class was written, per the
  standing instruction.
- **The register moved with it.** v1.6 rewrites `ORD-14`: the manual step in which
  administration set `CHIUSO/ACQUISITO` within five days is replaced by the automatic
  rule, in the YAML and in both prose documents. It joins the
  [v1.6 change set](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md).
- WooCommerce orders are unaffected: they are created already `Incassato`.

## 2026-11-13 - changed: the Opportunity is won at the first payment, deployed to Prod

**Requested by Pienissimo**, relayed by Aurel Mrruku (_"hanno chiesto di
mandare un opportunity in vinta nel momento in cui riceviamo il primo pagamento
della fattura"_; _"tutte queste cose li ha chiesto pienissimo"_): the
Opportunity goes `Chiusa/Vinta` as soon as **the first payment** on its order is
received. The individual and the channel for this request are not recorded.

- **Still payment, not signature** — only the threshold moved, from the last
  paid tranche to the first paid order line.
- **Mechanism.** When an `OrderItem` moves to `Mexal_Payment_Status__c = Paid`
  (Mexal scadenziario `P` or `E`,
  [OI-201](OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)),
  `OrderItemTriggerHandler` calls the new
  `OrderTriggerHandler.closeWonOpportunitiesForPaidOrders`. This happens on
  insert and on update, and only on the transition to `Paid`. Opportunities that
  are already won are skipped.
- **The `Incassato` rule stays**, unchanged, as a backstop. Since the WooCommerce
  change below, WooCommerce orders also close their Opportunity at the first
  scadenziario payment.
- **The order state machine is unchanged.** The order still goes `Fatturato` and
  then `Incassato` only when every tranche is paid. Ticket availability per
  tranche is untouched.
- **Side effect.** Once the Opportunity is `Chiusa/Vinta`, the record page hides
  the "Nuovo Preventivo Standard" action. A follow-up quote on the same
  Opportunity can no longer be created from that button after the first payment.
  Nothing else is blocked: no validation rule, trigger or path restriction acts
  on `Chiusa/Vinta`.
- **Deployed to Pienissimo Prod on 2026-11-13.** Validation `0AfSW000001M49F0AS`
  ran `OrderTriggerHandlerTest`, `MexalIntegrationTest` and `TicketingTest`: 76
  tests, 0 failures. Coverage was 88% on `OrderItemTriggerHandler` and 89% on
  `OrderTriggerHandler`. Quick deploy `0AfSW000001M4Ar0AK` deployed the 2
  components. Before deploying, both Prod classes were retrieved and matched git
  `HEAD`. No new test was written.
- **No backlog.** A read-only Prod query found **no** Opportunity that is not
  won and has a paid order line, so no existing record needed updating.
- Redeployed in the WooCommerce release below, and now **also in UAT**.

## 2026-11-13 - changed: WooCommerce orders are no longer created Incassato

**Requested by Pienissimo by phone**, relayed by Aurel Mrruku: _"quando un
ordine arriva da woocomerce non deve arrivare in incassato. in incassato lo
porta solo lo scadenziario."_

- **Before.** `WoocommerceOrderService.createOrder` inserted the order as
  `Ordinato`. It then set it to `Incassato` at once, unless the order was Plus or
  had bundle tranches. That also made the tickets `Disponibile` and closed the
  linked Opportunity won.
- **Now.** The order stays `Ordinato`. It moves only through the scadenziario
  path that every other order follows: `Fatturato` when invoiced, and
  `Incassato` when Mexal reports every line or tranche paid. The Opportunity is
  won at the first paid line.
- ⚠ **Consequence: WooCommerce tickets wait for Mexal.** A customer who pays
  online by card keeps the tickets in `Ordinato` until the scadenziario reports
  the payment (`P` or `E`). Before, the tickets were available at once. If Mexal
  does not register the receipt for these orders, they stay stuck.
- This resolves the contradiction recorded at the
  [2026-10-02 Pre-UAT](../meetings/2026-10-02%20Interna%20Pre-UAT%20Plus.md)
  between the register rule _"created already Incassato (paid online)"_ and the
  fact that only the first tranche is paid online.
- **Existing orders are unchanged.** WooCommerce orders that are already
  `Incassato` were not touched; nobody asked for that.
- **Tests.** Two assertions in the existing `TicketingTest` were updated to the
  new behaviour: the order is `Ordinato`, and the Opportunity is not won at
  creation. No new test was written.
- **Prod.** With `RunSpecifiedTests`, `WoocommerceOrderService` reached only
  70.6% coverage, below the 75% per-class threshold; only `TicketingTest`
  covers it. The release was therefore validated with `RunLocalTests`:
  `0AfSW000001M4Nl0AK`, 176 tests, 0 failures. It was quick-deployed as
  `0AfSW000001M4PN0A0` with all four classes; both handlers were redeployed
  unchanged. All four classes show 2026-11-13 16:24Z.
- **UAT.** UAT enforces per-class coverage with `RunSpecifiedTests`, so the
  release was deployed with `NoTestRun` (`0AfMA00000DBF130AH`, 4 components,
  16:22Z). The tests were then run in UAT: 77 tests, 76 passed. The one failure
  is `MexalIntegrationTest.schedulerRegistersTheNightlyJob`, because a job named
  "Mexal Sync - Nightly" is already scheduled in UAT. It is unrelated to this
  change and passed in Prod. Before deploying, the UAT handlers and service
  matched git `HEAD`; UAT's `TicketingTest` was older and is now aligned.
- Seen in a separate UAT run: `QuoteDocumentsTest.pdfControllerRendersLinesAndFormatsMoney`
  fails in UAT because the quote PDF controller requires tranches. Not investigated.

## Still open

- ⚠ **Neither change is in a signed register version yet.** Both join the next
  change set.
- ⚠ **WooCommerce tickets are now gated on Mexal** — see the consequence above.
  Confirm with Pienissimo that card-paid online orders are registered as paid in
  the Mexal scadenziario.

- ⚠ **The client has not seen this.** It is a ROMI decision; it reaches Pienissimo with
  the v1.6 change set.
- ⚠ **Lines with no tranche are ignored.** An order whose lines are only partly assigned
  to tranches goes `Incassato` when the assigned ones are paid. Not decided whether that
  is right.
- ~~⚠ **Nothing sets `Fatturato`.**~~ 2026-11-04: deployed to UAT and Prod —
  `Fatturato` when every line is invoiced and at least one is unpaid
  ([OI-314](OI-314%20The%20order%20line%20fatturato%20status%20is%20not%20implemented.md)).
- ⚠ **No way back.** A payment later reversed in Mexal moves the tranche back but leaves
  the order `Incassato` and the Opportunity won
  ([OI-92](OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md),
  [OI-157](OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)).
- `Perso` ([OI-85](OI-85%20Order%20state%20set%20may%20be%20incomplete.md)) is still
  undecided.
