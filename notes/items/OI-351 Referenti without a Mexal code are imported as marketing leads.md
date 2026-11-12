---
id: OI-351
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Elena Spini, Sabatino Rinaldi
org: both
raised: 2026-11-10
updated: 2026-11-12
depends_on: [OI-290, OI-352]
blocks: [go-live]
severity: high
source: notes/meetings/2026-11-10 INTERNA Referenti come lead.md
---

# OI-351 - Referenti without a Mexal code are imported as marketing leads

**The decision [OI-290](OI-290%20Lead%20and%20Referenti%20migration%20data%20is%20owed%20by%20the%20client.md)
had been waiting for arrived in writing on 10 November, and it was confirmed by
the client on 11 November. The roughly 49,800 referenti with no Mexal customer
code are loaded as standard Leads carrying two flags and surfaced through one list
view. Everything the design was questioned on is still open.**

## The decision, in the client's words

[Sabatino Rinaldi, 2026-11-10 08:07:34Z](mailto:sabatino.r@pienissimo.com), Gmail
thread `1a1a746c8e63d5ac`:

> _"per quanto riguarda i contatti privi di codice mexal, la decisione presa con
> la direzione e quella di inserirli come **lead con un flag Zoho: true** … Oppure
> se fosse possibile creare un elenco lead dedicato … **Questi Lead non dovranno
> essere lavorati dai commerciali** ma saranno lead del marketing che verranno
> lavorati e puliti man mano."_

## The mapping, as ROMI wrote it back

Elena Spini's recap mail of **2026-11-10 18:41:48Z**, after a telephone call with
Sabatino Rinaldi that left no recording:

| Lot | Object | Mapping | View |
| --- | --- | --- | --- |
| **Lead import** (file from Sabatino Rinaldi, 29 October, `Import Ordini` thread) | Lead | `Status = New`, **`Lead from Zoho = TRUE`** | — |
| **Referenti with no Mexal code** (`Referenti` thread) | Lead | `Status = New`, **`Referenti Marketing = TRUE`** | 🆕 **`Lead - Referenti Marketing`** |

🟢 Sabatino Rinaldi confirmed on **2026-11-11 14:32:21Z**: _"Si Elena, va bene"_,
and that the lead file already sent is the one to use for the production import
(15:05:21Z, _"Sisi"_).

## The cleanup, which is the client's

Two routes were put to Pienissimo and **neither has been chosen**:

- **Option A** — the commercial fills in the real Partita IVA and anagraphics; on
  conversion Salesforce matches the existing Account and creates the Contact under
  it. ⚠ _"il processo standard di conversione **generera contestualmente anche
  un'Opportunita**"_, to be marked **Closed Lost** so the pipeline is not polluted.
- **Option B** — the operator creates the Contact by hand under the existing
  Account and discards the Lead.

## What is still open

1. 🔴 **Visibility is not solved.** The client asked that these leads not be worked
   by the sales side. Aurel Mrruku, on the 10/11 internal call: _"**Non e solo una
   shin\[sharing\] roll.** Poi dipende cosa puo fare, cosa deve fare"_, and a list
   view cannot restrict by profile. No sharing design exists.
2. 🔴 **The field mapping has never been verified against the file.** _"Se non
   abbiamo una mappatura corretta non gli possiamo importare."_ The workbook
   arrived 12/11 10:30Z and holds **67,154 rows**; it was not opened by this run
   because it carries real customer records.
3. 🔴 **They cannot be converted as loaded** — no Partita IVA, so no qualification
   and no conversion. See [OI-352](OI-352%20The%20fifty%20thousand%20referenti%20leads%20are%20loaded%20with%20fake%20company%20and%20VAT%20values.md).
4. ⚠ **Aurel Mrruku recorded a dissent**, on the 10/11 call: _"Ma e sbagliato, pero
   fa niente. Non non andra cosi. **Assicuro che non andra cosi.**"_

## Volumes

- **49,800** referenti without a Mexal code (counted by Elena Spini on the 12/11
  client call: _"Codice Mexal senza codice sono 49.800"_).
- **107** whose Mexal code matches no Azienda in production, from the 05/11
  exception list — ⚠ **unmentioned in this window and still unhandled.**
- The lead lot proper is the file of **29 October**, confirmed for production.

## What is owed

- Option A or B, from Pienissimo, before the cleanup starts.
- A sharing design, if _"non lavorati dai commerciali"_ is to mean anything.
- Field-by-field verification of the Referenti workbook against the Lead schema
  before the load.
