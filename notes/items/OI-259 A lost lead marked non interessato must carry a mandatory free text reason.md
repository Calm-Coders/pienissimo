---
id: OI-259
type: open-item
status: open
owner: Elena Spini
with: Elisa Migliano
org: both
raised: 2026-10-19
updated: 2026-10-20
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

## 🟢🔴 2026-10-20 — scope settled at four values, called a change request internally, and built for one

**The client widened the rule from one reason to four and ROMI accepted it in
under a minute. Aurel Mrruku classified it as a change request in the same breath
— and the build that shipped four and a half hours earlier implements the single
original case.**

At [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md),
Elena Spini reported the new ask:

> _"Invece adesso hanno chiesto dettaglio di non interesse obbligatorio per tutti
> … per tutti questi quattro valori diversi."_
>
> _"obbligatorio perché sennò non puoi andare avanti, per tutti e quattro."_

Aurel Mrruku, immediately: **_"digli che è una CR. Sì, sì, lo mettiamo, non è un
problema … lo mettiamo obbligatorio."_**

- 🟢 **So the open question from 19/10 is closed**: it is not one reason, and not
  all ten. It is **four**, mandatory, blocking the save.
- 🔑 **And ROMI's own position is that this is a change request** — _"digli che è
  una CR"_, said to the PM, four days after the Fase 1 scope freeze. ⚠ **It is
  recorded as a CR nowhere**, and no source says the client was told. The instruction
  was to tell them; whether anyone did is unverified.

### ⚠ Which four is not stated

The transcript says _"questi quattro valori"_ while Elena Spini was sharing her
screen, and **names none of them**. `Lead.Dettaglio_Motivazione_Uscita__c` carries
**ten** values on `origin/DevMain` (`Non interessato`, `Prezzo alto`, `Sceglie
concorrenza`, `Servizio non adatto`, `Ha già P.Pro`, `Già in contatto`, `Dati per
il contatto inesatti`, `Duplicato da CRM`, `Non in target`, `Richiesta inviata per
errore`), so four is a subset somebody chose.

**The likeliest reading — and it is a reading, not a fact — is the four debated in
the room on 19/10**: `Non interessato`, `Prezzo alto`, `Sceglie concorrenza`,
`Servizio non adatto`, which are also the first four in picklist order and the
only ones any participant argued for. ⚠ **Marked uncertain. It must be confirmed
before the build, because building the wrong four is indistinguishable from
building the right four until a tutor hits the fifth.**

### 🔴 The build implements one of the four

`baa8597` (Anita Aga, `DevAnita19`, 20/10 **12:27:43 CEST** — four and a half
hours *before* the decision) adds `Lead.Motivazione__c` and gates it in
`leadCustomPath.js`:

```js
get requiresMotivazione() {
  return (
    this.exitReason === "Perso" && this.exitReasonDetail === "Non interessato"
  );
}
```

- **So it fires on exactly one detail value**, the 19/10 minimum — correct when
  written, superseded the same afternoon.
- ⚠ The field is `<required>false</required>` in metadata and `TextArea`; the
  mandatory behaviour lives in the LWC, so **it binds only the custom path, not an
  API write or a list-view edit.**
- ⚠ Its label is `Dettaglio non interesse` and its description names the single
  case — both will read wrong once it covers four reasons.
- ⚠ The commit message, _"Added Motivazione field for Leads Non Qualificato/Perso/
  Non Interessato"_, reads as three values but is one path: stage `Non
  qualificato`, reason `Perso`, detail `Non interessato`.
- 🔴 **Unmerged.** On `DevAnita19`, no PR.

🔑 **The competitor-list conflict with `DM-07` is untouched by any of this.** The
register still specifies `Sceglie concorrenza (lista competitor da selezionare)`
and Elena Spini still advised free text instead. **If `Sceglie concorrenza` is one
of the four, this row now builds free text over a signable dropdown.** Still a
human's ruling; the register carries only the `tracked_by: [OI-259]` pointer added
on 19/10.
