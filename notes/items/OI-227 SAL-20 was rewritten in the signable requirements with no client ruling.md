---
id: OI-227
type: open-item
status: open
owner: Elena Spini
with: Rexhina Hysi
org: ROMI
raised: 2026-10-12
updated: 2026-10-19
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

## 🔴 2026-10-15 - she has told the client it is built, and asked Aurel Mrruku to make that true

**Elena Spini, DM to Aurel Mrruku, 2026-10-15 18:33:14 CEST (16:33Z):**

> _"poi domani mi fai sapere se questa cosa c'è in UAT please? e se non c'è se la
> possiamo mettere domani dato che me la sono venuta come fatta 🙂"_

Read as _"me la sono vendut**a** come fatta"_ — _I have sold it as done_. ⚠ The
dictation is imperfect and that reading is this sweep's; no other reading of the
sentence is available, and nothing else in the DM qualifies it.

🔑 **This is the escalation, and it is the worst available version of this row.**
Yesterday the position was that the project manager did not know whether a
requirement rewritten into the signable text had been built, and was describing
the pre-rewrite version to the client. Tonight she has told the client it **is**
built, and is asking the developer to confirm it exists — or to build it tomorrow
so the statement becomes true.

The sequence, across two days and three surfaces:

| When (CEST)      | Where                     | What                                                                      |
| ---------------- | ------------------------- | ------------------------------------------------------------------------- |
| 14/10 19:14      | mail to Marco Montesi     | describes the **as-is** as the TASK model — the wording `96d77de` deleted  |
| 14/10 20:52      | DM to Aurel Mrruku        | _"questa parte ce l'abbiamo? c'è la creazione di task + invio email?"_     |
| 14/10 20:53      | DM to Aurel Mrruku        | _"non ne abbiamo mai parlato perchè non è stata fatta o perchè non ne abbiamo avuto modo?"_ |
| **15/10 18:33**  | **DM to Aurel Mrruku**    | **_"me la sono venuta come fatta"_**, and a request to build it tomorrow if absent |

🔴 **Aurel Mrruku has not replied to any of the three.** The 15/10 session ran for
seventy-seven minutes with both of them in it and `SAL-20`, the task model and
the reminder email **are not mentioned once** in the transcript. The automation
subject came up (`00:11`–`00:20`) but about Marco Montesi's own asks, which
Sabatino Rinaldi then de-prioritised — see
[OI-222](OI-222%20The%20commercial%20mail%20and%20WhatsApp%20notification%20flows%20are%20unspecified.md).
The build state of the rewritten requirement was not raised with the one person
who knows it, in the one place both were present.

## 🔴 What this does to the row

1. **The register question is now urgent rather than merely open.** Three nights
   of leaving the YAML alone were justified by the decision being uninformed.
   That argument is gone: a statement has been made to the client, and the
   register says something different from both what was built and what the client
   has been told.
2. **A build may land tomorrow to match a sentence.** _"se la possiamo mettere
   domani"_ is a request to implement a contract-bound requirement on a day's
   notice, under a scope freeze announced the same evening
   ([OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md))
   that permits only _"affinamenti minori o piccole correzioni puntuali"_. ⚠ If
   it is built, the register's current text is wrong; if it is not, the client has
   been told something untrue. **Either way the YAML has to move**, and which way
   depends on a decision nobody has taken.
3. ⚠ **It is still not a client ruling.** Nothing in today's sources establishes
   that the task model was ever agreed with Pienissimo. The row's central finding
   stands unchanged: **neither version of `SAL-20` has a client ruling behind it.**

### Unchanged by this

⚠ **The YAML was again deliberately not touched**, a fourth night — because the
correct edit now depends on an answer due tomorrow. **This is the last night that
reasoning holds.** Once it is known whether the behaviour exists in UAT, the
register either moves to match the build or the build happens and the register
moves to match it; waiting past that point is just drift.

