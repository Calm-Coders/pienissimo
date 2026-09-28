---
id: MTG-2026-09-04-datamodel-2
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-04
updated: 2026-09-04
source: Drive - "[ROMI-PIENISSIMO] - Data Model: Parte 2 - 2026/09/04 16:04 CEST - Appunti di Gemini", summary, Decisioni, details and full transcript read 2026-09-04
---

# 2026-09-04 Data Model Parte 2

**Client-facing session, 4 September 2026, 16:04 CEST; the transcript runs
1h01m33s.** The second of the deep customer-registry mapping sessions
([OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md)).
Present: **Elena Spini**, **Aurel Mrruku**, **Andrea Di Cicco**, **Elisa
Migliano**. Fabrizio Paganelli and Sabatino Rinaldi were invited and do not
appear in the transcript.

The Gemini document carried summary, **Decisioni** and the full transcript on
first reading, as Parte 1 did. Everything below is from that document; direct
quotations are from the transcript.

🟢 **It kept to its hour**, unlike Parte 1 which overran by 108%. It also
finished what it opened: the Account cleanup was completed and the **Referente
(Contact)** object was walked field by field.

## What was settled

### 1. Shipping address becomes a hidden mirror of billing

Elisa Migliano raised the duplication of `città`, `cap` and `provincia` across
billing and shipping. The decision:

- **both sets of fields exist in the Salesforce data model**;
- the shipping set is **populated automatically with the billing values**;
- the shipping set is **hidden on the Salesforce user screens**;
- both are **passed to Mexal**.

The reason is explicitly defensive — to avoid Mexal blocking an order for a
missing address. ⚠ **This is the workaround for
[OI-113](../items/OI-113%20Whether%20Mexal%20requires%20both%20addresses%20to%20create%20an%20account.md),
adopted before OI-113 was answered.** Mirroring makes the question cheap rather
than settling it: if Mexal does demand a genuinely distinct shipping address for
some customer, a mirrored value is a wrong answer rather than a missing one.
The test call OI-113 asks for is still worth making.

The workbook already carries the empty shipping fields — `CAP di spedizione`,
`Città di spedizione`, `Provincia di spedizione`, `Via spedizione`, `Paese di
spedizione`, all under the `MEXAL` section
([OI-24](../items/OI-24%20Data%20model%20workbook.md)).

### 2. Contacts get a role picklist instead of duplicate records

Rather than hold one Contact per role, a **single Contact carries a picklist**.
Agreed values, from the Decisioni block and the transcript:

`commerciale` · `amministrativo` · `amministrativo e commerciale`

The distinction is load-bearing, not cosmetic: **commercial contacts are the
recipients of event tickets**, administrative ones are not.

🔴 **The workbook does not say this.** Its `Referente` sheet carries
`Ruolo — Vedi nota` with the values `Amministrativo/Commerciale/Piattaforma` —
three values, but **`Piattaforma` instead of the combined
`amministrativo e commerciale`**. The two artefacts were written the same
afternoon and disagree
([OI-120](../items/OI-120%20The%20contact%20role%20picklist%20values%20disagree%20between%20the%20workbook%20and%20the%20session.md)).

### 3. The reference contact becomes editable on the quote

Aurel Mrruku proposed allowing the reference contact to be **selected and
changed inside the Preventivo itself**. The worked case is chains and
franchises — he named **Poké** — where each site answers to a different
referent, so the contact that belongs on the deal is not always the account's
default.

Alongside it, a **`contatto principale` flag** (`isPrimary` in the workbook)
that **deactivates itself automatically when another contact is made primary**.

⚠ This lands on the Quote object, which is also where
[OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md)
puts `Tipologia Attività` and where
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md) is still reconciling
the state machine. Three separate changes are now queued on one object.

### 4. Fields deleted from the contact registry

Removed outright: **`Origine lead`** (tracked automatically anyway),
**`Telefono abitazione`**, **`Segreteria`**, **`Tipologia attività`** and
**`Contatto obsoleto`**. `Partita IVA` is removed from the Contact — it belongs
on the Account.

⚠ **`Tipologia attività` here is the *Contact* field and this does not reverse
[OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md).**
Elena Spini said _"sul contatto"_ and Aurel Mrruku answered _"non mi dice
niente, mai sentito sui contatti"_. The workbook's Preventivo sheet still
carries `Tipologia Attività — Picklist non restrittiva`, so the field name appears on
three objects and has now been decided differently on each: **deleted on
Contact, moved off Account, added to Preventivo.**

**`Contatto obsoleto` is worth its own line**, because the session reasoned it
out rather than just cutting it. Elisa Migliano checked with a tutor: the flag is
used when a person no longer works at the restaurant, or when the phone number is
wrong. Aurel Mrruku's objection — _"se un ex dipendente si deve cancellare"_,
and the contacts are editable anyway — carried. Elena Spini: _"facciamo data
model pulito come l'altra volta."_

Kept: the **email opt-out** fields (marketing needs them), **e-mail
secondaria**, **PEC**, `Nome Locale`, `Data di nascita`. Deleted: the standard
Salesforce activity fields and the Twitter block.

### 5. `Keap Id Esterno` survives pending a check

The external-id field on the Contact is held **pending verification with
Sabatino Rinaldi and Matteo**. ⚠ The Gemini summary renders it _"Kip esterno"_;
the workbook spells it **`Keap Id Esterno`** — Keap being the marketing
platform. Same field.

### 6. `Azienda Precedente` is confirmed as the Mexal link

