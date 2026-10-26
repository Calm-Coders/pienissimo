---
id: meet-2026-10-15-migrazione-e-go-live
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-15
updated: 2026-10-15
source: meetings/2026-10-15-migrazione-e-go-live-transcript.it.md
---

# 2026-10-15 Migrazione e Go-Live

**The session ROMI called to settle migration and go-live moved the go-live date
for the second time — to 2 November, with a Go/No-Go on 27 October — and the
client's product lead said on the record, before the new plan was sent, that
2 November is not achievable. It also replaced the migration source: historical
orders will now come out of Mexal, not Zoho.**

**Source:** [meetings/2026-10-15-migrazione-e-go-live-transcript.it.md](../../meetings/2026-10-15-migrazione-e-go-live-transcript.it.md)
(full raw transcript, 74,341 characters, 01:17:40). Booked 14:30–15:30 CEST,
started 14:31, ran 01:17:40.

Participants, from the transcript header: **Aurel Mrruku, Elena Spini, Elisa
Migliano, Fabrizio Paganelli, Sabatino Rinaldi**. ⚠ Elisa Migliano is named in
the header but **never speaks**; Fabrizio Paganelli says at `00:00` that she is
not there yet and at `00:11` that she _"è dovuta uscire"_. Sabatino Rinaldi
leaves at about `00:20` for an urgent appointment — he says Fabrizio will brief
him — so the last hour is Elena Spini, Fabrizio Paganelli and Aurel Mrruku.

⚠ **Speaker labels are unreliable in the usual way** and the transcript's own
footer says so. It also garbles the ERP throughout as _"Maxal"_, _"Maxile"_,
_"Mexale"_, _"Exale"_ and once _"Zomexal"_; all read as **Mexal**. _"la gente"_
is consistently the dictation of **_"l'agente"_**, and _"Zoo"_ / _"Zomexal"_ of
**Zoho**. Read that way throughout; flagged rather than silently corrected.

## 1. The go-live date moved again, to 2 November

Elena Spini opened by restating the plan as it stood — _"il piano che avevamo
condiviso … riportava il il Golive il 21, ma con l'approvazione del 13"_ — and
then proposed the new one (`00:04`–`00:05`):

> _"La mia proposta è lasciarvi la settimana successiva anche per testare,
> rivedere le ultime rifiniture e il go o no go del goive … e darci il go o no
> go il 27 … martedì 27 go o no go per andare in produzione effettivamente
> operativi il due."_

And on what ROMI does with that week: _"dal 27 in avanti noi portiamo tutto in
produzione"_, with the client potentially able to use production from **2
November**.

She sent it in writing the same evening, **17:35:47Z**, into the
`[ROMI-PIENISSIMO] - Stato Avanzamento Progetto` thread — the same thread that
carried the 6 → 21 October move. See
[OI-243](../items/OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md).

🔴 **Fabrizio Paganelli said in the session that the date will not hold**
(`00:40`), and his reason is training, not build:

> _"se noi vogliamo iniziare a usare Sales force il due, quindi con tutto il
> ciclo degli ordini, la fatturazione eccetera eccetera, bisogna che tutte le
> persone internamente siano formate su questo e da oggi che il 15 di ottobre
> al 2 di novembre non ce la facciamo."_ … _"Non non ce la facciamo a a formare
> 7-8 persone che ci sono di là nel commerciale ad utilizzare Sales Force entro
> il 2 di novembre."_

And again, after Elena Spini's proposal of dedicated training sessions: _"son
sicuro che per il due non ce la facciamo, dai. Però, ecco, lavoriamo per
quello, però non illudiamoci di riuscire a farcela."_ See
[OI-246](../items/OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md).

⚠ **None of that doubt is in the mail Elena Spini sent two hours later**, which
presents 02/11 as the date and asks only for acknowledgement.

⚠ **Both sides noticed that 2 November is a public holiday in Italy** — Elena
Spini: _"il 2 di novembre è il giorno dei morti"_, and in a DM at 14:38:43 CEST
_"il giorno dei morti GO-LIVE … mi serbra azzecato per questo progetto 💀"_.
Fabrizio Paganelli's _"adesso vediamo se sarà il 2 di novembre o il 2 di
dicembre"_ was a joke he immediately said was _"una battuta a ragion veduta"_.
He also flagged **another event in mid-November**; last year's Pienissimo live
dates are given as **24 and 26 November**.

