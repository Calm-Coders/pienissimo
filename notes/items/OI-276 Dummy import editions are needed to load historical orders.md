---
id: OI-276
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-10-21
updated: 2026-10-21
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
