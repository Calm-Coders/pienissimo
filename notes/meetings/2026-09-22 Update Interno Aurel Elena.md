---
id: meeting-2026-09-22-update-interno-aurel-elena
type: meeting
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-22
updated: 2026-09-22
source: Drive transcript doc 1mFIToHo7HNrlXid-Ec8Dg9nvpMskCwQWVL9-PpQnqY4 (read in full)
---

# 2026-09-22 Update Interno Aurel Elena

**ROMI only, 16m30s, 22/09 14:31 CEST.** Aurel Mrruku, Elena Spini. A standing
two-person slot Elena Spini created because _"sennò non riuscivamo mai a parlare io
e te"_. Short, and the densest internal session of the day.

## 🔑 Lead conversion has no agreed duplicate rule

Raised by the developers during testing, not by a client. From a Lead, conversion
creates **Account + Contact + Opportunity** — and nothing says what happens when
the counterpart already exists:

- Account already present → the contact attaches to it. Both agreed.
- **Contact already present, but with a different P.IVA or a different ragione
  sociale** → undecided. Aurel Mrruku: the same contact on two accounts
  _"non può essere. Non ha senso."_

Their working direction: **deduplicate on `partita IVA` alone**, not on the
`ragione sociale` + P.IVA pair, because the P.IVA is also what drives the Anticipay
call at first order — and a typo is far likelier in the company name than in the
VAT number. Two accounts with the same P.IVA must not exist. ⚠ **Yesterday's
Anticipay test behaved this way already**, attaching to the pre-existing account
with that P.IVA.

⚠ Elena Spini's position is to **carry it into UAT as a point of attention** and let
the client rule; Aurel Mrruku's is that the case will certainly occur.
→ [OI-163](../items/OI-163%20Lead%20conversion%20has%20no%20agreed%20duplicate%20rule.md)

## 🔑 The tranche complications are gone

Aurel Mrruku, on the 11:22 client session:

> _"io sono totalmente d'accordo con quello che hanno detto, molto più sereno,
> perché praticamente tutte le complicazioni che avevo previsto non succedono più,
> perché quei beati ordini plus è semplicemente lo stesso prodotto n volte. Non so
> perché l'hanno complicato all'inizio."_

He also found `frazione 1`, `frazione 2`, `frazione 3` written in the client's own
extraction — the shape
[OI-142](../items/OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md)
proposed already exists in their historical data.
→ [OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)

## 🔴 Data migration was never planned

> _"sulla migrazione degli ordini… sinceramente io non avevo messo in piano, non
> avevo calcolato il tempo per la migrazione dei dati. Non sarà una cosa che si farà
> in un giorno."_

And the environment problem on top of it: today's work is in a test org, so
production means moving structures, migrating data, **then** granting access. The
client data is not clean — Aurel Mrruku's concern is **missing links between the
ids**, and the insertion order that would restore them. Elena Spini, of the
extraction: _"fanno cagare"_ — and yet the intent is to demo with real records
rather than test ones, _"perché conoscendo i miei polli, se vedono 'test' si
agitano"_.
→ [OI-165](../items/OI-165%20Data%20migration%20was%20never%20planned%20or%20estimated.md)

## 🟢 The missing WooCommerce UAT session was found and booked

Elena Spini lost the WooCommerce invitation when the dates were rewritten —
_"quando ho mandato gli inviti mi sono persa quello di WooCommerce"_ — and the
client wants to see it, Marco Montesi included. Agreed in this call to **attach it
to Friday 25/09**, using the funnel already used in the 21/09 test. The updated
invitations went out at 16:34–16:35Z.
→ [OI-158](../items/OI-158%20No%20UAT%20session%20is%20booked%20for%20the%20checkout-link%20flow.md)

## Lead demo plan

Rexhina Hysi had already simulated conversion **from Salesforce**; a **Web-to-Lead
form** simulation was planned for the end of 23/09. Both `lead da diretta` and
`lead standard` forms were offered (20 minutes); Elena Spini asked for one only,
since in practice nobody will ever create a Lead by hand — _"idealmente non lo
dovrebbero fare"_. Aurel Mrruku's caveat: showing it from Salesforce
_"non è proprio un test corretto"_.

⚠ Tested at 18:18 CEST and it failed — see
[OI-164](../items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md).

## Scope note

The QR-code misunderstanding was named here in full — see
[the 10:32 session](2026-09-22%20Temi%20QR%20Code%20Biglietti.md). Aurel Mrruku's
scope cut: the app calls Salesforce, Salesforce updates the asset, the campaign
member state follows from the asset by formula, and nothing more.
