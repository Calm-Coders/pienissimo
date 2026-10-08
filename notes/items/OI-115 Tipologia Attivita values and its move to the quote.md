---
id: OI-115
type: open-item
status: in-progress
owner: Elisa Migliano
with: Elena Spini
org: both
raised: 2026-09-03
updated: 2026-10-08
depends_on: [OI-59]
relates_to: [OI-123]
requirement: SAL-16
source: notes/meetings/2026-09-03 Data Model Parte 1.md
---

# OI-115 - Tipologia Attivita values and its move to the quote

## 8 October source implementation and contradiction

The user's latest field table and explicit instruction to create every missing
field place `Tipologia_Attivita__c` on Lead and map it to Account at conversion.
Source now implements that direction with all 21 supplied values and adds the
three values absent from the existing Account field: `Gelateria`, `Agenzia
Comunicazione`, and `Attività diversa da somministrazione`.

This conflicts with the earlier agreement preserved below that the field moves
to Quote. The current source follows the latest user instruction, but it is not
deployed and the contradiction remains visible rather than being treated as a
client-confirmed reversal.

**`Tipologia Attività` leaves the customer registry and becomes a field on the
Preventivo.** Agreed at
[Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md), and
written into the client's own workbook the same hour — the Preventivo sheet now
carries the line `Tipologia Attività — Picklist non restrittiva >> PIENISSIMO TO
DO: Inserire i valori esistenti`
([OI-24](OI-24%20Data%20model%20workbook.md)).

Two things were decided and one is owed.

**Decided.** It moves from Account to Quote, and it is a **non-restrictive**
picklist — users may type a value that is not in the list.

**Owed.** Elisa Migliano is to extract and send the existing values from Zoho.

## Why the move is more than a relocation

The field describes the **kind of business being sold to**, and putting it on the
quote rather than the account means it is captured **per deal, not per customer**.
That is a deliberate choice — a customer can be sold to in different capacities —
but it also means the account no longer carries the classification at all, so any
report or segmentation that assumed it lived there has to reach through the
quotes.

⚠ **A non-restrictive picklist is a decision to accept dirty data.** It is the
right call for a migration where the value set is unknown, and the wrong one to
leave in place afterwards. Nothing in the session said when it should be
tightened — worth a line in the Parte 2 or Parte 3 wrap-up.

⚠ It also lands on the Quote object while
[OI-59](OI-59%20Quote%20workflow%20configuration.md) is still reconciling that
object's own state machine and layout, and while the new
[quote acceptance page](../objects/The%20Landing%20Page%20community.md) reads
Quote fields directly. **Whoever adds the field should check the acceptance page
still renders.**

**No date was set for the values.**

## 🟢 2026-09-16 - it gets a source, and the source is the locale

[Data Model Parte 5](../meetings/2026-09-16%20Data%20Model%20Parte%205.md)
resolved the half of this row that the 3 September session left hanging: **where
the value comes from.**

**`Tipologia Attività` is created on the Locale-record-type Account** as a
**global, non-restrictive picklist**, and the quote **pre-fills from the locale
associated with the account**, staying manually editable.

🟢 **This is better than what 03/09 decided, and it repairs a real gap.** The
earlier reading was that the field simply _moves_ Account → Quote, which left
the account carrying no classification at all and every report reaching through
quotes. It now lives in both places with a stated direction of travel: the
locale is the master, the quote takes a snapshot, a tutor may override it for a
particular deal.

🟢 It also lands the field on the object
[OI-123](OI-123%20The%20Zoho%20questionnaire%20fields%20have%20no%20home.md) created
for exactly this kind of orphan — the _locale_ is the natural owner of "what
kind of business is this", and as of 08/09 it exists as a record type.

🔴 **One consequence was agreed in passing and is worth stating plainly:
selecting a locale becomes mandatory on the quote.** Nothing in the session
said what happens to a quote for a company that has no locale yet, and the
Azienda/Locale split only shipped on 8 September — so most existing Accounts
have no child.

🔴 **The values are still owed**, now for the **thirteenth day**. Elisa Migliano
re-committed to sending them by email at Parte 5; **no date was given**, and
five of her six outstanding deliverables from that session are picklist values
that block field creation. This row cannot close on a design; it closes on a
list.

## 🔴 2026-09-17 - the field went mandatory and the reminder was deleted

The workbook was read at its `2026-09-16T11:20:06Z` version
([OI-24](OI-24%20Data%20model%20workbook.md)). On the **Preventivo** sheet,
`Tipologia Attività` is now marked **`TRUE` mandatory** and typed
**`Global picklist`**.

On 3 September the same cell read _"Picklist non restrittiva >> **PIENISSIMO
TO DO: Inserire i valori esistenti**"_.

🔴 **The TO-DO text is gone and no values replaced it.** The field is now
specified as mandatory, global and empty. The client deleted the marker that
tracked their own debt without paying it, and the only remaining record that the
values are owed is this note.

**Fourteenth day.** The change also raises the cost of the gap: a _mandatory_
global picklist with no values cannot be deployed at all, where a non-restrictive
one could have shipped and been populated later. Nothing in
[the design diagram](../The%20newest%20design%20diagram.md) mentions the field —
searched, zero occurrences — so the workbook is its only source.

