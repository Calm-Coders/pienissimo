---
id: OI-331
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-04
updated: 2026-11-04
depends_on: [OI-201, OI-212]
blocks: []
severity: gating
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-331 - A reversed collection cannot move the order and asset states back

**The order and asset state machine was deliberately built one-way. Demonstrated
in production on 4 November: a collection was reversed in Mexal, the invoice due
date went back to unpaid, and the asset stayed `Disponibile`. The client's normal
monthly banking cycle reverses collections on the 1st of every month, and if the
asset was inside its ticket-send window the ticket has already gone.**

## How it surfaced

Fabrizio Paganelli asked the operational question during
[the 04/11 production session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md)
and then performed it on screen:

> _"se io mi accorgo che questo incasso l'ho registrato male, cosa facciamo noi?
> Eliminiamo l'incasso. Questa rata qui che l'avevo chiusa, la riapro e
> praticamente adesso il mio cliente mi deve pagare ancora €4.830."_

The sync brought the reversal back — _"In realtà ho fatto una scadenza, è tornato
indietro, vedi?"_ — and the asset did not follow: _"invece qui dovrebbe tornare
indietro in stato di ordinato."_

## 🔑 The design, stated by its author

> **Aurel Mrruku:** _"se sei andato in incassato noi abbiamo fatto in modo che tu
> non puoi tornare mai più dietro indietro, capito? È tutto il meccanismo che era
> con un path, quindi con una via sola in avanti. **Adesso dobbiamo fare in modo
> che anche se sei incassato tu devi poter tornare indietro se aggiorni lo
> scadenzario.**"_

So the forward-only path is intentional, it is the thing that has to change, and
the author named the change on the call. ⚠ **It was not scoped, dated or
assigned.**

## 🔴 Why this is the normal case, not an edge case

Fabrizio Paganelli described the Ri.Ba. cycle he and Mirko Merendi designed:

> _"noi il 20 del mese mandiamo via il flusso \[e\] il cliente si chiude, quindi
> come se ci fosse stato l'incasso, però è un incasso salvo buon fine, per cui il
> giorno uno del mese successivo la banca ci restituisce un flusso di ritorno
> dove ci dice: su 100 Ri.Ba. che mi hai mandato solo 90 sono stati effettivamente
> incassati. Questi 10 il cliente non ha pagato. Quindi noi andiamo in contabilità
> e riapriamo la rata. **Facciamo in modo automatico quello che hai visto fare
> manualmente a me adesso.**"_

🔑 So the reversal happens **monthly, in bulk, automatically**, for every
customer paying by Ri.Ba. The behaviour demonstrated once by hand on 4 November is
the behaviour the system will see on 1 December.

## 🔴 The ticket consequence

Aurel Mrruku: _"Tu pensi di aver aggiustato la fattura, ma è già partito il
biglietto."_ The send fires when an asset becomes `Disponibile` **and** the current
date is inside the window between the mapping's ticket-send date and the event —
Fabrizio Paganelli confirmed the rule: _"se sono sotto data mando il biglietto
subito"_.

Two remedies were floated and neither was chosen:

1. **Batch the sends to the evening**, so there is a working day to correct the
   accounting first — Aurel Mrruku: _"o dobbiamo fare che i biglietti vengano
   inviati ogni sera, così hai tutto il giorno davanti per aggiustare la
   fattura"_. 🔴 **Rejected for the normal case** by Fabrizio Paganelli: _"i
   biglietti non possono essere mandati via ogni sera. A ridosso dell'evento forse
   anche sì, però normalmente no."_
2. Gate the send some other way — not specified.

🟢 **The exposure is bounded**, and Fabrizio Paganelli bounded it himself: it only
bites when a collection is reversed inside the ticket-send window, which is near
the event — _"questo avviene quando noi riceviamo degli incassi che sono
immediatamente vicini all'inizio dell'evento. La Mastery ci sarà il prossimo
maggio."_ Aurel Mrruku agreed: _"se non sei dentro la fascia dell'invio del
biglietto non deve succedere."_

## Where it was routed

🔑 **Fase 2, by agreement in the room.** Fabrizio Paganelli: _"Fase due. Questo
era."_ Aurel Mrruku: _"dobbiamo fare attenzione nella fase due"_ and _"ci sono
diversi corner case che dobbiamo essere molto molto attenti a gestire con dei
flussi ad hoc per questi casi qua."_

🆕 **A meeting is owed**, with four named people and no date: Elena Spini,
Fabrizio Mastracci, Rebecca and Fabrizio Paganelli — _"dobbiamo essere molto molto
attenti adesso anche con Elena, con Fabrizio di Romi, con voi Rebecca, di capire
quello che deve succedere quando tu vai indietro"_. Fabrizio Paganelli asked for
Rebecca specifically: _"dopo quando parleremo di queste cose facciamo venire anche
la Rebecca."_

## Why it is open

1. 🔴 **The asset is wrong in production right now** for any reversed collection,
   and nothing detects it.
2. 🔴 **There is no decision** on whether the asset reverts, and if it does, what
   happens to a ticket already nominated — the restore path is itself Fase 2
   ([OI-253](OI-253%20Restoring%20a%20ticket%20after%20an%20accidental%20rinuncia%20is%20Fase%202.md)).
3. 🔴 **The Ri.Ba. return flow is not built**, and the Ri.Ba. territory is already
   priced into Fase 2 R2 at 12/02/2027 — so the automatic reversal arrives **after**
   the manual one is in daily use.
4. ⚠ **Nothing says whether the Order's own `Incassato` state reverts** either.
   `OrderItemTriggerHandler` moves orders forward into `Incassato` and, since
   4 November, between `Ordinato` and `Fatturato`
   ([OI-314](OI-314%20The%20order%20line%20fatturato%20status%20is%20not%20implemented.md)) —
   that rule explicitly _"never touches `Incassato`"_, which is exactly the state
   this item needs to be reversible.

## Related

- [OI-201 Ri.Ba. payments are read as unpaid because only P counts](OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md)
- [OI-212 A Ri.Ba. rate reads as paid before its due date](OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
- [OI-206 The Insoluto concept has no invoice due date and no invoice record](OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md)

**Closing it:** a collection reversed in Mexal, and the Salesforce order, tranche
and asset all returning to the state they held before it — with a recorded answer
for the ticket that was already sent.
