---
id: OI-302
type: open-item
status: open
owner: Aurel Mrruku
with: Sabatino Rinaldi
org: ROMI
raised: 2026-10-30
updated: 2026-10-30
depends_on: []
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-30 Connessione WooCommerce.md
---

# OI-302 - WooCommerce matches customers by email instead of partita IVA

**A WooCommerce order attaches itself to an existing Salesforce account by email
address. One Pienissimo customer can own several businesses with different VAT
numbers on the same email, so the match binds an order to the wrong company. The
rule is agreed to change to partita IVA. It is not yet changed.**

## How it was found

Live, in [the 30 October WooCommerce call](../meetings/2026-10-30%20Connessione%20WooCommerce.md),
`00:15:17`. Fabrizio Paganelli placed a test order as a fictitious new customer
paying by bank transfer; the Mexal customer create then failed, and Aurel Mrruku
traced it to the order having been **associated with an existing account on the
strength of a shared email address** rather than on the VAT number.

## Why the email is the wrong key

Sabatino Rinaldi's reason, `00:16:42`: **a customer can hold several premises with
different partite IVA registered against the same email address.** So email is not
a business identity in this catalogue, and treating it as one merges distinct
companies.

🔑 **The replacement key is available on every order.** Aurel Mrruku's ground for
choosing it: **WooCommerce always requires the partita IVA for invoicing**, so the
field is never empty on the inbound payload.

## What is agreed

> _"Si stabilisce di effettuare il controllo dei clienti duplicati su WooCommerce
> basandosi sulla partita IVA anziché sull'indirizzo email."_

Owner: **Aurel Mrruku**. A retest with a different partita IVA at `00:20:49` was
reported as correctly associated and created without account overlap. ⚠ **That was
a behavioural check in the session, not evidence of a committed code change.**

## Why it is open

1. 🔴 **No code change is in the repository.** Nothing on `DevMain` at `52ddc4c`
   or on `DevAnita30` at `4fb8092` touches WooCommerce account matching.
2. ⚠ **The retest and the change are not separable in the record.** Whether the
   `00:20:49` success came from a code change made during the call or from simply
   using a distinct VAT number is not stated.
3. 🔑 **It bears on the already-loaded history.** The historical load keyed Accounts
   from the Mexal customer code, not from email; but any account WooCommerce has
   already merged by email is wrong now, and nobody has counted them.
4. ⚠ **Masked VAT numbers would defeat the new key too.** The Lead file carries
   `XXXXXXXXXXX` in the P.IVA column —
   [OI-307](OI-307%20The%20Lead%20import%20needs%20the%20duplicate%20rules%20disabled.md).
   Whether a WooCommerce order can arrive without a real VAT number is not
   established; the claim is that invoicing requires it.

## Related

- [The WooCommerce payload contract](../The%20WooCommerce%20payload%20contract.md)
- [OI-296](OI-296%20Account%20creation%20to%20Mexal%20failed%20in%20UAT%20and%20account%20send%20was%20switched%20off.md)
  — the 28/10 Mexal customer create that failed HTTP 400 in UAT, also on a new
  account. 🔑 **This note is a candidate explanation for it**, but the 28/10 log was
  never read, so the connection is unestablished.
