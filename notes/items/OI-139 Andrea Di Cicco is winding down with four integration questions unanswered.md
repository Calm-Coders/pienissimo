---
id: OI-139
type: open-item
status: open
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-09-16
updated: 2026-09-21
depends_on: [OI-102, OI-110, OI-125, OI-135]
blocks: [go-live]
requirement: [INT-01, INT-05, INT-13]
source: Slack group DM C0BFDNXQKAS, 2026-09-16 18:01-18:04 CEST
---

# OI-139 - Andrea Di Cicco is winding down with four integration questions unanswered

**ROMI released its Mexal and WooCommerce integration counterpart from the
project on 16 September, while four open items name him as the person who owes
the answer.**

## What was said

Group DM (Aurel Mrruku, Andrea Di Cicco, Elena Spini), 16 September:

> **Andrea Di Cicco, 18:01:39** — _"Ragazzi domani servo al meeting interno su
> Pienissimo?"_
>
> **Aurel Mrruku, 18:03:10** — _"per me no. forse più in avanti per fare un
> check sulle api mexal ma non domani"_
>
> **Elena Spini, 18:04:12** — _"si concordo Andre, in caso ti chiediamo cose
> puntuali per l'integrazione Mexal ma per ora ti puoi lentamente staccare 😥"_
>
> **Andrea Di Cicco, 18:04:54** — _"perfetto thanks"_

⚠ **This is a wind-down, not a departure.** Both ROMI voices leave the door open
for specific Mexal questions later. Nothing says he has left the project or the
company. The finding is not that he is gone — it is that **the door was left
open in general terms while four specific questions were already behind it.**

## What is behind it

| Item                                                                                                     | Owed by him since | State                                                                                                                                                   |
| -------------------------------------------------------------------------------------------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [OI-110](OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md) | **2026-09-02**    | JSON update + test send, outstanding 14 days. The sharpened Kreosoft question has never been asked — **seventh day.**                                   |
| [OI-102](OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)             | **2026-09-08**    | The **filtered** WooCommerce Postman collection, promised 08/09 for "17:00–18:00". **Eighth day.** Sabatino Rinaldi still holds the pre-filter version. |
| [OI-125](OI-125%20Mexal%20customer%20update%20needs%20a%20PUT%20method.md)                               | **2026-09-14**    | Aurel Mrruku's objection — that a full-body PUT may overwrite Mexal's auto-populated fields — **unanswered**.                                           |
| [OI-135](OI-135%20Who%20must%20be%20told%20when%20Salesforce%20starts%20creating%20Mexal%20orders.md)    | **2026-09-14**    | _"per la creazione di un ordine chi devo avvisare?"_ — **unanswered**, asked between two questions he did answer.                                       |

His DM with Aurel Mrruku has carried **nothing since 14/09 17:28 CEST** — two
days silent through the day he was released.

## Why this is worth a row

Three of the four questions are **not answerable by anyone else at ROMI**. They
are questions about the Mexal WEBAPI contract and about Sabatino Rinaldi's
WooCommerce plugin, and Andrea Di Cicco is the only person in this record who
has run either. The fourth — OI-135 — is a question about **who at Pienissimo
must be warned before Salesforce starts writing orders into their live billing
system**, and the order leg is already enqueued on every new Order.

⚠ **The alternative route exists and has never been used.** **Mirko Merendi at
Kreosoft** answered eight questions of exactly this shape in one pass on
11 August. Nothing in this record shows anyone approaching him since.

⚠ **Elisa Migliano said in [Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md)
that Sabatino Rinaldi is unreachable too** — on tour with the client's
direction, with no WhatsApp reply the previous week. So on 16 September **both**
integration counterparts are off the board at once, seven days before UAT opens.

## What a person must do

1. **Extract the four answers before he detaches**, or name who owns each one
   instead. Aurel Mrruku's own words — _"forse più in avanti per fare un check
   sulle api mexal"_ — are the hook; a dated session is not.
2. **Or ask Mirko Merendi at Kreosoft** the OI-110 and OI-135 questions
   directly. They are one message and they have been open 14 and 2 days.
3. **Chase the filtered WooCommerce collection separately** — it is owed to the
   client, not to ROMI, and the sixty-year JWT it authenticates with is still
   unrotated.

## 🔴 2026-09-17 - he declined today's internal, and he is working normally elsewhere

**He declined `[PIENISSIMO] - Follow-up Interno`, 17/09 14:15–15:15 CEST** —
the recurring internal slot, and the meeting Elena Spini named as where the
WooCommerce id question would be settled
([OI-49](OI-49%20WooCommerce%20checkout-link%20flow.md)). ⚠ The decline cannot be
dated: it sits on a recurring series created on 09/07 and this instance was
moved on 16/09. **Do not read it as a fresh act** — read it as the state of the
invitation on the day the questions are still open.

