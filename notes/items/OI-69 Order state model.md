---
id: OI-69
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-14
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
requirement: ORD-01
---

# OI-69 - Order state model

Order states are **Ordinato → Fatturato → Incassato**. The old **"Chiuso
acquisito" is deleted** — Fabrizio Paganelli: _"non serve più."_

**The Opportunity goes Closed Won only when the order reaches _Incassato_.**
Payment closes the opportunity, not signature. This binds the older
"closed-won driven by payment" principle to an explicit state, and it means
opportunity closure now depends on the invoice arriving back from Mexal.

Decided; configuration pending. `Order` carries **no custom fields** in the
repository, so nothing of this exists yet.

⚠ The set may be incomplete. Fabrizio floated a fourth state **_Perso_** driven
by credit notes and Elena Spini called three states thin — see
[OI-85](OI-85%20Order%20state%20set%20may%20be%20incomplete.md). Configuring
before that is settled means configuring twice.

Sits in the middle of
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md).
