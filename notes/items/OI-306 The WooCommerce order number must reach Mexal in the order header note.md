---
id: OI-306
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-30
updated: 2026-11-04
depends_on: []
blocks: []
source: notes/meetings/2026-10-30 Connessione WooCommerce.md
---

# OI-306 - The WooCommerce order number must reach Mexal in the order header note

**The client wants the WooCommerce order number printed on the Mexal document so
that an order can be matched when it is invoiced. The carrier is the Mexal order
header note. Kreosoft named the field the same afternoon; the work is estimated at
half an hour and is not done.**

## The request

Fabrizio Paganelli, in [the 30 October WooCommerce call](../meetings/2026-10-30%20Connessione%20WooCommerce.md):
put the **WooCommerce identifier — the order number — inside the documents printed
from Mexal**, to make the match straightforward **at invoicing time**. Aurel Mrruku
located the reference field and agreed the value should be stored in **an order
note field**.

## The field, from Kreosoft

Fabrizio Paganelli asked Mirko Merendi by mail, Gmail `1a18d5dc165b3e23`,
**2026-10-30 15:11:33Z**, cc Aurel Mrruku and Elena Spini:

> _"avremmo bisogno di sapere il codice del campo Note di Testata su Ordini"_

Mirko Merendi answered in **four minutes**, Gmail `1a18d62bf46e4358`,
**15:15:33Z**:

> _"il campo si chiama **nota** lato API."_

🔑 **So the Mexal API field for the order header note is `nota`.** That is an API
contract fact, from the vendor, in writing — the same standing of evidence as the
`sconto` and `id_riga` rulings of 26/10.

## Why it is open

1. 🔴 **Nothing is built.** No `nota` key appears in `MexalOrderSendService` on
   `DevMain` at `52ddc4c`.
2. 🔑 **Fabrizio Paganelli sized it himself at about half an hour.** It is the
   cheapest open item on the board and it unblocks the client's invoicing match.
3. ⚠ **What exactly goes in the field is not specified** — the bare WooCommerce
   order number, a prefix, or more. Only _"il codice identificativo di WooCommerce
   (come il numero d'ordine)"_ is recorded.
4. ⚠ **Whether it applies to every order or only WooCommerce ones is unstated.**

## A tension worth naming

🔑 **The same day, ROMI ruled out free note fields on orders.** Elena Spini's
`#tproj-pienissimo` recap at **15:30 CET** — forty minutes before Fabrizio
Paganelli's mail to Kreosoft — records: _"Niente campo note libero su ordini e
preventivi, come richiesto da Fabrizio per limitarne l'uso non corretto dei
commerciali"_ (see [OI-292](OI-292%20The%20Notes%20related%20lists%20on%20Lead%20Account%20and%20Opportunity%20are%20not%20built.md)).

⚠ **These are probably not the same thing** — that ruling is about a Salesforce
note field the sales team could type into, this is a Mexal header note written by
the integration — **but both were decided within the hour by the same person on
the same object, and nobody has said they are distinct.** Flagged so the Monday
contract meeting does not reverse one by applying the other.

## Related

- [The Mexal integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md)
- [OI-287](OI-287%20The%20Mexal%20line%20discount%20is%20sent%20as%20a%20line%20total%20instead%20of%20per%20unit.md)
  — the other Kreosoft field ruling, still not implemented as specified.

## 🔑 2026-11-03 - the purpose is confirmed by the client, and it is still not built

In [the e2e production session](../meetings/2026-11-03%20Test%20e2e%20PROD.md)
Fabrizio Paganelli raised it himself and explained **why**, which answers point 3
above:

> _"ti ricordi Aurel che c'eravamo fatti dare da Mirko il codice di quel campo che fa
> riferimento alle note di testata dell'ordine?"_ … _"L'altro giorno con Mirko ci siamo
> scambiati una mail."_

The reason: the customer signs the quote, the signed document carries the **Salesforce
order number**, and when amministrazione raises the invoice _"qui c'è il riferimento al
preventivo dove questo qui è il numero dell'ordine di Mexal. Quindi qua nelle note
bisognerebbe mettere il riferimento"_.

🔑 **So what goes in the field is now specified**: the **quote reference and the Mexal
order number**, so the invoice document carries both. Fabrizio Paganelli would accept
the order code alone — _"Va bene anche mettere solo [il codice], dai"_.

🔴 **Nothing is built, four days on.** Aurel Mrruku, twice: _"Sì, sì, ma non l'ho fatto
ancora"_, _"T'ho detto che quello non l'ho fatto"_, and his own list of what production
is still missing: **_"Mi mancano la community, le note, alcuni layout."_**

⚠ **Point 4 is still open** — whether it applies to every order or only WooCommerce
ones. The 3 November discussion was about a **standard** sale, which cuts against
"WooCommerce only", but nobody said so.

🔑 **The tension flagged above sharpened rather than resolved.** The same session agreed
to turn the quote's payment-condition description into a **`note preventivo`** free-text
field — see
[OI-317](OI-317%20The%20payment%20condition%20description%20field%20must%20become%20quote%20notes.md)
— which is the third decision about note fields on quotes and orders in five days, in
the third direction.

## 2026-11-04 - built in source, not deployed

🔑 **Aurel Mrruku chose the content: the bare Salesforce quote number** (format
`00000005`, the standard `QuoteNumber` auto-number). This settles point 3.

- `MexalOrderSendService.loadOrder` now selects `Quote__r.QuoteNumber`;
  `buildOrderPayload` sends it as **`nota`** in the order header.
- **The key is omitted when the order has no linked quote**, so orders created
  without one (including WooCommerce orders) send no note. That answers point 4 in
  effect: the note appears only on quote-backed orders.
- ✅ Compiles: dry-run deploy to `Pienissimo UAT`, `NoTestRun`, 2026-11-04.
- ✅ **Deployed to `Pienissimo UAT`** 2026-11-04 09:29Z, deploy id
  `0AfMA00000D5kii0AB`, `NoTestRun`; the live class body was re-read and carries the
  `nota` line.
- ✅ **Deployed to `Pienissimo Prod`** 2026-11-04 09:34Z, deploy id
  `0AfSW000001L2MP0A0`, `RunSpecifiedTests MexalIntegrationTest` — 59 tests, 0
  failures, `MexalOrderSendService` 246/298 lines covered (83%); the live class body
  was re-read and carries the `nota` line.
- 🔴 **Not yet seen working in Mexal.** No order has been sent with the note. The
  maximum length of `nota` is still unrecorded; an 8-digit number is unlikely to hit it.

**Closing it:** a quote-backed order sent to Mexal whose header note, and the invoice
printed from it, shows the quote number.
