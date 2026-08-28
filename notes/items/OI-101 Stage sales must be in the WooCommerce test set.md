---
id: OI-101
type: open-item
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: both
raised: 2026-08-27
updated: 2026-08-27
depends_on: [OI-102]
blocks: [OI-49]
source: meetings/2026-08-27-integrazione-woocommerce-transcript.it.md
---

# OI-101 - Stage sales must be in the WooCommerce test set

**Fabrizio Paganelli's own escalation, unprompted, at the close of the
[27 August design session](../meetings/2026-08-27%20Integrazione%20WooCommerce.md).**

WooCommerce is used for two very different things, and the integration has so
far only been reasoned about as the small one:

| Case                         | Typical value           | How the order starts                                          |
| ---------------------------- | ----------------------- | ------------------------------------------------------------- |
| Book / video course / stream | ~€97                    | customer buys online unaided                                  |
| **Vendita da palco**         | **€8,900–9,000 and up** | customer **in the room** scans a QR code and buys on the spot |

> _"se ci blocchiamo su una vendita di un libro o di uno stream che costa €97,
> pazienza. Ma se ci blocchiamo su una vendita da palco che magari sono in gioco
> anche €8.900 €900 o più, dopo lì diventa un problema grosso."_
> — Fabrizio Paganelli

He asked for **both cases to be simulated** in the technical tests, and named
two reasons beyond the amount:

- The customer is **present and deciding now**, so the flow must complete
  quickly and simply — a failure is visible to the room, not to a support inbox.
- 🔴 **A stage sale triggers downstream mechanisms, contract generation among
  them** — _"si scatenano tutto una serie di meccanismi successivi che sono
  l'invio del contratto"_. So the test is not just "does the order arrive"; it
  is whether everything hanging off a high-value order fires.

Sabatino Rinaldi agreed to test it and argued it should be **simpler**, not
harder, because a stage sale is a direct customer action ending in the same
`in lavorazione` / `completato` states as any other order. Aurel Mrruku
concurred on the mechanics and drew the distinction that matters: the technical
test is cheap, but a **functional test across the several cases** is separate
work and has not been scheduled.

## State

🔴 **Not done.** The
[afternoon test session](../meetings/2026-08-27%20Test%20Integrazione%20WooCommerce.md)
ran a single €50 test product through the happy path. Stage sales were not
simulated — Sabatino Rinaldi deferred them explicitly to the Salesforce-connected
round: _"anche quelli che vuole Fabrizio, li facciamo direttamente quando
abbiamo il collegamento con Sales[force]"_.

Blocked behind
[OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md),
which is what makes that round possible. Target: **week of 31 August**.

## Why this is worth a tracker row

The sale-origin discriminator already matters elsewhere: per
[OI-49](OI-49%20WooCommerce%20checkout-link%20flow.md), _"da palco"_ is
identified by the **product code on the WooCommerce order** and _"recall
tutor"_ by a mandatory field on the Opportunity. So a stage sale takes a
**different path through the same integration**, and it is the path carrying the
money. Neither path has been exercised end to end.

Related: `ORD-11` in the register — _"Performance Plus from stage bundle or
direct tutor entry"_ — and
[OI-70](OI-70%20Performance%20Plus%20opportunity%20typing.md).
