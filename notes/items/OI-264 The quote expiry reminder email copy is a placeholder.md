---
id: OI-264
type: open-item
status: open
owner: Marco Montesi
with: Elena Spini
org: Pienissimo
raised: 2026-10-19
updated: 2026-10-19
requirement: SAL-09
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-264 - The quote expiry reminder email copy is a placeholder

**The automatic reminder that goes to the client and the tutor two days after a
quote enters `In trattativa` is built and working, and the text it sends is a
stand-in ROMI wrote. The client has to supply the real copy and has not.**

## What exists

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`01:21:16`, Marco Montesi recited the rule back correctly and Elena Spini
confirmed it: five days' quote validity, and _"dopo 2 giorni dall'aggiornamento
in trattativa c'è la creazione automatica del task … e invio della mail"_ to the
client and the tutor.

She then read the current text out and pasted it in chat (`01:22:28`), with no
illusions about it — _"per ora con molta moltissima fantasia il nostro copy che
abbiamo messo è questo"_ and _"l'ho messo in brutto"_. Its shape:

> Buongiorno, ti ricordiamo che il preventivo `{QuoteNumber}` `{QuoteName}` è
> disponibile fino a `{data di scadenza}`. Per qualsiasi chiarimento puoi
> rispondere direttamente a questa mail. Grazie, `{nome utente}`

The merge fields are the quote number, the quote/opportunity name, the expiry
date and the tutor who created it.

## What is owed

Elena Spini put the ball in the client's court — _"appena ci dirai qual è il
copy, noi lo mettiamo"_ — and Marco Montesi accepted it twice: _"dobbiamo
rivedere. Sì, sì."_ The Gemini notes assign it to the group:
_"Revisionare il testo delle email di promemoria automatico per i preventivi in
scadenza"_.

## Open

- 🔴 **No date and no named author.** _"Il gruppo"_ is not an owner; Marco Montesi
  is recorded here because he accepted it in the room, **and that attribution is
  from the transcript, not from a written assignment.**
- ⚠ **It is a customer-facing email that ships at go-live.** Unlike an internal
  label, this text leaves the system and reaches Pienissimo's own prospects. It
  is the only mail in the commercial flow whose copy nobody has approved.
- ⚠ **The same question is unanswered for the DocuSign signature-request mails**
  shown in the same session — those also go out automatically and no source
  records who wrote their copy.

## What closing it looks like

The client supplies the Italian text, ROMI loads it, and one reminder is sent in
UAT and read by the client before go-live.
