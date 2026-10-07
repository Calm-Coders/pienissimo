---
id: OI-214
type: open-item
status: open
owner: Aurel Mrruku
with: Marco Montesi
org: both
raised: 2026-10-07
updated: 2026-10-07
depends_on: [OI-219]
blocks: [OI-134, go-live]
severity: gating
source: notes/meetings/2026-10-07 UAT Integrazione WooCommerce e Mexal.md
---

# OI-214 - The Mexal order send requires an agent code WooCommerce orders lack

**Mexal rejects an order without an agent code, and an order arriving from
WooCommerce need not have an agent. The send failed on exactly this at
the 07/10 UAT, and there is no default.**

## The failure

At [the WooCommerce session](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md),
re-sending a test order to Mexal returned an error for the missing mandatory
agent code. Aurel Mrruku tried assigning an agent by hand to test the sync and
found the agent user **inactive**, which Elena Spini confirmed. The send
eventually succeeded only once an active agent was associated.

## The shape of the gap

Fabrizio Paganelli put a number on it: **about 80% of WooCommerce orders belong
to customers already linked to a tutor or a company**, so the agent comes
through. For the remainder the assignment _"deve essere gestita dall'ufficio
commerciale"_ — a manual step, with no default value and no queue.

Two rulings from the same session bound the problem:

- **An order keeps the agent it was created with.** Changing the agent on the
  customer registry later does not move orders already created.
- **The agent is inherited from the customer registry at order creation**, and
  the fields that matter are the agent category and the commission category
  (Fabrizio Paganelli, Elena Spini). Commission categories are not native on the
  Mexal order and sit on the customer registry — Fabrizio Paganelli confirmed he
  had that added on Salesforce.

## Open

- 🔴 **Which agent code to use for WooCommerce orders with no agent is
  unanswered.** Elisa Migliano undertook to ask Marco Montesi. Until he answers,
  the ~20% have no route.
- **The default agent logic for orders from Palco is Aurel Mrruku's** to define,
  together with the payment-method mapping
  ([OI-219](OI-219%20Default%20payment%20method%20and%20agent%20for%20WooCommerce%20and%20Palco%20orders.md)).
- ⚠ **The error is not surfaced where it happens.** Aurel Mrruku asked for the
  mandatory-agent-code error to be reported **on the order screen itself** for
  diagnosis; at present it is only visible in the integration log.

## What closing it looks like

Marco Montesi names the fallback agent code, the inheritance runs at order
creation for every channel including WooCommerce and Palco, an order with no
natural agent still transmits, and the failure is readable on the order record
rather than only in `Integration_Log__c`.
