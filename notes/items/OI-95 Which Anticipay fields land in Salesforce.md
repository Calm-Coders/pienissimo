---
id: OI-95
type: open-item
status: resolved
owner: Fabrizio Paganelli
with: Elisa Migliano
org: Pienissimo
raised: 2026-08-25
updated: 2026-09-03
depends_on: [OI-94, OI-108]
blocks: [OI-73]
source: notes/meetings/2026-09-01 Follow-up Integrazione Anticipay.md
---

# OI-95 - Which Anticipay fields land in Salesforce

**Open, and owned by the client.** The 25 August session agreed that the
middleware returns **only the fields that are actually needed**, not Anticipay's
full response — which Andrea Parmeggiani and Aurel Mrruku both described as
carrying far more information than anyone wants. Nobody has yet said which
fields those are.

**Fabrizio Paganelli and Elisa Migliano hold the action** to analyse the
candidate fields and decide what is worth integrating. No date was given.

The prerequisite is on the other side: **Andrea Parmeggiani owes an example of
every field Anticipay returns**, at Fabrizio Paganelli's request, so the choice
can be made against a real list rather than from memory. Until that arrives this
item cannot move.

## Candidates named in the session

Raised in discussion, none of them decided:

- **ragione sociale** and **rappresentante fiscale** — Andrea Parmeggiani and
  Aurel Mrruku, as the obvious minimum beyond the VAT number itself
- **legale rappresentante**
- **the Anticipay reliability score** for the customer — Fabrizio Paganelli
  wants to know whether the scoring can come across, which would make this a
  credit-risk signal and not only a registry lookup
- **electronic-invoice routing via PEC**

Fabrizio Paganelli framed the whole thing as an opportunity to revisit which
fields Mexal carries too, not only Salesforce — so the answer may widen the
Mexal mapping as well as the Salesforce object.

## Why it matters more than a field list usually would

Two of the candidates are not registry data. **A reliability score is a
commercial judgement about a customer**, and **PEC routing is invoicing
configuration**. Both would put data in Salesforce that nothing in the signed
requirements asks for, on an object the client's own administration reads. Decide
what the field is _for_ before agreeing to store it — and check it against
[the publishing rules](../../docs/publishing.md) before any of it reaches the
recaps or [site/](../../site/).

