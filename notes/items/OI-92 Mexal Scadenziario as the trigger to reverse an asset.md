---
id: OI-92
type: open-item
status: open
owner: Andrea Di Cicco
org: ROMI
raised: 2026-08-20
updated: 2026-08-20
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

In English: **can an *unpaid* invoice in Mexal's _scadenziario_ (the payment
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
