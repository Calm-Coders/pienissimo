---
id: meet-2026-09-17-follow-up-interno
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-09-17
updated: 2026-09-17
depends_on: [OI-49, OI-50]
blocks: [OI-140, OI-141, OI-142]
source: Drive - "[PIENISSIMO] - Follow-up Interno - 2026/09/17 14:15 CEST - Appunti di Gemini" (10y9rumBvGVk4mruOZXi1JT3pJBP-vnSPWpKeCpl5AG4)
---

# 2026-09-17 Follow-up Interno

**ROMI-internal, 17 September 2026, 14:15 CEST, booked for one hour and ran at
least 1h22m** — the transcript's last timestamped heading is `01:21:47` and the
Gemini notes document was created at 16:05 CEST. **No client attended.**

This is the session the 17/09 nightly run could not see: it began twelve minutes
before that sweep executed and produced its artifacts afterwards.

## Who was there

| Person                 | In the session                                                        |
| ---------------------- | --------------------------------------------------------------------- |
| **Aurel Mrruku**       | ROMI, 388 transcript turns — set the Salesforce shape                 |
| **Elena Spini**        | ROMI, 381 turns — ran the session and carried the client's positions  |
| **Fabrizio Mastracci** | ROMI marketing automation, 83 turns — Meta/WhatsApp and the flows     |
| **Andrea Di Cicco**    | **invited and declined** (struck through on the invitation)           |

⚠ **No Pienissimo attendee.** Everything below is a **ROMI position**, not a
client agreement. The notes themselves say the order constraints are _"in attesa
della validazione finale con il cliente nella call di venerdì"_.

## What was agreed (ROMI-side)

From the notes' own `Concordato` block, each traceable to a timestamped passage.

### 1. Data Cloud is bypassed for the ticket flows

Flows are fed **directly from the `event invitation` object**, not through Data
Cloud. Fabrizio Mastracci raised duplicate records for unified persons and the
slowdown they cause; Aurel Mrruku agreed, on the grounds that the token already
joins Account and Campaign so the filter can be applied directly
(`00:12:10`, `00:11:02`). Fabrizio Mastracci will build custom tables with
`datagraph` (`00:13:15`).

### 2. Rinuncia is blocked once an asset has been filled in

Selecting `rinuncia` cancels every associated event; but **once an asset has
been compiled, rinuncia is no longer available for that ticket**. Aurel Mrruku
stated the logic, Elena Spini agreed (`00:14:41`).

### 3. Three Opportunity record types, chosen at creation

`recall tutor` · `vendita standard` · `offerta plus attivazione/rinnovo`, split
so that mixed product sets can be handled correctly (`00:25:26`). In the
transcript Aurel Mrruku frames them as the order typologies — _"Bundle standard
oppure plus"_ — and names the problem they solve: _"come capirò io che recall
tutor l'ordine che ha creato il tizio da WooCommerce è un ordine bundle? È un
ordine standard o un ordine plus? Perché all'inizio avevamo detto che tutti gli
ordini che sono recall tutor sono ordini bundle. Ieri però hanno detto
un'altra cosa."_ → [OI-140](../items/OI-140%20Three%20Opportunity%20record%20types.md)

### 4. A bundle product locks the rest of the order

Inserting a bundle product (`recall tutor` or `offerta plus`) raises a **hard
constraint** that prevents further products being added to the same order
(`00:28:26`, `00:33:19`). For orders arriving **from WooCommerce the client side
must transmit the order type via API** (`00:29:31`). ⚠ The constraint is
explicitly **held pending client validation on Friday** (`00:31:21`).

### 5. High-value products are split in the product registry for tranches

Rather than build a tranche mechanism, **fractional product records** are created
in the anagrafica — halves, thirds, quarters of the expensive courses — each tied
to its Mexal invoice (`00:34:58`). Elena Spini approved and proposed taking it
straight to the client (`00:38:21`). → [OI-142](../items/OI-142%20Fractional%20product%20records%20for%20tranche%20payment.md)

### 6. A Contract record is created automatically for Plus orders

When a **Performance Plus** or **attivazione/rinnovo** order is generated, a
linked **Contract** object is created automatically (`00:40:30`, `00:47:16`) to
carry state, total value, invoiced amount and collected amount.
→ [OI-141](../items/OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)

## Left open, by the notes' own `Da approfondire` block

- **The Mexal API contract for the contract financials** — invoiced, collected
  and `scoperto clienti` — is deferred to **a session with Andrea**
  (`00:51:43`, `00:57:12`). That session is now booked: see below.
- **Instalments as separate order lines, and how they reach Mexal**, needs a
  joint check with the referents.