The three-month retention agreed for **error** codes in
[OI-94](OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
was not stated to cover the returned **data**. Nobody asked how long the
retrieved company details are kept, or under what basis. That question is
unraised, not answered.

## 2026-08-31 - the prerequisite arrived; the item still cannot move

🟢 **The blocker on Andrea Parmeggiani's side is discharged.** He sent
`Documentazione API – Salesforce.pdf` on **31 August 16:15Z**, four days inside
his commitment — see
[OI-94](OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md).
The "example of every field Anticipay returns" that this item has waited on since
25 August is presumably in that document.

🔴 **But the item does not move yet, for two separate reasons.**

1. **The document has not been read.** This sweep cannot open a Gmail attachment.
   Until somebody does, the candidate field list below is still the only one the
   record holds, and it is a list of things people said out loud in a meeting.
2. **The decision was never Andrea Parmeggiani's to make.** The action sits with
   **Fabrizio Paganelli and Elisa Migliano** — they choose which fields are worth
   integrating. Both are on the cc line of the 31 August mail, so they now have
   what they asked for. No date was ever set for their answer and none was set
   on 31 August either. **That is the ask to put to them at the 1 September
   call.**

⚠ The `status:` here stays `open` deliberately. The prerequisite arriving is not
the decision being taken, and the two have been conflated in this project before.

The privacy question above is **unaffected and still unraised**: a document
listing available fields does not decide how long retrieved company data is kept
or on what basis. If the PDF turns out to include the reliability score or PEC
routing among the returnable fields, that question gets sharper, not softer.

## 2026-09-01 - the list is real, and it is shorter than anyone expected

**The document was read.** Full decode at
[the Anticipay middleware API contract](../The%20Anticipay%20middleware%20API%20contract.md).
The candidate list above was a list of things people said out loud in a meeting;
this replaces it with the wire format.

**The middleware returns eleven fields and no more.** There is no larger response
to trim.

| Field                                    | Serves the stated purpose?                                                                                                                             |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `ragione_sociale`                        | ✅ yes — the obvious minimum, and named in the session                                                                                                 |
| `indirizzo`, `citta`, `provincia`, `cap` | ✅ yes — the registered-office address block                                                                                                           |
| `pec`                                    | ✅ yes — and it is the **electronic-invoice routing** candidate, present as predicted                                                                  |
| `nome_legale_rappresentante`             | ⚠ named in the session; personal data                                                                                                                  |
| `codice_fiscale_legale_rappresentante`   | ⚠ personal data, not raised by anyone                                                                                                                  |
| `data_di_dascita_legale_rappresentante`  | ⚠ personal data, not raised by anyone; **and misspelled** ([OI-105](OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)) |
| `luogo_nascita_legale_rappresentante`    | ⚠ personal data, not raised by anyone                                                                                                                  |
| `indirizzo_legale_rappresentante`        | 🔴 a private individual's **home address**, not raised by anyone                                                                                       |

### Two of the session's candidates are simply not available

- 🔴 **The Anticipay reliability score is not returned.** Fabrizio Paganelli
  asked specifically whether the scoring could come across; the answer, on the
  documented contract, is **no**. If he still wants it, it is a change request to
  Pienissimo Software, not a field-selection choice — and it would make this a
  credit-risk feed rather than a registry lookup, which is a bigger conversation
  than the one that has been had.
- **`rappresentante fiscale` is not returned either.** The document returns
  `legale rappresentante`, which is a different role. Andrea Parmeggiani and
  Aurel Mrruku both named _rappresentante fiscale_ in the session as part of the
  obvious minimum. Worth checking whether they meant the legal representative and
  used the terms loosely, or whether something is genuinely missing.

### 🟢 The list matches the as-is Mexal lookup exactly

[OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) records Elisa
Migliano describing the existing pre-invoicing service as returning _"ragione
sociale, address, PEC and legal representative"_ — which is precisely these
eleven fields. **The middleware is not a trimmed view of Anticipay; it is the
service Pienissimo already uses, re-exposed.** That is reassuring on accuracy
(Elisa Migliano rates that registry _"corretta al 99,5%"_) and it means the
selection question is smaller than it looked.

### 🔴 The privacy question is no longer theoretical

The prediction at the end of the 31 August section was half right: PEC is there,
the score is not — **and six of the eleven fields identify a natural person**.
Raised in full as
[OI-108](OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md),
which recommends storing the company block and dropping the person block. That is
a recommendation for this item's owners to accept or reject, not a decision taken
for them.

### ⚠ Whatever is chosen has to be built, and none of it exists

Account carries **three custom fields in total** — `Partita_IVA__c`,
`Lead_Email__c`, `Nome_Locale__c`. `ragione_sociale` maps to `Name` and the
address block to the standard billing address, so those are free. **PEC and all
five legal-representative fields have no landing place in the org**, and creating
them, exposing them and granting FLS is unestimated work that starts only once
this item is decided. With Fase 1 development ending **10 September**, the
decision date matters as much as the decision.

### The item still does not move — but the reason has changed

It is no longer waiting on Andrea Parmeggiani; he has delivered everything he
owed. **It is waiting on Fabrizio Paganelli and Elisa Migliano**, who have held
the action since 25 August with **no date on it**, and who have had the field
list since 31 August. Both are on the mail thread.

**Get a date at the 1 September call.** That is the entire ask.

## ✅ 2026-09-01 - resolved in the room, and the answer is "all of them"

**The [1 September follow-up](../meetings/2026-09-01%20Follow-up%20Integrazione%20Anticipay.md)
took the decision.** The advice one section above was to get a _date_; the call
produced the _decision_ instead. Aurel Mrruku walked point 6 of the
documentation field by field with Elisa Migliano and Andrea Parmeggiani, and
**every one of the eleven fields is taken.**

| Field                                    | Lands on                                                                                                                                           |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ragione_sociale`                        | `Account.Name`                                                                                                                                     |
| `indirizzo`, `citta`, `provincia`, `cap` | the standard billing address block                                                                                                                 |
| `pec`                                    | **a new dedicated field on Account**                                                                                                               |
| `nome_legale_rappresentante`             | **a new text field on Account**                                                                                                                    |
| `codice_fiscale_legale_rappresentante`   | **a new field on Account**                                                                                                                         |
| `data_di_dascita_legale_rappresentante`  | **a new field on Account** — still carrying the [misspelled key](OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md) |
| `luogo_nascita_legale_rappresentante`    | **a new field on Account**                                                                                                                         |
| `indirizzo_legale_rappresentante`        | **one single free-text field**, not a structured address                                                                                           |

### The two shape rulings

- **On the Account, not on a Contact.** Aurel Mrruku proposed a typed Contact
  record for the legal representative. **Elisa Migliano overruled it** — the data
  _"andrebbero messe all'interno dell'account… perché poi dopo il tema del legale
  rappresentante è fondamentale per la firma dei contratti."_ Aurel Mrruku
  accepted while recording a reservation: _"lo vedo come una struttura più
  complessa dei semplicemente dei campi sull'account, ma fa niente, **per il
  momento**."_ The reservation is worth keeping — a director changing is a
  perfectly ordinary event and flat Account fields have no history.
- **The person's address is one text field.** Andrea Parmeggiani: _"non è
  importante che salviamo il CAP del legale rappresentante. Va bene un testo
  tutto completo."_ Note the asymmetry: the **company** address is structured,
  the **person's** is not.

### 🔴 The recommendation in OI-108 was not taken, and it was never discussed

[OI-108](OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md)
recommended **storing the company block and dropping the person block**. The room
took the person block in full. The personal-data question **was not raised by
anyone** in the twenty minutes.

⚠ It is not accurate to call that a rejection. Elisa Migliano supplied, for the
first time in the record, **a stated business purpose** — contract signature —
which is exactly what OI-108 asked for (_"if a field has no stated purpose, the
answer is to not store it"_). One field now has a purpose on the record. **Four
still do not**: codice fiscale, date of birth, place of birth and home address
were never individually justified, and retention, lawful basis, field-level
security and erasure were not mentioned. See OI-108 for what remains.

### What this unblocks, and what it now costs to build

🟢 **The build can start.** This item has blocked
[OI-73](OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) since 25 August
and no longer does.

🔴 **But the "unestimated work" flagged above is now committed work.** Account
carries three custom fields today; this decision adds **six more** —
PEC plus five legal-representative fields — each needing creation, page-layout
placement and field-level security, on top of the callout itself. That was true
of any outcome except the OI-108 recommendation, but it is now real and it lands
with **nine days** before Fase 1 development ends on 10 September.

⚠ A **twelfth** field may yet arrive:
[OI-109](OI-109%20Codice%20destinatario%20SDI%20as%20a%20twelfth%20Anticipay%20field.md),
the codice destinatario SDI. Do not wait for it — build the eleven.

## 🟢 2026-09-03 - the field list stops being a guess

At [Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md) the
client struck the whole legal-representative block from their own template and
handed the mapping to ROMI. Fabrizio Paganelli:

> _"per me li potete eliminare tutti e poi li mettete su voi in base a come
> servono."_

Aurel Mrruku took it:

> _"Li toglierei tutte in base a quello che ci restituisce. Faccio io il mapping."_

**This is the cleanest possible resolution of the field-selection problem**: the
Salesforce field list becomes a consequence of the live Anticipay response rather
than a list agreed in advance from a PDF. It also means the eleven-field
agreement of 1 September is no longer load-bearing — what the call actually
returns is.

⚠ **The contradiction flagged on 2 September was never raised.** Zoho already
holds the legal representative's residence split into street, town, province,
postcode and country, while this item agreed to model it as **one free-text
field**. The record said to raise it at Parte 1; it was not raised. Dropping the
block arguably makes it moot — the structure will follow the response — but
**that is an inference, not a decision.** Confirm at Parte 2.

⚠ **Still nothing has run.** No lookup has ever been executed against Anticipay,
so "what it returns" is not yet knowable. The mapping cannot start until it does,
and [the field build has still not started](../risks/Risk%20-%20the%20Anticipay%20field%20build%20has%20not%20started.md).

⚠ One incidental discovery: the Zoho field `Ultima Verifica Credit Safe` is being
renamed `Ultima Verifica Anticipay`. **Credit Safe was the predecessor
VAT-lookup provider**, which the record has never named.
