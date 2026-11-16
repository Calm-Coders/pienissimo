---
id: decision-opportunity-won-first-invoice
type: decision
status: resolved
owner: Elisa Migliano
with: Sabatino Rinaldi, Elena Spini, Aurel Mrruku
org: Pienissimo
raised: 2026-11-13
updated: 2026-11-16
depends_on: [OI-69]
blocks: []
requirement: DM-06
source: notes/meetings/2026-11-13 Richiesta call urgente.md
---

# Decision - the Opportunity is won at the first collected invoice

**On 13 November the client asked for the Opportunity to close as won at the first
collected invoice rather than when the order is paid in full, ROMI put it in
writing as an express derogation from the Blueprint, and it was built and released
the same evening. It was proved end to end in production on 16 November. The
request came from an internal misunderstanding on the client's side, and the two
people who own the Mexal and commercial sides were not both in the room.**

## The ruling

| | |
| --- | --- |
| **Trigger** | the **first invoice** on the order reaching collected — not the first tranche, because one invoice can carry several tranches and one tranche several events |
| **State** | `Chiusa/Vinta` on the Opportunity. The order keeps its own path: Ordinato → Fatturato → Incassato |
| **Scope** | all sales, **WooCommerce included** |
| **Side effect** | the restriction on editing a won Opportunity's order, lines and assets is **relaxed** |
| **Reversibility** | none. Only a System Admin, by hand, and the reports will not match |
| **Revisit** | Fase 2, together with the scadenzario reverse gear and an invoice-date rule |

## Who decided it, and how

Asked by **Elisa Migliano** and **Sabatino Rinaldi** on the call of 13 November
14:00 CET, convened by the client that lunchtime as urgent. Sabatino Rinaldi
opened with _"nostra culpa perche c'e stato tra di noi non ci siamo capiti e sta
roba non va bene"_ — the rule as built was the rule as specified; the client's own
people had not agreed internally.

Elisa Migliano gave the reason: a Performance Plus over twelve monthly tranches
closes only at the twelfth, and _"questo e lato commerciale sbagliato … non e
proprio un dato corretto a livello statistico, a livello commerciale, a livello
marketing."_

Accepted by **Aurel Mrruku** on the condition that it be written down and that the
hard case be revisited in Fase 2: _"possiamo decidere che facciamo che l'opportunity
vada in vinta alla prima tranche e **scrivete da qualche parte** che poi dobbiamo
rivedere la logica."_

## The written form

[Elena Spini's mail](../The%20Pienissimo%20recap%20of%20open%20changes.md) to
Sabatino Rinaldi, amministrazione and Fabrizio Paganelli, **2026-11-13 14:46:20Z**
(Gmail `1a1d55fdf926a7b5`), subject
`[ROMI-PIENISSIMO] - Aggiornamento urgente per logiche Opportunity`:

> _"**Richiesta del cliente, concordata in call:** l'Opportunity passa in
> 'Chiusa/Vinta' all'incasso della prima fattura ricevuta da Mexal, e non piu quando
> l'ordine e incassato per intero (valido anche per WooCommerce). **Lo facciamo su
> vostra espressa richiesta, in deroga a quanto previsto nel Blueprint**, ed Aurel
> lo inserisce nel rilascio di oggi."_

🔑 **"In deroga a quanto previsto nel Blueprint"** is ROMI's formal position on the
record: the Blueprint says otherwise and the client overrode it in writing. That
matters while
[OI-343](../items/OI-343%20The%20client%20disputes%20that%20the%20stage%20sale%20contract%20was%20outside%20the%20Fase%201%20Blueprint.md)
is live — the client is simultaneously disputing a different ROMI claim about what
the Blueprint covers.

The mail closes _"se qualcosa non corrisponde a quanto concordato, fateci sapere
asap. Altrimenti procediamo con il rilascio come descritto."_ Nothing records a
reply.

## Who was not in the room

🔴 **Fabrizio Paganelli**, who owns the Mexal side and whose reverse-payment
example the whole risk discussion rests on, was invited and never joined. Elena
Spini's mail: _"Riconfermeremo il tutto anche con Fabrizio, che oggi non era
presente."_ Her Slack status post of the same evening puts it plainly:
_"Fabrizio, che segue di solito le parti delicate di Mexal, non c'era."_

He did see it on 16 November and confirmed the rule in his own words, after
testing it himself:

> _"la regola generale che vale per tutto e che l'opportunity va in vinta quando
> c'e stato l'incasso collegato alla fattura che e collegato a sua volta a
> quell'ordine."_ — Aurel Mrruku: _"corretto."_

## Proved in production

On the 16/11 call, on a real order: quote with four tranches signed through
DocuSign, order into Mexal, part-invoiced, first invoice paid. The invoice and the
scadenza went paid, the **order correctly stayed out of Fatturato** because not
everything was invoiced, and the **Opportunity went Vinta**. Aurel Mrruku:
_"Perfetto, funziona."_

## What the decision leaves open

[OI-365](../items/OI-365%20The%20Opportunity%20cannot%20return%20from%20Vinta%20once%20a%20payment%20is%20reversed.md)
— the one-way door, the missing admin runbook, and the deferred invoice-date rule.
