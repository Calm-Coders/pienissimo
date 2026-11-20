---
id: OI-373
type: open-item
status: open
owner: unassigned
with: Rexhina Hysi, Anita Aga, Aurel Mrruku
org: ROMI
raised: 2026-11-17
updated: 2026-11-20
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

## 🔴 2026-11-18 - still blank, and the client has now been told the flow is live

The sheet was edited again by **Anita Aga** at **2026-11-18 14:54:08Z**. Row 7, the
Lead Source translation, moved to `done` for production. **This row did not move:
`Status Uat` = `Done`, `Status Prod` still blank.**

🔴 **Fourteen minutes earlier, at 14:40:26Z, ROMI told Pienissimo in writing that
the flow is released** — _"L'invio tramite DocuSign, come richiesto, dopo la
conferma di ricezione dell'ordine da Mexal"_ →
[OI-374](OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md).

Two readings, and this run settles neither:

1. the configuration was done today and the cell was simply not ticked — the same
   person wrote the mail and would have done the work; or
2. the mail describes code that is in production while the configuration it needs is
   not.

🔑 **The code is not new.** The order PDF and DocuSign-at-order-level stack —
`OrderPdfService`, `DocuSignOrderEnvelopeService` / `Queueable`,
`orderDocuSignErrorBanner`, `orderDocuSignRetryAction`, the `Reinvia_DocuSign` quick
action and the four `Order` DocuSign/PDF fields — went to production on **12
November at 16:19Z** (quick deploy `0AfSW000001Lxnh0AC`). Today's delta
`4478915..4d18d57` contains **no DocuSign component at all**. So this row has been
blank for six days with the code live behind it, and ⚠ the 12/11 journal entry ends
_"No smoke test was run on a real order yet"_ — nothing since reports one.

**Six days to Pienissimo Live (24-26/11).** The org was not opened; no DocuSign
credential or connected-app value was read.

## 🟢 2026-11-20 - the circuit was verified end to end in production on 16 November

🟢 **The one thing this item has been waiting for is now on the record**, from
Elena Spini's weekly status post in `#tproj-pienissimo`, 20/11 19:00 CET:

> _"**Primo lunedi in PROD (16/11):** con Fabrizio P. ed Elisa abbiamo rifatto il
> giro **preventivo >> DocuSign >> ordine >> Mexal >> fattura >> incasso** e
> **funziona**."_

🔑 **So DocuSign does work in production**, inside a complete quote-to-cash
circuit, walked through with **Fabrizio Paganelli and Elisa Migliano** on the
first production Monday. That answers four windows of _"whether DocuSign is
actually configured in production"_.

⚠ **It is not a complete answer to this item.** Three gaps remain:

1. ⚠ **The circuit tested was quote → DocuSign.** This row is specifically about
   the **order** PDF attachment — the stage sale contract released on 18/11, two
   days after the test. Nothing says the order path was exercised.
2. 🔴 **The manual-steps production cell was still blank** at its last reading
   ([the tracker](../Manual%20Steps%20Pienissimo%20tracker.md)), and no source on
   20/11 shows it filled.
3. 🔴 **The order return trigger is still unbuilt** ([OI-322](OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md)) — a signature
   coming back from DocuSign on an order has nowhere to land.

🔑 **And a new fact from the same test, which is a question in its own right:**

> _"Dai dati migrati **non e partito nessun biglietto**."_

⚠ **No Biglietto was generated from the migrated data.** Whether that is correct
behaviour — no qualifying migrated order, or the event end dates still unrestored
([OI-353](OI-353%20Production%20event%20end%20dates%20are%20backdated%20to%20stop%20ticket%20mails%20during%20the%20load.md))
— or a defect, **no source says**. It is reported as an observation, not as a
pass or a fail, and nobody is recorded as investigating it. Pienissimo Live is
24-26 November.
