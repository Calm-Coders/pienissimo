---
id: OI-215
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-07
updated: 2026-10-14
depends_on: [OI-173, OI-211]
blocks: [go-live]
source: notes/meetings/2026-10-07 UAT Integrazione WooCommerce e Mexal.md
---

# OI-215 - Anticipay does not cover San Marino addresses

**Anticipay resolves Italian addresses only. For a San Marino customer — which
is what Pienissimo mostly is — the enrichment does not apply, the order goes
straight from Salesforce to Mexal, and the partita IVA becomes mandatory.**

## Established in the run

At [the WooCommerce session](../meetings/2026-10-07%20UAT%20Integrazione%20WooCommerce%20e%20Mexal.md)
Aurel Mrruku verified that _"il sistema Antipay opera esclusivamente per
indirizzi italiani e non per San Marino"_, which led the room to **prefer the
Italy state for compatible addresses**. Later in the same session Fabrizio
Paganelli and Aurel Mrruku drew the split plainly: Italian customers transit
through Anticipay before reaching Mexal, **foreign customers arrive at Mexal
directly from Salesforce and must carry a partita IVA**.

An Anticipay error had already fired earlier in the session over a fictitious
partita IVA entered for a test order.

## The collision

Preferring Italy to keep Anticipay working fights the San Marino fiscal data the
ERP needs. [The Mexal call](../meetings/2026-10-07%20Temi%20Integrazione%20Mexal.md)
an hour later had Fabrizio Paganelli describing the inverse correction as
routine: realising Italy was entered instead of San Marino, they fix country,
electronic-invoicing type and fiscal residence **in Mexal** and let the nightly
return flow carry it back. So the two systems pull the same record in opposite
directions, and the field at issue is the one
[OI-211](OI-211%20Mexal%20rejects%20N%20for%20the%20electronic%20invoicing%20code.md)
is already stuck on.

## Of record in the code

⚠ Anita Aga's **`577fc5c`** (07/10 17:32, branch `DevAnita07`, **not in
`DevMain`**) is titled in part _"anticipay Country logic fix"_ and adds one line
to `AnticipayAccountService.cls`:

```apex
accountRecord.BillingCountry = 'IT';
```

That is consistent with "Anticipay is Italy-only", and it is an unconditional
write on every Anticipay-enriched account. **Whether it is intended to apply to
accounts that are actually San Marino has not been established by this sweep**,
and the commit is not merged. Recorded as a fact of the diff, not as a defect.

## Open

- **No rule is written** for which address a San Marino customer carries in
  Salesforce, or at which point in each flow it is set.
- **Showcase events make it worse.** Elena Spini, Fabrizio Paganelli and
  Sabatino Rinaldi discussed Tour and Food events admitting participants with
  unknown registry data or fictitious partite IVA, and the administrative
  handling of foreign customers excluded from Anticipay — raised, not resolved.
- Aurel Mrruku and Fabrizio Paganelli flagged that **critical fields must not be
  freely editable by agents**, and Fabrizio Paganelli suggested mandatory fields
  or defaults. That is the same lock as
  [OI-209](OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md).

## What closing it looks like

A written rule for country and fiscal residence per customer type, agreed with
Fabrizio Paganelli, that lets Anticipay enrich the records it can without
corrupting San Marino fiscal data — and one San Marino order transmitting
cleanly end to end.

## 🟡 2026-10-08 - Italy became the agreed default, and the hardcode merged

Two movements, in the same direction.

🟢 **`Concordato` at [the 08/10 internal session](../meetings/2026-10-08%20Internal%20Test.md):**
_"È stato stabilito di impostare l'Italia come paese predefinito per le risposte
di anticipate."_ Aurel Mrruku reported the Anticipay tests on the invoice
scadenzario and confirmed the Italy default with them. So the "prefer Italy"
instinct of 07/10 is now a decision of record.

🟢 **Anita Aga's `577fc5c` is in `DevMain`**, merged 08/10 10:14 CEST via
**PR #84**. The unconditional `accountRecord.BillingCountry = 'IT'` in
`AnticipayAccountService.cls` is therefore live on the working branch, and it is
no longer only a fact of an unmerged diff — it implements the ruling above.

🔴 **The collision the item was raised for is untouched.** The ruling settles
what Anticipay gets; it says nothing about the San Marino fiscal data Mexal
needs, and it was taken in a **ROMI-internal session with no client present**,
one day after Fabrizio Paganelli described correcting country, electronic-
invoicing type and fiscal residence **in Mexal** as routine. An account whose
real country is San Marino still has `IT` written onto it by every Anticipay
enrichment, and the nightly return flow of
[OI-209](OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)
— which would carry Mexal's correction back — **is still not built**.

⚠ So the two systems still pull the same record in opposite directions; what
changed is that one of the two pulls is now deliberate and merged.

## 2026-10-14 — the San Marino gap was demonstrated to the client, and the call's trigger is now of record

**Two sources the same day.**

### The e2e put it in front of the client

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`01:01:30`):
Aurel Mrruku showed that the Anticipay call

> _"non risulta attiva per un account di San Marino poiché non presente sul
> database italiano o non gestito in automatico"_

🔑 **This is the first time the limitation is demonstrated to the client rather
than established internally.** The 07/10 finding was ROMI's; the 08/10 Italy
default was agreed in a ROMI-internal session with no client present. Elisa
Migliano saw it happen on 14/10 and did not contest it.

### 🔑 And the call's trigger is stated for the first time

`01:03:00`, Elisa Migliano and Aurel Mrruku together:

> _"la chiamata ad Anticipay viene eseguita esclusivamente al primo ordine di un
> account quando viene generato il codice Maxal, evitando così costi superflui"_

**Once per account, at the first order, when the Mexal code is generated** — a
deliberate cost control, and a fact no previous source carried.

⚠ **It has a consequence nobody drew.** If the enrichment runs once and never
again, then a customer whose registry data changes later is never re-enriched —
which is the gap [OI-209](OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md)
describes from the other side, and the case
[OI-234](OI-234%20Tranche%20invoicing%20when%20the%20customer%20changes%20legal%20entity%20mid-order.md)
raises. ⚠ It also means the unconditional `BillingCountry = 'IT'` write of
`577fc5c` lands **once, permanently**, at first order.

### A 404 the same morning

An automated Salesforce mail at **2026-10-14 08:11:09Z**, subject _"Sandbox:
Errore Anticipay da verificare"_, reports the check failing on account
`001MA000012gCXsYAM` in the **partial sandbox** —
`ability-customization-52152--partial` — with **HTTP 404** and message
_"TEST - Azienda non trovata"_, integration log `a05MA00000GWyvtYAD`.

- 🟢 **The error path works end to end** — the callout failed, the integration log
  was written, and the notification arrived. That is
  [OI-107](OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)
  behaving.
- ⚠ **404 is the documented response for a company Anticipay cannot resolve**, so
  this is consistent with a test VAT number, with a San Marino company, or with
  both. **Which cannot be told from the mail**, and the account was not opened.
- ⚠ **The mail went to `a.mrruku@romicompany.com` only** — the hardcoded ROMI
  address of [OI-119](OI-119%20The%20Anticipay%20error%20notification%20goes%20to%20a%20hardcoded%20ROMI%20address.md),
  still unfixed. The message says it _"richiede una verifica amministrativa"_ and
  no administrator received it.
