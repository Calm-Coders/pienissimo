---
id: OI-227
type: open-item
status: open
owner: Elena Spini
with: Rexhina Hysi
org: ROMI
raised: 2026-10-12
updated: 2026-10-14
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

## 🔑 2026-10-14 — the answer arrived from the opposite direction: ROMI's own PM still describes the old wording, and does not know whether it was built

**Two sources the same day, both Elena Spini's, settle what this row was waiting
for — and they settle it against the rewrite.**

### 1. She described the task model to the client as the agreed as-is

Mail to Marco Montesi, **2026-10-14 17:14:01Z**, cc Sabatino Rinaldi,
Rebecca Marmo, Aurel Mrruku and Fabrizio Mastracci, in the Business Blueprint
thread, introduced as _"la sintesi del flusso **as-is** per come è stato
condiviso e tracciato nei diagrammi di processo"_:

> _"**Opportunità Status == "In Trattativa":** Trascorsi 2 giorni
> dall'aggiornamento dell'opportunità (se il preventivo non è stato ancora
> accettato), si prevede la creazione automatica di una **TASK** con: Subject:
> Preventivo Inviato · **Task Subtype: Da Ricontattare** · Due Date: giorno
> successivo alla creazione del task · Invio e-mail al cliente"_

🔴 **That is the wording `96d77de` replaced.** Two tasks "da ricontattare" became
two Opportunity parking stages; the PM, two days later, is telling the client the
tasks are the agreed flow.

### 2. She asked Aurel Mrruku whether it exists at all

DM, the same evening. Times CEST.

| Time | Elena Spini |
| --- | --- |
| 18:52:58 | _"PIENISSIMO - questa parte ce l'abbiamo? c'è la creazione di task + invio email?"_ — then the same spec verbatim, ending _"Verrà fornito copy da MM"_ |
| 18:53:33 | _"è presente sul grafico di Drawio ma non ne abbiamo mai parlato perchè non è stata fatta o perchè non ne abbiamo avuto modo?"_ |
| 18:54:46 | _"chiedo perchè ora Marco M. si è svegliato con le cose sue da chiedere … questa è l'unica che effettivamente ha chiesto - non abbiamo ancora il copy ovviamente però l'ha chiesta"_ |

**No reply from Aurel Mrruku is in the record at the time of this sweep.**

### What this establishes

🔑 **The question this row asked — was the new `SAL-20` agreed with the client,
and when — now has an answer, and the answer is no.** Not because anyone ruled
against it, but because:

- **The project manager does not know the behaviour's build state**, nine days
  after the commit that wrote it into the signable text as settled. Whoever
  authorised the rewrite, it was not her, and she was not told.
- **She is representing the pre-rewrite wording to the client as the as-is**, in
  writing, in the thread the Business Blueprint was delivered in. So the client's
  current understanding matches `REQUISITI.it.md` **before** `96d77de`, not after.
- ⚠ **Her own uncertainty cuts both ways**: _"non ne abbiamo mai parlato"_ means
  the task-and-email behaviour may never have been discussed with the client
  either. The old wording is not thereby confirmed — **neither version has a
  client ruling behind it**, which is worse than the row originally recorded.

🔑 **And a dependency surfaces that neither version mentions.** The reminder
email's copy is owed by **Marco Montesi** — _"Verrà fornito copy da MM"_, and
_"di questo siamo tuttora in attesa"_. The register's rewritten `SAL-20` has no
email in it at all; the mechanism it replaced did. ⚠ **So the rewrite dropped a
client-facing email that ROMI is still waiting on the client to write.**
Recorded as a consequence of the two texts differing, not as a separate defect.
See [OI-222](OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md).

### Unchanged by this

⚠ **The YAML was again deliberately not touched**, a third night. Later evidence
wins, but reverting contract-bound text on the strength of two internal messages
is not this procedure's call: the register is a separate authority and
[OI-184](OI-184%20Register%20v1.6%20goes%20to%20the%20client%20as%20one%20change%20set%20at%20UAT%20close.md)
exists so v1.6 reaches the client as one reviewable change set. **What has
changed is that the decision is now informed**: the person who has to make it has
said in her own words that she does not know whether it was built, and has told
the client the other version.