## 🟢 2026-09-21 - the Locale record type reached source

`08b97cc` (Anita Aga, 21/09 18:24 CEST, `DevAnitaRecheckAutomations`, **PR #54
open**) adds the UI this row needs: an `Account_Locale_Record_Page` flexipage (+504
lines), an `Account-Locale Layout` (+177), and changes to the Account three-column
page. So the **Locale** Account the 16/09 ruling put `Tipologia attività` on now has
a page and a layout.

🔴 **The values are still not delivered**, and the field is still mandatory and
global. Nothing in this window changed that.

⚠ **The same failure is being set up again.** At
[Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`01:22:51`) a **`tipologia evento`** field was made **mandatory at event creation**
with only an "initial" value set agreed verbally —
[OI-148](OI-148%20Tipologia%20evento%20is%20mandatory%20at%20event%20creation.md).
A mandatory picklist with no values blocks record creation, which is precisely what
this row records happening once already.

## 2026-09-24 — Account field and UAT source values

The user-provided Account model workbook places `Tipologia Attività` on Account
as a multi-select picklist. At the user's direction, `Account.Tipologia_Attivita__c`
was deployed to UAT with the 18 distinct values found in `Account_NEW`. It is
visible on both Azienda and Locale pages. The import populated 181 Azienda
Accounts; no Locale rows were part of this source load. This new Account data
does not by itself build the Quote field or its Locale-to-Quote defaulting,
which remain open in this item. The source values are observed in the client
extract, not a separately confirmed complete value set for future use.

## 🟢🔑 2026-10-05 - the value list arrived, and it is twenty-one values

Agreed at
[the 05/10 Lead session](../meetings/2026-10-05%20Check%20Data%20Import%20Lead%20e%20Contact.md):
the standard `Settore` field is **replaced** by `Tipologia di attività`, a
**multiselect picklist**, with the generic Salesforce industry values deleted.
Elisa Migliano and Sabatino Rinaldi drove it; gourmet restaurants were added in
the closing minutes.

[The Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md),
modified the same day at 16:40Z, now carries the list on **both the `Lead` and
the `Account` sheets**, identically, 21 values:

Ristorante · Ristorante Gourmet · Ristorante specialità Carne · Ristorante
specialità Pesce · Pizzeria · Pub · Fast food · Agriturismo · Sushi · Locale
notturno · Pasticceria · Gelateria · Hotel · Franchising · Catena di Proprietà
· Spiaggia con servizio Ristorazione · Bar · Cocktail Bar · Negozio · Agenzia
Comunicazione · Attività diversa da somministrazione

The `Account` sheet types it `Multiselect picklist` and the `Preventivo` sheet
types it `Global picklist` and marks it **mandatory** — 🔑 so the move to the
quote that this item is about is specified in the client's own document, as a
**global** value set shared by Lead, Account and Quote. The Lead sheet records
it as `Mapping con campo Account`.

⚠ **Global and multiselect are not the same thing.** A global value set can
back a multiselect picklist, but the workbook states both without saying which
surface is which, and a mandatory multiselect on the quote is a different
constraint from a mandatory single-select. Worth settling before building.

## 🟢 2026-10-06 - the client sent the mapping, as a workbook attached to mail

Elisa Migliano mailed it at **06:54:07Z**, the morning after the Lead session
asked for it — **twice**, as two near-identical messages with different
recipient sets:

| Thread             | Subject                                                          | To / cc                                                                                               |
| ------------------ | ---------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `1a10ffdcc543c242` | `Sottocategorie, Categorie , Origine Lead , Tipologia attività ` | Elena Spini, Aurel Mrruku; cc Fabrizio Paganelli, Marco Montesi, Sabatino Rinaldi                     |
| `1a10ffdcab74ce05` | `Sottocategoria, categoria, origine lead, tipologia attività`    | Elena Spini, Aurel Mrruku; cc Sabatino Rinaldi, Marco Montesi, **Matteo Distaso**, Fabrizio Paganelli |

Both carry the attachment
**`Mappatura_Categorie_Sottocategorie_Origine Lead_Tipologiattività.xlsx`** and
the same body:

> _"In allegato i campi richiesti, potremmo aver aggiunto nel frattempo dei
> pacchetti e dei campi. Provvederò a farti l'integrazione."_

🔑 **This is the first delivery of the four picklists together** — categoria,
sottocategoria, origine lead and tipologia attività — and it comes from the
person whose values the 05/10 session adopted.

## 🔴 The attachment has not been read

It exists **only as a mail attachment**: a Drive search on `Mappatura` returns
nothing matching, and the sweep has no tool that downloads a Gmail attachment.
So the values inside are **unread**, and the 21-value `Tipologia di attività`
list held in
[the Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
**cannot be reconciled against it this run.**

⚠ Elisa Migliano's own caveat — _"potremmo aver aggiunto nel frattempo dei
pacchetti e dei campi"_ — says the workbook list may already be short. And she
states she will do the integration herself (_"Provvederò a farti
l'integrazione"_), which is a commitment with **no date**.

**To unblock:** the file needs to be put in Drive, or opened by someone with the
mailbox, and the four lists diffed against what the org and the workbook carry.
Until then the global value set cannot be built with confidence.
