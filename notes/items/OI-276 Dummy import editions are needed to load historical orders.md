---
id: OI-276
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-10-21
updated: 2026-10-27
depends_on: [OI-244]
blocks: [OI-274, go-live]
severity: gating
source: notes/meetings/2026-10-21 Tema Migrazione.md
---

# OI-276 - Dummy import editions are needed to load historical orders

**Every order line in the historical load must resolve to an edizione whose date
range contains its invoice date, or the import fails outright. Past events have
no edizione in Salesforce and creating the real ones would hand customers
tickets to events they have already attended. The agreed answer is throwaway
editions with deliberately silly names covering the earlier periods, whose
tickets are then deleted en masse.**

Designed by Fabrizio Paganelli at `01:16:52` of
[the 21/10 afternoon session](../meetings/2026-10-21%20Tema%20Migrazione.md) and
accepted by Aurel Mrruku, who judged it better than the alternative:
_"Sì, sì, sì. Ha anche più senso così."_

## Why it is needed

Aurel Mrruku: _"tutti i prodotti che fanno parte in questi ordini devono avere
delle edizioni e una mappatura in Sales Force edizione prodotto, altrimenti non
si lega con l'edizione"_, and without it _"mi esplode tutto, perché non trova la
campagna."_ The mapping must exist **before** the load: _"si deve fare prima
dell'import[o]."_

The trap Fabrizio Paganelli spotted: creating a real `Academy 2026` edizione to
satisfy an older invoice would make its tickets available again —
_"mi renderai disponibile un biglietto legato all'Academy 26 … cosa che noi non
vogliamo."_

## The mechanism, as stated

For each event, two editions:

- the **real** future edizione, which generates tickets and links — e.g.
  `Academy 2027`, dated 22 January 2026 to 19 January 2027;
- a **dummy** edizione covering everything earlier — Fabrizio Paganelli's
  working name was _"Academy Pippo"_, refined by Elena Spini to the
  `… Import <anno>` form: _"è Academy Import 2026 per quella passata"_, _"tutto
  ciò che è edizione import anno passato non deve generare biglietti"_.

Then: run the import, let the tickets generate against both, and delete the
dummy ones. _"Poi sarà male che andiamo a eliminare i biglietti su Academy Pippo
e così per tutti gli altri gli eventi … Se potete farlo voi con un update
massivo."_ Aurel Mrruku confirmed he can: _"basta che mi dai l'evento, ti annullo
tutti i biglietti di quell'evento."_

⚠ **The two candidate names are not reconciled.** `Academy Pippo` is what the
client wrote on screen; `Academy Import 2026` is what Elena Spini proposed and
what the Gemini notes record as agreed. **No naming convention was fixed** — and
the name is what Aurel Mrruku will key the mass deletion on.

## Why the simpler route was rejected

Aurel Mrruku proposed leaving the open orders on Zoho until the last event
closes and importing only true history: _"non sarebbe possibile per questi ordini
aperti tenere Zo[ho] [fino a] quando c'è l'ultimo evento?"_ Fabrizio Paganelli
ruled it out three times — _"Non ce la faremo mai"_ — because the client is
already invoicing events out to **September 2027**: Soldout in March, Camerieri
Venditori and PEAM in April, Mastery through the academic year, which runs
September to May.

Worked example recorded in the call: Camerieri Venditori moved from March to
**6 April 2027**, so its real edizione spans 25 March 2026 to April 2027 and its
dummy edizione spans 1 January 2025 to 24 March 2026.

## What this costs

- Fabrizio Paganelli must create the editions **and** map every product in the
  load to one. He does not consider it the hard part: _"la mappatura la faccio,
  quello non è un problema … è l'ultimo dei miei problemi."_
- 🔑 The mapping is the single point of failure. Aurel Mrruku: _"Il problema è se
  tu non hai la mappatura in modo corretto, se non trovi l'edizione esplode e
  devo rifare da capo."_
