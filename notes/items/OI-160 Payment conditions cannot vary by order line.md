---
id: OI-160
type: open-item
status: open
owner: Fabrizio Paganelli
org: both
raised: 2026-09-22
updated: 2026-09-22
depends_on: [OI-143]
blocks: [go-live]
source: notes/meetings/2026-09-22 Test Mexal.md
---

# OI-160 - Payment conditions cannot vary by order line

**Asked by the client on 22/09 at 11:22 and answered by the Mexal vendor at 15:00
the same day. The answer is no, and the agreed remedy is to change how the business
sells.**

## What the client wanted

Fabrizio Paganelli and Elisa Migliano want a **coded payment condition per block of
order lines** — his example `A1` meaning 50% now, 50% later — instead of what happens
today: the tutor writes the plan in the **order notes**, and administration reads the
note and **edits the payment method by hand before issuing each invoice**.

His worked case at
[the 11:22 session](../meetings/2026-09-22%20Logiche%20Spacchettamento%20Righe.md):
a tutor bundle where one block is due 30/09 and an Academy block is invoiced 31/12
with 50% on 31/12 and 50% on 31/01.

## The vendor's answer

Mirko Merendi, at
[Test Mexal](../meetings/2026-09-22%20Test%20Mexal.md):

- The payment condition exists **only on the order header**, never on the line.
- **The only field available on an order line is the due date.**
- There are **no hidden fields** in Mexal. Additional line-data views exist but
  require constant manual interaction, and extra descriptions **get printed on the
  invoice** unless removed by hand.

## The decision

🔴 **Unanimous: do not force the system.** The header condition commands, so any
per-line plan would mean editing every generated invoice by hand. The group chose to
**adapt commercial behaviour** instead. Fabrizio Paganelli will **delete the obsolete
payment-condition codes and create new structured ones for use with Salesforce**,
deliberately kept loose because customers move between bonifico, Ri.Ba. and recovery
plans.

## What is still unresolved

- 🔴 **Nobody has defined what "adapt commercial behaviour" means.** No rule, no
  owner, no date. The tutors are the people who would have to change, and no tutor
  was in either session.
- 🔴 **The Mastery has no mechanism.** A single high-value ticket (~€6,0xx) cannot be
  split into several product lines — _"non posso mettere più righe per lo stesso
  biglietto"_ — so a split payment plan on one ticket has neither the tranche
  mechanism nor a payment condition. Fabrizio Paganelli deferred it:
  _"ragioniamoci."_ It is the case
  [OI-142](OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md) was
  invented for, and the only case that survives it.
- ⚠ **The new payment-condition codes are owed** and will need mapping into
  Salesforce.
- ⚠ Elena Spini left the Test Mexal session before this was closed and flagged the
  topic for a later pass with Aurel Mrruku and Fabrizio Paganelli.
