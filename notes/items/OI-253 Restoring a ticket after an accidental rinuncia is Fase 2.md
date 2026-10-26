---
id: OI-253
type: open-item
status: open
owner: Elena Spini
with: Rebecca Marmo
org: both
raised: 2026-10-16
updated: 2026-10-16
depends_on: [OI-242]
source: notes/meetings/2026-10-16 UAT Flussi MKT Biglietti.md
---

# OI-253 - Restoring a ticket after an accidental rinuncia is Fase 2

**Renunciation is irreversible and there is no back-office way to undo one. The
client asked for a recovery path in the same session in which it insisted on
putting the renunciation button in the invitation mail, and ROMI deferred the
recovery to Fase 2 while accepting the button for Fase 1.**

## The ask

At [the 16/10 UAT session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)
(`00:43:08`) Rebecca Marmo asked it plainly:

> _"Se io premo tasto rinuncia e poi cambio idea, noi possiamo rendere di nuovo
> disponibili per la nomina i biglietti?"_

And restated it as a back-office need (`00:58:00`):

> _"io devo avere la possibilità io qui in backoffice che se mi scrive il cliente
> mi dice sbagliato, posso rimetterglielo disponibile"_

Aurel Mrruku's answer describes the current design, not a defect:

> _"Eh, questo è il problema, no? Perché abbiamo detto quando si rinuncia si
> rinuncia a tutto."_

## The ruling

Elena Spini deferred it (`00:44:20`):

> _"stiamo facendo per ora i primi processi flusso, diciamo, Happy P[ath], come
> l'ha chiamato Aurel, tutti i casi limiti … lo tracciamo come caso limite della
> fase due, ma adesso dobbiamo andare avanti e non pensare a tutte queste
> casistiche perché verranno gestite in un secondo momento."_

🟢 She accepted it is a real case — _"ci sta, può essere il caso, dobbiamo
pensarle tutte"_ — and that the work is being done, just not now.

## 🔑 Why the pairing matters

This is the **mitigation for the risk ROMI itself identified** in the same
session, and the two halves landed in different phases.

Aurel Mrruku's objection to a renunciation button in the mail (`00:38:08`) was
precisely accidental clicks:

> _"Tu apri la mail in un cellulare, hai attiva rinuncia, per sbaglio hai fatto
> rinuncia, hai già spaccato tutto e hai perso tutti i biglietti."_

Elena Spini made the same point for the mobile case — a holder _"sono sul
pullman, sto guidando, ho cliccato semplicemente sbagliando nella mail"_.

ROMI then **conceded the button into Fase 1**
([OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md))
and **deferred the undo to Fase 2**. So from go-live the system exposes a
one-click, irreversible, customer-facing action with:

- a double-confirm pop-up as the only guard, itself still to be built;
- no back-office reversal;
- ⚠ and no recorded design for what a support agent does when a customer calls.

⚠ **Nobody in the room connected the two decisions.** Recorded here because the
exposure is a consequence of the pair, not of either one.

## Open

- 🔴 **Not specified.** Whether recovery means re-opening the asset, issuing
  replacements, or an admin-only state transition is unestablished, and the
  asset state machine
  ([OI-74](OI-74%20Asset%20state%20machine.md)) has no path out of `rinunciato`.
- 🔴 **No Fase 2 row carries it yet**, and the Fase 2 offer is still unsent
  ([OI-83](OI-83%20No%20phase%202%20estimate.md)).
- ⚠ **The interim answer is unwritten.** Between go-live and Fase 2 the only
  available remedy appears to be a manual data fix by someone with admin
  access — which today is everyone
  ([OI-186](OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)).

## What closing it looks like

Either a Fase 1 guard strong enough that recovery is not needed, or a named
interim procedure for support, and a Fase 2 line item with an estimate.
