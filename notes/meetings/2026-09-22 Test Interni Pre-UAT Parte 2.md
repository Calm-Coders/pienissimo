---
id: meeting-2026-09-22-test-interni-pre-uat-parte-2
type: meeting
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-22
updated: 2026-09-22
source: Drive transcript doc 17eFiD68p53ElcBG8WyXT3ji9NZNNqPJBoq3HD4zQIpc (read in full)
---

# 2026-09-22 Test Interni Pre-UAT Parte 2

**ROMI only, 1h06m41s, 22/09 17:00 CEST.** Aurel Mrruku, Anita Aga, Elena Spini.
**Rexhina Hysi absent** — on another client's work; Aurel Mrruku:
_"Regina is working on banca etica, let's go without her."_ Second of the internal
pre-UAT walkthroughs, **two days before UAT opens.**

## 🟢 The quote-to-order chain ran end to end, live

Quote created → PDF generated → sent → **DocuSign signature** → signed document
returned → quote moves to `Accettato` → **the order is created automatically**,
with the same line items. Verified in the integration log in the same session.

⚠ Caveats recorded as observed:

- The signature request mail **arrives from Anita Aga's own user** — it is the demo
  DocuSign environment and her user is the sender. A production swap is still owed.
- Salesforce ends up holding **both an unsigned and a signed preventivo**. Agreed:
  **delete the unsigned one** once the signed copy returns. The quote itself is
  never deleted, _"you need to know from where everything has started"_.
- The PDF has a **near-blank page** Elena Spini spotted; assigned to Rexhina Hysi.
- The contract body is **not worked on at all**: _"we haven't worked on the content
  of the DocuSign"_. The client must say **where the signature and the date go**,
  and supply the field values. Elena Spini has worked examples in the documents the
  client provided.

## 🔴 A new mandatory rule was built during the session

Aurel Mrruku, on the Lead:

> _"now we are going to make a field on the lead that is going to be `agente` that
> is going to be connected with the user, and **you can't convert a lead without
> having an agente on the lead**, cause you can't create an account without an
> agent."_

and immediately after: **_"he said he's going to think about it, but I'm putting it
right now, so I don't forget it."_**

⚠ So a **conversion-blocking validation** is being implemented while the client is
still deciding. It follows from
[OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md),
agreed two hours earlier, but the agreement was that the agent belongs to the
customer — not that a Lead cannot convert without one.

## 🟢 Performance Plus, as agreed that morning

The **tranche count on the product** drives it: pick the product, the number of
tranches is read from the product, `crea tranche` generates the named rows
(`1 di 2`, `2 di 2`…) and the user fills the due-date grid. Quantity is locked; the
price comes from the product. Built the same day it was agreed.
→ [OI-167](../items/OI-167%20Plus%20orders%20explode%20from%20a%20tranche%20count%20on%20the%20product.md)

Also settled in passing:

- Quote **expiration defaults to +5 days**, editable by the tutor when the event is
  close — consistent with the register's `quote` rule "Validity 5 days".
- Performance Plus **service start and end dates** default to the end of next year,
  with users trained to correct them; the client confirmed there is no two-year
  case.
- Record types must be extended to **all quote and opportunity types**.

## 🔴 Bundle pricing is incomplete in the build

- **No `PricebookEntry` is created for a bundle product.** Aurel Mrruku:
  _"I have missed this one"_ — and he will automate it, because otherwise a quote
  cannot price the bundle.
- The bundle header must carry **`totale bundle` and `totale listino prodotti`**;
  the components carry prezzo listino, prezzo unitario and a **prezzo manuale**,
  and the parent price is hidden from the client — matching the weighted-spread
  ruling of the morning
  ([OI-144](../items/OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)).
- A filter currently **prevents adding the same product twice** to a bundle; to be
  lifted, because in practice a line is sometimes repeated at price zero.
- Selecting a second bundle **silently replaces the first**.

## 🔴 Anticipay is built but switched off

The flow exists and is **deactivated**; the P.IVA check must become **mandatory on
account creation, on the trigger side**. Anticipay is on the **6 October** UAT
agenda per Elena Spini's calendar post.

## 🔴 Contract logic has not been started

Elena Spini asked directly. Aurel Mrruku: _"No, we haven't even started with it…
I haven't even started thinking about it."_ Plan for UAT: show the opportunity
logic for `Plus attivazione/rinnovo` and tell the client the contract comes after
the order. **`Contratto` is on the 5 October UAT agenda.**
→ [OI-168](../items/OI-168%20Contract%20logic%20is%20not%20started%20and%20is%20on%20the%205%20October%20UAT.md)

## Plan for the first two UAT sessions

- **24/09** — Lead, vendita standard, **WooCommerce** (not bundle). Two hours, and
  both expect it to overrun: _"they are going to spend a lot of time on
  preventivi."_
- **25/09** — Performance Plus, and the bundle if it is ready.

## Housekeeping

- The **Pienissimo logo** will be added as a static resource by ROMI, not by Elena
  Spini.
- `Integration Log` to be exposed as a tab inside the app.
- Tomorrow (23/09): **import the client's accounts, delete the test ones**, and send
  the **first order from Salesforce to Mexal**.

⚠ **Attribution caveat**: the transcript renders Rexhina Hysi as "Regina" and Anita
Aga as "Anna" / "Ana", as on 17/09 and 21/09. No test email address, account name or
P.IVA from the session is reproduced here.
