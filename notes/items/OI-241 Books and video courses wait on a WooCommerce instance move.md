---
id: OI-241
type: open-item
status: open
owner: Sabatino Rinaldi
org: Pienissimo
raised: 2026-10-14
updated: 2026-10-16
depends_on: [OI-182]
blocks: [go-live]
source: notes/meetings/2026-10-14 UAT Test e2e.md
---

# OI-241 - Books and video courses wait on a WooCommerce instance move

**Books and video courses were excluded from the 14/10 end-to-end test because
Sabatino Rinaldi has not yet moved those orders into the correct WooCommerce
instance. That is the first explanation any source gives for a scope question
three sources have contradicted each other about.**

## What the record says

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`00:04:34`):

> _"I libri e i video corsi vengono temporaneamente esclusi poiché Sabatino non
> ha ancora trasferito tali ordini nell'istanza corretta di WooCommerce."_

**Temporaneamente**, and for a named reason, with a named owner.

## 🔑 Why this matters: it settles a three-way contradiction

The record has carried three incompatible statements, all from October:

| Date | Source | Statement |
| --- | --- | --- |
| 09/10 | Elena Spini, `#tproj-pienissimo` status post | books moved to the new Woo shop and have left Salesforce **"for now"** |
| 12/10 | Elena Spini, the e2e invitation scope line | scope names **`libro/videocorsi`** |
| 13/10 | the Feedback Test UAT test list | names **`vendita libro`** |

🔑 **This reading reconciles them.** The orders are in WooCommerce, which is what
the 09/10 post describes; they are **in** Salesforce scope, which is what the two
later scope lines say; and they are untested because they sit in the **wrong
WooCommerce instance**. Nobody is contradicting anybody — the sales channel moved
and the integration source of record has not caught up.

⚠ **This is a reconciliation, not a ruling.** No source states it as a decision,
and nobody in the session said which instance is the correct one or when the move
happens.

## Why it is gating

- 🔴 **Go-live is 21 October and this path has never been tested.** It is a
  revenue channel with an owner on the client side and no date.
- 🔴 **It is the second untested path on the same integration.** Stage sales —
  _"manca ancora la parte relativa agli ordini da palco"_ — are
  [OI-101](OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md),
  and the WooCommerce **pacchetti tutor** were also listed as still to examine.
  **Three WooCommerce order types, none exercised end to end.**
- ⚠ **The plugin has a history of surprising people when an instance changes.**
  [OI-216](OI-216%20The%20WooCommerce%20plugin%20flushed%20its%20unsent%20order%20backlog%20into%20Salesforce.md)
  records it flushing an unsent backlog into Salesforce. A move of historical
  book orders between instances is the same class of event.
- ⚠ **`Product2.Evento__c` and the article-code scheme carry no book entry** in
  any record, so what a book order's article code looks like is unstated.

## What closing it looks like

Sabatino Rinaldi names the target instance and a date, the orders move, and one
book order and one video-course order transit WooCommerce to Salesforce to Mexal.

## 🔴 2026-10-16 — restated to the whole team, still with the same owner and no date

Elena Spini's `#tproj-pienissimo` status (16/10 19:20 CEST), in the UAT e2e
paragraph:

> _"libri e videocorsi fermi finché Sabatino non sposta gli ordini sul
> WooCommerce integrato."_

🟢 **The explanation and the owner are now stated in the project's own status
channel**, not only in a session transcript — so it is visible to everyone on
the project rather than inferable from the 14/10 e2e.

🔴 **Nothing has moved.** Second day with the same sentence, no date, and
**Sabatino Rinaldi was present for the whole 02:26 of the 16/10 UAT session and
it was never raised** — not by him, not by ROMI. The question of which
WooCommerce instance is correct remains on the unreachable list for a second
run.

⚠ **It now blocks more than its own test.** The books-and-videocorsi orders are
one of the three WooCommerce order paths that would exercise the agentless
default-agent logic built the same day
([OI-214](OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md)),
and digital products are also where the no-ticket article flag matters
([OI-251](OI-251%20ODB%20Live%20streaming%20must%20not%20generate%20a%20ticket.md)).
**Three rows now wait on one unscheduled instance move, seventeen days from
go-live.**
