---
id: OI-69
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-15
source: meetings/results/2026-08-06-chiusura-punti-aperti.md
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

🔴 **The requirement register still carries the old order states, and this is
the one real state-machine gap.** `order.states` reads
**`[CREATO, CHIUSO/ACQUISITO]`** — the values from
[the diagram](../The%20newest%20design%20diagram.md), with the rule that
`CHIUSO/ACQUISITO` is _"set manually by administration within max 5 days of
confirmed payment"_. The 6 August session replaced that with
`Ordinato → Fatturato → Incassato`.

**Nobody has stated whether `Incassato` is `CHIUSO/ACQUISITO` renamed or a
different milestone.** It matters because
[the tranche](OI-50%20Tranche%20object.md) still uses `CHIUSO/ACQUISITO`, the
register documents the name as a deliberate Order/Tranche collision, and
`REQUIREMENTS.md` carries both vocabularies. **Confirm with Elena Spini, then
update the register** — configuring before that means configuring twice.

⚠ The set may also be incomplete. Fabrizio floated a fourth state **_Perso_**
driven by credit notes and Elena Spini called three states thin — see
[OI-85](OI-85%20Order%20state%20set%20may%20be%20incomplete.md). Configuring
before both points are settled means configuring twice.

Sits in the middle of
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md).
