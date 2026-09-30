---
id: OI-161
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Parmeggiani
org: both
raised: 2026-09-22
updated: 2026-09-28
depends_on: [OI-74]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-09-22 Temi QR Code Biglietti.md
---

# OI-161 - The event check-in app must integrate with Salesforce

**Established at
[Temi QR Code Biglietti](../meetings/2026-09-22%20Temi%20QR%20Code%20Biglietti.md),
22/09 10:32 CEST. An integration the record did not contain.**

Everything held about QR codes concerns **generating** them. Nothing established
what **reads** them. Pienissimo runs a **custom Android application** — not a Zoho
product, built against Zoho over REST, distributed via TestFlight and APK packages
on Drive, refreshed about every ninety days — and it is the thing that scans a
ticket at the door.

⚠ Elena Spini, the same afternoon: **_"di questa app non ne hanno mai parlato"_**,
and she had read "QR code done" as including the scan and the asset update. See
[the internal update](../meetings/2026-09-22%20Update%20Interno%20Aurel%20Elena.md).

## Agreed scope for Fase 1

1. The app makes a **REST call to Salesforce** and the asset moves to
   **`utilizzato`**; a failure returns a customisable error code and message.
2. **Validity is checked against the child campaign's start and end dates** before
   the asset is updated, so a code for another event or edition is rejected.
3. **One check-in for the whole event**, not per day. Reference case:
   **Pienissimo Live, 24–26 November**.
4. The **campaign member state follows from the asset**, by formula — Aurel Mrruku
   explicitly refused to build a second write path for it.

## Open

- 🔴 **Andrea Parmeggiani owes credentials, an endpoint and the payload definition**
  for the app side.
- 🔴 **Aurel Mrruku owes payload examples and a Postman collection**, committed for
  the end of week 22–26/09.
- 🔴 **Nothing is built.** The asset state machine
  ([OI-74](OI-74%20Asset%20state%20machine.md)) has the `utilizzato` state; no inbound
  endpoint exists.
- 🔴 **Pre- and post-event testing breaks the date filter.** The agreed workaround is
  to move the campaign dates or issue filter-free test codes — neither is specified.
- ⚠ **No requirement covers this integration.** It is new scope surfaced three days
  before ticket UAT on 30 September, and **allocating a requirement id is a human's
  call.**
- ⚠ The app also draws ticket allocation down from a **company giacenza** by event,
  edition and ticket type. Whether Salesforce owns that allocation is unestablished.

## 2026-09-23 — org-status check

Read-only check of Pienissimo UAT, 08:01–08:40Z, `DevMain` at `61f2a53`. Nothing was deployed or changed.

- 🔴 **No ticket in UAT has a QR:** **0 of 31** Assets carry `QR_Id__c` (23 `Ordinato`, 4 `Assegnato`, 3 `Rinuncia`, 1 `Disponibile`). `Asset.Data_CheckIn__c` and `QR_Id__c` exist, but nothing fills either, and no inbound check-in endpoint exists. `BIG-11` (check-in by QR scan) cannot be shown. **Ticket UAT is 30/09.** (verified)


## 2026-09-23 — the first statement of what the integration is *for*

**[Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md), `01:56:20`–`02:01:26`.**

🔑 **The scan calls Salesforce, and Salesforce answers.** Aurel Mrruku described the
scanner app as making an API call on scan, with Salesforce returning a **speaking error**
when the entry rules are not satisfied — his example: the holder used only one of three
entries in the previous block and is presenting for the second block.

> _"io gli devo restituire un errore parlante […] guarda, non hai effettuato tutti gli
> ingressi."_

**Everything this record previously held described the integration as one-way** — the app
updating the asset. This is the first evidence it is a **request/response validation
endpoint**, which is a materially larger build.

⚠ **It is Fase 2, and the auto-summary says otherwise.** The Gemini notes list
_"\[Aurel Mrruku\] Implementare errori QR"_ under *Passaggi successivi*, as though it
were in flight. The transcript does not support that: Elena Spini closed the topic as
Fase 2 and Aurel Mrruku himself said the data model for it is missing. **Fase 1 scope is
unchanged — the asset update only** — and
[the decision](../decisions/Decision%20-%20ingressi%20live%20on%20the%20campaign%20edition%20and%20are%20Fase%202.md)
records the boundary.

🟢 **Andrea Parmeggiani is confirmed as the counterpart** — Aurel Mrruku reached for the
name and Elena Spini supplied it. The 23/09 Pienissimo org chart places him as
**Maintenance Manager at Pienissimo Software Srl**.

🔴 **Unchanged and still gating: nothing is built, and ticket UAT is 30/09.**

## 🔑 2026-09-28 - Infopoint is confirmed Fase 2, and the Salesforce side of the endpoint exists

Two movements, from two different sources.

### 🟢 The client-facing split is now stated in writing

Elena Spini's project status in **`#tproj-pienissimo`** (28/09 09:07 CEST — the
channel is findable again, see the trace) separates the two halves of this note:

> _"QR Code: l'app aggiornerà Salesforce tramite API, mentre è stato confermato che
> la parte Infopoint (app custom di Pienissimo che ci è stata presentata in
> settimana -.-), anche se fondamentale per la gestione dei check-in degli eventi,
> passerà alla Fase 2."_

- 🟢 **The scan-updates-Salesforce-by-API design is confirmed** — the direction this
  note established on 22/09.
- 🔑 **Infopoint moves to Fase 2, and is named for the first time.** Her own
  annotation — _"app custom di Pienissimo che ci è stata presentata in settimana"_,
  with a visible `-.-` — matches the 22/09 finding that the app had never been
  mentioned. ⚠ **She calls it fundamental to event check-in and defers it anyway.**
  That is a scope decision with a consequence: **at go-live there is no check-in
  path**, and the tickets it would scan are Fase 1.
- ⚠ **The `Link_Iscrizione_Infopoint__c` Campaign field reached `DevMain` on
  25/09** in PR #62, so a field naming Infopoint ships in Fase 1 while the
  integration behind it does not.

### 🟢🔑 The Salesforce-side lookup endpoint has been written

**`807ed4e`** (Rexhina Hysi, 28/09 17:49 CEST) — _"expose endpoint to get info
based on campaign member id"_ — adds **`TicketQrLookupService.cls` (317 lines)**,
together with two notes the author wrote herself:
`notes/Ticket QR lookup endpoint usage.md` (new, 109 lines) and an update to
`notes/Ticket QR code generation.md`.

🔴 **It is on the branch `DevMain_exposeEndpoint` and is NOT on `DevMain`.** No PR
was open for it at the time of this sweep. **Its two notes are therefore not in the
vault either**, which is why this section describes the commit rather than linking
them.

⚠ **This was not drilled.** The class and its notes were identified by commit, and
whether the endpoint matches the contract Andrea Parmeggiani needs — the *speaking
error when a previous block's entries are incomplete*, recorded above from 23/09 —
**was not verified.** That is a read for whoever merges it.

🟢 **QR generation itself landed the same morning**: `e887b15` and `b40db42`
(Rexhina Hysi, 09:41 and 10:12 CEST) add `AssetQrService.cls`,
`BarcodeGenerator.cls` (796 lines, with a vendored `Portwood-DocGen` licence under
`docs/third-party/`) and `TicketQrImage.cls`. See
[OI-185](OI-185%20The%20participant%20name%20change%20regenerates%20the%20ticket%20as%20a%20new%20asset.md).
