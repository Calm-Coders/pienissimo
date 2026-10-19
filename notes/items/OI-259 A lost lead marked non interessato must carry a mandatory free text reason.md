---
id: OI-259
type: open-item
status: open
owner: Elena Spini
with: Elisa Migliano
org: both
raised: 2026-10-19
updated: 2026-10-19
requirement: DM-07
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-259 - A lost lead marked non interessato must carry a mandatory free text reason

**`Non interessato` is the vaguest reason a lead can be closed with, and it is
the one tutors will reach for. The client agreed that choosing it must force a
free-text `Motivazione` before the record can be saved. Whether the same applies
to the other loss reasons was left open in the room.**

## What was agreed

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`00:51:23`, Marco Montesi opened it — _"se non sei più interessato, però ce lo
deve spiegare perché non è più interessato"_ — and Elisa Migliano went further:
_"io lo toglierei quasi non interessato. È veramente troppo vago."_

Sabatino Rinaldi objected to replacing the picklist with free text, on the
grounds that it would simply be left empty:

> _"il testo libero, ma diamoci magari un campo in più … perché altrimenti io già
> lo so che poi i commerciali non metteranno niente lì dentro o mettono cose a
> casa senza senso."_

Elena Spini proposed the rule that was taken, and Sabatino Rinaldi accepted it
twice (_"facciamo così"_):

> _"se scegli perso non interessato, allora devi compilare obbligatoriamente per
> salvare questa impostazione motivazione di non interesse. Campo testo libero."_

**The field name is settled.** Elena Spini asked for one; Marco Montesi gave
_"motivazione basta"_ and Elisa Migliano agreed. So: **`Motivazione`, free text,
required only when the loss reason is `Non interessato`.**

## What was left open

🔑 **Scope.** Elena Spini asked directly — _"e deve essere obbligatorio solo in
questo caso?"_ — and the room did not converge:

- Sabatino Rinaldi: yes, only there, _"perché è l'unico più vago"_.
- Elisa Migliano: also on `Sceglie concorrenza` (_"quale concorrenza?"_), also on
  `Servizio non adatto`, and finally on all of them — _"io lo lascerei per tutti
  e poi dopo si valuta"_.
- Marco Montesi argued `Prezzo alto` is almost never the real reason —
  _"nel 99% dei casi sia un'ob[ie]zione che noi dobbiamo andare a smu[o]ntare"_ —
  which is an argument for capturing detail there too.

Elena Spini closed with _"ottimo, segnato"_, and the Gemini notes put the
extension under `Da approfondire`. **So the agreed minimum is one reason; the
client's stated preference is all of them; nobody decided.**

⚠ **And the extension to `Sceglie concorrenza` contradicts the signable text.**
Marco Montesi asked for a competitor dropdown — _"un menù a tendina che poi tira
fuori i nostri 10"_ — which is what
`requirements/pienissimo-requirements.yaml` already specifies:
**`Sceglie concorrenza (lista competitor da selezionare)`**. Elena Spini advised
free text instead: _"forse è meglio se lo mettete a ma[no] libero"_. **ROMI
advised against its own signable register, in front of the client, and nobody
noticed.** A human must rule which stands.

## Why the register was not amended

The register's `picklists.lead_motivazione_uscita` block is verbatim from DGM-1
and models values, not field requiredness, so the mandatory rule has no natural
home in it. The competitor-list conflict above **does** touch signable text — and
it is a conflict, not a decision, so it is reported rather than written.

## What closing it looks like

The `Motivazione` field is created and the validation built for `Non
interessato`; a person rules whether it extends to the other reasons; and the
`Sceglie concorrenza` conflict between the register and Elena Spini's advice is
settled in both prose documents if the register moves.