Andrea Di Cicco and Aurel Mrruku confirmed the use of Mexal's **`codice
alternativo azienda precedente`** to tie a company to its previous registry
entry. This is the third leg of
[OI-118](../items/OI-118%20Ragione%20sociale%20continuity%20on%20the%20customer%20registry.md),
and the workbook now models it as `Azienda Precedente — Lookup (con se stessa)`
on Account.

### 7. `Modalità iscrizione annullata` comes from Zoho Campaigns

Elisa Migliano undertook to **share the correct value set in chat**. The
workbook records the source as `Zoho campaigns`. ⚠ **Owed, undated, and it had
not appeared on any source by the end of 4 September.**

## Two things that were answered without being on the agenda

🟢 **The ATECO question is answered, and it is a yes.** Elisa Migliano went to
Andrea Parmeggiani directly and reported back: he will pass **the ATECO code,
the ATECO description and the codice fiscale**, in the same Anticipay call —
_"nella stessa chiamata"_. Aurel Mrruku had already seen the mail:
_"sto qua, lo stavo lavorando tipo 20 minuti fa."_ This resolves
[OI-112](../items/OI-112%20Whether%20Anticipay%20returns%20the%20ATECO%20code.md)
and extends the documented eleven-field response.
⚠ **The two mails Andrea Parmeggiani sent that morning are not in the swept
mailbox** — see [the trace](../traces/Source%20trace%202026-09-04.md).

🟢 **DocuSign moved, verbally.** Aurel Mrruku asked at the close. Elena Spini
had spoken to Sabatino Rinaldi, who answered and then went quiet because of the
client's event: _"comunque tutto confermato. In realtà poi li hanno anche
rimbalzati a loro stessi perché poi sono andati in ferie quelli commerciale
Docusign. Comunque tutto confermato, ha detto che **Massimo settimana prossima
ci fa sapere**."_ So the delay is attributed to DocuSign's own sales team being
on holiday, and a named contact owes an update next week
([OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md)).
⚠ **Still nothing written**, and _"tutto confermato"_ is Sabatino Rinaldi's
word relayed, not a contract.

## Marketing is still waiting, and it is now explicit that it does not block

Elena Spini reported that **Matteo** has not come back on the review of the
~100 marketing forms — but stated plainly that **this does not block the data
model work**. Elisa Migliano took an action to tell Sabatino Rinaldi that Elena
Spini is waiting; the group took a second to chase Matteo and Sabatino Rinaldi
on which forms to replicate.

## The calendar changed in the room, and the invitation does not match

Elisa Migliano said she had to leave early and that **Monday 11:00–12:00 is not
enough** to finish. Elena Spini proposed adding an hour with only Aurel Mrruku
and freeing Andrea Di Cicco, who is unavailable Monday; the group then agreed to
**move to Tuesday**, Elena Spini noting a free slot **12:00–13:00**.

Attendance was named explicitly — Elena Spini: _"metto sempre solo te e
Fabrizio"_ — because, as Elisa Migliano explained, **the tour starts Tuesday and
neither Matteo nor Sabatino Rinaldi will be available**.

🔴 **What was booked does not match what was agreed.** At 15:05Z Elena Spini
sent an invitation for **`[ROMI-PIENISSIMO] - Data Model: Parte 4`, Tue 8 Sept
12:00–13:00 CEST**, to Aurel Mrruku, `amministrazione@pienissimo.com` and
Fabrizio Paganelli — Andrea Di Cicco not invited, Sabatino Rinaldi not cc'd,
consistent with the room. But **`Parte 3` remains on the calendar for Mon 7 Sept
11:00–12:00** with Andrea Di Cicco invited and Sabatino Rinaldi cc'd, and **no
cancellation or update for it appeared on any source**.

So the session was **added, not moved**, and Andrea Di Cicco is invited to a
Monday session he said he cannot attend. Either Parte 3 needs cancelling or the
Monday hour stands with a different cast. **Nobody has said which**
([OI-99](../items/OI-99%20Customer%20registry%20deep%20mapping%20session.md)).

## What this session did not reach

The **same four gaps** recorded on 2 and 3 September survive it:

- the **Ordine** field list — 🟢 partially moved: the workbook's Ordine sheet now
  carries the note _"Nell'ordine è importante che ci siano le seguenti
  informazioni: Codice Agente, Classificatore Rete, Codice Zona"_
  ([OI-110](../items/OI-110%20Agent%20and%20network%20fields%20are%20missing%20from%20the%20Mexal%20order%20call.md)),
  but no Zoho-side field mapping;
- **Utenti** — still an empty header row;
- **Profili** — still an empty header row;
- the **initial-load plan**, `C-1`–`C-6` — still six empty rows.

`Flussi` still holds only **F-1** and **F-2**. The Lead table, deferred from
Parte 1 for Sabatino Rinaldi, was not opened either — and he is unavailable from
Tuesday.

## Actions out of the session

| Action                                                                                   | Owner              | Date  |
| ---------------------------------------------------------------------------------------- | ------------------ | ----- |
| Configure billing/shipping address fields, hidden and auto-populated                     | the group          | none  |
| Send the Mexal order integration with every field needed to complete the order           | Andrea Di Cicco    | none  |
| Implement the contact role picklist (three values)                                        | Andrea Di Cicco    | none  |
| Delete `Origine lead`, `Telefono abitazione`, `Segreteria`, `Tipologia attività`, `Contatto obsoleto` | Andrea Di Cicco    | none  |
| Tell Sabatino Rinaldi that Elena Spini is waiting on the forms                            | Elisa Migliano     | none  |
| Chase Matteo and Sabatino Rinaldi on which forms to replicate                             | the group          | none  |
| Share the `Modalità iscrizione annullata` values from Zoho Campaigns                      | Elisa Migliano     | none  |

⚠ **Not one action carries a date**, and Fase 1 development ends **10
September** — four working days away, three of them inside ROMI's 9–11 September
offsite
([the compressed calendar](../risks/Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)).