## 2. The scope is frozen, in writing

The mail of 17:35:47Z adds a constraint the session only gestured at:

> _"Potranno essere presi in carico solo affinamenti minori o piccole
> correzioni puntuali; non potranno pertanto essere accettate o incluse
> ulteriori modifiche sostanziali rispetto a quanto già sviluppato e
> consegnato. Eventuali nuove esigenze o Change Request sollevate durante
> questo periodo saranno prese in carico nella Fase 2, per la quale invieremo
> un'offerta e un piano di progetto dedicati in un thread separato."_

In the room it was put as _"testare e non stravolgere tutti i piani … un conto
è testare e aggiustare una cosina, un conto è stravolgere il tutto"_ (`00:04`).

🔑 **This is the first time ROMI has committed in writing to send a Fase 2 offer
and plan.** [OI-83](../items/OI-83%20No%20phase%202%20estimate.md) has recorded
the absence of a Fase 2 estimate since August.

## 3. Migration: the source changed from Zoho to Mexal

Elena Spini reported an exchange with Fabrizio Paganelli the previous day
(`00:25`): the critical problem is the Zoho extractions — _"i file che avevamo
iniziato a guardare che ci aveva condiviso, delle estrazioni di Zo[h]o di
preventivi, preventivi testate, preventivi righe"_ — and _"lì c'è da mettere
mani perché … ci sono delle cose da rivedere"_. His proposal, which the session
adopted: **bring the historical orders up from Mexal instead.**

Aurel Mrruku's constraint is that he has no Mexal API for orders — _"su Mexal
io non c'ho un[']API che prende gli ordini da Mexal"_ — so the exchange is a
spreadsheet. What was agreed (`00:30`–`00:35`):

- Aurel Mrruku delivers, **by the evening of 16 October**, an Excel naming every
  field he needs at **Order** and **Order Line** level, with the expected values
  as examples: _"entro domani sera ti creo un Excel con tutti i campi che
  servono a me a livello di ordine, a livello di orderline"_.
- Fabrizio Paganelli maps his columns onto it and populates it — _"se invece tu
  mi dai esattamente i i 10 15 campi che ti servono, io dove li trovo te li
  popolo"_. His own files are _"giganteschi"_, about a hundred fields each.
- Required alongside the order: the **customer reference** (the external id) and
  therefore the **agent**, because the customer carries the agent.
- **Invoices and scadenzari are not wanted** — Aurel Mrruku: _"le fatture non mi
  interessa perché le fatture ce le ho già. Fatture scadenziari le ho già prese
  tutte."_
- **The load runs twice**: a mapping-and-test load in UAT now, the real migration
  **on the day production goes live** — _"nel giorno in cui si va in produzione,
  facciamo la migrazione da quel momento in poi"_.
- Expected state after load: invoiced, and partly collected, derived by running
  the existing nightly procedure against the Mexal id rather than being imported.

See [OI-244](../items/OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).

**Volumes given in the room** (`00:35`), which supersede the guess made a minute
earlier: _"c'ho un archivio con il dettaglio delle righe ordine e praticamente
dal primo gennaio 23 ad oggi siamo attorno ai 51.000 record"_, thinning to
_"attorno ai 10.000 record all'anno"_ because the platform sale no longer runs.
His first estimate in the same exchange was _"20.000 record"_ — ⚠ the two
figures are different scopes (orders vs order lines) and the transcript does not
reconcile them.

Aurel Mrruku's caution is of record and was not challenged: _"non sarà un lavoro
facile, non andrà tutto lì, ti assicuro"_, and the method is to load, find what
breaks, and finish by hand.

### 🔴 A factual contradiction about Mexal sits under the whole plan

