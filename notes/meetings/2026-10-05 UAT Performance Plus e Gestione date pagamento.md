---
id: MTG-2026-10-05-uat-performance-plus
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-111, OI-141, OI-151, OI-167, OI-186, OI-188, OI-201, OI-205, OI-206, OI-207, OI-208, OI-209]
source: Drive 1YPxjosDtZag60yd8GrNIYq68uaLbzRcwBPTyl3oF450 (Gemini notes + transcript)
---

# 2026-10-05 UAT Performance Plus e Gestione date pagamento

**Client UAT, 15:01 CEST, ~2h01m.** Aurel Mrruku · Elena Spini · **Fabrizio
Paganelli · Elisa Migliano · Sabatino Rinaldi · Marco Montesi** — four
Pienissimo-side. The Performance Plus activation path was driven end to end,
signed through DocuSign **in production**, and the session then turned to
renewals and to the scadenziario.

Read from the Gemini notes (summary, decisions, next steps and the full
`Dettagli` section) plus the opening ~15 minutes of the transcript. The rest of
the verbatim transcript was not read; the structured sections are
timestamp-linked.

## 🟢🔑 DocuSign production works, and the free-plan finding was the wrong account

Aurel Mrruku spent the morning unable to sign in — see
[the internal session](2026-10-05%20Interna%20Check%20PROD%20per%20MKT.md) — and
opened this call still blocked: _"da 3 ore che sto cercando di connetterla con
produzione, ma mi chiede il codice"_. Elisa Migliano read out the verification
code live and the connection completed in the session: _"meno male, meno male,
bello. Vi che facciamo live una prova introduzione di Dokusin."_

🔑 **There are two DocuSign accounts.** Aurel Mrruku: _"hanno due account
Elena. Allora, in qualche modo hanno creato un account, poi Docusign ha
aggiunto il loro account."_ And the one he had been configuring was the wrong
one: _"Io stavo facendo quella configurazione sugli user di amministrazione,
però no, dobbiamo usare user di Pienissimo, sappiatelo anche voi."_

🔑 **The client holds a paid contract.** Sabatino Rinaldi: _"noi abbiamo chiuso
un contratto per 2005, cioè abbiamo la disponibilità di erogare 2500 buste
annuali"_ — the figure he lands on is **2,500 envelopes a year** (the "2005" is
a transcription garble). One envelope per quote, several documents per envelope.

🔴 **This corrects, and largely discharges, the 05/10 finding that the
production account is a free plan capped at three envelopes** — that was the
`amministrazione` account, not the one the integration must use. Recorded in
[OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md).
⚠ Aurel Mrruku still intends to spend envelopes sparingly: _"cercherò di usare
il meno possibile Docusign in produzione perché costa."_

## Concordato — nine rulings

- **Plus products are one article with a tranche-count field**, selected from
  the codes agreed with Fabrizio Paganelli. 🔴 **The delivered article registry
  does not support this** — see
  [OI-210](../items/OI-210%20The%20delivered%20article%20registry%20carries%20no%20tranche%20count.md).
- **Quotes must show the list total, the net total and the total discount** as
  commercial information visible to the customer.
- **The contract activation date is the strategist's to fill.**
- **Strategists share one user account**, to hold down licence cost.
- **The `digital` field is hidden** in the contract interface; the field stays
  in the database. Task management is the strategist's.
- **Performance Plus renewals do not use DocuSign** — the order goes out
  through Salesforce and the state is set directly to `Firmato`.
- **Separate opportunity types for activation and renewal**, tied to the
  product configuration.
- **List price, quantity, discount, net amount and due date appear on every
  screen, quote and order.**
- **Email templates are editable directly in production.**

## Da approfondire — two

- **Overdue versus upcoming payments.** Fabrizio Paganelli wants unsettled
  amounts split between `scaduto` (a due date already past) and `a scadere`.
  Aurel Mrruku found `data scadenza` in the Mexal scadenziario and believes the
  calculation can be automated on the contract, **subject to agreeing the full
  set of scadenziario states with Mirko Merendi** —
  [OI-208](../items/OI-208%20Overdue%20and%20upcoming%20payments%20are%20not%20distinguished%20on%20the%20contract.md).
