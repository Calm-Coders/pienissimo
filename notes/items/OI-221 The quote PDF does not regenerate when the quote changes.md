---
id: OI-221
type: open-item
status: open
owner: Rexhina Hysi
with: Aurel Mrruku
org: ROMI
raised: 2026-10-08
updated: 2026-10-08
depends_on: [OI-207]
blocks: [go-live]
source: notes/meetings/2026-10-08 Internal Test.md
---

# OI-221 - The quote PDF does not regenerate when the quote changes

**`Concordato` at the 08/10 internal session: any change to a field used in the
quote must trigger a refresh of the attached PDF, constraining the user's
action, so the document can never disagree with the record. Nothing in the
repository does this yet.**

## The ruling

From [the session](../meetings/2026-10-08%20Internal%20Test.md), as
`Concordato`: _"ogni modifica ai campi utilizzati nel preventivo deve attivare
l'aggiornamento del documento PDF vincolando l'azione dell'utente"_. Aurel
Mrruku set it out in the `Dettagli` with the fields named — **payment
conditions, the account** — and the reason is stale-document risk: a PDF
generated before an edit keeps circulating with the old figures.

It was assigned to Rexhina Hysi as _"Implementare una logica di refresh
automatico per il preventivo quando vengono modificati i campi rilevanti per
evitare dati non coerenti"_.

## What is built, and what it is not

🔴 **Rexhina Hysi's `090d9e2` (08/10 16:58, merged to `DevMain` via PR #89) is
not this.** Its `quoteGeneratePdf.js` change fixes the *page refresh after* a
manual generation: it drops `RefreshEvent`, closes the quick action and reloads
a clean record URL, with its own comment explaining that Lightning otherwise
reopens the modal.

That is a usability fix on the existing manual button. **No trigger, flow or
field-change hook regenerates the PDF when a quote field moves.** The commit
message — _"community page edit and refresh on pdf generation"_ — reads like the
ruling and is not.

## Why it is a go-live item

The quote PDF is the customer-facing document and the acceptance surface: the
community page and the DocuSign envelope both carry it. Combined with
[OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
— the commercial fields only recently added to the quote — a stale PDF is a
price shown to a customer that the record no longer agrees with.

## What closing it looks like

A named set of quote and quote-line fields whose change regenerates the PDF, the
mechanism (trigger, flow or required user action) in source, and the user-facing
constraint the ruling calls for, verified by editing one of the named fields on
a quote that already has a PDF.