⚠ **He is not unavailable, he is unassigned.** He was active on Slack this
morning, 11:03–11:08 CEST, asking Aurel Mrruku to share a credential vault with
a colleague — for a different client. The wind-down is working exactly as agreed
on 16/09; the problem this row records is that **four Pienissimo answers went
with him and none has been asked since.**

🔴 **There is a fifth question, and it has been drawn on the wall for four
weeks.** The `Flusso Biglietti` page of
[the design diagram](../The%20newest%20design%20diagram.md) carries a yellow
sticky, added 20 August and **still present in the 16/09 version**, reading:

> _"Scadenziario MEXAL - **Check con Andrea** — Capire se da fattura NON pagata
> (Scadenziario) è possibile aggiornare ASSET allo stato prima."_

That is [OI-92](OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md),
addressed to him by name in the project's own design file, unanswered for
**twenty-eight days**. It governs whether the admin-only `Aggiornamento Incasso`
button can work at all.

**So the count is five, not four**, and the cheapest route to three of them is
still Mirko Merendi at Kreosoft, who answered eight questions of the same shape
in one pass on 11 August.

## 🟢 2026-09-17 (evening) - a Mexal session with him is booked for Friday morning

`[PIENISSIMO] - Temi Mexal`, **Friday 18 September 2026, 10:00–11:00 CEST**,
organised by Elena Spini, invitation sent **13:17:39Z**. Invited: **Aurel
Mrruku and Andrea Di Cicco** — nobody else.

This is the _"check sulle api mexal … più in avanti"_ Aurel Mrruku named on
16/09 when he said Andrea Di Cicco was not needed at the internal, and it is
the venue [the 17/09 internal follow-up](../meetings/2026-09-17%20Follow-up%20Interno.md)
deferred the contract-financials API to (`00:51:43`, `00:57:12`).

🔴 **One hour now carries six questions.** OI-110 (agent and network fields on
the Mexal order call), OI-102 (Salesforce endpoint and token for the WooCommerce
plugin), OI-125, OI-135 (who to notify before Salesforce creates a Mexal order),
the twenty-eight-day one named above, and now
[OI-141](OI-141%20Contract%20object%20for%20Performance%20Plus%20orders.md)'s
`scoperto clienti` / `scadenziario` contract. **Only the last is on the
invitation's subject line**, and the older five have no agenda anywhere.

⚠ **Nothing shows anyone has listed them for him.** He was active and
responsive elsewhere today — a 11:03 CEST DM asking Aurel Mrruku to share a
vault with a colleague, and unrelated posts in `#gen-chat-cazzeggio` at 17:55
CEST — so the silence on these six is not unavailability.

## ⚠ 2026-09-21 - the premise has weakened: he has not detached

Andrea Di Cicco attended **two Pienissimo sessions in the 18–21/09 window** and is
on the invitation for a third:

- [the 21/09 Mexal internal](../meetings/2026-09-21%20Interna%20Temi%20Mexal.md),
  45 minutes, where he supplied the answers this row says were owed;
- [the 21/09 client call](../meetings/2026-09-21%20Test%20WooCommerce%20e%20Temi%20Mexal.md),
  where Elena Spini kept him specifically for the Mexal topics;
- **`Test Mexal`, 22/09 15:00–17:00**, with Mirko Merendi and Kreosoft.

So _"lentamente staccare"_ has not happened, and the Mexal questions are being
worked rather than abandoned.

🟢 **What he answered on 21/09:**

- The scadenziario field is **`Data scadenza PG`**, and it is **not** linked to the
  order-line due date — it derives from the payment method. → the whole of
  [OI-143](OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md).
- **Only two outbound APIs exist**: customer and order. An `evasione riga` API
  would create per-line invoices but is **not used**, because invoices are created
  manually.
- **A tranche, to Mexal, is the beginning of an invoice** — _"sarebbe l'incipit
  della fattura"_.

🔴 **What is still owed by him or through him:**

- [OI-110](OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md) —
  `cod_agente` / `zona` / `classificatore rete` have nowhere on the wire. **Not
  touched in either session**, now 19 days.
- [OI-135](OI-135%20Who%20must%20be%20told%20when%20Salesforce%20starts%20creating%20Mexal%20orders.md) —
  unanswered.
- **Whether Mexal accepts n lines for one bundle article**
  ([OI-144](OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)) —
  new, and the 22/09 session is the venue.
- Whether the discount fields travel on the order API
  ([OI-145](OI-145%20Order%20header%20discounts%20are%20removed.md)) — new.

⚠ **A source-custody commitment was made and needs holding.** He may build a
**custom LWC** for the Mexal filtered call; Aurel Mrruku asked him to record which
components so they can be taken into git, and observed that _"in teoria si parte
dalla sandbox e va in produzione e invece qua in Romi non sempre succede."_