🔴 **The reminder email's copy is still owed by Marco Montesi.** Elena Spini
restated it in the session, a fortnight on: _"abbiamo previsto un invio della
mail di cui siamo sempre in attesa del suo COP[Y] che non ci ha mai più
rimandato"_.

## 🔴 2026-10-16 — a fifth night, and the question Elena Spini asked by today went unanswered

**Nothing moved.** The record for the day:

- 🔴 **No reply to the 18:33:14 DM of 15/10.** Elena Spini asked Aurel Mrruku to
  tell her **today** whether `SAL-20` is in UAT — _"domani mi fai sapere se questa
  cosa c'è in UAT please"_. The Elena Spini DM carried 14 messages on 16/10
  (12:22 CEST and 17:43–17:53 CEST); **every one is about LIFE365 documentation
  and none mentions `SAL-20`, UAT or the parking stages.**
- 🔴 **Not raised in the session.** `SAL-20`, _"da ricontattare"_ and the
  Opportunity parking stages appear nowhere in the 02:26:15 of
  [the 16/10 UAT](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md) —
  which was the marketing flow, so the absence is expected rather than telling.
- 🔴 **No client ruling in any source.** No mail, no message, no meeting.
- 🔴 **`DevMain` has not moved**, so the rewritten text stands exactly as PR #94
  merged it on 12/10.

🔑 **Four messages in three days, none answered.** The escalation recorded on
15/10 — that she has told the client the behaviour is built, _"me la sono venuta
come fatta"_ — is therefore **unresolved going into the key-user test week that
starts on Monday**, and the Opportunity parking stages are part of the
commercial flow Marco Montesi is shown on 19/10 at 15:00.

### The register, a fifth night

**Not amended. Version stays 1.6; `SAL-20` stays `to_confirm`.**

⚠ **The 15/10 trace said this reasoning expires today, and it has.** The
argument for leaving the YAML alone was that the correct edit depended on an
answer Elena Spini had asked for by 16 October. **That answer did not arrive**,
so the dependency has not resolved — it has simply gone stale.

🔑 **This sweep still does not amend it, for a different and narrower reason:
there is nothing new to write.** The options have not changed and none of them
is this procedure's to pick —

| Option | Why it is not an agent's call |
| --- | --- |
| Revert `SAL-20` to the pre-`96d77de` wording | Reverses a signable-text edit a ROMI developer made deliberately, against an internal instruction recorded in [OI-59](OI-59%20Quote%20workflow%20configuration.md) |
| Confirm the new wording | Requires a client ruling that does not exist |
| Mark `SAL-20` disputed in the register | Writes a project-management state into a contract-bound document |

⚠ **What has changed is the cost of waiting.** The text sits in
`REQUISITI.it.md` — the document Pienissimo signs — describing behaviour the
client has never ruled on, **five days on, with the client's own people in the
system from Monday.** The fix is one answer from Aurel Mrruku about his own
build, and it has been asked for four times.


## 🔴 2026-10-19 — sixth night, and the key-user week has started

**No answer.** Elena Spini's DM carried seven messages on 19/10 and **`SAL-20`
is in none of them** — they are the quote discounts, a live error screenshot and
the Mexal migration tracciato. The 01:45 commercial-flow session with four client
people never mentioned it either, in a session that walked the entire
quote-to-tranche path `SAL-20` sits in.

🔴 **Five messages in four days, none answered.** The question Elena Spini asked
to be answered by 16 October is now three days overdue, and **the rewritten
signable text stands while the client's own key users test the system it
describes** — their window opened today and runs to 23/10.

⚠ **The YAML was left alone a sixth night, for the reason given on 16/10 and not
a new one: there is nothing new to write.** The three available moves are
unchanged — revert a deliberate developer edit to signable text, confirm wording
with no client ruling, or record a project-management state in a contract-bound
document. **None of them is an agent's call.** What has changed is only the cost
of waiting.
