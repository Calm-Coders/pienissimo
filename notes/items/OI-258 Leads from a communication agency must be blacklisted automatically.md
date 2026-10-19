---
id: OI-258
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-19
updated: 2026-10-19
depends_on: [OI-257]
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-258 - Leads from a communication agency must be blacklisted automatically

**Pienissimo leaves `Agenzia di comunicazione` in its public forms on purpose,
as a trap for competitors filling them in. The client asked for any lead
arriving with that activity type to be set to non qualificato automatically,
with a blacklist exit reason, so no tutor ever works it.**

## What was asked

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`00:14:22`, Sabatino Rinaldi:

> _"riusciamo a fare in modo che in automatico, ogni volta che entra un nuovo
> lead che ha come tipologia attività agenzia di comunicazione, riusciamo a
> bannarlo in automatico, cioè che non riceverà nulla, è bloccato, non lo
> vediamo … applicare un ban[d]list."_

He gave the reason it must stay in the form at all:

> _"noi quella lì la teniamo come trappola la tipologia di attività agenzia
> comunicazione: chi lo mette viene bannato."_

Elena Spini agreed and stated the shape: _"ci sarà un flusso che ogni volta che
entra un lead di questo tipo ci sarà in automatico l'aggiornamento a non
qualificato, dettaglio della motivazione, motivazione uscita blacklist."_ The
Gemini notes record it as `Concordato` with her as owner.

🟢 **Sabatino Rinaldi gave it an explicit low priority** — _"può andare anche in
fase 5, non è un'urgenza, giusto per metterci d'accordo"_. ⚠ **_"fase 5"_ is
dictated and this project has two phases**; it is recorded verbatim because what
he meant — Fase 2, or simply "later" — is not determinable from the source. **It
is not ruled into Fase 1.**

## What is not settled

- 🔑 **Which exit reason value.** Elena Spini said _"blacklist"_, and the
  signable register already carries
  **`"SW House, Ag. Marketing, Web Agency"`** under `lead_motivazione_uscita.errato`
  (`requirements/pienissimo-requirements.yaml`), which Marco Montesi confirmed
  exists in the org the same session: _"software house agenzia di marketing …
  l'abbiamo accolpati tutti insieme"_. **So the value this flow needs may already
  exist under another name.** Adding a new `Blacklist` value would duplicate it;
  reusing the existing one would not match the word Elena Spini used. **Nobody
  compared the two.**
- ⚠ **What _bannato_ means beyond the lead status.** Sabatino Rinaldi asked for
  _"non riceverà nulla"_ — no marketing sends — which is a suppression rule in
  Marketing Cloud, not a lead field. Whether non-qualified leads are already
  excluded from journeys is not in any note.
- ⚠ **Whether the block is per-lead or per-identity.** A trap only works once per
  address if the record is simply closed; repeat submissions would create new
  leads each time.

## What closing it looks like

The exit-reason value is chosen (new or existing), the automation is built and
tested with a form submission carrying that activity type, the marketing
suppression is confirmed or scoped out, and the phase is ruled by a person.
