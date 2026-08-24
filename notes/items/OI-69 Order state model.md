---
id: OI-69
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-08-06
updated: 2026-08-24
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

## 2026-08-20 - the diagram caught up, and still did not answer the question

`Flows & Objects.drawio` was re-decoded at its **2026-08-20T15:36:24Z** version
and now **draws `Ordinato · Fatturato · Incasato`** (one `s`, as drawn) — on the
LEAD-OPTY page as a new `ORDINE` block, and again on the Ordini page — together
with the rule _"Status Order == Incassato >> Aggiornamento dell'Opty in **Chiusa
Vinta**"_. That is exactly the 06 August decision, and it is the first time the
drawing has carried it. It also confirms the second half of this note: the
Opportunity closes on `Incassato`, not on signature.

🔴 **But `CHIUSO/ACQUISITO` was not struck.** `Order Status SF ==
CHIUSO/ACQUISITO` and `Order Status SF == CREATO` are still on the Ordini page,
and the tranche rule still sends the first tranche to `CHIUSO/ACQUISITO`. **The
diagram now shows both vocabularies at once**, which is worse than showing only
the old one: it can no longer be dismissed as a drawing that predates the
decision, and it still does not say whether `Incassato` and `CHIUSO/ACQUISITO`
are the same milestone.

One weak signal, not enough to act on: the client's own
[`Workflow Pienissimo 23-7-26.drawio`](../The%20client%20Lead-Opty%20diagram%20moved%20on%2020%20August.md),
edited the same afternoon, labels its closed-won box **"Chiuso Vinto /
Incassato"** — while still defining `CHIUSO/ACQUISITO` separately elsewhere on
the same page. Suggestive of a rename; **not a ruling**.

**The state-name ask is unchanged.** Elena Spini: is `Incassato`
`CHIUSO/ACQUISITO` renamed, or a different milestone? Aurel Mrruku's 2026-08-24
decision now settles how the tranche is created and how payment rolls up, so
that mechanism can be built. The final tranche-state label and the Order state
machine must not be configured until this sentence exists.

⚠ The set may also be incomplete. Fabrizio floated a fourth state **_Perso_**
driven by credit notes and Elena Spini called three states thin — see
[OI-85](OI-85%20Order%20state%20set%20may%20be%20incomplete.md). Configuring
before both points are settled means configuring twice.

Sits in the middle of
[the quote to order flow](../flows/The%20quote%20to%20order%20flow.md).
