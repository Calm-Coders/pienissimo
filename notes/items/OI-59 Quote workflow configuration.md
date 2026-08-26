---
id: OI-59
type: open-item
status: in-progress
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-07-31
updated: 2026-08-25
source: meetings/open-items.md row 59
---

# OI-59 - Quote workflow configuration

From the 31 July business review. The lead/opportunity flow itself was
**confirmed** there; these are the residual configuration items.

- **5-day validity**, with the expiry date a **mandatory field at send**
- automatic alerts to tutor and client **on day 2 and at expiry**
- a **"qualificato da ricontattare"** state
- a **manual quote-creation button**

**Marco Montesi owes the list of preset expiry timings** per product category
and business line. Without it the 5-day default is the only rule, and the
client's own annotated diagram asked for the ability to **revive expired
quotes** — which is a related behaviour nobody has specified.

## The states were renamed, and the diagram records the old names

[The newest design diagram](../The%20newest%20design%20diagram.md) (6 August)
carries the renames in brackets, which is how they can be identified at all:

| Object      | New name                          | Was                  |
| ----------- | --------------------------------- | -------------------- |
| Quote       | `In Trattativa`                   | _Prev. Inviato_      |
| Quote       | **`In Attesa Accettazione`**      | **_Scaduto_**        |
| Opportunity | `In Trattativa`                   | _Preventivo Inviato_ |
| Opportunity | `Da Ricontattare - Prev. Inviato` | _Da Ricontattare_    |

The second row matters most: the "scaduto" substatus that the 5-day validity
produces is now **`In Attesa Accettazione`**.

**That rename is already captured** — the register lists it among the quote
states, notes it as _"the new label for the former 'preventivo scaduto'"_, and
records `preventivo scaduto` under name collisions as a **retired label the room
will keep using anyway**. `REQUIREMENTS.md` uses the new name too. No correction
needed; expect the old word in conversation.

Full quote lifecycle in the diagram: `Bozza → Nuovo Preventivo → In Trattativa →
In Attesa Accettazione → Accettato / Rifiutato`.

The diagram also fixes the opportunity reminder: a task plus **email to the
Opportunity owner after 3 days** in _Preventivo Inviato_ — distinct from the
day-2 and expiry alerts above, which are quote-side.

Configuration, not design. `Quote` in the repository carries one custom field
(`Motivazione_Da_Ricontattare__c`), so the state exists and the timing rules do
not.

Downstream of [OI-68](OI-68%20Quote%20acceptance%20landing%20page.md) in
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md).

## 2026-08-24 - fully specified, and carrying one contradiction

Two sessions in five days turned this from an outline into a build spec. The
[20 August client session](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) set the business rules; the
[24 August internal session](../meetings/2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md) set the Salesforce mechanics; the
[master diagram](../The%20newest%20design%20diagram.md) now carries both, with the picklist values.

**Agreed with the client on 20 August:**

- Quote sent → opportunity to **In trattativa**; quote valid **5 days by
  default**, the date settable and modifiable by the tutor rather than fully
  automatic, so "sotto evento" cases with compressed timing work. ROMI to assess
  feasibility.
- **Day 2**: automatic reminder task for the tutor **and** an email to the
  client. Copy and template owed by Marco Montesi and Elisa Migliano.
- **Day 5 with no answer**: the quotation moves to **"in attesa di
  accettazione"**; the **opportunity stays in "trattativa"**, because there is no
  definitive outcome yet.
- **Two separate reason fields**, kept apart at Marco Montesi's request:
  "motivazione da ricontattare" (opportunity) and "motivazione ricontatto
  preventivo" (trattativa).
- **Close**: quote accepted → order generated → opportunity to **chiusa vinta
  only when the order is incassato**.

**Added internally on 24 August:**

- Quote creation permitted **only during `trattativa`**, with an automatic move
  into that state if a quote is raised from `qualificato`.
