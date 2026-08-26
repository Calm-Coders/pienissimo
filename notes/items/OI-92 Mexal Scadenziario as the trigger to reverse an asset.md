---
id: OI-92
type: open-item
status: in-progress
owner: Andrea Di Cicco
org: ROMI
raised: 2026-08-20
updated: 2026-08-26
depends_on: [OI-50, OI-91]
uncertain: who raised it; the diagram carries no attribution beyond the name Andrea
source: Drive - Flows & Objects.drawio, modified 2026-08-20T15:36:24Z
---

# OI-92 - Mexal Scadenziario as the trigger to reverse an asset

A question written onto the master design file on **20 August 2026**, as a
yellow note placed beside the `Aggiornamento Incasso` button on the
`Flusso Biglietti` page. Verbatim:

> **Scadenziario MEXAL - Check con Andrea**
> Capire se da fattura NON pagata (Scadenziario) è possibile aggiornare ASSET
> allo stato prima

In English: **can an _unpaid_ invoice in Mexal's _scadenziario_ (the payment
schedule / aged-receivables ledger) drive an Asset back to its previous
state?**

It is the **last cell in the file** and is not present in
[the 19 August standalone drawing](../The%20ticket%20flow%20diagram%20of%2019%20August.md),
so it was added on 20 August. Nothing else accompanies it — no recording, no
message, no minute.

## Why it is its own item

[OI-91](OI-91%20Aggiornamento%20Incasso%20button.md) is a **manual** admin
button that reverses `Disponibile → Ordinato` when a payment was booked against
the wrong tranche. This asks whether the **same reversal can be driven
automatically from Mexal** instead — a payment that turns out not to have
arrived, rather than one filed in the wrong place.

That is a different mechanism with different consequences:

- it makes the reversal an **integration behaviour**, not an admin action, so it
  lands in the Mexal contract rather than in a Salesforce button;
- it needs the **tranche object**, which
  [OI-50](OI-50%20Tranche%20object.md) records as **not built at all**;
- it reverses [OI-75](OI-75%20Ticket%20availability%20rule.md)'s release rule
  from the invoice side, so a released ticket could be un-released by an
  external system.

## Who and when

**Andrea** is almost certainly **Andrea Di Cicco** (`a.dicicco@romicompany.com`,
ROMI) — he is a guest on the **26 August** Mexal review below, and no other
Andrea appears in the project records. ⚠ The diagram gives only the first name;
treat the identification as probable, not confirmed.

There is now a forum for it: **`[ROMI-PIENISSIMO] - Review Temi Integrazione
Mexal`, Wednesday 26 August 2026, 16:00–17:00 CEST**, Google Meet, organised by
Elena Spini, invitation sent 20 August 14:48 UTC. Guests: Aurel Mrruku
(attendance optional), Andrea Di Cicco, `amministrazione@pienissimo.com` and
Fabrizio Paganelli. **This is client-facing** and the first Mexal session since
14 July.

**Ask it there, and get the answer minuted** — the question was raised in a
drawing on the same afternoon the meeting was called, which is unlikely to be a
coincidence.

Related: [the Mexal integration](../flows/The%20Mexal%20integration.md) if the
answer changes the contract, and
[the newest design diagram](../The%20newest%20design%20diagram.md) for where the
note sits.

## 2026-08-24 - it came from Fabrizio Paganelli, and it is now Andrea Di Cicco's

This item was raised from an undated sticky note in the design file. Two
recovered minutes now supply its provenance and its status.

**[20 August](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) — it is Fabrizio Paganelli's proposal.** In the client asset
session he offered it as the alternative to Elena Spini's manual button
([OI-91](OI-91%20Aggiornamento%20Incasso%20button.md)): compare the **Mexal
scadenziario** between yesterday and today, detect the discrepancy, and correct
ticket availability automatically.

**Decision at that meeting: taken to Andrea Di Cicco** as ROMI's Salesforce/Mexal
flow owner, with Fabrizio Paganelli to brief him beforehand on the **three-level
hook — ordine → fattura → scadenziario**. So the sticky's _"Check con Andrea"_ is
a minuted action, not a loose thought.

**[24 August](../meetings/2026-08-24%20Follow-up%20Interno.md) — it advanced but did not land.** The Follow-up Interno
confirmed the scadenziario as the mechanism that lets Salesforce realign an
asset's state when an invoice changes, and
[the integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md) lists **scoperto cliente (Scadenziario)
as a GET endpoint**, which makes it technically reachable rather than
hypothetical.

**Still not answered** is the question the sticky actually asks — whether an
**unpaid** invoice in the scadenziario can drive an asset _backwards_ to its
previous state. Andrea Di Cicco holds the open action to work out the
invoice-to-order-line link, which was named as the hard part and is unresolved.

It remains the natural question for the **26 August client Mexal review**, where
Fabrizio Paganelli is an invitee.

## 2026-08-26 - the endpoint is confirmed on the wire

[The Postman collection](../The%20Mexal%20Postman%20collection.md), read on
26 August, contains a working request against
**`https://services.passepartout.cloud/webapi/risorse/scadenzario/ricerca`** —
`POST`, with the standard `{"filtri":[{"campo":"data_ult_mod",…}]}` delta body.

That moves the scadenziario from _"listed as a GET endpoint in the workbook"_ to
**a call Andrea Di Cicco has actually configured**. The mechanism this item asks
about is reachable.

⚠ **It confirms the endpoint, not the semantics.** The collection saves **no
responses**, so nothing here shows what the scadenziario returns for an
**unpaid** invoice, or whether that state is distinguishable in a way that could
drive an Asset backwards. The question the sticky note actually asks is exactly
as open as it was on 20 August.

⚠ Note also that two _other_ requests in the collection are mis-pointed at this
same endpoint (`Ricerca Ordini Clienti`, `Ricerca Indirizzo di spedizione`), so
its presence three times over is a copy-paste artefact rather than three
deliberate uses. Only `Ricerca Scadenziario` is the real one.

**Still the natural question for today's 16:00 client review**, where Fabrizio
Paganelli — who proposed the mechanism on 20 August — is an invitee.
