---
id: ref-dgm1-0820
type: reference
status: active
owner: Marco Montesi
org: Pienissimo
updated: 2026-08-20
source: Drive - Workflow Pienissimo 23-7-26.drawio, modified 2026-08-20T14:28:17Z
uncertain: which of the points below are the 20 August edit and which were missed on 14 August
---

# The client Lead-Opty diagram moved on 20 August

`Workflow Pienissimo 23-7-26.drawio` — **`DGM-1` in the requirement register**,
owned by **Marco Montesi** at Pienissimo, reached from the ROMI project folder
through a shortcut. Single page, `LEAD-OPTY`. 49 KB, plain mxfile XML, decoded
in full on 2026-08-20.

**It was modified 2026-08-20 at 14:28 UTC — its first change since 4 August.**
Elena Spini's master moved **68 minutes later** at 15:36 UTC
([the newest design diagram](The%20newest%20design%20diagram.md)). So **both of
the register's source diagrams moved on the same afternoon**, and neither change
is minuted: no recording, no canvas entry, no message.

This is the client's own annotated copy of the sales flow, and the internal
**24 August _"Interna per update flusso Lead/Opty"_** meeting (Elena + Aurel) is
four days away. That the client edited this file first is worth knowing before
that meeting.

## ⚠ What cannot be established

**No prior decode of this file exists at a version between 4 and 20 August**, so
a change made today cannot be told apart from one made on 4 August and missed
when the register was built on 14 August. Everything below is stated as _"in the
file now, not in the register"_ — **not** as _"added today"_.

## In the file now, not in the register

- Three annotations reading **`DA INSERIRE`** — on _"DA RICONTATTARE TASK dopo
  1º contatto con possibilità di mettere una data specifica"_ and on a
  _"Da ricontattare"_ state. The client is marking things as still to be added.
- _"Possiamo aggiungere **campo INFO** che specifica come usare le
  motivazioni"_ — a request for guidance text on the exit-reason picklists.
- _"**Attivare funzione SF** che mette in automatico l'OPP. in prev. inviato"_ —
  asking that the Opportunity move to _preventivo inviato_ automatically.
- The quote-expiry box reads _"Nessuna risposta entro **un numero definito di
  giorni** dall'invio"_. The register carries **`Validity 5 days`** and Elena's
  master says _"entro 5 giorni"_. Marco Montesi is the named owner of the
  outstanding **quote validity times** input (`SAL-10`), so a generalised
  wording on his own copy may be deliberate. **Do not narrow it to 5 days in the
  register on the strength of this file, and do not widen the register either
  — ask.**
- The closed-won box is labelled **"Chiuso Vinto / Incassato"**. This is the
  only place in any source where the two vocabularies are written as one thing —
  but the same file still defines `CHIUSO/ACQUISITO` separately, so it is
  **suggestive, not a ruling**, on
  [OI-69](items/OI-69%20Order%20state%20model.md).

## What it confirms, already held

The four picklists (`lead_motivazione_uscita` perso and errato,
`opportunity_chiusa_persa`, `opportunity_da_ricontattare`,
`quote_da_ricontattare`) match the register **verbatim**. So does the
`CHIUSO/ACQUISITO` rule — _"aggiornamento manuale da parte dell'amministrazione
entro max 5gg. a fronte della conferma di effettivo pagamento ricevuto"_ — and
the `ERRATO` sub-category that must be exportable and filterable for lead-source
quality analysis, and the suggestion that an expired quote be returnable to
_In trattativa_ by the tutor with a _"richiamare"_-style state.

Nothing there needs re-extracting.

⚠ This file also carries the **same real customer order** as the worked example
that the master uses — a company name and VAT number. Keep it out of `notes/`,
the recaps and [site/](../site/).
