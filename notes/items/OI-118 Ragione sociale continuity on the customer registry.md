---
id: OI-118
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-09-03
updated: 2026-09-03
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-118 - Ragione sociale continuity on the customer registry

**When a customer changes its registered company name, the statistics have to
follow it.** Fabrizio Paganelli asked for this at
[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md) and
Aurel Mrruku designed the answer in the room. Three parts, all agreed, none
built.

## 1. The `Azienda Precedente` inner lookup

A lookup on **Account pointing at Account** — Aurel Mrruku's phrase was _"inner
lookup"_ — labelled **`Azienda Precedente`** or `Ragione Sociale Precedente`. It
chains backwards so a record can be traced through **five** predecessors.
Fabrizio Paganelli confirmed five is sufficient operationally.

The field is already in the client's workbook, under the MEXAL section, typed as
`Lookup (con se stessa)` ([OI-24](OI-24%20Data%20model%20workbook.md)).

## 2. History Tracking on the critical fields

For name changes on a **still-active** company — where no new record is created —
Salesforce History Tracking keeps the previous values. Aurel Mrruku named the
constraint himself: **a maximum of 10 tracked fields per object**, with partita
IVA and ragione sociale the ones that matter.

⚠ **Ten is a hard Salesforce limit on a 150-field object**, and the session did
not choose which ten. That choice should be made once and written down, because
retro-fitting a field into tracking does not backfill its history.

## 3. The previous code goes to Mexal

The predecessor company's code is passed across to Mexal, where it is stored in
Mexal's **`codice alternativo`** field. This is the first time that field appears
in the record.

## What this leaves open

- 🔴 **Traversal is not aggregation.** A five-deep lookup chain lets a human click
  backwards; it does **not** make a report sum an account's orders across its
  predecessors. Fabrizio Paganelli's stated need was _statistical continuity_.
  Nobody asked how a report would walk the chain, and Salesforce roll-ups do not
  cross a lookup like this.
- ⚠ **Codice fiscale and partita IVA diverge exactly here.** Fabrizio Paganelli
  noted the two are normally identical but **can differ after a change of ragione
  sociale** — which is why the pre-population agreed in the same session is a
  default and not a mirror. Any dedupe or matching rule keyed on either field
  meets this case first.
- ⚠ **Nothing says who creates the successor record**, or whether the old one is
  flagged `Azienda obsoleta` (the new flag from the same session) automatically or
  by hand.

⚠ **No requirement covers this.** The register's nearest entry is `DM-02`
(_"Account = company, with a local-name field alongside the registered name"_),
which is about naming, not about succession. So a mechanism agreed with the
client on 3 September has **a tracker row and no contractual anchor** — worth a
line at Parte 2 or Parte 3 if the client expects it in scope.

**No date was set.** Aurel Mrruku carries it as _"Configurare Lookup"_ on the
session's action list.
