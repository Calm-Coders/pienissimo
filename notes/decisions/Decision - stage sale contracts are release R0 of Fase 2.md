---
id: dec-stage-sale-contracts-are-r0
type: decision
status: open
owner: Elena Spini
with: Fabrizio Paganelli
org: both
raised: 2026-11-02
updated: 2026-11-03
depends_on: [OI-304]
blocks: []
source: notes/meetings/2026-11-02 Tema Contratti WooCommerce.md
---

# Decision - stage sale contracts are release R0 of Fase 2

**Decided 2 November, with the client in the room: the stage-sale contract flow is
chargeable Fase 2 work and becomes its first release, R0. It still has to be in
production before Pienissimo Live on 24-26 November, so a Fase 2 release lands
eight days after Fase 1 goes live.**

Elena Spini, on
[the call](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md):

> _"vi devo anticipare che questo però deve passare come primo rilascio della fase
> due, perché io queste giornate poi le devo mettere da qualche parte. Noi abbiamo
> già finito tutte le giornate possibili immaginabili."_

🟢 **The client accepted** — Fabrizio Paganelli: _"Sono d'accordo che lo devi
aggiungere"_ — and Elena Spini warned the days would be visible in the estimate:
_"sappiate che se vedrete queste giornate in più nella stima … è per questo, anche
perché è un rilascio, il primo rilascio che dobbiamo ufficializzare."_

🟢 **It is the first application of
[the margin ruling](Decision%20-%20new%20scope%20after%2026%20October%20goes%20to%20Fase%202.md).**
Gianpaolo Motta's 26 October instruction — everything new goes to Fase 2 — had been
applied to nothing for a week. This is the first time it was said to the client and
acted on.

🟢 **It is in the documents the same day.** R0 appears in both
[the Fase 2 offer and project plan](../The%20Fase%202%20offer.md) at **5-7 days**,
dated November 2026, _"In produzione prima di Pienissimo Live (24-26/11)"_. ROMI's
own internal sizing in Slack the same morning: Elena Spini _"metto 6gg?"_ → Aurel
Mrruku _"si"_ → _"6-7gg??"_ → _"si"_.

## What is unresolved inside the decision

1. ⚠ **The scope the client agreed to may be narrower than the scope priced.**
   Fabrizio Paganelli's full sentence was _"Sono d'accordo che lo devi aggiungere
   **solo per la parte della Plus corsi**"_, and both decks price R0 for standard
   courses **and** Performance Plus. **Nobody raised the difference.**
2. 🔴 **The release date is unsettled.** Aurel Mrruku offered **19 November**
   (_"il 19 te lo passo in produzione"_), Fabrizio Paganelli pushed for **18**, and
   the decks say only _"before 24-26/11"_. **The bundle must be built on Monday
   23 November**, which is the real deadline.
3. 🔴 **It is not confirmed in writing.** The agreed mechanism is a solution
   document or blueprint addendum, drafted by Aurel Mrruku and Elena Spini, put to
   the client **Wednesday 4 November** — _"Ce la devono confermare e poi
   procediamo"_. ⚠ Until that happens this is a verbal classification of chargeable
   work, which is the exact failure mode Aurel Mrruku named: _"non vogliamo cadere
   gli stessi errori di prima."_
4. ⚠ **Nobody has said whether R0 is contingent on the client approving Fase 2.**
   The project plan sets _"Approvazione Fase 2 entro il 13/11"_, which falls
   **before** R0's build window. **The dependency is unstated.**

## 🟢🔑 2026-11-03 - the classification is in front of the client in writing

[The functional analysis](../The%20stage%20sale%20contract%20functional%20analysis.md)
went to Fabrizio Paganelli, `amministrazione@pienissimo.com` and Sabatino Rinaldi at
**18:00:14Z**, and states it plainly:

> _"Impatto sulla Fase 2. **Le giornate della Fase 1 sono esaurite.** L'intervento entra
> come **primo rilascio ufficiale della Fase 2** e si aggiunge alla stima in
> preparazione."_