Aurel Mrruku, citing Mirko Merendi: once an order is invoiced it is gone —
_"questo ordine è stato rasato via perché è diventato una fattura e nella
fattura c'è la referenza dell'ordine"_. Fabrizio Paganelli says the opposite:
the disappearance is a front-end effect and the order archive persists —
_"non è visibile dall'utente, ma dentro io ho l'archivio degli ordini e
l'archivio delle fatture"_, with order date and number carried on the invoice
record, so he can extract both archives.

Unresolved. Aurel Mrruku proposed another round with Mirko Merendi: _"Se vuoi
facciamo un altro giro con Mirko"_. See
[OI-245](../items/OI-245%20Whether%20a%20Mexal%20order%20survives%20invoicing%20is%20disputed.md).

### Pending Zoho offers are re-entered by hand

Fabrizio Paganelli (`00:40`), on the offers the client has not yet confirmed:

> _"tutti gli utenti una volta imparato a usare il sistema dovrebbero prendere e
> andare a vedere tutte le offerte che hanno pending su Zo[h]o e inserirle anche
> su Sales Force."_

Elena Spini agreed it was clear. 🔑 **This is the operational cost of
[OI-172](../items/OI-172%20Historical%20quotes%20and%20offers%20are%20not%20migrated.md)**,
whose rule is that only orders migrate — stated for the first time as manual
work for the commercial team, with no owner, no volume and no window.

## 4. Marco Montesi gets a System Admin user, as an interim

[OI-240](../items/OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)
is answered (`00:10`–`00:15`). Elena Spini asked for a user for the commercial
lead; Aurel Mrruku explained why the profile question cannot be answered first:

> _"tutti i flussi fino adesso … per tutti i flussi abbiamo usato solo il
> permesso di sistem admin perché avevamo detto confermiamo prima tutto e poi
> decidiamo chi deve vedere cosa … se io adesso devo fare i permessi, ma ci sono
> campi che non servono, ci sono layout che devono cambiare, io li devo rifare
> ogni volta che cambia un campo perché i permessi sono legati con l'entità."_

Elena Spini's decision: give him System Admin now, _"con la l'accortezza che
poi non sarà così nel futuro, così almeno inizia a mettere mano"_. Aurel Mrruku:
_"Quello sì, lo faccio senza problemi."_

Elena Spini will contact him **Monday 19 October** for a guided session on the
lead flow; Fabrizio Paganelli mailed him during the call to tell him so.

🔴 **The profile question is deferred, not answered** — and
[OI-186](../items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)
has carried it since September. Everyone testing the system is still a System
Admin eighteen days before the new go-live.

## 5. Account field sections: who may edit what

Aurel Mrruku shared the Account layout (`00:55`–`01:05`) and walked its sections.
The model as stated:

| Section                        | Editable by                                                 |
| ------------------------------ | ----------------------------------------------------------- |
| **Dati Mexal**                 | administration only — _"non devono essere toccabili dai commerciali"_ |
| **Dati commerciali**           | commerciali                                                 |
| **Mexal dati per provvigioni** | 🔴 **the responsabile commerciale only**                     |
| Technical fields               | nobody operationally; they carried the Zoho id for migration |

Fabrizio Paganelli's requirement on the third: _"devono essere modificabili da
parte del responsabile commerciale, quindi solo da parte di Marco"_, with the
reason stated plainly — _"Io che sono il commerciale a non posso decidere io
quali clienti assegnarmi."_ Aurel Mrruku's proposal to open it to all
commerciali was rejected by both Fabrizio Paganelli and Elena Spini. ⚠ Fabrizio
Paganelli then noted that Marco Montesi will delegate the work anyway —
_"dopo Marco questa cosa qui non la fa … la fa fare qualcun altro"_ — and that
was not resolved. See
[OI-247](../items/OI-247%20Only%20the%20responsabile%20commerciale%20may%20edit%20the%20provvigioni%20fields.md).

**`Agente` moves to the commercial section** and stays editable after the order
has gone to Mexal.

Elena Spini confirmed the `Categoria statistica Mexal` field — which Fabrizio
Paganelli intends to use to flag bad payers — is in the Mexal section and
therefore read-only to the commercial side, and that under the right profile
Marco Montesi _"i dati di Mexal con i permessi giusti non li potrà editare"_.