- **Anagrafica and address synchronisation.** Deferred to the same technical
  session —
  [OI-209](../items/OI-209%20Mexal%20anagrafica%20updates%20only%20propagate%20when%20an%20order%20is%20sent.md).

## 🔴 The quote layout is missing the commercial fields

Testing a renewal, Fabrizio Paganelli found **unit list price, quantity, unit
of measure, line discount and net price all absent** from the screen and from
the quote. Marco Montesi and he both put it as commercial transparency: the
starting price and the discount applied must show per line and reconcile to the
offer total. Aurel Mrruku accepted and explained the omission — the build had
concentrated on process logic rather than on layout. Elena Spini extended it to
the community pages and the documents.
[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md).

## 🔑 Renewals, settled

Fabrizio Paganelli: the twelve-month Performance Plus contract renews tacitly,
so **no new quote and no new DocuSign contract** — _"non è necessario inviare
né far firmare un nuovo contratto completo"_ — but a record must be generated
that tracks the new contractual period. Aurel Mrruku proposed moving the state
straight to `Firmato` off the renewal flag and opportunity type; agreed. The
customer receives **only the last page, the quote/order table**, deliberately
avoiding envelopes that would be consumed for nothing.

🟢 This is the client confirmation that
[the renewal decision](../decisions/Decision%20-%20Performance%20Plus%20Rinnovo%20bypasses%20conditions%20and%20signature.md)
did not have — that note was written from an internal instruction the same day.

## Products and tranches, as tested

The Plus products come from **a file supplied by Fabrizio Paganelli** and carry
article category `C10` or `C11`. 🔴 He flagged live that some codes are
disabled or cancelled, naming one of the renewal codes. Aurel Mrruku picked an
active product and configured **four tranches with monthly due dates from
October to January**, which generated the order lines. The custom metadata
tables (`C10` activation, `C11` renewal) were shown.

## Next steps recorded

| Owner | Action |
| --- | --- |
| Aurel Mrruku | Unit of measure onto the Plus products, populated in the next tests |
| Aurel Mrruku | List total, total discount and net amount onto the quote |
| Aurel Mrruku | Pienissimo logo top-left on the quote layout |
| Aurel Mrruku | Hide the `Digital` field, keep it in the database |
| Aurel Mrruku | Unit of measure, quantity, list price, discounts on the order lines and every layout |
| Aurel Mrruku | Automatic redirect to the signature page on renewal, bypassing DocuSign |
| Aurel Mrruku | Automatic date generation on quote creation |
| Aurel Mrruku | Email preview and in-Salesforce text personalisation |
| Aurel Mrruku | A button on the Account to force a real-time scadenziario refresh |
| Aurel Mrruku | Test orders prepared in advance for Wednesday's technical call |
| Aurel Mrruku | Documentation for the Plus tables and custom metadata |
| Aurel Mrruku · Fabrizio Paganelli | Align with Mirko Merendi on order→invoice behaviour in Mexal and on partial tranches |
| **Fabrizio Paganelli** | 🔑 **Map every scadenziario state and code — a complete list** |
| Elena Spini | Book Mirko Merendi for **Wednesday 07/10 at 12:00** |
| **Elisa Migliano** | Send the **renewal email template**, owed the next day |

🔑 **Fabrizio Paganelli now owns delivering the full scadenziario state list** —
the client-side answer to
[OI-201](../items/OI-201%20Ri.Ba.%20payments%20are%20read%20as%20unpaid%20because%20only%20P%20counts.md),
whose vendor-side answer has been in writing since 02/10 and is still not in
the code.

⚠ The Mirko Merendi session is on the calendar as
`[ROMI-PIENISSIMO] - Temi Integrazione Mexal`, **Wed 07/10 12:15–13:00**, with
`mirko@kreosoft.com`, `amministrazione@` and `fabrizio.p@`. It **overlaps the
WooCommerce and Mexal integration UAT booked 10:00–13:00 the same day.**
