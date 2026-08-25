---
id: OI-91
type: open-item
status: in-progress
owner: ROMI
org: ROMI
raised: 2026-08-19
updated: 2026-08-24
depends_on: [OI-50, OI-75]
blocks: [OI-92]
uncertain: who requested it, and whether it is in contract scope
source: Drive - Flusso Biglietti.drawio, created 2026-08-19T15:00:55Z; confirmed in Flows & Objects.drawio, modified 2026-08-20T15:36:24Z
---

# OI-91 - Aggiornamento Incasso button

A second Asset button, drawn for the first time in
[the 19 August ticket flow diagram](../The%20ticket%20flow%20diagram%20of%2019%20August.md)
and **recorded nowhere before it** — not in either tracker, not in
`REQUIREMENTS.md`, not in the requirement register, not in any meeting result.

What the diagram specifies:

- **Visible only to administration users**, and only **after an Asset reaches
  `Disponibile`** — the mirror of the `Casi Limite` button, which appears only
  after `Assegnato`.
- Its purpose: _"correggere lo sbaglio di una fattura pagata in relazione ad una
  tranche errata"_ — a payment booked against the **wrong tranche**.
- Behaviour: from the button, see **every tranche/rata on that Account's
  order**, update the correct one, and **put the asset back to its previous
  state — `Disponibile` → `Ordinato`**.

## Why it matters more than a button

It is the **first backward transition in the asset state machine**. Everything
in [OI-74](OI-74%20Asset%20state%20machine.md) and
[the ticket lifecycle](../flows/The%20ticket%20lifecycle.md) moves forward;
`Disponibile → Ordinato` reverses the release rule that
[OI-75](OI-75%20Ticket%20availability%20rule.md) makes the centre of the ticket
flow. If a ticket can be un-released, then availability is **not** a one-way
consequence of a paid tranche, and OI-75's wording needs to say so.

It also assumes a **tranche object that can be re-pointed**, which
[OI-50](OI-50%20Tranche%20object.md) records as **not built at all** — nothing
exists. So this cannot be built before the tranche object is.

⚠ **Unknown, and not to be guessed:** who asked for it, whether it came out of
the 19 August session, and whether it falls inside the contracted scope or is
evolutiva. The diagram is the only evidence; it carries no attribution. The
20 August asset meeting called by Elisa Migliano — _"ci sono delle cose di cui
non abbiamo mai parlato"_ — is the obvious place it gets confirmed or denied.

## Confirmed in the master, 2026-08-20 - and now questioned

The button is **no longer only in the standalone drawing**: the 20 August
re-decode of `Flows & Objects.drawio` found it folded into the master's
`Flusso Biglietti` page, unchanged, with the same
_"visibile solo dopo che un Asset è DISPONIBILE"_ rule. See
[the newest design diagram](../The%20newest%20design%20diagram.md).

Drawn beside it on the same day is a new question —
[OI-92](OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
— asking whether an **unpaid invoice in Mexal's _scadenziario_** could drive the
same reversal automatically. If the answer is yes, this manual button may be the
wrong shape for the requirement, or may be only the fallback path. **That is
reason not to build it yet**, on top of the tranche object not existing.

⚠ Still no attribution, and Elisa Migliano's 20 August asset meeting left **no
recording, no canvas entry and no message** — see
[the trace](../traces/Source%20trace%202026-08-20.md). Whether it ran at all is
unrecorded.

## 2026-08-24 - the origin is now known, and an alternative is on the table

Two recovered minutes date this item precisely.

**It was raised on [19 August](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md)** by Elisa Migliano and Elena Spini: a
button, named "Aggiornamento Incasso" or similar, letting administrators fix an
instalment recorded against the wrong invoice by forcing the ticket's
availability back to `ordinato`. The same session listed the underlying problem
as explicitly **da approfondire** — it is the one thing that meeting declined to
settle.

**On [20 August](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) Fabrizio Paganelli proposed an alternative** to the button
entirely: compare the **Mexal scadenziario** day over day, detect the
discrepancy, and correct availability automatically without an administrator
pressing anything. See
[OI-92](OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md).

**These are competing designs, not complements** — one is a manual admin
override, the other removes the need for the override. The 20 August decision was
to take the choice to Andrea Di Cicco rather than to decide it in the room.

Elena Spini also holds an action from 19 August to design the button's logic and
circulate the proposal; there is no sign on any source that she has.

The button remains drawn in the [master diagram](../The%20newest%20design%20diagram.md) — admin users only, visible
only after an asset is `Disponibile` — so the design file still shows the manual
route as current.
