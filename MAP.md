# MAP - Pienissimo

Entry point for humans and agents. Keep this file under 5 KB. If it grows, move
detail into a note and link it.

Last updated: 2026-08-14 · Source of record: [notes/](notes/)

## Where the project stands

ROMI is migrating Pienissimo from **Zoho CRM to Salesforce**. Zoho expires
**31 October 2026**; the working go-live is **6 October**; data import ~1 Sept.
Requirements went to sign-off on 2026-08-06.

- **2026-08-06 settled the last open designs** — DocuSign in for
  quotes/contracts and out for tickets, order states
  `Ordinato → Fatturato → Incassato`, the
  [ticket lifecycle](notes/flows/The%20ticket%20lifecycle.md), and ticket release
  on a fully paid tranche invoice.
- **The repository is a week ahead of every tracker.** Six things the 08-03 org
  check called missing were committed 4–7 August and never written up —
  [the build ahead of the record](notes/objects/The%20build%20ahead%20of%20the%20record.md).
- **The org and the repository also disagree.** The whole Biglietto DocuSign/PDF
  stack is Active in UAT and absent from `force-app/` —
  [risk](notes/risks/Risk%20-%20the%20Biglietto%20Apex%20stack%20is%20not%20in%20source%20control.md).
- **Nothing can deploy today.** Apex coverage is **1%** against a 75% floor —
  [OI-64](notes/items/OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md),
  [OI-66](notes/items/OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md).
  The suite is written as one task, requested separately before the deploy.
- **The restart calendar is fixed: 19 Aug** marketing funnels · **20 Aug** asset
  flow · **25 Aug** Anticipay · **27 Aug** WooCommerce credentials. Two of the
  four are design discovery, not build —
  [the compressed calendar](notes/risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md).

## The live chain

1. **Deployability** — the two coverage items above gate every other, and are
   handled as one late task on Aurel's request.
2. **Client inputs owed** — prices
   ([OI-87](notes/items/OI-87%20Real%20catalogue%20prices%20still%20outstanding.md)),
   the event list ([OI-46](notes/items/OI-46%20Bundle%20classification%20picklists.md)),
   bundle codes ([OI-48](notes/items/OI-48%20Bundle-only%20article%20codes.md)),
   the Zoho workbook ([OI-24](notes/items/OI-24%20Data%20model%20workbook.md)) —
   and ROMI owes the
   [import template](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md).
3. **Dated but unbuilt** — [tranche](notes/items/OI-50%20Tranche%20object.md)
   (nothing exists),
   [participants](notes/items/OI-78%20Participant%20data%20collection.md),
   [WooCommerce](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)
   (credentials 26 Aug),
   [VAT](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
   (provider unconfirmed).
4. **Commercial** — the
   [phase 2 dispute](notes/risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md)
   has run four meetings, and
   [OI-83](notes/items/OI-83%20No%20phase%202%20estimate.md) records that the
   decision-maker was never told.

## Map of the territory

| Area                | Start here                                                                             |
| ------------------- | -------------------------------------------------------------------------------------- |
| Everything, indexed | [INDEX.md](INDEX.md)                                                                   |
| How to read/write   | [notes/Retrieval and write protocol.md](notes/Retrieval%20and%20write%20protocol.md)   |
| Requirement ids     | [requirements/pienissimo-requirements.yaml](requirements/pienissimo-requirements.yaml) |
| Items · built · people · risks | [items](notes/items/) · [objects](notes/objects/) · [people](notes/people/) · [risks](notes/risks/) |
| Session handoffs    | [JOURNAL.md](JOURNAL.md)                                                               |
| Publishing rules    | [docs/publishing.md](docs/publishing.md)                                               |

## Standing constraints

- **Daniela Morgese** decides and signs commercially; **Sabatino Rinaldi** leads
  day-to-day; **Elisa Migliano** is the operational authority on administration,
  invoicing and the infopoint; **Fabrizio Paganelli** owns the product registry;
  **Marco Montesi** sales. **Elena Spini** chairs for ROMI, **Aurel Mrruku** is
  technical lead. Full list: [notes/people/](notes/people/).
- **The build is written by the Calm-Coders team working for ROMI.** Their work
  lands in the repository ahead of the trackers — check `git log` and
  `force-app/` before calling something unbuilt.
- **Never show placeholder prices to Pienissimo** — every catalogue price in UAT
  is a ROMI invention tagged `[PLACEHOLDER …]`.
- Requirements have two governing texts: `REQUISITI.it.md` is presented for
  signature, `REQUIREMENTS.md` mirrors it. Facts in English, agreed wording in
  Italian.
- The repository is private. [site/](site/) is public and must stay sanitized.
