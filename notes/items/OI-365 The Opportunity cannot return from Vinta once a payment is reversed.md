---
id: OI-365
type: open-item
status: open
owner: Aurel Mrruku
with: Elisa Migliano, Sabatino Rinaldi, Fabrizio Paganelli
org: both
raised: 2026-11-13
updated: 2026-11-16
depends_on: [OI-69]
blocks: []
severity: high
requirement: DM-06
source: notes/meetings/2026-11-13 Richiesta call urgente.md
---

# OI-365 - The Opportunity cannot return from Vinta once a payment is reversed

**From 13 November an Opportunity goes Chiusa/Vinta as soon as one invoice on its
order is collected. It never comes back. The case that forces it back — a payment
registered by mistake and later reversed in Mexal — is a real case the client gave
ROMI themselves, and it has no mechanism. The agreed answer is that a System
Admin edits the record by hand and the reports disagree with the logic. Nothing has
been written for the client beyond one line in a recap mail, and the proper fix is
parked on a Fase 2 that is not yet approved.**

## Why it is one-way

Told to the client on the 13/11 call, by the developer, three times:

> _"se un'opportunity va in vinta, quella rimane in vinta"_
>
> _"**non c'e nessuna casistica che mi fa portare indietro l'opportunity.** Anche
> se tu vuoi correggere poi le fatture non va indietro."_

The reason is the trigger point, not a missing branch. The automation fires on the
transition of the **first** order line to paid. Aurel Mrruku:

> _"se tu lo fai a mano … quando arriva la seconda trans l'opportunity non cambia
> piu, rimane non vinta, **non scatta piu l'automatismo**, perche l'automatismo
> scatta solo alla prima tranch."_

So a manual rollback is not merely unsupported: it is unrecoverable, because the
later payments will not re-fire the rule.

## The case that needs it

Aurel Mrruku, attributing it to Fabrizio Paganelli and flagging his own
uncertainty — _"l'esempio che m'ha fatto Fabrizio, **se non mi sbaglio**"_:

> _"era quando era bonifico bancario … tipo il 20 vengono in automatico come tutto
> pagato, ma a fine mese ci rendiamo conto che non e stato tutto pagato e dobbiamo
> portarlo in non pagato."_

🔴 **Fabrizio Paganelli was invited to that call and did not attend**, so the one
person who owns the Mexal side never confirmed his own example. Elena Spini's
recap mail says so: _"Riconfermeremo il tutto anche con Fabrizio, che oggi non era
presente."_

## What was agreed instead

| | |
| --- | --- |
| **Correction route** | System Admin, by hand. Aurel Mrruku: _"sistem admin … puo fare tutto"_, through an admin extension, and _"dietro le quinte rilasso le condizioni, quindi ti faccio fare modifiche anche quando un'opportunita e in vinta, ti faccio cambiare lo stato **solo per system admin**"_ |
| **Consequence accepted** | _"se qualcuno lo fa poi vedrete dei dati che **non matciano con le logiche** che avete implementato"_ |
| **Client's position** | Elisa Migliano: _"come regola globale e giustissima … nei casi limite e possibile gestirla dall'admin manualmente?"_ · _"si segnalera, tanto parliamo di un caso limite"_ · _"saranno casi rarissimi"_ |
| **Proper fix** | Deferred to Fase 2, bundled with the scadenzario reverse gear, using the invoice date to identify the first invoice |

🔑 **Why the invoice date is not used today.** Aurel Mrruku: _"io per il momento
**non ce l'ho l'informazione qual e la prima o la seconda fattura**. Io ho
semplicemente che queste righe d'ordine sono collegate a questa fattura a livello
di Mexal."_ Elisa Migliano proposed ordering by invoice date; he accepted it is
possible but needs extra checks, and it was postponed: _"poi portiamo la seconda
logica della data fatture … piu avanti."_

## The written record, and what it does not cover

The only client-facing text is
[Elena Spini's recap mail](../The%20Pienissimo%20recap%20of%20open%20changes.md)
of 13/11 14:46:20Z (Gmail `1a1d55fdf926a7b5`):

> _"l'Opportunity **non torna indietro in automatico**. Se un pagamento viene
> riportato a 'Da pagare', resta vinta. Nei casi eccezionali puo correggerla solo un
> System Admin a mano, e i report potrebbero non essere allineati."_

Aurel Mrruku asked for exactly this, and for a reason:

> _"deve essere scritto da qualche parte perche cosi rischiamo che **dopo 6 mesi
> venite da noi** e dite fate un'analisi cosa e successo."_

🔴 **Not covered anywhere**: who the System Admin is in the client's organisation,
what they are meant to do when it happens, how the reports are to be reconciled,
and whether the admin extension Aurel Mrruku offered has been installed. There is
no runbook.

## The other half: the lock came off

To let the rule work at all, the restriction on editing a won Opportunity's chain
was relaxed. Aurel Mrruku, 13/11: _"l'altra cosa da segnare che devo fare stasera
e **rilassare i cambiamenti** che si possono fare su un opportunity vinta."_
Verified on the 16/11 call: _"non c'e nessun blocco su azioni su quella struttura
… ordini, opportunita, righe d'ordini, asset."_

⚠ This is the same locking that the signed-quote protection and the tranche guards
rely on. Nothing in this window establishes what else that relaxation now permits.

## Related

- [OI-69](OI-69%20Order%20state%20model.md) — the state model itself, superseded on
  13 November
- [the decision](../decisions/Decision%20-%20the%20Opportunity%20is%20won%20at%20the%20first%20collected%20invoice.md)
- [OI-331](OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md) — the
  scadenzario reverse gear, the same missing mechanism one layer down
- [OI-359](OI-359%20An%20interrupted%20contract%20cannot%20unwind%20its%20tranches%20assets%20and%20tickets.md)
  — the third missing reverse gear, also parked on Fase 2
- [OI-342](OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)
  — the Fase 2 these three are parked on, still unapproved
