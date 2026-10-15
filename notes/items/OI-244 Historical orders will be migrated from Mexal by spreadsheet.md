---
id: OI-244
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-10-15
updated: 2026-10-15
depends_on: [OI-245, OI-165]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-15 Migrazione e Go-Live.md
---

# OI-244 - Historical orders will be migrated from Mexal by spreadsheet

**The migration source changed. Historical orders no longer come from the Zoho
quote extractions — they come out of Mexal as a spreadsheet, mapped by the
client onto a field list Aurel Mrruku owes him by the evening of 16 October.
This is the first migration method the project has ever agreed.**

Agreed at [the 15/10 session](../meetings/2026-10-15%20Migrazione%20e%20Go-Live.md)
(`00:25`–`00:40`).

## Why the source changed

Elena Spini reported the previous day's exchange with Fabrizio Paganelli: the
Zoho extractions are the critical problem — _"delle estrazioni di Zo[h]o di
preventivi, preventivi testate, preventivi righe"_ — and _"lì c'è da mettere
mani perché … ci sono delle cose da rivedere"_. His own proposal was to bring
the orders up from Mexal instead, and the session adopted it.

Aurel Mrruku's constraint makes it a spreadsheet rather than an integration:
_"su Mexal io non c'ho un[']API che prende gli ordini da Mexal"_. The order→Mexal
direction exists; the reverse does not.

## The method, as agreed

1. **Aurel Mrruku produces the field specification by the evening of 16 October**
   — _"entro domani sera ti creo un Excel con tutti i campi che servono a me a
   livello di ordine, a livello di orderline"_ — with expected example values,
   because the mapping is the client's to do: _"devi essere te a fare il match
   dei campi"_.
2. **Fabrizio Paganelli populates it from Mexal.** His own archives are
   _"giganteschi"_ at about a hundred fields each, which is exactly why he asked
   for a short list: _"se invece tu mi dai esattamente i i 10 15 campi che ti
   servono, io dove li trovo te li popolo"_.
3. **Two sheets, joined by a key**: order, and order line carrying a reference to
   its order — _"ogni riga d'ordine deve avere una reference, quindi una chiave
   che lo collega con l'ordine"_.
4. **The customer reference comes with it**, as the external id, and the agent
   with the customer — _"se c'è il cliente in automatico c'avrà anche l'agente"_.
5. **Invoices and scadenzari are explicitly not wanted** — _"le fatture non mi
   interessa perché le fatture ce le ho già. Fatture scadenziari le ho già prese
   tutte."_
6. **State is derived, not imported.** The orders load as placed and the existing
   nightly procedure reconciles them against the Mexal id, so they become
   invoiced and partly collected by running the integration rather than by being
   declared so. Fabrizio Paganelli: _"facciamo girare la procedura quella di
   interfaccia e in linea teorica tutti quegli ordini lì dovrebbero essere
   fatturati … ed anche incassati parzialmente perché magari non tutte quelle
   fatture sono state pagate."_
7. **It runs twice**: a mapping-and-test load into UAT now, then the real
   migration **on the day production goes live** — _"nel giorno in cui si va in
   produzione, facciamo la migrazione da quel momento in poi"_, because anything
   loaded earlier goes stale as the client keeps trading.
8. **First pass is deliberately small** — _"magari ti posso inizialmente passare
   degli ordini … solo pochi parzialmente [fatturati]"_.

Aurel Mrruku's caution is of record and nobody disputed it: _"non sarà un lavoro
facile, non andrà tutto lì, ti assicuro"_, and when it breaks _"ti dico
esattamente cosa non è andato bene e cerchiamo di farlo a mano a sto punto"_.

## Volumes

Two figures were given a minute apart and the transcript does not reconcile them:

| Figure                | Scope as stated                                      |
| --------------------- | ---------------------------------------------------- |
| _"20.000 record"_     | Fabrizio Paganelli's first guess, _"un numero a caso"_ |
| **~51,000**           | order **lines**, _"dal primo gennaio 23 ad oggi"_     |
| **~10,000 per year**  | his own reading of the recent years                   |

He attributes the difference to volume history — 2023 and 2024 carry many more
lines because the platform sale no longer runs. ⚠ **Orders and order lines are
different counts and the session mixed them**; the field spec will have to state
which number applies to which sheet. These figures sit alongside, and do not
replace, the Zoho-side volumes in
[OI-79](OI-79%20Migration%20volumes%20and%20mapping%20method.md).

## 🔴 What this does not settle

1. **It rests on a disputed fact.** Whether Mexal still holds an order after that
   order has been invoiced is contradicted between Aurel Mrruku (citing Mirko
   Merendi) and Fabrizio Paganelli — see
   [OI-245](OI-245%20Whether%20a%20Mexal%20order%20survives%20invoicing%20is%20disputed.md).
   If Aurel Mrruku is right, the archive Fabrizio Paganelli proposes to extract
   does not exist in the form he describes, and step 2 fails.
2. **No date for the client's half.** Aurel Mrruku's deliverable has a deadline
   (16/10 evening); the population, the test load and the verification do not.
   The real load is pinned to go-live day, which is **2 November**
   ([OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md)) —
   two days **after** the Zoho contract expires, so there is no fallback behind
   it ([the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md)).
3. **Order line states are unmapped.** Aurel Mrruku raised it directly — the
   Salesforce row states (`pagato`, `non pagato` and the rest) are unlikely to
   exist in Mexal: _"Non penso che hai lo stesso valore anche in Mexal."_ The
   exchange moved on without answering it.
4. **The derived-state plan has never been tested on imported data.** It depends
   on the scadenzario sync, which
   [OI-239](OI-239%20The%20Mexal%20scadenzario%20sync%20must%20run%20every%20half%20hour%20and%20nothing%20schedules%20it.md)
   records as scheduled by nothing and run by pasting Apex into a console, and on
   the payment predicate
   [OI-212](OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
   records as wrong. **Deriving `incassato` for ~10,000 historical orders through
   a predicate known to read unpaid rates as paid would produce wrong figures at
   volume**, and no source connects these.
5. **Accounts are already done; orders are not.** Accounts and contacts are
   imported in UAT from Mexal and refresh nightly — _"tutti gli account li prendo
   da Mexal"_. That is the precedent being extended, and it is the only part of
   migration with any evidence behind it.

Closing it means: the field spec delivered, the client's file populated, one test
load into UAT with the state reconciliation verified against known orders, and a
dated plan for the production run.