## Other statements worth keeping

- **Tranches are represented as separate order lines** carrying the **same
  product code with the price divided**, with **start and end dates entered by
  hand for each tranche**, for the calculation and for the send to Mexal
  (`01:15:36`). → [OI-50](../items/OI-50%20Tranche%20object.md)
- **The freeze was restated a fourth time**: after acceptance both the quote and
  the order are frozen and no longer editable (`01:11:11`). The contract data
  model and its activation field are **not** yet defined.
  → [OI-138](../items/OI-138%20Quotes%20and%20orders%20freeze%20once%20the%20order%20is%20accepted.md)
- **Contract dates are entered manually.** The signature date does not coincide
  with the start of service, so the operational team (_"user strategies"_ /
  _strategist_) enters start and end dates through a banner on the order
  (`00:55:19`, `01:11:11`).
- **There is still no definitive product-code file.** Elena Spini: only about
  2,000 sample codes and a further set of ~200 products have been sent, so which
  product code triggers contract generation has to be driven by a dedicated
  parameter instead (`01:04:06`). ⚠ This is the same gap as the **article codes
  owed by the client**.
- **One PDF at offer level** carrying quote, contract and general conditions
  (`01:05:41`); quote templates are distinguished per product family —
  *Performance Plus*, *Pienissimo Pro* (the notes read _"Pianissimo Pro"_) and
  *Duomo*, the last covering most tutor sales (`01:06:59`).
- **Meta / WhatsApp configuration** for digital engagement is being set up by
  Fabrizio Mastracci through Marketing Cloud; it needs a Meta account with
  two-factor authentication (`00:00:00`). ⚠ **WhatsApp sends consume significant
  credits** and both Elena Spini and Aurel Mrruku flagged that as needing
  evaluation (`00:02:45`).
- **A Food Marketing Festival ticket-generation mail from Rebecca Marmo**
  reached Fabrizio Mastracci only, three days earlier. Elena Spini decided to
  fold that step into the flow while noting _"ce lo devono dire loro, non è che
  me lo invento io"_ (`00:02:45`). He is to forward the thread.

⚠ **Values not recorded here.** The session quoted catalogue prices for the
high-value courses and an order value for Performance Plus. Per
[docs/publishing.md](../../docs/publishing.md) none of them is copied into this
repository; the shape of the problem is recorded, the numbers are not.

## Next steps, as minuted

| Owner                              | Action                                                                  |
| ---------------------------------- | ------------------------------------------------------------------------ |
| Fabrizio Mastracci                 | forward Rebecca Marmo's Food Marketing Festival ticket thread            |
| Elena Spini                        | put the system tests in the calendar — **done the same afternoon**       |
| Aurel Mrruku                       | share the object/record/community-link detail with Fabrizio Mastracci    |
| Fabrizio Mastracci                 | draft an operational spec from it                                        |
| the group                          | Monday operational session, 16:00–18:00, with Anita Aga and Rexhina Hysi |
| Aurel Mrruku                       | send Elena Spini the files and links for the blueprint document          |
| the group                          | present the built features to the client on **Friday's call**            |
| Elena Spini, Aurel Mrruku, Andrea  | settle the contract-creation flow and the Mexal data for Plus orders     |
| Aurel Mrruku                       | build the Plus order template and the tranche split in the quote flow    |
| Elena Spini                        | review Elisa Migliano's documents for completeness                       |

⚠ The notes render Anita Aga as _"Anita" / "Ana"_ and Rexhina Hysi as
_"Regina"_. Both are Gemini transcription artifacts of ROMI developers on this
project; the identification is **inferred from the invitation to the Monday
session**, which names `a.aga@romicompany.com` and `r.hysi@romicompany.com`.

## What it booked

Three calendar actions followed within four hours, all from Elena Spini:

| Event                                       | When                              | Who                                     |
| ------------------------------------------- | --------------------------------- | --------------------------------------- |
| `[ROMI-PIENISSIMO] - Test Interni Pre-UAT`  | **Mon 21/09, 16:00–18:00 CEST**   | Aurel Mrruku, Rexhina Hysi, Anita Aga   |
| `[PIENISSIMO] - Follow-up Interno`          | Mon 21/09 17:00–18:00 — **cancelled**, _"Annullo per altro meeting"_ | — |
| `[PIENISSIMO] - Temi Mexal`                 | **Fri 18/09, 10:00–11:00 CEST**   | Aurel Mrruku, **Andrea Di Cicco**       |

🔑 **`Temi Mexal` is the alignment with Andrea the notes deferred to**, and it is
the first booking that puts [OI-139](../items/OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md)'s
counterpart back in a room before he detaches.
