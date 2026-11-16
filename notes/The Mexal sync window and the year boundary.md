---
id: mexal-sync-window
type: reference
status: active
owner: Aurel Mrruku
with: Fabrizio Paganelli, Mirko Merendi
org: both
raised: 2026-11-16
updated: 2026-11-16
depends_on: []
blocks: []
source: notes/meetings/2026-11-16 Ultimi Check PROD.md
---

# The Mexal sync window and the year boundary

**Two facts about the Mexal reads that are not in any contract and were only
stated aloud on 16 November: Mexal is unreachable in the small hours because of
its own nightly maintenance, which is why the first night of scheduled syncs
failed; and Mexal keeps invoices in a separate table per calendar year, which the
invoice sync works around by querying two years at once.**

## Mexal is down at night, and that is by design

The three nightly jobs activated on 13 November at 01:00, 02:00 and 03:30 ran for
the first time on the night of 15-16 November. The 01:00 article run and the 02:00
customer run both returned **HTTP 500** (`2001 - errore imprevisto in fase di
interrogazione servizi predesk`); the 03:00 quote reminder, which does not call
Mexal, succeeded.

Found on the client call when Fabrizio Paganelli reported his Sunday article
changes had not arrived. Aurel Mrruku checked the job log: _"Mexal non era
raggiungibile dall'1 alle 3, alle 3:30 … **lo stesso errore su tutte e due**."_

🔑 **The cause, from the client, who runs the Mexal estate:**

> **Fabrizio Paganelli:** _"ci sono delle procedure che girano in notte su Mexal
> che **buttano fuori gli utenti**, fa dei backup suoi automatici, a meno che sia
> proprio quella l'ora in cui ti butta fuori. Quindi **qualsiasi procedura non
> funziona**. Magari proviamo a spostare l'ora."_
>
> _"il problema e che era incompatibile l'orario."_

So the 500 is not transient and not a ROMI defect. It is a maintenance window.
⚠ **Its exact boundaries are not known.** The observed failures span 01:00 to
03:30 Europe/Rome; Fabrizio Paganelli guessed 04:00 would be safe and Aurel
Mrruku proposed 05:00 on the grounds that nobody starts work before 06:00. Neither
asked Mirko Merendi, although Aurel Mrruku suggested it twice — _"ci puo dire
Mirko esattamente quando?"_ The window was never confirmed by Kreosoft.

**What was done instead:** the jobs moved to two rounds a day from 05:00 and
13:00, agreed in the room and recorded in
[OI-334](items/OI-334%20The%20Mexal%20sync%20frequency%20is%20undecided%20and%20no%20job%20is%20scheduled%20in%20production.md).
Each round takes about 2-5 minutes — Aurel Mrruku: _"ho controllato che ogni job
circa prende 2, 3, 4 minuti al massimo."_

🔴 **The collision risk runs the other way too.** Sabatino Rinaldi asked for the
final times in writing _"cosi evitiamo di accavallarci, perche noi ne facciamo
abbastanza poi di questi di notte"_ — the client runs its own nightly procedures
and nothing reconciles the two calendars. Tracked in
[OI-370](items/OI-370%20The%20client%20cannot%20run%20the%20Mexal%20syncs%20by%20hand.md).

## Invoices live in a table per year

Aurel Mrruku, explaining the invoice and scadenzario job:

> _"Mexal li vede come **due tabelle diverse per anno**, quindi ogni anno lui crea
> un codice da zero. E quando vado a interrogare gli dico dammi le ultime modifiche
> nelle fatture negli ultimi 30 giorni del 2026, e quando andro nel 27 interrogo
> **sia 26 che 27**, quindi mi prendo le ultime 30 giorni di modifiche su tutti e
> due gli anni sempre."_

He attributes the warning to Kreosoft: _"Andrea, Mirko … m'aveva detto che quando
andiamo nell'anno nuovo su Mexal la chiamata si fa filtrando per anno e rischiamo
di non ricevere le fatture dell'anno precedente."_ ⚠ The attribution is uncertain
in the transcript — he names two people and corrects himself.

**Consequences worth knowing:**

- The window is **30 days of modification date, not document date**. Confirmed to
  the client explicitly, because he asked: _"anche se risalgono ad un documento
  vecchio di 2 anni?"_ — _"Ah, si, si, si. Il database lo legge come modifica."_
  This matters because the client edits old scadenzario rows: _"a volte andiamo a
  modificare anche documenti che sono molto vecchi, soprattutto sullo
  scadenziario."_
- 🔴 **A change older than 30 days is never picked up.** Nothing re-reads beyond
  the window, so a correction made on a document last touched more than a month
  ago will not reach Salesforce at all.
- At the 1 January boundary both years are queried, so the previous year's late
  corrections still arrive — for the first 30 days only.

## Related

- [OI-327](items/OI-327%20The%20blow%20product%20codes%20carry%20the%20wrong%20gruppo%20merceologico.md)
  — the article flags this window delayed
- [the Mexal integration mapping workbook](The%20Mexal%20integration%20mapping%20workbook.md)
- [the Mexal Postman collection](The%20Mexal%20Postman%20collection.md)
