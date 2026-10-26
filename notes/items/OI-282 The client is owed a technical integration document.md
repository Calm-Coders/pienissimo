---
id: OI-282
type: open-item
status: open
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-21
updated: 2026-10-21
depends_on: []
blocks: []
severity: normal
source: notes/meetings/2026-10-21 Check Dati Migrazione e OP.md
---

# OI-282 - The client is owed a technical integration document

**The client asked whether the integration logic he had just been walked through
exists in writing, and Aurel Mrruku undertook to write him a technical document
covering the Salesforce / Anticipay / Mexal chain, its lookup tables and its
system responses. No scope, format or date was agreed.**

Agreed at `02:42:04` of
[the 21/10 morning session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md).

Fabrizio Paganelli asked because he expects to forget it: _"voi tutte queste cose
qua le avete scritte in un documento? … dopo sono documenti che sono documenti
che ci date perché io temo che queste cose poi dopo tra un mese e mezzo me le
dimentico."_

Aurel Mrruku: _"ti farò un un documento tecnico perché … non è solo questa.
Dietro le quinte ci sono un sacco di logiche[,] vanno a vedere le tabelle, le
risposte eccetera."_ Elena Spini confirmed it to the client as a deliverable:
_"Tu avrai il documento tecnico di Aurel."_

The Gemini notes for the session record it as an action item: _"Redigere un
documento tecnico dettagliato che descriva la logica di integrazione tra
SalesForce, Anticipay e Mexal."_

## What it has to contain, from the same call

The order/contract chain Aurel Mrruku narrated at `02:18:59`–`02:20:23` is the
substance of it, and is written up in
[the meeting note](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md).
Beyond that he named: the lookup tables, the Mexal and Anticipay responses, and
the error paths — including the fact that integration failure mails will be
repointed from his own address to the client's.

## Still open

- ⚠ **No date, no format, no scope boundary.** It is an undertaking, not a
  commitment with an owner's date against it.
- ⚠ Nothing says whether it is client-facing documentation subject to the
  publishing rules, which would exclude credentials, catalogue prices and
  article-code values.
- 🔑 It overlaps the project's own records: this repository already holds the
  integration behaviour in `notes/flows/` and `notes/objects/`, in English.
  **Nobody proposed generating the document from them**, and the two will drift
  if it is written separately.
