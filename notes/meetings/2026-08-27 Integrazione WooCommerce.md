---
id: MTG-2026-08-27-woocommerce
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-08-27
updated: 2026-08-27
source: meetings/2026-08-27-integrazione-woocommerce-transcript.it.md
---

# 2026-08-27 Integrazione WooCommerce

**Client-facing session, 27 August 2026, 10:00–10:48 CEST, 48m20s.** Gemini
notes, **full transcript** and a recording all exist and were recovered. It is
the technical session
[OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md) has been waiting
for since 31 July, and the fourth post-Ferragosto restart meeting. A second,
hands-on session ran the **same afternoon** —
[2026-08-27 Test Integrazione WooCommerce](2026-08-27%20Test%20Integrazione%20WooCommerce.md).

**Present:** Elena Spini (chair), Aurel Mrruku, Andrea Di Cicco (ROMI);
Sabatino Rinaldi, Fabrizio Paganelli, Elisa Migliano (Pienissimo).
`amministrazione@pienissimo.com` was invited. Speaker labels in this transcript
are readable and the attributions below are from the transcript, not the
auto-summary.

## The decision that settles the architecture

🟢 **WooCommerce writes into Salesforce. Salesforce does not poll WooCommerce.**

The direction had been recorded as "webhook, ROMI recommends it" since 6 August
but never tested against what WooCommerce can actually do. It was tested live in
this session and the answer is sharper than "webhook":

- **Standard WooCommerce webhooks were evaluated on screen and rejected.** The
  admin UI allows **one topic per webhook and no multi-select**, and gives no
  control over the body: _"non è che mi fa fare una multiselection, mi fa fare
  solo una selezione"_ (Sabatino Rinaldi). A stock webhook would push **every
  order in every state** and could not carry the customer structure at all.
- **The agreed mechanism is a custom WooCommerce/WordPress plugin using a PHP
  action hook on the order status transition**, composing its own JSON body.
  Aurel Mrruku read WooCommerce's own guidance aloud during the call: it advises
  against the stock webhook for exactly this reason and recommends a small
  plugin whose action inspects the order state.

⚠ **This supersedes the mu-plugin described in
`Integrazione_Salesforce_WooCommerce.docx`.** The client-side component is now
Sabatino Rinaldi's own plugin, written and maintained by Pienissimo, not a
snippet ROMI specifies. Recorded at
[the WooCommerce order integration](../flows/The%20WooCommerce%20order%20integration.md).

⚠ **The pre-existing design was Sabatino Rinaldi's platform *pulling* from
WooCommerce on a cron.** Asked how his current Pienissimo platform learns that
an order has moved to "in lavorazione", he answered: _"ho un [cron] che ogni tot
di minuti va a controllare che è un sync"_. Aurel Mrruku named the consequence —
_"è un processo asincrono, non un processo sincrono"_, and the call goes from
his platform **to** WooCommerce, the wrong way round for Salesforce, which has
no order to poll for. That exchange is what produced the ruling above.

## The three scenarios, stated by the client and approved

Elena Spini set out the operating cases the payload must serve. Aurel Mrruku
restated the end-to-end flow and Elena Spini approved it aloud (_"A me torna"_).

| # | Case | What Salesforce must receive |
| - | ---- | ---------------------------- |
| 1 | Customer **not** known to Salesforce | full company anagrafica **+** contact **+** what is being bought |
| 2 | Account and contact **already** exist | the order only |
| 3 | **Recall-tutor** opportunity | a Salesforce-generated link carrying the **Opportunity id**, which comes back on the order |

Scenario 3 is [OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md)
end-to-end: Salesforce creates an opportunity of a given type → it generates an
email carrying a link with the opportunity id → the customer clicks through to
the WooCommerce cart → on the order reaching the trigger state the plugin pushes
the order, with the opportunity id, to Salesforce. Scenarios 1 and 2 are the
same mechanism **without** the first leg.

## Payload shape agreed

Three sub-structures in one JSON body — **order**, **customer**, **order
lines** — with Aurel Mrruku doing the wrapper mapping on the Salesforce side.
Andrea Di Cicco asked whether to split it into one webhook for the customer and
one for the order; Aurel Mrruku's answer was that the cost is the same either
way (_"non è che cambia tanto avere due rapper complessi oppure avere un rapper
gigantesco"_) but that a single call means a single point of failure to trace.
It resolved in practice to **one payload carrying all three**, which is what
the afternoon session then demonstrated.

## The client's own escalation

🔴 **Fabrizio Paganelli: the test set must include the "vendita da palco".**
Unprompted, at the close of the meeting. WooCommerce is used *heavily* for stage
sales — the customer in the room scans a QR code and buys — and the amounts are
of a different order to the e-commerce baseline: _"se ci blocchiamo su una
vendita di un libro o di uno stream che costa €97, pazienza. Ma se ci blocchiamo
su una vendita da palco che magari sono in gioco anche €8.900 €900 o più, dopo lì
diventa un problema grosso."_ He added that a stage sale **triggers downstream
mechanisms including contract generation**. Recorded as
[OI-101](../items/OI-101%20Stage%20sales%20must%20be%20in%20the%20WooCommerce%20test%20set.md).

## Raised and not yet owned

🔴 **Andrea Di Cicco: the WooCommerce and Mexal field sets must be merged before
either is built.** _"dovremmo fare un attimo il un merge di quelle che sono le
informazioni che arrivano da WooCommerce, quelle che arrivano su Mexal onde
evitare di creare 12.000 campi e ridurre il numero di campi."_ Nobody picked it
up and it is in neither meeting's next steps. Recorded as
[OI-103](../items/OI-103%20WooCommerce%20and%20Mexal%20field%20overlap.md).

## What did not happen

🔴 **The WooCommerce credentials were not exchanged.** The calendar invitation
for this session promised _"integrazione tecnica con WooCommerce tramite
Webhook, comprensiva dello scambio di credenziali"_, and they have been on the
owed list since 14 July. They were never raised. The session's own outcome
partly explains why — with WooCommerce pushing rather than Salesforce pulling,
the credential that matters is now the **Salesforce** endpoint and token, which
ROMI owes Pienissimo
([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).
Whether Salesforce still needs WooCommerce CK/CS for a read-back is **not
settled** — see the flow note.

## Context from Slack the same morning

The ROMI group DM `C0BFDNXQKAS` runs alongside this call. Elena Spini posted the
link to `Integrazione_Salesforce_WooCommerce.docx` at 10:08 CEST; Andrea Di
Cicco replied _"ma io non l ho mai visto sto documento XD"_ and, a minute later,
_"io sto andando a braccio"_. Elena Spini: _"queste sono le casistiche io non so
manco cosa sia sto webhook"_. The document has been in the Slack canvas since
31 July. Not a decision, but it explains why the session re-derived an
architecture the spec already proposed.
