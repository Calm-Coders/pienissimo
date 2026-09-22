---
id: OI-158
type: open-item
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-09-21
updated: 2026-09-22
depends_on: [OI-49]
source: Gmail thread 1a0b563a6c15098c and the six UAT invitations of 2026-09-21
resolution_source: notes/meetings/2026-09-22 Update Interno Aurel Elena.md
---

# OI-158 - No UAT session is booked for the checkout-link flow

Elena Spini's UAT proposal of **18/09 18:39 CEST** listed **seven** topics. The
invitations she sent on **21/09 between 16:43 and 16:53Z** cover **six**.

| Proposed topic                                        | Invitation sent                       |
| ----------------------------------------------------- | ------------------------------------- |
| Lead e Opportunità                                    | ✅ Thu 24/09 15:00–17:00               |
| Preventivi e Firme Digitali (DocuSign)                | ✅ Fri 25/09 10:30–12:30 (`Preventivi`)|
| Gestione Biglietti (Asset), Campagne ed Eventi        | ✅ Wed 30/09 14:00–16:00               |
| Flussi Marketing Cloud                                | ✅ Fri 02/10 10:00–12:00 (`Flussi MKT Biglietti`) |
| **WooCommerce e Link di Checkout (da Opty SFDC a ordine WooCommerce)** | 🔴 **none** |
| Performance Plus + Gestione date pagamento            | ✅ Mon 05/10 15:00–17:00               |
| Integrazione Mexal ↔ Salesforce                       | ✅ Tue 06/10 10:00–12:00               |

The missing one was proposed for **2 October 15:00–18:00**. The 2 October morning
slot went to Marketing Cloud instead, and the afternoon was not booked.

## Why it may be deliberate, and why that is not enough

The WooCommerce flow **was tested end to end with the client on 21/09**, two hours
before the invitations went out, and it passed — see
[the session note](../meetings/2026-09-21%20Test%20WooCommerce%20e%20Temi%20Mexal.md)
and [OI-49](OI-49%20WooCommerce%20checkout-link%20flow.md). A reasonable reading is
that Elena Spini considered it accepted and dropped the session.

🔴 **Nothing says so.** Not the mail, not the call, not the Gemini notes. And:

- **Acceptance is formal and due by 13 October.** A flow with no UAT session has no
  session in which the client signs it off.
- **The 21/09 test was one order, on a zero-price gift article, driven by Sabatino
  Rinaldi himself from his own plugin.** That is a developer integration test, not
  user acceptance by the people who will use it — Fabrizio Paganelli asked his
  recall-list question in that very call and **did not get an answer**.
- **Sabatino Rinaldi is the only client-side person who understands it**, he is
  flat out with the Food event, and the referent has moved to Fabrizio Paganelli.

## Open

- 🔴 **Ask Elena Spini whether the omission is intentional.** If it is, record the
  checkout-link flow as accepted on the 21/09 test and say so to the client. If it
  is not, the slot is 2 October afternoon and it is still free.
- ⚠ **The 2 October morning session clashes for Elisa Migliano**, who told the
  21/09 call _"io il due non ci sono"_.

## 🟢 RESOLVED 2026-09-22 — it was an oversight, and it was booked the same day

Named as an oversight by Elena Spini at
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md),
22/09 14:31 CEST:

> _"quando ho mandato gli inviti dei meeting mi sono persa, perché mi hanno fatto
> cambiare le date, mi sono persa quello di WooCommerce."_

So the seventh topic was **lost when the dates were rewritten**, not dropped on
purpose. Aurel Mrruku's first reaction was that the session was unnecessary —
_"non serve più, abbiamo già fatto l'ordine"_ — and Elena Spini overrode it: the client
wants to see it, **Marco Montesi included**, because he is the tutor who will use it.
_"quello che serve a lui è: per WooCommerce devi avere il bottone, devi sapere cos'è che
si chiamano funnel."_ They agreed to attach it to **Friday 25/09** and reuse the funnel
from the 21/09 test.

🟢 **Done at 16:34–16:35Z.** Two updated invitations went out, and the 25/09 session was
renamed:

| Session | Now covers |
| ------- | ---------- |
| **Thu 24/09 15:00–17:00** `UAT: Lead e Opportunità` | Lead diretta/standard · Opportunità vendita standard + preventivo with DocuSign |
| **Fri 25/09 10:30–12:30** `UAT: Recall Tutor + Bundle` | 🟢 **Opportunità recall tutor >> WooCommerce e Link di Checkout (da Opty SFDC a ordine WooCommerce) + Ordine su SFDC** · vendita standard with Bundle products + preventivo with DocuSign |

Elena Spini posted the **client-validated calendar** to `#tproj-pienissimo` at
22/09 18:37 CEST. The 6 October Mexal session also picks up **Anticipay (per check
P.Iva)**, and per the 11:22 client call it stretches to **10:00–13:00** to fold in a
WooCommerce walk-through as well.

⚠ **The 1 October slot is gone**, as Fabrizio Paganelli asked on 21/09 — it is a public
holiday in San Marino. His written request for **3 or 4 October** was not taken up (both
are a weekend) and, as of this sweep, **still has no written answer**; the calendar
simply omits 1 October. The remaining dates are unchanged: 30/09 Biglietti, 02/10 Flussi
MKT, 05/10 Performance Plus + date pagamento + **Contratto**, 06/10 Mexal + Anticipay.

🔴 **What the booking does not fix**: the flow reaching UAT is the one proved on 21/09
against **a zero-price gift article**, with products lacking a SKU and SKUs absent from
Salesforce still unresolved
([OI-49](OI-49%20WooCommerce%20checkout-link%20flow.md)). And **Contratto is on 5 October
with nothing built** —
[OI-168](OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md).