- 🟢 It also removes the closed/open split as a hard requirement. Once dummy
  editions exist Fabrizio Paganelli can pass everything in one file —
  _"non c'è neanche bisogno di fare ordini aperti e ordini chiusi, dico bene?"_ —
  and Aurel Mrruku agreed, keeping the split only as an error-isolation aid:
  _"Per quello li volevo dividere … gli ordini aperti, gli ordini chiusi."_

## Still open

- 🔴 Nothing created. No edizione, no mapping, no load.
- ⚠ The naming convention, as above.
- ⚠ Whether the dummy editions must also be deleted afterwards, or stay as
  inert history. Not discussed.

## 🟡 2026-10-22 — a second mechanism was offered, and a precondition was added

At `00:16:10` of
[the 22/10 session](../meetings/2026-10-22%20Check%20Excel%20Migrazione.md) Aurel
Mrruku proposed a **flag on the real edizione** instead of throwaway editions:

> _"se vuoi ti faccio un campo sull'edizione lo chiamo `old`, quindi vecchio,
> edizione vecchia. E per non generare il link sulle edizioni vecchie, intendo"_

⚠ **Fabrizio Paganelli did not engage with it** — _"adesso io faccio fatica a
seguirti perché sto pensando a questo tracciato"_ — and the call moved on.
🔴 **So two mechanisms for the same problem are on the record and neither has
been withdrawn**: the dummy `Pippo`/`Import` editions agreed on 21/10, and this
flag. They are not equivalent: the flag suppresses link generation on a real
edizione and leaves no tickets to mass-delete, which would make the 21/10
deletion step unnecessary — and would remove the naming-convention risk this row
already carries.

🔑 **A new precondition was stated twice and accepted**: every product in the
historical orders must be **active** before the edizione mapping can be done.

> _"per mettere i prodotti sulla ma[pp]atura i prodotti devono essere attivi
> praticamente. Io ti devo abilitare prima tutti i prodotti"_

and as a closing action: _"E dobbiamo abilitare tutti i prodotti."_ Fabrizio
Paganelli accepted it as temporary — _"se è una cosa temporanea, non è un
problema"_.

⚠ **Nobody said what activating the whole catalogue does to the live product
list tutors see, or who reverses it.** This is the fourth migration-only
condition with no named owner for its removal, alongside the Mexal-send bypass
([OI-267](OI-267%20Loading%20historical%20orders%20would%20push%20them%20to%20Mexal%20and%20generate%20tickets.md)),
the edizione date reversal and the Performance Plus contract bypass
([OI-280](OI-280%20Performance%20Plus%20contract%20generation%20must%20be%20bypassed%20for%20migrated%20orders.md)).

## 2026-10-23 - the activation happened, and a fifth condition appeared

🟢 **The precondition above is satisfied.** Elena Spini to the client,
13:15:52Z (Gmail `1a168166785585be`): _"I prodotti sono già tutti attivi in
ambiente di UAT, quindi puoi procedere"_, and Aurel Mrruku in
[the 16:00 call](../meetings/2026-10-23%20Import%20Ordini%20Migrazione.md):
_"ieri ti avevo detto ti metto tutti i prodotti attivi in sales force … adesso
anche i prodotti vecchi attivi."_ 🟢 **The mapping is formally unblocked** —
_"puoi procedere con la configurazione di edizione e mappatura-edizione."_

⚠ **Still nobody named to reverse it**, and nothing says what the whole active
catalogue does to the product list tutors see. Unchanged from 22/10.

🔴🔑 **A fifth migration-only condition is now on the record: the Mexal product
synchronisation flows are disabled.** Aurel Mrruku, same call: _"li ho
disabilit[ati] ci sto lavorando per quello"_, confirming the client's
observation _"adesso i flussi di sincronizzazione sono disabilitati,
chiaramente."_

