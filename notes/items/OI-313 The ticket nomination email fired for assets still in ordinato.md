---
id: OI-313
type: open-item
status: open
owner: Aurel Mrruku
with: Elena Spini
org: both
raised: 2026-11-03
updated: 2026-11-05
depends_on: []
blocks: []
severity: gating
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-313 - The ticket nomination email fired for assets still in ordinato

**A live production email went to the client telling him his tickets were ready, for
an order whose assets were still `ordinato` and whose tickets do not exist. The cause
is known: the event link reached `pronto`. ROMI has promised the client an answer and
has not given one.**

## What the client received

At **12:33 CET on 3 November**, about twelve minutes after
[the e2e production session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) ended,
Fabrizio Paganelli received `SPAM EDIZIONE TEST: i tuoi biglietti sono pronti.`,
sent from the project's Salesforce marketing sender, asking him to complete
participant data. He forwarded it at **12:35 CET** (Gmail `1a1a131d3129e774`):

> _"facendo i test ci è arrivata questa mail per nominare i biglietti. Per un ordine
> che ha asset in ordinato e quindi non ancora disponibili. La mail non sarebbe dovuta
> arrivare. Probabilmente dipende dal fatto che l'ambiente di produzione non è ancora
> tutto configurato, giusto?"_

🔑 **Clicking the buttons confirms it is wrong.** Elena Spini, 13:01 CET:

> _"Confermo che non sarebbe dovuta arrivare questa mail, anche perché se provi a
> cliccare sui bottoni Accetta o Rinuncia dell'email atterri sulla community dove vedi
> il messaggio: **"Non ci sono biglietti disponibili per questo account."**
> Verifichiamo e vi faremo sapere."_

⚠ **The mail body also shows empty event fields** — `Dove:`, `Check-in:`, `Fine
evento:` and `Indirizzo:` are all blank, with only the date `15/11/2026` populated.
That is the test edition created on the call, so the blanks are expected here, **but
the template renders them as empty labels rather than suppressing them.**

## 🔑 The cause, diagnosed the same hour

In the marketing group DM at **12:46 CET** Elena Spini named it:

> _"secondo me il problema qui è che il link era in PRONTO"_

This matches the transcript. During the test she noticed the event link had already
reached `pronto` — _"L'event link ce l'ho già su pronto … Non me l'aspettavo in
pronto"_ — and Aurel Mrruku confirmed _"il link è pronto, ma non ci sono
biglietti"_. **They verified the landing page behaves correctly and moved on.** The
mail then fired off the same state.

⚠ Elena Spini, 12:46 CET, also saw the order move: _"quindi partono le logiche di
Fabrizio, mentre ora vedo che è IN ATTESA - hai cambiato qualcosa?"_ on order
`801SW00000hBue3YAC`. Aurel Mrruku: _"io non ancora, sto lavorando coi permessi"_.
⚠ **Why the state changed was not established.**

## Why it is open

1. 🔴 **ROMI owes the client an answer** — _"Verifichiamo e vi faremo sapere"_ — and
   none was sent on 3 November.
2. 🔴 **It is a production send to a real mailbox.** The next one could reach a
   customer. The marketing flows are live in production while the environment is, in
   Fabrizio Paganelli's words, not fully configured.
3. 🔑 **The gate is the wrong one.** The nomination mail keys on the **event link
   state** (`pronto`), not on whether any asset is actually `disponibile`. Those are
   different facts, as this send proves.
4. ⚠ **Whether the sender's own prefix is intended is unclear** — the subject arrived
   as `SPAM EDIZIONE TEST: …`. **Not investigated.**
5. ⚠ **Which flow owns the send is not recorded here.** It is marketing-side; see
   [OI-311](OI-311%20The%20marketing%20flow%20update%20needs%20clean%20test%20records.md),
   where Fabrizio Mastracci's rebuilt flow is _"quasi terminato"_ and awaiting clean
   records.

## Related

- [The agreed Asset and ticket send logic document](../The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md)
- [The marketing ticket send logics as written by Marketing](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)
- [Decision - asset states stay as built and the ordinato label is not renamed](../decisions/Decision%20-%20asset%20states%20stay%20as%20built%20and%20the%20ordinato%20label%20is%20not%20renamed.md)

## 🔴🔑 2026-11-04 - it fired again, and the diagnosis moved off the event link

**Second occurrence in two days, in production, during
[the 04/11 e2e session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md).**
Fabrizio Paganelli, mid-test with the assets still `ordinato`: _"Qui mi sono
arrivati i biglietti. **Sono già arrivati.**"_ Aurel Mrruku: _"Là dobbiamo capire
cosa sta succedendo perché non è corretto."_

🔑 **So this is reproducible, not a one-off.** Point 5 above — which flow owns the
send — now has an answer, and it is not the one point 3 assumed.

Looking at the asset list on screen, Aurel Mrruku put it on the **marketing flow's
own filter**, not on the event-link state:

> _"Molto probabilmente sta facendo il filtro in modo sbagliato marketing e che
> non è disponibile … chi non sta prendendo correttamente."_
>
> _"Penso che ha lasciato … lui aveva fatto un flow tipo un mese e mezzo fa, penso
> che non l'ha aggiornato."_

So the owner is **Fabrizio Mastracci's flow**, on a version predating the asset
logic it is filtering against. Aurel Mrruku undertook a call: _"ne faccio delle
call con lui, forse appena chiudo con te o domani mattina."_

⚠ **A confound that strengthens the case.** Fabrizio Paganelli had deliberately
pushed the mapping's ticket-send date far into the future — _"io Academy 27 nella
mappatura ho messo data invio biglietto, tutto quanto al 31/12/27 per il momento
per evitare di far casino"_ — so this send happened **outside any plausible send
window**. That is direct evidence the date gate is not being read either.

## 🔴 ROMI still has not answered the client, 30 hours on

- **Elena Spini promised an answer on 03/11** and none was sent that day.
- 🔴 **Aurel Mrruku declined to write on 04/11.** Elena Spini on Slack, 16:47 CET:
  _"puoi scrivere a Fabrizio nella chat comune?"_ → Aurel Mrruku 16:51: _"oggi no,
  domani faccio dei controlli che sto portando avanti i sviluppi richiesti."_
- 🟡 **Elena Spini escalated internally instead**, 17:29: _"Inizio a mettere sul
  gruppo e poi faccio reminder domani"_, and at 18:26 told Fabrizio Mastracci in
  the marketing group DM: _"sembra esserci un problema sull'invio dei biglietti in
  PROD … hanno notato che i biglietti vengono di nuovo inviati quando lo stato
  dell'asset è in ordinato"_, with _"domani ti manderà lui i dettagli"_.

🔑 **So the client has been told nothing for two days on a production send to a real
mailbox, while ROMI has now reproduced it internally.** The details Fabrizio
Mastracci was promised are owed by Aurel Mrruku on **5 November**.

## 🟡🔑 2026-11-05 - the flow was changed in Prod, the retest passes, and the diagnosis moves again

🟢 **A production flow change was made on 4 November, early afternoon.** Aurel
Mrruku in the marketing group DM, 11:55 CET: _"abbiamo fatto un aggiornamento del
flow in prod, sul nomina biglietto deve essere ok"_; Elena Spini confirmed the
timing: _"l'ha fatto Aurel ieri primo pomeriggio"_. 🆕 Fabrizio Mastracci named what
changed, 11:56: _"abbiamo cambiato una **regola di ingresso** che prima era un campo
status url (cosi mi era stato detto) e ora **`status__c`**"_. ⚠ **Nothing says the
change is in source**, and this is a direct Prod edit of the kind
[JOURNAL.md](../../JOURNAL.md) already lists as undeployed drift since 29/10.

🟢 **Fabrizio Mastracci retested and it behaved as specified**, 11:49-11:51 CET:
_"abbiamo rifatto io ed Aurel un giro di compilazione del biglietto e abbiamo visto
lo storico degli invii email da Marketing cloud"_ → _"sembra che funzioni ESATTAMENTE
come ci hanno chiesto che funzionasse … se rinuncio o compilo almeno un biglietto
vado fuori dal flow"_. He tested on `Event_Invitation__c` `a03SW00000ewEtOYAU`.

🔑 **And he offered a third explanation, against the second.** 11:50-11:52 CET:

> _"Quello che abbiamo notato è che **loro non si sono mai mandati biglietti**, quindi
> di fatto non hanno mai confermato."_
>
> _"Possiamo affermare al 99% che **non hanno fatto i test** / o che hanno **confuso
> il link di richiesta biglietto** con quelle che effettivamente inviano in allegato
> il biglietto."_

⚠ **This is not reconciled with the 04/11 evidence.** Aurel Mrruku was in the room
when it fired during the test — _"Sono già arrivati"_, assets `ordinato` — and
attributed it to the marketing flow's own filter on a version 1.5 months old. A
retest passing after a Prod entry-rule change is consistent with the fault having
been real and fixed; the _"non hanno fatto i test"_ reading says it was never real.
🔴 **Nobody has stated which it is**, and the 03/11 occurrence was a mail to the
client's own mailbox, so at least one send is not in doubt.

🔴 **The client has still been told nothing — third day.** Everything above happened
in a ROMI-internal DM. No mail in this window goes to Pienissimo about it, and Elena
Spini's _"Verifichiamo e vi faremo sapere"_ of 3 November is still outstanding. ⚠ The
details Aurel Mrruku owed Fabrizio Mastracci on 5 November were delivered as a call
instead (_"adesso ci sono se vuoi ci sentiamo in una call"_, 10:15 CET); what was
agreed on it is not recorded.

⚠ **Residual, and untested**: the empty-field rendering noted above and the
`SPAM EDIZIONE TEST:` subject prefix were not revisited, and the deliberate 31/12/27
send date in the mapping — the evidence that the date gate is not read — is not
addressed by an entry-rule change.
