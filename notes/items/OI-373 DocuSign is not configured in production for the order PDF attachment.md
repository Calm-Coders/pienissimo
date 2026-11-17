---
id: OI-373
type: open-item
status: open
owner: unassigned
with: Rexhina Hysi, Anita Aga, Aurel Mrruku
org: ROMI
raised: 2026-11-17
updated: 2026-11-17
depends_on: [OI-322]
blocks: []
severity: normal
uncertain: the tracker names no owner and no date for the production column; whether the step was performed and left unticked was not verified in the org
source: Google Drive 1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo
---

# OI-373 - DocuSign is not configured in production for the order PDF attachment

**A new row appeared on ROMI's manual-steps tracker today: configure DocuSign in
production so the signed PDF attaches to the order. It is `Done` in UAT and blank
for production, on an org whose users went live yesterday and whose first stage-sale
contracts are due in production before Pienissimo Live on 24-26 November.**

## The row

[The Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md)
(`1u-LgUKVlGK9ePyjMzZ_uJjXniHluo5_449siHgAIBHo`) was modified **2026-11-17
10:46:26Z** by **Anita Aga** and grew from five rows to seven. This is the sixth:

| Manual Step | `Status Uat` | `Status Prod` |
| --- | --- | --- |
| **Configure DocuSign in Prod for the attachment of the pdf in orders** | `Done` | 🔴 **blank** |

## Why it is a distinct gap

🔑 **It is the order path, not the quote path.** DocuSign demonstrably works in
production for quotes — a quote PDF was generated and signed on the go-live call of
16 November, which is where
[OI-369](OI-369%20DocuSign%20asks%20signers%20to%20register%20and%20the%20client%20expects%20to%20lose%20them.md)
and the American date on the PDF were both found. This row is about the **order**
document.

That makes it the configuration half of
[OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md),
which is the code half: the return trigger sets a Quote to `Firmata` and a
stage-sale order has no Quote, so Aurel Mrruku has to tell an order document from a
quote document. ⚠ **The two are not the same work and neither is finished.** OI-322
is unbuilt development scheduled inside Fase 2 release R0; this row is an org-side
setting that is already `Done` in UAT, which implies something exists there to
configure.

⚠ **What exactly "configure DocuSign … for the attachment of the pdf in orders"
covers is not stated** — the tracker gives a one-line title and no click path,
unlike its other rows. Nothing here establishes whether it is an envelope template,
a connected-app or writeback setting, or a DocuSign Apex toolkit configuration.

## 🔑 The sending code already exists, which is what makes this a configuration gap

The repository carries an order-level DocuSign send that mirrors the quote one:

| Class | Purpose |
| --- | --- |
| `DocuSignOrderEnvelopeService` / `DocuSignOrderEnvelopeQueueable` | the order path |
| `DocuSignQuoteEnvelopeService` / `DocuSignQuoteEnvelopeQueueable` | the quote path |

Both order classes were added in commit **`54adb2e`, Anita Aga, 2026-11-09 17:28
CET**, _"Sending pdf to Docusign in Order level"_, and are **on `DevMain`**.
`DocuSignOrderEnvelopeService` is also granted in the **`Agente` permission set**,
which was touched again today.

🔑 **So the send is built and the return is not** — that is the line between this
item and [OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md),
whose gap is specifically the trigger that handles the **signed document coming
back** and cannot tell an order document from a quote document. Read together:
sending an order PDF to DocuSign is written, configuring production to do it is
unticked, and receiving the signed order back is unbuilt.

⚠ **No test class exists for any of the four DocuSign envelope classes** — there is
no file matching `*Test*` for them anywhere in `force-app/main/default/classes/`,
and the only references to `DocuSignOrderEnvelopeService` are the two order classes
themselves. Recorded as state per the standing instruction; **not acted on**.

## Why it matters now

- 🔴 **The stage sale contract is the first Fase 2 release** and is due in
  production **before Pienissimo Live (24-26 November)** —
  [OI-343](OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md).
  An order-signature path that is unconfigured in production blocks it.
- 🔴 **The tracker's production column has a history of being wrong in the
  optimistic direction.** The WooCommerce default-agent row read `done` while the
  client's first production WooCommerce order was being rejected for exactly that
  missing configuration →
  [OI-354](OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md).
  A blank cell here is weaker evidence than it looks, in both directions.
- ⚠ **Nothing assigns it.** As with every other row on this sheet, the production
  column carries no owner and no date →
  [OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md).

## What this note does not claim

⚠ **The org was not opened in this run.** A blank cell means no completion was
recorded in ROMI's own tracker; it does not prove the step is undone in production.
No DocuSign configuration, credential or connected-app value was read or copied.

## Related

- [OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md) — the code half
- [OI-301](OI-301%20Three%20production%20manual%20setup%20steps%20are%20outstanding.md) — the tracker's unticked production column
- [OI-336](OI-336%20The%20quote%20PDF%20allegato%20B%20has%20no%20signature%20field.md) — the missing third signature, raised again on 16/11
- [The Manual Steps tracker](../Manual%20Steps%20Pienissimo%20tracker.md)
