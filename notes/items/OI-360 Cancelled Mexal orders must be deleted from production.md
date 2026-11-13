---
id: OI-360
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Paganelli
org: both
raised: 2026-11-12
updated: 2026-11-13
depends_on: [OI-310, OI-315]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-11-12 Check Pre-Import.md
---

# OI-360 - Cancelled Mexal orders must be deleted from production

**Thirteen orders already loaded into the production org have been cancelled in
Mexal and must come out again. They are real orders, not test data. The system was
deliberately built so that orders cannot be deleted, so each one has to be torn
down by hand with everything hanging off it, in production, the night before the
client's users start. Nineteen more must be updated, which changes the delta from
insert-only to update.**

## What the client sent

Fabrizio Paganelli, **2026-11-12 15:32:30Z**, `File Import Ordini`, attaching
`Import Ordini (versione del 2026.11.12).xlsx`:

> _"Rispetto alla precedente versione che vi avevo inviato, oltre a **41 nuovi
> ordini**, ci sono: **13 ordini che abbiamo ELIMINATO da Mexal** perche sono stati
> annullati (e che sono da eliminare anche su Salesforce) … **19 ordini modificati**
> (che sono da aggiornare su Salesforce)"_

|            |                                                                                                                                                                                    |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| New orders | **41**                                                                                                                                                                             |
| To delete  | **13** — Mexal numbers `66387`-`66392`, `76581`-`76584`, `78050`, `78051`, `78111`                                                                                                 |
| To update  | **19** — `68808`, `68949`, `69327`, `77568`, `77667`, `77688`, `77696`, `77718`, `77758`, `77778`, `77921`, `77985`, `78038`, `78061`, `78062`, `78075`, `78079`, `70868`, `77241` |

⚠ The workbook itself was **not opened** — it carries real customer records.

## Why deletion is hard

On the [Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md),
before the mail arrived, the two worked out what it means:

🔴 Aurel Mrruku: _"**io non cancello mai ordini.** Fabrizio, abbiamo fatto tutto il
sistema in modo che gli ordini non si possono cancellare dagli utenti oppure da
integrazioni. Ovviamente li posso cancellare perche io sono sistema\[dmin\], \[ma\]
devo fare **un po' di porcherie sul sistema** per cancellare quegli ordini."_

🔴 **The delta cannot find them.** _"io non ho un delta per capire se l'ordine in
sal\[esforce\] c'ha il codice Maxal … Io non lo posso distinguere se c'e o non c'e su
Maxal, perche anche altri ordini non hanno piu il riferimento di Mexal perche sono
diventate fatture."_ So the client must hand over the list — which he did.

🔴 **The whole structure goes with it**: _"il sistema non ti permette a cancellare
l'ordine se non hai pulito prima tutta la struttura dietro. Quindi gli asset che
sono collegati a quegli ordini, gli eventi, i biglietti … **sono costretto a fare
una pulizia totale.**"_ When Elisa Migliano offered to flag which orders carried
marketing versus courses and tickets, that became unnecessary for exactly this
reason: _"anche su quelli che non hanno un biglietto sto cancellando tutti i asset
di quegli ordini."_

🔑 **Sequence agreed**: deletions first, then the delta. _"Me lo mandi prima, cosi
io faccio prima la cancellazione, poi rimetto il delta."_

## The delta becomes an update

🔴 Fabrizio Paganelli: _"Non vale non andare solo in update dei record mancanti,
**va anche in aggiornamento dei record di quelli gia presenti** … possiamo avere
delle cose che nel frattempo le abbiamo modificate."_ Aurel Mrruku, who had
planned insert-only — _"vai solo in aggiunta, non vai in modifica"_ → _"**Ok, vado
in modifica.** Allora, faccio un controllo generale"_, _"su ordini soprattutto"_.

This is a change to [OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md):
the delta described there was additive.

## Expected volume and risk

🟢 Aurel Mrruku expects a small delta: _"mi aspetto un delta di **200, 300, 500
record al massimo**"_, with the Account and Order entities the ones he is wary of —
_"questi sono le entita che mi preoccupano di piu."_

🔴 **It is destructive work, in production, with no rollback named, on the eve of
go-live**, and it bears directly on
[OI-315](OI-315%20Production%20test%20records%20cannot%20be%20deleted.md): the same
scripts that remove these thirteen would remove the earlier test orders, which has
been owed since 3 November.

## What is owed

- The list of Mexal codes, from Fabrizio Paganelli, **before** the delta runs.
- A record of what was actually deleted — counts per object, not just orders.
- Confirmation that the update-mode delta does not overwrite the Prod-side edits
  the client made on 12/11 to the event dates
  ([OI-353](OI-353%20Production%20event%20end%20dates%20are%20backdated%20to%20stop%20ticket%20mails%20during%20the%20load.md)).

## 🟢 2026-11-13 - the 13 cancelled orders are out of production, and the 19 updates are in

All thirteen were deleted from **Pienissimo Prod** with everything hanging off them,
after a rolled-back dry run and with a script that aborts on any invoice, payment, contract
or ticket past `Ordinato`. A fourteenth order was deleted with them: the old version of
one of the 19 listed orders, whose `DATA_DOC` had changed and so arrived as a new key.
The other 18 were **recreated from the file rather than edited in place**, so their tickets
and invitations match the corrected lines; their ids and order numbers changed. Together:
**32 orders, 70 lines, 32 tranches, 45 tickets and 23 invitations deleted.** The records
deleted are backed up outside the repository. Counts and the full picture:
[OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md).