🔑 **This is the first time the 26 October margin ruling has been put to the client in a
document.** Until now it had been said once on a call.

🆕🔑 **And it asks for written confirmation, with a date and an owner.** **OP-3**:
_"Conferma scritta dell'inserimento nella Fase 2 come primo rilascio di questa nuova
funzionalità, **prima dell'inizio dello sviluppo**. La proposta di Fase 2 era attesa
entro il 13/11."_ — owner **Pienissimo**, due **05/11**.

🟢 **So the open question of whether R0 depends on the 13 November Fase 2 approval is
answered**: ROMI is not waiting on it. It seeks a standalone R0 confirmation by
5 November, eight days ahead of the proposal deadline, and development starts the week
of 9 November on that confirmation alone.

🆕 **A meeting to close it**: **Thursday 5 November 12:00-12:30**, a Fase 2 recap
_"compreso questo primo rilascio, così chiudiamo insieme gli Open Point"_.

### The sizing, and why it is thin

**6-7 days**, settled in the internal follow-up — Aurel Mrruku: _"Fai così, fai 6-7
giorni … diciamo 7 giorni alla fine."_ Both Fase 2 decks say 5-7.

🔴 **Aurel Mrruku does not believe it**, and said so twice:

> _"Ho la paura che abbiamo messo davvero poche giornate … Sai quanto mettevo per un
> template? **da 10 a 15 giorni**"_ — _"2-3 giorni"_ with AI.

🔴 **Elena Spini cannot ask for more**: _"E non posso chiedere più i giorni, mi sa che
già m'ammazzano."_

🔴 **And the seven days cover more than the document describes** — the new Order template
built from scratch, the **DocuSign return-trigger rewiring**
([OI-322](../items/OI-322%20The%20DocuSign%20return%20trigger%20only%20handles%20quotes%20not%20orders.md)),
**two templates rather than one**
([OI-326](../items/OI-326%20A%20second%20PDF%20template%20is%20needed%20for%20corsi%20and%20for%20Plus.md)),
the **bundle Plus classification**
([OI-328](../items/OI-328%20A%20bundle%20containing%20a%20Plus%20product%20must%20be%20flagged%20as%20a%20Plus%20bundle.md)),
and the signature status the client has yet to specify.

🔴 **Aurel Mrruku is alone on it.** _"c'ho un sacco di progetti che sono partiti adesso.
Eh, Regina su un progetto, Ana e Sara su un altro che durerà tipo 6-7 mesi **e il lavoro
lo devo fare io**. Amen."_ ⚠ Names as transcribed and **uncertain**; almost certainly
Rexhina Hysi, Anita Aga and Sara Aga.

🟢🔑 **The scope ambiguity this decision carried is resolved in ROMI's favour.** Aurel
Mrruku checked the 2 November transcript himself and confirmed the contract is wanted for
**all** stage sales, courses and Plus alike — so pricing both in R0 matches the
agreement, and Fabrizio Paganelli's _"solo per la parte della Plus corsi"_ did not narrow
it.

### ⚠ The Fase 2 day count is still unreconciled, and they know

> **Aurel Mrruku:** _"Sai cosa faranno qua? Metteranno una media o il 58?"_
> **Elena Spini:** _"mi sa che poi lui ha detto la media … lo scopriremo."_

**150 giornate** in the offer against **58 - 78** in the plan. 🔑 **Not an oversight
nobody noticed — ROMI is aware and waiting to be told.** Aurel Mrruku: _"è un bagno di
sangue."_

🆕🔑 **And the route to settling it was fixed on the e2e call.** Andrea Galotto told Elena
Spini to do a pass with the project's owner before taking a call with **Daniela**.
Agreed: **Elena Spini and Fabrizio Paganelli review the activity list first** — _"la
lista delle attività è già definita, però poi c'è il preventivo"_ — then **Andrea Galotto
and Daniela handle the quote and the numbers**. ⚠ **Daniela appears to be
Pienissimo-side** — Fabrizio Paganelli undertook to brief her — but this is **inferred,
not established**.
