---
id: OI-238
type: open-item
status: open
owner: Elisa Migliano
with: Marco Montesi
org: both
raised: 2026-10-14
updated: 2026-10-14
depends_on: [OI-59]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-14 UAT Test e2e.md
---

# OI-238 - The tacit renewal path skips client acceptance and its approval workflow is undecided

**The 14/10 e2e established that a Performance Plus tacit renewal needs no
DocuSign contract and no customer approval: the tutor confirms and accepts the
quote internally and it becomes an order to invoice. Then the session deferred
the question of what governs that — the approval workflow for renewals without
the customer's signature — to Marco Montesi, who was not in the room.**

## The behaviour, as confirmed in the room

[The 14/10 e2e](../meetings/2026-10-14%20UAT%20Test%20e2e.md) (`01:52:05`,
`01:53:45`): for the Performance Plus tacit renewal the full contract need not go
out through DocuSign, and

> _"Aurel mrruku e Elena Spini confermano che il tutor può confermare e accettare
> direttamente il preventivo internamente, trasformandolo subito in ordine da
> fatturare senza passare per l'approvazione del cliente."_

Two rulings from the same block support it:
[renewals carry no system contract, only the quote PDF](../meetings/2026-10-14%20UAT%20Test%20e2e.md),
and a renewal quote cannot be edited once saved — it is deleted and recreated.

## The open half

Gemini files the session's **only** `Da approfondire` as:

> _"**Workflow di approvazione per i rinnovi taciti** — La definizione del flusso
> operativo per gestire i rinnovi taciti senza il passaggio obbligato della firma
> cliente è stata rinviata in attesa di un riscontro da parte di Marco."_

and the next step is Elisa Migliano's: _"Chiedere un parere a Marco sulla
gestione dei passaggi obbligati per la conferma degli ordini di rinnovo senza
accettazione del cliente."_

## Why this is gating

- 🔴 **An internal confirmation creates a billable order against a customer who
  has signed nothing in this cycle.** Whatever the commercial basis of a tacit
  renewal is, the system now has a path from a tutor's click to a Mexal invoice
  with no customer artefact at all, and **no approval step stands between them**.
- 🔑 **It is a live path, not a design.** The session drove it: the renewal
  Opportunity, the quote on product `N07 / plus-06` in four tranches, the
  internal acceptance, and Aurel Mrruku's confirmation that the order had already
  reached Mexal.
- 🔴 **The person who must rule on it is the one person with an unanswered
  question of his own.** Marco Montesi's 05/10 question about mail and WhatsApp
  governance went nine days unanswered
  ([OI-222](OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md),
  answered 14/10 17:14Z), and his `Recall Tutor` mass-creation point is
  [OI-224](OI-224%20Mass%20Opportunity%20creation%20is%20contested%20as%20a%20Fase%202%20deferral.md),
  still unanswered by Sabatino Rinaldi. **Adding a third ask to the same
  bottleneck, seven days before go-live, is the risk here.**
- ⚠ **The renewal-without-DocuSign path is already a v1.6 register candidate**
  and has been since it was first described. This session is the first to confirm
  it end to end, and it is still not in the register.

⚠ **No claim that the behaviour is wrong.** A tacit renewal that renews by
silence is a normal commercial instrument. What is missing is the authorisation
step, who may perform it, and whether anything is recorded on the customer's side
when it happens.

## What closing it looks like

Marco Montesi's ruling on the mandatory steps, written down: who may confirm a
renewal order internally, against what evidence of the customer's intent, and
whether an approval process stands in front of it.
