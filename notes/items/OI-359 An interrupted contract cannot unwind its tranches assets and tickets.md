---
id: OI-359
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli, Elisa Migliano
org: both
raised: 2026-11-12
updated: 2026-11-12
depends_on: [OI-331]
blocks: []
severity: high
source: notes/meetings/2026-11-12 Check Pre-Import.md
---

# OI-359 - An interrupted contract cannot unwind its tranches assets and tickets

**When a client stops a multi-tranche service part way through, the tranches that
will never be invoiced, the assets already released and the event links already
sent have no way to be cancelled. The developer confirmed on 12 November that
nothing was built for it, named the design it would need, and the case was parked
on the Fase 2 shopping list.**

## The case, from the client

Fabrizio Paganelli, on the
[Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md):

> _"per il futuro noi avremo magari un ordine di un cliente che ha 10 tranche …
> Se a un certo punto il cliente interrompe il contratto, le tranche che non
> abbiamo ancora fatturato, **come facciamo a in qualche modo disabilitarle,
> eliminarle**? … Faccio l'esempio, un cliente della Performance Plus dove c'e un
> ordine con 12 tranche mensili e **a meta del servizio il cliente si ferma** …
> Le seconde sei non emetteremo mai le fatture … **C'e un modo per disabilitarle
> queste tranche o rimarranno sempre li?**"_

And he pushed back on it being called an edge case: _"non e che sono casi
particolari, e nella normalita delle aziende … si fanno le fatture, si fanno anche
**le note di credito**, quindi un cliente puo decidere di smettere di venire i
corsi."_

## The answer

🔴 Aurel Mrruku: _"**Per il momento non l'abbiamo previsto.**"_ And the design it
would need, in one breath:

> _"forse dobbiamo creare uno stato dell'ordine … e quando l'ordine va in quello
> stato, in automatico devi **cambiare lo stato delle tranche, cambiare stati degli
> asset e cambiare i stati dei link evento**. Perche e una catena di azioni che
> deve succedere dietro."_

Elena Spini named it: _"una sorta di **interruzione del servizio**."_

## The second half, from administration

🔑 Elisa Migliano added the credit-note case, which is stricter than "unavailable":

> _"oltre alle note di credito ci sono anche dei casi in cui il biglietto poi non
> deve essere piu disponibile, ma **deve essere annullato**. … il cliente magari ha
> pagato la prima tranche per intero e quindi si sono sbloccati e resi disponibili i
> biglietti per quella tranche, pero poi il cliente non va piu avanti, per cui gli
> abbiamo fatto nota di credito … **I biglietti non sono disponibili per nessuna**"_

Aurel Mrruku extended the chain: _"**E non solo i biglietti, anche i link degli
eventi che mandiamo** \[da\] marketing."_ Elena Spini: _"e tutta quello che ha
detto quando c'e tutta la catena."_

## Where it was parked

🟡 Elena Spini: _"Praticamente lo aggiungeremo nelle m\[ille\] cose della **fase
due**."_ Fabrizio Paganelli: _"Lo aggiungeremo alla lista della spesa."_

⚠ **Not in any Fase 2 document.** It is in neither the seven-release offer nor the
project plan ([the Fase 2 offer](../The%20Fase%202%20offer.md)); R6 is _note di
credito_, dated **12 April 2027**, and nothing states whether this is inside it.

## Relation to OI-331

🔑 This is the **same defect class** as
[OI-331](OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md) —
the state machine has no reverse gear — but it is a different trigger and a wider
blast radius:

| | OI-331 | OI-359 |
| --- | --- | --- |
| Trigger | a collection is deleted or returned unpaid | the customer stops the contract |
| Scope | that tranche's asset goes back `Disponibile` → `Ordinato` | **all remaining** tranches, assets and event links, plus annulment after a credit note |
| Status | 🟢 priced, specified, release **R1 on 14/12** | 🔴 nothing written, nothing priced |

Both need the email timing rule that is still owed by Rebecca Marmo
([OI-350](OI-350%20The%20R2%20date%20and%20the%20ticket%20email%20timing%20conditions%20need%20Rebecca.md)),
because an unwind may have to undo mails already sent.

## What is owed

- Whether this is inside R1, inside R6 or unquoted, stated before the client signs.
- The order state and the cascade, specified — it is the same mechanism as R1 and
  should be analysed with it.
- Whether a credit note must **annul** a ticket, and what annulled means for a QR
  code already in a customer's inbox.
