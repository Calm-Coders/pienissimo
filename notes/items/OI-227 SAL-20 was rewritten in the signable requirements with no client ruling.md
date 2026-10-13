---
id: OI-227
type: open-item
status: open
owner: Elena Spini
with: Rexhina Hysi
org: ROMI
raised: 2026-10-12
updated: 2026-10-12
depends_on: [OI-59, OI-184]
blocks: [go-live]
severity: gating
requirement: SAL-20
source: git 96d77de, PR #94, 2026-10-12T12:22:14+02:00
---

# OI-227 - SAL-20 was rewritten in the signable requirements with no client ruling

**A developer commit changed `SAL-20` in the contract-bound register and in both
prose documents — `REQUISITI.it.md` included, the text Pienissimo signs — in the
direction of what was built. The requirement's `status` is still `to_confirm`,
the register's `version` is still `1.6`, and no client ruling for the new wording
exists in any source this sweep can read.**

## What changed

`96d77de` (Rexhina Hysi, 2026-10-12 12:22 CEST), merged to `DevMain` as
**PR #94** by Aurel Mrruku at 14:41 CEST.

| | Before | After |
| --- | --- | --- |
| Mechanism | two **tasks** "da ricontattare" | two Opportunity **parking stages** |
| Second trigger | after the **first contact** | after a **quote** |
| The date | **settable** by the user | **populated automatically** on entry |
| The reason | not mentioned | **mandatory**, one per stage |

The register's `state_machines.opportunity` block also gained the state
`"Da ricontattare"` and three rules, one of which is **not in `SAL-20` at all**:

> `"Moving to Chiusa/Persa automatically moves every related Quote to Rifiutato"`

The same cascade was written into the `Opportunity` row of the state table in
**both** prose documents — EN _"Chiusa/Persa rejects every related Quote"_, IT
_"Chiusa/Persa porta automaticamente tutti i Preventivi collegati a
Rifiutato"_.

## Why this is a row and not a correction

🟢 **The build itself is recorded and is not in question.** It is described in
detail, by the developer, in
[OI-59](OI-59%20Quote%20workflow%20configuration.md) — which also states the
instruction's origin: _"The user supplied the current task/Opportunity rules
directly and asked for the missing generic `Da ricontattare` stage."_ So there is
an internal instruction behind the behaviour.

🔴 **What is missing is a client ruling behind the words.** Three things make
that a problem rather than a formality:

1. **The Italian is the contractually operative text** (`AGENTS.md`, Language).
   An edit to `REQUISITI.it.md` is an edit to the document presented for
   signature, whoever makes it and for whatever reason.
2. **`status: to_confirm` was not changed.** The requirement is still formally
   unconfirmed, so the register now carries unconfirmed wording that reads as
   settled.
3. **`version` is still `1.6`.**
   [OI-184](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
   exists so that v1.6 reaches the client as **one** reviewable change set at UAT
   close. This edit is now inside the signable text and outside that change set,
   where the client will meet it without being told it moved.

⚠ **No claim is made that the new wording is wrong.** It may well be exactly what
the client wants, and the new text is more precise than the old. The defect is
that the record cannot tell the difference between "the client agreed this" and
"the build did this, so the requirement was made to match".

## What closing it looks like

Someone who was in the room says whether the new `SAL-20` and the Chiusa/Persa
cascade were agreed with Pienissimo, and when. Then either:

- it was agreed — cite the session, set `status`, and put the change in OI-184's
  change set so the client sees it as a change; or
- it was not — the wording goes back to the signed text and the built behaviour
  becomes a proposal, not a requirement.

⚠ **Until that happens, do not read `SAL-20` as agreed.** The three new
state-machine rules are in the same position.
