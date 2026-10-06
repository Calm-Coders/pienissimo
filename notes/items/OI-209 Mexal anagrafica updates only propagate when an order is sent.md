---
id: OI-209
type: open-item
status: open
owner: Aurel Mrruku
with: Kreosoft
org: both
raised: 2026-10-05
updated: 2026-10-06
depends_on: [OI-58, OI-112]
source: notes/meetings/2026-10-05 UAT Performance Plus e Gestione date pagamento.md
---

# OI-209 - Mexal anagrafica updates only propagate when an order is sent

**Fabrizio Paganelli raised at the 05/10 client UAT that a correction to a
customer's registry data in Salesforce reaches Mexal only when an order is
transmitted, so a fix made on one side alone leaves the two systems
divergent.** The session deferred it to a technical call with Mirko Merendi.

Aurel Mrruku had just demonstrated the automation that derives fiscal
residence, the two- and three-letter country codes, the description and the VAT
sezionale from the billing address — so the newly computed values are exactly
the ones at risk of never arriving. Fabrizio Paganelli then widened it to
anomalies from data entered wrongly by customers or by operators.

The agreed next step, from the session's `Da approfondire`:

> _"La gestione della sincronizzazione e dell'aggiornamento notturno degli
> indirizzi e delle anagrafiche tra Salesforce e Mexal è stata rimandata a un
> confronto tecnico successivo con Mirko."_

## 🔑 The client's own workbook already specifies it

[The Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
has carried both legs in its `Flussi - elenco` sheet since July — they are the
only two rows that sheet has ever had filled:

| # | Flow | From | To | Object | Mode | Operation |
| --- | --- | --- | --- | --- | --- | --- |
| `F-1` | upsert anagrafiche | sfdc | erp cliente | account | realtime | update+insert, returns the ERP id — _"scatta alla prima opty won"_ |
| `F-2` | update | erp cliente | sfdc | account | **batch notturno** | update — _"ogni notte aggiorniamo le anagrafiche sfdc sulla base delle modifiche fatte su erp"_ |

🔴 **`F-2` is the nightly alignment the room decided to go and ask Mirko
Merendi about.** It was specified by the client, in the client's own document,
three months ago. This is the third instance of the same pattern in four days,
after `Data invio automatico biglietti` and the commercial quote fields in
[OI-207](OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md).

⚠ `F-1` is also narrower than what is built: it fires _"alla prima opty won"_,
whereas the behaviour Fabrizio Paganelli described is a send on every order.

## State

- No nightly Account read from Mexal exists. The 24/09 data jobs created
  **zero** Mexal customer-update queueables, and no new job has appeared since.
- 🔴 It compounds
  [the Mexal write risk](../risks/Risk%20-%20Mexal%20writes%20fail%20after%20their%20own%20log%20insert.md):
  the shipping address write already cannot complete, so even the
  order-triggered propagation is not reliable today.
- Unresolved: which system wins on a conflict, whether the nightly read
  overwrites a Salesforce-side correction, and who owns the exception queue —
  the same unassigned operational duty
  [OI-200](OI-200%20The%20client%20was%20asked%20to%20confirm%20logics%20whose%20open%20points%20were%20removed.md)
  and [OI-202](OI-202%20Anticipay%20does%20not%20recognise%20sole%20traders%20absent%20from%20the%20registro%20imprese.md)
  both record.

Due at `[ROMI-PIENISSIMO] - Temi Integrazione Mexal`, **Wed 07/10 12:15**.

## 🟢 2026-10-06 - the design question is answered in the room, a day before the vendor call

At **[the 06/10 client session](../meetings/2026-10-06%20Form%20Link%20per%20partecipanti.md)**
Fabrizio Paganelli opened on exactly this flow, and the room agreed a shape for
it — without Mirko Merendi, and before the 07/10 technical call it had been
deferred to:

> _"Gestione blocco interfaccia tra Sales Force e Mexal: i campi anagrafici non
> impattanti sulla fatturazione vengono bloccati sull'interfaccia utente di Sales
> Force, demandando le variazioni a Mexal con aggiornamento notturno."_

So the three unresolved questions this note recorded now have answers:

| Question | Ruling |
| --- | --- |
| Which system wins on a conflict | **Mexal**, for every registry field that bears on invoicing. Those fields are locked in the Salesforce UI so the conflict cannot arise from the Salesforce side |
| Whether the nightly read overwrites a Salesforce-side correction | It cannot: the correction is **made in Mexal** by design. Commercial fields stay open in Salesforce and are out of scope of the sync |
| Who owns the exception queue | ⚠ **Still unassigned.** Nothing in the session names an owner for anomalies from wrong data entry, which is how Fabrizio Paganelli widened it on 05/10 |

🔑 **The sync runs as a dedicated user that bypasses the interface lock** — the
notes are explicit: _"sincronizzate su Salesforce durante la notte tramite
un'utenza dedicata che bypassa il blocco."_ Creating the utenze is a next step
on the whole group.

🟢 **This is `F-2` of the client's own workbook, agreed at last** — three months
after it was written down. The pattern this note recorded still holds: the design
came back round to what the client had already specified.

## State after 06/10

- 🔴 **Nothing is built.** No nightly Account read from Mexal exists, the
  interface lock does not exist, and the dedicated user does not exist. The
  ruling is a design, agreed in a room, with **two weeks to go-live**.
- ⚠ **Fabrizio Paganelli owes the field list** — which registry fields stay
  editable from the Salesforce interface — as his own next step from the session.
  Without it the lock cannot be configured.
- The 07/10 12:15 `Temi Integrazione Mexal` call still stands, with Mirko
  Merendi, Elisa Migliano and Fabrizio Paganelli invited. ⚠ It now has a design
  to validate rather than a question to open.
- 🔴 It still compounds
  [the Mexal write risk](../risks/Risk%20-%20Mexal%20writes%20fail%20after%20their%20own%20log%20insert.md):
  the shipping-address write still cannot complete, so the order-triggered leg is
  unreliable even before the nightly leg is built.
