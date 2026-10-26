---
id: OI-257
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: ROMI
raised: 2026-10-19
updated: 2026-10-19
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-257 - Standard sector picklist values must be removed

**The industry and activity-type picklists still carry Salesforce's stock
values — chimica, trasporti, banche, albergo — alongside Pienissimo's own. The
client asked for every stock value to be deleted, unanimously, in the first
session its own key users spent in the system.**

## What was asked

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`00:11:31`, Elena Spini offered: _"queste due picklist così se non le vuoi le
togliamo, sono standard."_ Fabrizio Paganelli listed what was wrong with them —
_"noi abbiamo il nostro, diciamo, ristorante, albergo eccetera eccetera …
secondo me van tolti quelli lì"_ — and Sabatino Rinaldi closed it without
qualification:

> _"van tolti senza dubbio. Van tolti tutti."_

Elena Spini accepted on the spot: _"togliamo, perfetto"_, and the Gemini notes
carry it as a `Concordato` with her as owner — _"Rimuovere i valori standard
dalle liste di selezione non pertinenti"_.

## What is not settled

- ⚠ **Which picklists, exactly.** The transcript says _"queste due picklist"_
  while Elena Spini has the screen, and names no API field. From the surrounding
  discussion they are the lead's **settore merceologico** and **tipologia di
  attività**, but the record does not state it and the screen is not readable
  from the transcript. **Confirm the field names before deleting values.**
- 🔑 **`tipologia di attività` cannot simply be emptied of stock values**, because
  [OI-258](OI-258%20Leads%20from%20a%20communication%20agency%20must%20be%20blacklisted%20automatically.md)
  depends on one of its values (`Agenzia di comunicazione`) staying in the public
  forms as a deliberate trap. The two asks were made four minutes apart in the
  same session and nobody connected them.
- ⚠ **Deleting a picklist value is not reversible for reporting.** Any historical
  lead carrying a removed value keeps the string but loses the active entry.
  Whether any such leads exist in UAT is unchecked; the client's own data arrived
  from Mexal, not from these picklists.

## What closing it looks like

The two field names are confirmed, the Pienissimo-supplied value list is
reconciled against what is in the org, the stock values are deactivated (not
hard-deleted, so existing records stay readable), and `Agenzia di comunicazione`
is explicitly preserved for OI-258.
