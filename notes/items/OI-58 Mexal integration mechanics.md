---
id: OI-58
type: open-item
status: in-progress
owner: Andrea Di Cicco
with: Mirko Merendi
org: both
raised: 2026-07-14
updated: 2026-08-26
source: meetings/open-items.md row 58
---

# OI-58 - Mexal integration mechanics

Settled on 2026-07-14. The full mechanics — direction of truth, delta GETs,
callout limits, mastro 610, the "rinvio ordine" button — are written up in
[the Mexal integration](../flows/The%20Mexal%20integration.md).

**WEBAPI credentials were delivered on 15 July** (`services.passepartout.cloud`,
dominio PIENISSIMO, azienda PIE), so the build is unblocked.

**The field mapping is answered, and the workbook has now been read.** Andrea Di
Cicco sent the per-API workbook on 2026-08-07; Mirko Merendi returned it filled
in on 2026-08-11. `Integrazioni pienissimo.xlsx` was opened on 2026-08-14 and
its contents — seven sheets, three previously unrecorded calls, the target
column structures — are in
[the Mexal integration](../flows/The%20Mexal%20integration.md).

🔴 **It exposed a gap:** `Get Fatture` maps `numero_ordine` but **no order-line
number**, which is the key
[ticket availability](OI-75%20Ticket%20availability%20rule.md) was agreed to match
on. Raise it at the 27 August call.

Three things still sit under this item:

- **Listino 1 versus listino 2** — Mirko deferred to Fabrizio Paganelli, who has
  not answered. Whether a third listino could ever be needed is also open.
- **There is still no Mexal test environment.** Serie `10` gives a test lane,
  but inside the **production** company — test orders land in live data. A test
  company was the ask; nobody owns it.
- A registry field referencing the **previous code and VAT** is needed so a
  ragione-sociale change does not orphan the account.

⚠ The credentials arrived by email. Treat them as
[sensitive](../../docs/publishing.md) — they must not appear in notes, recaps or
the public site.

