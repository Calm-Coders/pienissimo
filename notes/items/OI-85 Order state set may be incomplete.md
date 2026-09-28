---
id: OI-85
type: open-item
status: open
owner: ROMI
with: Fabrizio Paganelli
org: both
raised: 2026-08-06
updated: 2026-08-20
blocks: [OI-69]
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
---

# OI-85 - Order state set may be incomplete

Fabrizio Paganelli floated a fourth order state, **_Perso_**, driven by credit
notes — and did not claim to know how it would work: _"Non lo so come
funzionerà."_ Elena Spini flagged the three agreed states as thin — _"mi
sembrano troppo pochi."_

Left undecided in session.

**Decide before configuring** [OI-69](OI-69%20Order%20state%20model.md). The
question is really whether a reversal is a **state** of the order or an
**event** recorded against it: the
[credit-note flow](OI-54%20Credit%20note%20flow.md) already links a credit note to
both the order and the order line, and supports partial reversal of a
multi-event bundle. A partially reversed order is not obviously "lost".

**2026-08-20:** when the order states were finally drawn into
[the master diagram](../The%20newest%20design%20diagram.md), **only three boxes
appeared** — `Ordinato · Fatturato · Incasato`. **No `Perso`.** That is evidence
about the drawing, not a decision: Elena drew what was agreed on 06 August, and
this item records something floated *after* that agreement and left open. It
does mean nobody has acted on Fabrizio's fourth state in the fortnight since.

That also interacts with tickets: a credit note on an "evento" product
auto-cancels the matching asset, so a per-line reversal has to be expressible
without moving the whole order out of
[the paid states that release tickets](OI-75%20Ticket%20availability%20rule.md).