### 🔴 Two defects found on screen during the walkthrough

1. **The Account's `codice agente`, `categoria provvigioni` and `zona` are
   stale.** With the agent changed to a different user on screen, those fields
   still read the old values — Fabrizio Paganelli: _"però qui è rimasto 19,
   vedo"_. Aurel Mrruku confirmed the order build no longer reads them: _"quando
   creo l'ordine non mi baso [su] questi due campi … prendo il campo
   dall'utente"_, the logic having moved out of the trigger onto the User.
   Fabrizio Paganelli: _"Allora togli addirittura i campi perché sennò facciamo
   casino."_ Aurel Mrruku undertook to keep them updated on the interface
   instead: _"Te li metto aggiornati di là."_ See
   [OI-248](../items/OI-248%20The%20Account%20agent%20and%20provvigioni%20fields%20are%20stale%20against%20the%20User%20record.md).
2. **`Agente ID` is not on the layout.** Fabrizio Paganelli asked for it to be
   visible — _"quello lì se me lo puoi mettere lì che io lo veda anche nella
   schermata"_ — and Aurel Mrruku agreed.

### An agent reassignment does not reach Mexal until the next order

Asked directly whether changing the agent on an Account propagates, Aurel
Mrruku: _"né immediatamente né alla notte, al successivo ordine"_. There is a
`crea cliente Mexal` action but **no update action** — _"non ho previsto un
tasto di aggiorna su Mexal"_ — which he offered to build. 🔴 The case that
makes this matter was put by Fabrizio Paganelli in the same breath: a
responsabile commerciale reassigning books of customers in bulk, _"100 clienti
di Fabrizio e darli ad Elena"_. See
[OI-249](../items/OI-249%20An%20agent%20reassignment%20reaches%20Mexal%20only%20at%20the%20next%20order.md).

## 6. The agent duplicate-code problem resurfaced and was not closed

Aurel Mrruku raised it again against the account import (`00:50`): the same
agent can carry different codes over time — an account created in 2023 with
agent code `01` for Fabrizio, the same agent reading `019` by 2025, _"perché per
qualche motivo qualcuno ha cambiato il codice dell'agente per lo stesso user"_.
His stated fallback was to take the most recent code per agent. 🔴 **Fabrizio
Paganelli refused that**: _"con gli agenti non facciamo casino … Facciamo una
cosa fatta bene."_

It then dissolved rather than resolved: Fabrizio Paganelli pointed out that
accounts come from Mexal and refresh nightly, so the live state should be clean;
Aurel Mrruku said _"allora va bene, non mi preoccupo"_. ⚠ But the example he
raised — an account still pointing at a code whose agent now has another — is
not addressed by a nightly refresh, and he could not produce the case on demand
(_"adesso devo trovare la mail"_), undertaking to reply in the thread. **No
owner, no date, no row of its own**; recorded here and on
[OI-169](../items/OI-169%20Agent%20code%20and%20commissions%20come%20from%20the%20customer%20record.md).

## 7. What else is of record

- 🟢 **Accounts and contacts are already imported in UAT** from Mexal and
  refreshed nightly — _"tutti gli account li prendo da Mexal"_, _"in ambiente di
  test"_. Elena Spini: _"siamo un po' più confident perché abbiamo già fatto
  l'import con i dati che ci ha dato precedentemente Fabrizio"_.
- 🟢 **Aurel Mrruku's own confidence statement**, unprompted (`00:45`): _"a
  livello di flussi ci siamo … abbiamo fatto una decina di test, gli ordini sono
  stati creati in modo automatico, sia i bundle che i attivazione rinnovo che
  quei standard"_. What he expects to be hard is lead conversion and the
  permissions work — _"i campi che non vedono, oppure se abbiamo dato qualche
  permesso in più, qualche permesso in meno"_.
- 🔑 **Marketing Cloud is in production** — Elena Spini: _"Marketing Cloud è già
  in produzione perché sennò non potevamo vedere niente"_ — but configuration is
  unfinished and it was explicitly held back from the client's autonomous tests:
  _"dato che sono arrivati anche i form all'ultimo ci stiamo ancora lavorando"_.
  Sabatino Rinaldi was content: marketing is the part he worries about least.