The build sits on
[ROMI's standard integration scaffolding](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md),
committed in early August. That is house pattern and needs no requirement of its
own — what this item tracks is the Mexal-specific configuration on top of it.

## 2026-08-24 - a field-level mapping exists for the first time

Andrea Di Cicco created **`Integrazioni pienissimo.xlsx`** on 2026-08-24 and
presented it at [the Follow-up Interno](../meetings/2026-08-24%20Follow-up%20Interno.md) the same afternoon. See
[the Mexal integration mapping workbook](../The%20Mexal%20integration%20mapping%20workbook.md) for what it covers — entity list
with methods, Mexal manual page references, sync cadence, and a per-field
customer payload mapping.

Until now this item rested on meeting narration. It now has an artifact.

**Also settled at that session:**

- **The sandbox test pattern** — new customers under code **501**, new orders on
  **series 10**.
- **GET calls run once a day** for changed records.
- Andrea Di Cicco to send **the Postman collection** to Aurel Mrruku.

**Still open, and named as the hard part:**

- **The invoice-to-order-line link.** Instalment invoices against order lines are
  not yet understood; Andrea Di Cicco holds the action to study the detail call
  that confirms payment status.
- **Agent vs supplier filtering** on the read calls — needs Fabrizio Paganelli.

⚠ The **Mexal WEBAPI credentials** promised since July have still not arrived,
and Mirko Merendi's technical mail to Fabrizio Paganelli is still unanswered —
Fabrizio Paganelli was asked on 20 August to reply before the 26 August review.

## 2026-08-25 - the Postman collection landed, and the hard part got an answer

**The Postman collection arrived.** Andrea Di Cicco sent
`Mexal Dev.postman_collection.json` (13.9 KB) to Aurel Mrruku on Slack at
**11:52 CEST**, after Aurel Mrruku chased it that morning. It closes the action
carried from
[the 24 August Follow-up Interno](../meetings/2026-08-24%20Follow-up%20Interno.md).

⚠ **It is incomplete and Andrea Di Cicco says so** — _"devo ancora aggiungere
quella parte che dicevamo ieri sera"_. Treat it as a starting point, not the
integration contract. **It is a Slack file, not in the repository or in Drive**;
whether it should be committed has not been decided, and it may carry endpoint
or credential material, so check before moving it.

🟢 **The invoice-to-order-line link — named as the hard part on 24 August — is
answered.** Working through the Mexal data with Aurel Mrruku on Slack at 17:56
CEST, Andrea Di Cicco established that **a single invoice carries the list of its
items**, and concluded: _"quindi per le trance sappiamo come capire quando sono
state pagate"_. That is the mechanism
[OI-50](OI-50%20Tranche%20object.md) needs for payment aggregation and
[OI-92](OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
needs to reverse an asset.

**It is a reading of the data, not a built or tested call.** Nothing has been
implemented, and the call structure is still to be worked out — Aurel Mrruku's
reply was _"poi capiamo come strutturare le chiamate"_. Andrea Di Cicco's own
next unknown is **how tranches are created** on the Mexal side.

**Still open and untouched:** the missing order-line number on `Get Fatture`,
listino 1 vs listino 2, the absent Mexal test company, and agent-vs-supplier
filtering. All four are natural questions for the **26 August** client review.

**One registry detail settled in passing.** Andrea Di Cicco thought the price of
an individual theatre performance was missing from the catalogue; on checking he
withdrew it — `Performance` carries **`prices` as a related object** and a
**`Rate` field**, which holds IDs rather than values. Recorded so the same alarm
is not raised twice.

## 2026-08-26 - the collection was read; it is a probe, not a contract

[Decoded in full](../The%20Mexal%20Postman%20collection.md). Nine requests, no
folders, no saved responses. It closes the "has anyone opened it" question and
**opens four sharper ones**, all of which belong at today's 16:00 review.

🟢 **What it settles.** The real endpoint paths, on the wire: `clienti/ricerca`,
`fornitori/ricerca` (agents as suppliers — the mastro-610 design confirmed),
`dati-generali/pagamenti/ricerca` (**new** — the workbook had no path for it),
`articoli/ricerca`, `scadenzario/ricerca` and
`documenti/ordini-clienti/ricerca`. All **POST** to `/ricerca` with a
`{"filtri":[{"campo","condizione","valore"}]}` body, delta key `data_ult_mod`,
timestamps `YYYYMMDD HHMMSS`.

🔴 **The invoice call is absent.** Mirko Merendi's two-step `Get Fatture` via
`documenti/movimenti-magazzino` **is not in the file**; both requests named
_Fatture_ hit the customer-orders resource instead. So the call this item's
biggest open question depends on has **never been tested**, and the collection
does not show how to make it.

🔴 **The order-line-number gap is untouched.** With no saved responses, the file
shows no payloads and no field lists. It cannot and does not answer whether
`Get Fatture` returns the **numero riga d'ordine**. The 2026-08-25 Slack
reading — "a single invoice carries the list of its items" — remains a reading
of data, not a demonstrated call.

🔴 **Three requests are pointed at the wrong resource** — `Ricerca Ordini
Clienti` and `Ricerca Indirizzo di spedizione` both call `scadenzario/ricerca`,
and `Ricerca Fatture Copy` duplicates its twin. **Read the URL, never the
name.** There is **no shipping-address call at all**, so _destinazioni_ is still
_"da verificare"_ exactly as the workbook left it.

🔴 **Also missing:** any pagination parameter (against the 6 MB / 12 MB callout
limits), any write call (`Creazione Cliente` / `Creazione ordini` untested), and
a rolling watermark — the delta filter is hard-coded to **16 July 2026**.

⚠ **The workbook's `Method` column is wrong as an HTTP verb** — it says GET on
six calls that are really POST. That column feeds
`Integration_Configuration__c.HTTP_Method__c` directly, so the error is one
configuration step from being built.

### The credentials line in the 24 August section above is wrong

That section says _"the Mexal WEBAPI credentials promised since July have still
not arrived"_. **This file proves working credentials exist and are in active
use by ROMI** — two enabled credential headers on all nine requests. That is
consistent with the earlier paragraph in this note recording delivery on
**15 July**, and inconsistent with the 24 August line.

Whichever set is still owed from Fabrizio Paganelli, **it is not the one Andrea
Di Cicco is testing with.** Ask precisely which credential is missing rather
than repeating that they are absent.

🔴 **The file must not be committed** — live credentials in cleartext against
the ERP that is the system of record for invoicing. Handling:
[the collection note](../The%20Mexal%20Postman%20collection.md).
