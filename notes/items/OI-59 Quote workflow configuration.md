---
id: OI-59
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-07-31
updated: 2026-08-15
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

| Object      | New name                                | Was                |
| ----------- | --------------------------------------- | ------------------ |
| Quote       | `In Trattativa`                         | _Prev. Inviato_    |
| Quote       | **`In Attesa Accettazione`**            | **_Scaduto_**      |
| Opportunity | `In Trattativa`                         | _Preventivo Inviato_ |
| Opportunity | `Da Ricontattare - Prev. Inviato`       | _Da Ricontattare_  |

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
