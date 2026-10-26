---
id: ref-logiche-asset-invio-biglietti
type: reference
status: active
owner: Elena Spini
org: ROMI
raised: 2026-10-01
updated: 2026-10-05
source: Gmail thread 1a0f8b6c0021fe9c, 2026-10-01 18:25Z
---

# The agreed Asset and ticket send logic document

**The written specification of the ticket lifecycle that
[OI-197](items/OI-197%20The%20ticket%20send%20flag%20and%20the%20Inviato%20asset%20state%20are%20agreed%20and%20unbuilt.md)
had been waiting for. It exists as of 01/10, and it went to the client the same
evening with a request for written confirmation. It exists in two versions, and
the client's copy is the shorter one.**

## The two versions

| | Internal | Client |
| --- | --- | --- |
| Title | `PIENISSIMO – INTERNA Asset e invio biglietti.docx` | `PIENISSIMO – Logiche Asset e Invio Biglietti.docx` |
| Drive id | `1IR2YtSzZfyfqOZalzQVpNkKSFiNuRa7f` | `1p4W9ekBWZbVMh0ts6ui_xSIwOHZLMG4z` |
| Posted | marketing group DM, 01/10 12:17 CEST | mail to the client, 01/10 18:25Z |
| `LOGICHE FLUSSI SALESFORCE` | yes | yes — **identical text** |
| `Open point da confermare con il cliente` | **7 items** | 🔴 **absent** |
| `POSSIBILI PROBLEMI` | **10 items** | 🔴 absent, and marked internal in the source |

Both were read in full. The operative sections are word-for-word the same; the
client's copy simply ends after `NOTE IMPORTANTI`.

Elena Spini said so in advance, in the marketing group DM at 12:19 CEST: _"al
cliente darò un'altra versione senza la parte di op e possibili problemi"_.
Withholding the problems table is ordinary; withholding the open points is the
issue — see
[OI-200](items/OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md).

## What the client was asked

Elena Spini's mail went to Fabrizio Paganelli, Rebecca Marmo, Sabatino Rinaldi,
Marco Montesi and `amministrazione@`, copying Aurel Mrruku:

> _"Vi chiedo cortesemente di darmi riscontro a questa mail **per conferma di
> avvenuta lettura e di presa visione del documento condiviso e conferma delle
> relative logiche.**"_

And: _"Su questa base aggiorneremo i flussi e ve li presenteremo nel prossimo
incontro utile (ancora da concordare, non in programma)."_

🔴 **There is no next client meeting booked.** The mail says so in its own
parenthesis.

## The logic, as written

1. **Asset generation** — on the order reaching `Ordinato`, i.e. on signature of
   the quote. All assets are created in `Ordinato`.
2. **Availability** — an asset reaches `Disponibile` only when the invoice for
   **its tranche** is paid; with no tranches, when the order reaches `Incassato`.
   Assets on unsettled orders or tranches are filtered out of marketing campaigns.
3. **The link** goes to the main contact from `Event_Invitation__c`, **only once
   at least one asset is `Disponibile`**.
4. **Confirmation** sets `Ready_for_Ticket_Dispatch__c = TRUE`; the referent may
   confirm **one or some** of the tickets.
5. **Marketing Cloud selects** on
   `Ready_for_Ticket_Dispatch__c = TRUE AND Ticket_Sent__c = FALSE` and mails each
   participant the ticket PDF/QR held on the Asset.
6. **Write-back** sets `Ticket_Sent__c = TRUE` and `Ticket_Sent_Date__c`.
7. **The form** groups tickets to be named by edition at the top, already
   assigned tickets for the same order at the bottom.
8. **`Rinuncia`** is visible per edition until the first participant of that
   edition is confirmed, then hidden and disabled permanently. Later withdrawals
   go through an offline procedure.

⚠ There is **no `Inviato` asset state** anywhere in either version. The eighth
state agreed at the 30/09 Post UAT was dropped at
[the 01/10 Interna](meetings/2026-10-01%20Interna.md).

## 🔑 Three constraints that are new in writing

- **Chronological tranche sequencing.** _"Pienissimo ha confermato che le tranche
  vanno saldate in ordine cronologico."_ An unpaid September tranche blocks the
  November tranche's tickets **even if the November invoice is registered and
  paid**. Attributed in the text to Pienissimo; ⚠ no meeting or date is cited for
  that confirmation, and the sweep found no source for it.
- **Tranche composition is a human duty.** _"Sarà compito dei tutor/o di chi fa i
  bundle"_ to group a bundle's events into tranches by calendar proximity. No
  system check enforces it.
- **The unlock is per tranche invoice, not per order** — _"non dell'ordine totale
  contenente + tranche"_ — and it updates the assets of every order line in that
  tranche.

## The seven open points, as written internally

Verbatim subjects, all marked `da confermare con il cliente`:

1. When the link goes out — on the first `Disponibile` asset, or from the
   edition's `Data invio biglietto`?
2. Tickets unlocked by a **later** tranche — does the referent get a new mail, or
   must they reopen the same link?
3. Do reminders stop when the referent has named at least one ticket of the
   order, or of the single edition?
