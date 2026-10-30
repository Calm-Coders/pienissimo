---
id: OI-306
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-30
updated: 2026-10-30
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
