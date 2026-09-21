---
id: meeting-2026-09-21-test-woocommerce-temi-mexal
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-21
updated: 2026-09-21
source: Gemini notes doc 1acjJ_7S85bK2UzcL1_DY5llLhjtYFkdnWWsybrOC1QQ (read in full)
---

# 2026-09-21 Test WooCommerce e Temi Mexal

**Client-facing, 42m51s, 21/09 16:00 CEST.** Elena Spini, Aurel Mrruku,
**Sabatino Rinaldi** (left ~`00:33`), **Elisa Migliano**, **Fabrizio Paganelli**
(joined ~`00:11`, **pulled away at `00:37`**), **Andrea Di Cicco**. Booked as a
30-minute WooCommerce test and extended to an hour in two invitation updates to
add the Mexal topics.

## The WooCommerce order flow works end to end

🟢 🔑 **An order was created on WooCommerce, transmitted to Salesforce, and linked
to its Opportunity.** First attempts failed; the cause was **products with no SKU
and SKUs that do not exist in the Salesforce instance** — the plugin surfaced
_"Salesforce ordine non inviato. Prodotti senza SKU"_ (`00:18:33`). Aurel Mrruku
supplied working article codes, Sabatino Rinaldi updated the product record on the
plugin and re-sent, and the order arrived with its order id and a correct
`OpportunityId` (`00:25:51`).

⚠ Two details of the successful test:

- The article that worked is a **zero-price gift record** in Salesforce, which
  Aurel Mrruku identified as such while testing. So the green path ran on a
  giveaway article, not a priced one. **No price or article-code value is
  recorded here.**
- At `00:27:18` Aurel Mrruku suspected the plugin was sending a **stale
  opportunity id** — _"Questo è un vecchio opportunity. Non la stai prendendo in
  modo dinamico, mi sa"_ — then compared the ids and confirmed they matched.
  **Checked and cleared in-session**, not an open defect.

🔑 **Sabatino Rinaldi explained the mechanism to the rest of the client team**
(`00:29:31`), and it is the anatomy agreed on 18/09:

> _"il collegamento non è più andare a prendere il prodotto e di conseguenza l'ID
> del prodotto […] ma è direttamente da dove noi facciamo il carrello"_

The link binds the **cart (funnel)** to the **Opportunity**. Marketing
communicates the funnel name whenever a cart is built; the tutor then puts
whatever products they like into that cart. Stated benefit: any product, any
moment, one link — and it dissolves last year's ODP Live streaming problem.

**Agreed (decisions block):** _"I link dei carrelli per le attività commerciali
vengono associati direttamente alle opportunità di Salesforce anziché ai singoli
codici prodotto."_
→ [OI-49](../items/OI-49%20WooCommerce%20checkout-link%20flow.md)

🔴 **Fabrizio Paganelli's recall question is unanswered.** He asked how the list of
customers to call is produced — of 50 people in the room, two bought, the other 48
need calling (`00:31:05`, `00:32:23`). **Sabatino Rinaldi: that is separate
contact management, unrelated to the cart mechanism.** Nothing owns it, nothing
builds it.

🔴 **Article-registry hygiene.** Fabrizio Paganelli noted the registry carries a
great many superfluous codes that ought to be cleaned — but **if historical
movements are imported there would then be no code to reference them by**
(`00:20:35`, `00:22:25`). Aurel Mrruku has _"un po' di domande"_ after reviewing
the anagrafica with him. This is the
[article-code risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md)
restated by the client.

⚠ Sabatino Rinaldi has **built his own WordPress plugin**, with a _"verifica
connessione a Salesforce"_ button; the connection succeeded and the token was
obtained (`00:17:02`). This supersedes the mu-plugin `v1.0.0` the 31/07 spec still
specifies.

## Mexal — agreed, then cut off

🔑 **Agreed (decisions block):** _"La generazione delle fatture e delle relative
date di fatturazione su Mexal viene eseguita manualmente in prima istanza."_
Fabrizio Paganelli confirmed it: **_"L'importante per noi è che arrivino gli
ordini su Mexal, poi dopo alla fattura ci pensiamo noi."_** (`00:34:19`)

The three order types were restated with Andrea Di Cicco: standard with n
products each having an item, bundle, and plus / rinnovo-attivazione.

🔴 **Aurel Mrruku put the consequence on the table and did not get to finish.** At
`00:35:39` he explained that platform users will have to **enter the tranche's
invoice date by hand in Salesforce**, because otherwise there is no way to
reconcile the invoices received from Mexal, via the scadenziario, against the
tranche — and that a mistyped date breaks the reconciliation.

⚠ **At `00:37:11` Fabrizio Paganelli was called into another meeting by Daniela
Morgese and left**, agreeing to resume by phone. Elena Spini insisted on
reconvening in the same call rather than one-to-one, _"se poi parliamo solo io e te
non sono allineati tutti"_. **No artifact in this sweep shows that resumption
happening.** So the manual re-keying obligation
([OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md))
**is still not agreed with the client.**

## UAT dates resolved

🔑 **1 October was rejected** — it is a San Marino national holiday, the festa di
San Marino and the cambio della reggenza — **and 3 and 4 October were rejected
because they fall on the weekend** (Elisa Migliano: _"È sabato e domenica"_)
(`00:38:31`). **2 October was agreed** with Elisa Migliano in the room
(`00:39:21`).

⚠ **Fabrizio Paganelli had asked in writing for 3 or 4 October**, and he had
already left the call when this was decided. Elena Spini's reply to his mail says
only _"inviti mandati"_. **The client's written request was declined without a
written explanation**, and the reasoning exists only in this transcript.

⚠ **Elisa Migliano is not available on 2 October** — _"io il due non ci sono"_ —
and the 2 October afternoon is the marketing-flows session. She asked for Rebecca
Marmo and Sabatino Rinaldi on it, with herself and Fabrizio Paganelli added
anyway.

**Participants agreed** (`00:40:14`): Elisa Migliano and Fabrizio Paganelli
standard on everything; Rebecca Marmo and Sabatino Rinaldi rotating; **Marco
Montesi on lead, opportunity and quotes**; Rebecca Marmo on asset and marketing.
Elena Spini chooses the hours because the client expressed no preference.

⚠ **30 September is immediately after the Riccione event** (28–29). Elisa
Migliano flagged the state they will be in and confirmed they will attend anyway.

## QR code

Elisa Migliano is to get a slot from **Andrea Parmeggiani** — Sabatino Rinaldi
confirmed the address is the `pienissimo.pro` one — for the ticket QR-code topic;
agreed for the following morning 10:30–11:00 (`00:03:09`, `00:05:11`). ✅ The
`Temi QR Code Biglietti` invitation went out 21/09 14:17:51Z for 22/09 10:30.
This is the scan-app integration Elisa Migliano was asked to chase at
[Data Model Parte 6](2026-09-18%20Data%20Model%20Parte%206.md).

⚠ **Three different Andreas now appear in this project**: Andrea Di Cicco (ROMI),
**Andrea Parmeggiani** (Pienissimo Pro, the scanning counterpart) and the "Andrea
G." of the older status posts. The transcripts garble them freely.

## Action items

| Owner              | Action                                                       |
| ------------------ | ------------------------------------------------------------ |
| Elisa Migliano     | Get a QR-code slot from Andrea Parmeggiani ✅ booked 22/09    |
| Elena Spini        | Send the UAT calendar invitations by the evening ✅ done      |
| Fabrizio Paganelli | Phone Elena Spini after his other meeting to resume Mexal ⚠ no artifact shows it happened |