4. Payments close to the event — is there a manual unlock, and **who performs it**?
5. Does `Rinuncia` cover only that edition's currently `Disponibile` tickets, or
   also ones unlocked later?
6. Orders without tranches — does a partial collection leave every asset in
   `Ordinato`?
7. Credit note / cancellation — **which asset state**, distinct from `Rinuncia`
   and `Annullato`?

Point 7 is [OI-157](items/OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md);
point 3 bears on [OI-126](items/OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md).

## The ten problems, as written internally

The table is headed _"Nota interna, da rimuovere prima dell'invio al cliente. Il
giro sta in piedi; il rischio maggiore è il momento di invio del link."_ Its
findings, compressed:

| # | Risk |
| --- | --- |
| 1 | The link condition ignores the edition's `Data_Invio_Biglietto__c`: a December tranche for a November event would open nomination 11 months early — **which Fabrizio Paganelli excluded at the UAT** |
| 2 | `Event_Invitation__c` has one `Campaign__c` and one send date; on a multi-edition order it is undefined which applies |
| 3 | Newly unlocked assets trigger no new mail, and Rebecca Marmo's reminder filter skips anyone who has already named one |
| 4 | The selection query ignores `Status`: a corrected collection (`Disponibile` → `Ordinato`) after nomination still sends |
| 5 | If the flag and `Ticket_Sent__c` sit on different objects the query spans two objects — **this is now the built state**, [OI-199](items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md) |
| 6 | Chronological sequencing partly contradicts the per-tranche unlock; the job must check prior tranches too |
| 7 | Nothing warns when a distant event is placed in a near tranche |
| 8 | `Rinuncia` must be tracked per edition on the assets, not on `Event_Invitation__c`, to stop only that edition's reminders |
| 9 | Last-day payments depend on the nightly job; a manual override is needed |
| 10 | Real-time `Ticket_Sent__c` write-back at volume risks delays or double sends |

⚠ **Authorship of this table is uncertain.** Elena Spini calls it _"il feedback di
Claudio"_, and "Claudio" is not resolvable — see
[the 01/10 Interna note](meetings/2026-10-01%20Interna.md). Aurel Mrruku declined
to review it in the call, so **none of the ten has been through a ROMI technical
review**, and item 5 has already materialised in the build.

## 2026-10-05 - modified, and four of the ten problems have moved

The internal version `PIENISSIMO – INTERNA Asset e invio biglietti.docx` was
**modified 2026-10-05 at 08:37:23Z** and re-read in full.

⚠ **No textual change is detectable against the record above.** Both withheld
sections are still there and still the same size — seven open points, ten
problems — and the `LOGICHE FLUSSI SALESFORCE` text matches. The modification
is real; what it changed is not, and the 01/10 version was not retained to diff
against. The figure caption reads _"ciclo di vita del biglietto · 4 stati"_,
describing the path `Ordinato → Disponibile → [Nominato] → Assegnato`, not the
seven-value `AssetStatus` picklist. **Recorded as uncertain, not as unchanged.**

### Four problems closed or answered, by build rather than by decision

| # | Was | Now |
| --- | --- | --- |
| 1 | the link ignores the edition's `Data_Invio_Biglietto__c` — the biggest risk in the table | 🟢 **closed.** The field is built on `Event_Invitation__c` and takes the Campaign's value — [the 10:01 session](meetings/2026-10-05%20Interna%20Check%20PROD%20per%20MKT.md) |
| 2 | one `Campaign__c` per invitation, undefined on a multi-edition order | 🟢 **closed.** Aurel Mrruku confirmed it was taking _"la prima campagna che ha trovato"_, then rebuilt it per Order-Campaign pair in `4a6fe3f` — [the decision](decisions/Decision%20-%20Event%20Links%20belong%20to%20Order%20Campaign%20pairs.md) |
| 4 | the selection query ignores `Status` | 🟢 **closed by Marketing, unasked.** Fabrizio Mastracci's own query includes `Status = 'Assegnato'` — [the send contract](The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md) |
| 5 | three flags on two objects | 🟢 **closed 05/10.** All three are on `Asset`; the `Order` copies are deleted in both orgs — [OI-199](items/OI-199%20The%20ticket%20send%20flag%20fields%20are%20split%20across%20Asset%20and%20Order.md) |
| 8 | `Rinuncia` must be per edition, not on the `Event_Invitation` | 🟡 **addressed in part.** `Rinuncia` is now scoped to the link's own Campaign, which is per edition in effect |

🔑 **Four of the ten were right, and all four were fixed within four days of
being written** — by a table whose authorship this note records as uncertain
(_"il feedback di Claudio"_, unresolved) and which Aurel Mrruku declined to
review. ⚠ The remaining six, including #3 (no mail when a later tranche
unlocks tickets), #6 (chronological sequencing versus per-tranche unlock), #9
(last-day payments) and #10 (write-back at volume), are untouched.

🔴 **The document is still the text the client rejected.** Fabrizio Paganelli
and Sabatino Rinaldi objected to its `Regole di Business Aggiuntive` points 1
and 2, and point 1 — the multi-event aggregation per order — **has now been
rebuilt per edition**, so the paragraph in this document no longer describes
the build. It should not be re-sent as it stands
([OI-203](items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md)).