- **Primary quote**: accepting it auto-rejects the others; **rejecting it moves
  the whole opportunity to rejected**, with a mandatory popup reason.
- **No product or tranche edits** once the quote leaves `Bozza`.
- Mandatory reason **and** recontact date on `Da ricontattare`, enforced by
  trigger, for both the generic and the "preventivo inviato" case.

**The picklist values now exist**, in the diagram rather than in the register —
see [the newest design diagram](../The%20newest%20design%20diagram.md) for both lists verbatim.

## 🔴 The contradiction to resolve before building

The 20 August minute told **the client** that marking "Da ricontattare"
**does not** generate a task, and that an informational **banner** is used
instead so the follow-up is not forgotten.

The 24 August internal session specifies a **validation rule plus trigger** on
that same state, and its action list carries _"Configurare notifiche reminder"_.

A banner and a validation rule can coexist, so this is not a flat contradiction —
but the "no automatic task" ruling is a **client-facing commitment** and the
internal session did not reference it. **Neither should be built until Elena
Spini or Aurel Mrruku reconciles them**, because one of the two audiences is
going to be told something that is not true.

## 2026-08-25 - org check: the quote states are stock Salesforce

Verified read-only against **Pienissimo UAT**. None of the agreed lifecycle is
configured.

`Quote.Status` holds the **stock Salesforce values** — `Draft · Needs Review ·
In Review · Approved · Rejected · Presented · Accepted · Denied` — against the
agreed `Bozza → Nuovo Preventivo → In Trattativa → In Attesa Accettazione →
Accettato / Rifiutato`. Not one agreed value is present, including
**`In Attesa Accettazione`**, the rename this item singles out as mattering
most.

What _does_ exist on Quote:

- `Motivazione_Da_Ricontattare__c`, with three values (`Richiamare dopo la
stagione · Ha da fare · Deve pensarci`) — so the "qualificato da ricontattare"
  reason is captured, while the state it hangs off is not.
- `Quote.Crea_Tranche`, the **manual quote-side button** added 2026-08-25 — but
  for tranches, not for quote creation. The manual quote-creation button this
  item asks for does not exist.

The 5-day validity, the mandatory expiry date at send, and the day-2 and expiry
alerts have **no implementation at all** — there is no Flow in the org (see
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md)) and no
Apex that touches Quote other than `QuoteTrancheController`.

🔴 The constraint recorded on 2026-08-24 — **products and tranches may only be
edited while the quote is in `Bozza`** — is therefore **unenforced**. The
tranche UI shipped on 25 August without it, and `Bozza` is not a value
`Quote.Status` can hold. There are no validation rules on Quote.

This remains configuration, not design. The contradiction with the 20 August
client minute over whether "Da ricontattare" generates a task is untouched by
this check and still needs a human.

## 2026-08-25 - the reminder copy arrived

🟢 **Marco Montesi supplied the client reminder email copy**, owed since
20 August and chased again internally on 24 August. Elena Spini relayed it to
Aurel Mrruku on Slack at **10:11 CEST**: _"Marco Montesi ha mandato il copy della
mail di reminder al cliente"_, with the template pasted in full.

It is a **quote-expiry reminder**, sent by the tutor, built entirely from merge
fields: quote number/name, client name, service or product, send date, days
remaining, expiry date, and the tutor's name and contacts as the signature. The
body offers to review the offer and asks for a reply. Nothing in it is a
Salesforce behaviour — it is copy for the day-2 email this item already
specifies.

The template itself is a client-facing marketing asset and is **not reproduced
here**; it is in the Slack DM of 25 Aug 10:11 CEST for whoever builds the email
template.

**What is still owed by Marco Montesi is different and unchanged**: the list of
**preset expiry timings** per product category and business line. The copy
answers the day-2 email; it says nothing about how long a quote is valid for
anything other than the 5-day default.

The 🔴 contradiction above — whether "Da ricontattare" generates a task — is
**not** touched by this and still needs Elena Spini or Aurel Mrruku.
