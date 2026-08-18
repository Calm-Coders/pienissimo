---
id: ref-prodotti-e-bundle-workbook
type: reference
status: active
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-08-07
updated: 2026-08-18
uncertain: contents unread; whether it carries the event list, the bundle-only codes or any price is unverified
source: Gmail - Fwd "Lista Eventi, Codici prodotto, esempio Bundle", Elena Spini to Aurel Mrruku, 2026-08-18T07:41:32Z
---

# The Prodotti e Bundle workbook

`Prodotti e Bundle.xlsx` — the attachment Fabrizio Paganelli sent on
**2026-08-07 at 12:17 CEST** to the thread **"Lista Eventi, Codici prodotto,
esempio Bundle"**. It is the client input that
[OI-46](items/OI-46%20Bundle%20classification%20picklists.md) and
[OI-48](items/OI-48%20Bundle-only%20article%20codes.md) have been waiting on.

## What is now established

**The delivery is real.** For eleven days the record could only say that
Fabrizio had written something to that thread and that Elena Spini had thanked
him for it — his message survived in the ROMI mailbox only as an empty quoted
stub. Aurel Mrruku asked her to forward it on 2026-08-14; **she forwarded it on
2026-08-18 at 09:41 CEST** ("Sorry eccolo"), and the forwarded message resolves
the ambiguity:

- Fabrizio's message carries **no body text at all** — the entire content is
  the attachment. That is exactly why a `from:` search never surfaced it.
- There is **exactly one attachment**: `Prodotti e Bundle.xlsx`
  (`application/vnd.openxmlformats-officedocument.spreadsheetml.sheet`).
- It was addressed to Elena Spini, cc Amministrazione Eventi and Sabatino
  Rinaldi. Aurel was added to the thread by Elena at 12:38 the same day, which
  is why he never received the attachment itself.

## What is not established

**Nobody has opened it.** The contents are unread, so the workbook cannot yet
be said to satisfy any specific open item:

| Question                                                     | Status |
| ------------------------------------------------------------ | ------ |
| Does it contain the definitive 7-event list (OI-46)?          | Unverified — the mail subject says "Lista Eventi", the filename does not |
| Does it contain the bundle-only "(B)" article codes (OI-48)?  | Unverified — the subject says "Codici prodotto" and "esempio Bundle" |
| Does it contain real catalogue prices (OI-87)?                | Unverified — **prices are not named in the subject**; see the warning below |

⚠ **Treat it as price-bearing until someone confirms otherwise.** A Pienissimo
product registry export plausibly carries list prices, and prices must never be
copied into `notes/`, the recaps or [site/](../site/) — see
[docs/publishing.md](../docs/publishing.md) and
[the placeholder-price risk](risks/Risk%20-%20placeholder%20prices%20could%20reach%20the%20client.md).
Record what the workbook answers, never the values.

**Probably the long-promised `anagrafica prodotti`.** The 2026-07-22 session
closed with an action on Fabrizio Paganelli to _"inviare l'Excel con
l'anagrafica prodotti e discutere la classificazione degli eventi con Aurel"_,
paired with one on Aurel Mrruku to _"partecipare alla riunione di
approfondimento sull'anagrafica prodotti dopo aver ricevuto il file Excel"_.
The match is strong but **not confirmed** — it rests on the subject line and the
filename, not on the contents. If it holds, **a review meeting is owed** as soon
as the file is read.

## Why an agent cannot read it

No connected tool can reach a Gmail attachment: the Gmail integration exposes
attachment **metadata** only and has no download call. The file is in neither
Drive nor Slack — searched on 2026-08-18 and absent from both. This is the same
wall that
[`Integrazioni pienissimo.xlsx`](flows/The%20Mexal%20integration.md) hit on
2026-08-14, and it was solved the same way it must be solved here: **a human
downloads it and puts it where an agent can read it.**