- 🔑 **A UAT session is set for 16 October** to show the client the ticket and
  marketing flows, for Marco Montesi, Rebecca Marmo and Sabatino Rinaldi.
  Fabrizio Paganelli's framing: _"domani vediamo il flusso così come è oggi"_,
  and he undertook to let ROMI finish the flow before interrupting.
- **Train-the-trainer is the training model**: Elena Spini trains Marco Montesi,
  who trains the agents, with dedicated sessions proposed for **26–30 October**.
- 🔴 **[OI-161](../items/OI-161%20The%20event%20check-in%20app%20must%20integrate%20with%20Salesforce.md):
  Andrea Parmeggiani has still not answered** — Elena Spini, in the closing
  minute: _"Aurel ha mandato 7 giorni fa l'[API] per l'autenticazione del Q[R]
  Code a Andrea … Io l'ho ripingato e non ci ha risposto."_ Fabrizio Paganelli
  will chase him physically: _"adesso mi metto i guantoni da box, vado di là e
  faccio in modo che vi arrivi."_
- ⚠ **`Cambi di ragione sociale` was agreed into Fase 2 in the room.** Elena
  Spini: _"Se sei d'accordo, lo mettiamo a perimetro della fase due"_; Fabrizio
  Paganelli: _"Va bene, va bene."_ That closes the acceptance
  [OI-234](../items/OI-234%20Tranche%20invoicing%20when%20the%20customer%20changes%20legal%20entity%20mid-order.md)
  was waiting on — ⚠ though Elena Spini herself then observed _"Anche Fabrizio è
  mi dice va bene a tutto quello che gli dico. Anche lui stanco."_
- ⚠ **Capacity, stated by the client**: _"Siamo solo io e lei"_ — Fabrizio
  Paganelli and Elisa Migliano are the whole administration, and he says they
  have run the project alone, _"ci siamo trovati a fare i call da soli, a
  portare avanti il progetto da soli praticamente"_. He rates the platform
  positively — _"a me mi è piaciuta e anche intuitiva"_ — and expects bundles,
  pacchetti and tutors to gain operationally.
- ⚠ **Unidentified names recur**: _"Davide Stefani"_ (second session running),
  _"Carmine"_ / _"Carmen Troiano"_, used as agent examples on screen. Nothing
  establishes whether they are agents, contacts or test records, and none has a
  person note.

## 8. Marco Montesi's automation asks were de-prioritised by his own side

Elena Spini raised her 14/10 reply to Marco Montesi (`00:11`–`00:20`) — the
mail/WhatsApp automations he expects at lead creation, welcome message and a
tutor taking charge within 48 hours — restating that nobody had specified them:
_"Nessuno l'ha mai detto a noi"_, _"ci sono degli automatismi che non sono stati
proprio previsti né … mai parlati"_. Aurel Mrruku corrected the object in
passing: _"già ti dico che la parola opportunità non mi va bene là. Stiamo
parlando di lead."_

🟢 **Sabatino Rinaldi then ruled it out, speaking for Marco Montesi.** He asked
only whether Salesforce can do it at all; Elena Spini confirmed it can, through
Flows and Marketing Cloud (_"avete veramente la Ferrari"_). On that basis:

> _"questo punto lo puoi tranquillamente eliminare perché è una cosa che uno va
> cambiato rispetto a come lo facciamo ora, due va fatta in un secondo momento
> che non è una nostra priorità. Rispondo io per per Marco, questa non è una
> priorità."_

🔑 **This is the first client-side word on
[OI-222](../items/OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md)**,
which until now rested on ROMI's own extra-perimetro ruling. ⚠ It is Sabatino
Rinaldi answering for Marco Montesi, who had not read the mail and is not in
the room; and the texts remain the client's to write — _"quei testi li dobbiamo
comunque decidere noi"_.

🔴 **The reminder mail is still waiting on copy from Marco Montesi**, a
fortnight on: _"abbiamo previsto un invio della mail di cui siamo sempre in
attesa del suo COP[Y] che non ci ha mai più rimandato"_.
