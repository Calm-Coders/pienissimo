---
id: OI-357
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: Pienissimo
raised: 2026-11-12
updated: 2026-11-16
depends_on: []
blocks: [go-live]
severity: gating
source: notes/meetings/2026-11-12 Check Pre-Import.md
---

# OI-357 - The client commercial lead and the web counterpart are both leaving

**Marco Montesi, Pienissimo's Responsabile Area Commerciale and the author of every
Sales change request now being scheduled, has resigned. Sabatino Rinaldi, the
counterpart for WooCommerce and the website forms, is also leaving. Both were said
in plain terms on 12 November, four days before the client's users start work on
Salesforce.**

## What was said

🔴🔑 Fabrizio Paganelli, on the
[Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md), while
discussing whether to create a named production user for the commercial lead:

> _"se vogliamo creare un'utenza generica per il responsabile commerciale a me mi
> stride perche … non lo so tanto adesso se se Marco va tipo perche il tema qual e?
> e che **Marco e di\[missio\]nario. Marco Montesi.** … **Che se lui adesso va via,
> che cosa succede?**"_

Elena Spini's reaction, in the transcript, is one word: _"Davvero?"_ — so **ROMI
learned it on the call.**

And of Sabatino Rinaldi, in the same passage, on licence planning: _"a noi ci
servirebbe una per \[Perfor\]mance plus e **Sabatino va via**."_

Independently, on the [internal call](../meetings/2026-11-12%20INTERNA%20Modifiche%20Marco.md)
five hours later, Elena Spini to Aurel Mrruku:

> _"oggi hanno detto che **Marco se ne va**. che e quello che ha chiesto le
> modifiche."_

⚠ **No date, no successor and no handover plan was stated for either.**

## Why it is gating

1. 🔴 **He is the requirements owner for the Sales flow.** All twenty rows of
   [`Modifiche flussi Sales`](OI-344%20The%20client%20sent%20sixteen%20Sales%20flow%20changes%20and%20none%20is%20triaged.md)
   are his, as is the mail of 11/11 15:32Z adding the home-page work queue, the
   tranche totals and the lead-source list. He is also the only named source for
   what the Home page should contain — which
   [OI-364](OI-364%20Agents%20cannot%20see%20the%20home%20page%20or%20the%20calendar%20in%20production.md)
   leaves _"da definire"_.
2. 🔴 **He was the tutor-training counterpart** — the 09/11 and 11/11 sessions were
   arranged with him ([OI-300](OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)),
   and the agents who start on 16/11 report to him.
3. 🔴 **Sabatino Rinaldi owns the live integrations.** He connected WooCommerce to
   production himself on 11/11
   ([OI-354](OI-354%20WooCommerce%20is%20connected%20to%20production%20by%20the%20client.md)),
   holds the plugin credentials and the shop configuration, is the counterpart for
   the two public lead forms
   ([OI-340](OI-340%20The%20website%20lead%20forms%20have%20no%20field%20for%20the%20marketing%20consent.md)),
   and is the named source of the Lead migration file.
4. ⚠ **The requests may outlive the requester and nobody has decided.** Aurel
   Mrruku: _"Secondo me se te li dimentichi non nessuno si ricorda"_; Elena Spini:
   _"purtroppo c'era anche Fabrizio ahime, quindi siam fregati."_ The recap sheet
   went to the client anyway.
5. 🟢 **One mitigation already exists**: Marco Montesi has no named production user,
   by an earlier decision, so the commercial login survives him
   ([OI-356](OI-356%20The%20definitive%20list%20of%20production%20users%20is%20still%20incomplete.md)).
   ⚠ _"Basta che Marco lo sa perche non penso che lo sappia."_

## What is owed

- Leaving dates for both, and who inherits each role.
- Who confirms the Sales change requests once Marco Montesi has gone, and whether
  the deferred list still stands.
- The WooCommerce plugin configuration and shop credentials handover, before
  Sabatino Rinaldi leaves — ROMI holds none of it.
- See [Marco Montesi](../people/Marco%20Montesi%20-%20Pienissimo%20sales.md)
  and [Sabatino Rinaldi](../people/Sabatino%20Rinaldi%20-%20Pienissimo%20project%20lead.md).

## 2026-11-16 - both are still working, both still hold their files, still no dates

**Marco Montesi was on the go-live call**, added to it by Fabrizio Paganelli, four
days after his resignation was reported to ROMI in a meeting. What he did there:

- 🔴 **asked for and received production access** — Elisa Migliano, to the room:
  _"Marco ha chiesto gli accessi perche a loro serve, a Marco gli serve l'accesso
  per guardare gli ordini della eventi sulla piattaforma. Ma io glieli ho dati."_
- **took charge of the commercial start**: _"volevo capire se in questa fase i
  commerciali possono spostare un po' di opportunita"_ → _"intanto gli faccio
  creare le nuove opportunity"_ → _"**io intanto gli faccio caricare le opportunity
  che avevano su Zoho**"_
- **raised the DocuSign registration problem** and accepted it on behalf of his own
  team → [OI-369](OI-369%20DocuSign%20asks%20signers%20to%20register%20and%20the%20client%20expects%20to%20lose%20them.md)
- said of his own team, on day one: _"**non sappiamo come muoverci**"_ and
  _"alcune cose qui non vanno e non girano e non funzionano"_

**Sabatino Rinaldi** activated the WooCommerce plugin in production, ran the shop
test, holds the Pienissimo Live registration forms waiting on ROMI
([OI-371](OI-371%20Opportunities%20are%20re-keyed%20from%20Zoho%20while%20the%20web%20forms%20wait%20for%20ROMI.md)),
and at 15:54Z the same day asked ROMI to send him
[the Mexal integration APIs](OI-368%20The%20client%20asked%20for%20the%20Mexal%20integration%20APIs%20by%20mail.md)
_"per dei collegamenti interni"_.

🔴 **Still nothing on either departure**: no leaving date, no successor, no
handover, and no written acknowledgement by ROMI that it was told. The WooCommerce
plugin configuration and the shop credentials ROMI does not hold are still
Sabatino Rinaldi's, and the twenty Sales change requests and the undefined home
page are still Marco Montesi's.

⚠ Their person notes are unchanged and should be revisited the moment a date
exists.
