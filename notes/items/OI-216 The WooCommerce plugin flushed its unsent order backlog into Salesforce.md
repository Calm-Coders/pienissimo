---
id: OI-216
type: open-item
status: open
owner: Sabatino Rinaldi
org: Pienissimo
raised: 2026-10-07
updated: 2026-10-07
blocks: [go-live]
source: notes/meetings/2026-10-07 UAT Integrazione WooCommerce e Mexal.md
---

# OI-216 - The WooCommerce plugin flushed its unsent order backlog into Salesforce

**Enabling the send to Salesforce by hand made the shop plugin forward every
order it had never sent. Past orders for real, named customers arrived in
Salesforce unannounced during the 07/10 UAT. Sabatino Rinaldi will correct the
behaviour in the plugin.**

## What happened

At [the WooCommerce session](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md),
unexpected past orders appeared directly in Salesforce mid-test. Sabatino
Rinaldi explained the cause — he had had to activate the send to Salesforce
manually, which forwarded all previously unsent orders — and said he would fix
the behaviour from the plugin.

⚠ **The orders carried real customer records.** Two past customers were named
aloud in the session. **The names are deliberately not recorded here**; the fact
that real records entered the Salesforce environment this way is what matters.

## It answers a standing question

Aurel Mrruku asked Sabatino Rinaldi at **10:34:40Z on 06/10**, cc Elena Spini,
whether the WooCommerce orders he was seeing created in Salesforce were tests:

> _"Stiamo notando che state cercando di creare degli ordini da WooCommerce su
> SF. State facendo dei test?"_

No reply ever came by mail. **The answer is no** — they were the backlog flush,
established in the room the next morning. The question is closed by this item.

## Why it is not just noise

- The same session established that **Aurel Mrruku had already found roughly
  thirty earlier test orders and accounts** under a test prefix needing
  filtering or deletion, and the group agreed to **delete the accounts created
  during the last ten days of testing**. Real backlog orders mixed into that set
  make the cleanup riskier than a prefix filter.
- Aurel Mrruku raised separately that testing against real registry data could
  **corrupt the database on both Mexal and Salesforce** if a ragione sociale or
  partita IVA is edited. Elisa Migliano's answer — test accounts, no shared
  commercial credentials — became the UAT credential ruling.
- Sabatino Rinaldi is additionally **migrating all products and orders onto the
  single WooCommerce shop** he manages, so the same send path is about to carry
  more history.

## What closing it looks like

The plugin sends only orders placed after the integration is enabled, the
backlog that already arrived is identified and separated from the test data due
for deletion, and the ten-day cleanup runs without removing a real customer.