🟢 **Unlike the other four it has an owner by his own statement** — he disabled
it and is working inside it. ⚠ **It still has no date for reversal and nothing
that checks**, and it has an immediate consequence for this row: the client's
`categoria statistica` edits in Mexal **do not reach Salesforce by themselves**,
so the mapping this note depends on must be built after a manual re-import. See
[OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).

⚠ **The naming convention is still unreconciled** (`Academy Pippo` vs
`Academy Import 2026`), and ⚠ **neither mechanism has been withdrawn** — the
`old` flag was not mentioned on 23/10 either.

## 2026-10-26 - a third mechanism, and the first usable constraint

🔴 **The mechanism drifted again** in
[the 11:00 call](../meetings/2026-10-26%20Tema%20Ordini%20Mexal.md), `00:29`.
Aurel Mrruku offered the `old` flag a second time — _"vuoi che ti metto un flag
edizione vecchia? Così non genero il link"_ — and **Fabrizio Paganelli did not
remember it at all**: _"sinceramente non mi ricordo il tema del flag."_ He
described a third shape instead, an _"edizione bidone"_ bounded by dates:
_"creavo un'edizione bidone con la data dell'ordine antecedente alla data inizio
del p[i]enissimo live 26."_

🟢🔑 **The useful part is the constraint Aurel Mrruku then stated**, which no
earlier record contains and which explains why any of the three variants works:

> _"L'importante è che **la data non sia nel futuro**, perché altrimenti
> marketing prenderà il link."_

So the requirement is not the flag, the name or the bin edition as such — it is
that a historical edizione's dates must lie in the past, because the marketing
journey selects on future dates. Any mechanism satisfying that will do; 🔑 **this
is the first time the underlying rule is on the record rather than one of its
implementations.**

⚠ **Nothing was chosen.** _"dopo magari ci risentiamo su come devo creare queste
mappature."_ Three variants now coexist — dummy `Pippo`/`Import` editions, an
`old` flag, a past-dated _edizione bidone_ — and **none has been withdrawn**, a
second consecutive session.

🟢 **Its blocking precondition cleared.** The whole-catalogue activation is done
and confirmed twice on 26/10: in the call (_"Ho già abilitato tutti i
prodotti"_) and by mail at 15:54:22Z. ⚠ **Still nobody says who reverses it**,
and ⚠ **still nothing says the product synchronisation flows are switched back
on** — the 23/10 finding stands, and this round trip ran manually through
Kreosoft.

## 2026-10-27 - the mirror-image rule, for future events

🔑 **The same automation was discussed from the other direction, and the rule
inverts.** [The 27/10 Anagrafica Articoli call](../meetings/2026-10-27%20Anagrafica%20Articoli.md),
`00:08:27`, on an event whose date is not yet fixed (Food Marketing Festival
2027):

> **Aurel Mrruku:** _"nessuno ti vieta di mettere una data troppo in là e poi la
> modifichi nel momento in cui tu hai la data precisa … **metti una data molto in
> là**, quindi che sai che **non scatta l'automatismo dell'invio dei
> biglietti**."_

So:

- **Historical import** → the date must **not** be in the future, _"perché
  altrimenti marketing prenderà il link"_ (26/10, this row above).
- **Future unscheduled event** → the date must be **far** in the future, so the
  send does not fire early.

🟢 **Both are the same guard seen from two sides** — the ticket-send automation
keys off the edizione date — and together they are the clearest statement of that
rule the record holds. ⚠ **Neither is in the requirement register.**

🔴 **And the far-future workaround guarantees later manual repair.** Every
edizione created with a placeholder date will need its ~20 product mappings
hand-edited when the real date arrives —
[OI-291](OI-291%20Changing%20an%20edizione%20date%20does%20not%20update%20its%20product%20mappings.md).
The two rules were agreed in the same conversation and **the compounding was not
raised by either side.**

⚠ **Still three competing dummy-edizione mechanisms**, none withdrawn. Nothing on
27/10 chose between them.
