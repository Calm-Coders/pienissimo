---
id: OI-300
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-10-29
updated: 2026-10-30
depends_on: []
blocks: []
source: Gmail 1a1884b8e0d02735
---

# OI-300 - Tutor training and tutor test access are unplanned

**The client's commercial lead asked two questions on 29 October that nothing in
the record answers: how tutor training will be organised, and whether the tutors
are all supposed to test under his own user. Both are unanswered as at this
sweep, and the second proposes shared credentials.**

## The questions

Marco Montesi, Gmail `1a1884b8e0d02735`, **2026-10-29 15:33:33Z**, to Elena Spini,
cc Fabrizio Paganelli, `amministrazione@pienissimo.com` and Aurel Mrruku:

> _"ok, ti chiedo due cose:_
>
> _1. **Come ci organizziamo per la formazione** che voi potrete fare ai tutor?_
>
> _2. **Per far fare dei test ai tutor, entrano tutti col mio account?**"_

They close the thread in which Elena Spini had answered his 27/10 questions on the
Zoho calendar and on note-taking — see
[the calendar decision](../decisions/The%20Zoho%20tutor%20calendar%20is%20not%20migrated%20to%20Salesforce.md)
and [OI-292](OI-292%20The%20Notes%20related%20lists%20on%20Lead%20Account%20and%20Opportunity%20are%20not%20built.md).
The _"ok"_ accepts those answers; these two are what they raised in their place.

⚠ Two images ride with the mail (`1.png` and `Immagine 2026-10-27 133550.png`) and
**were not opened**.

## Why it is open

1. 🔴 **Training has no plan, no owner and no date in this record.** It is a
   deliverable the client is now asking about directly, four days after the
   ticketing answers and eighteen days before the agreed go-live of
   [16 November](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md).
   ⚠ **How many training hours the contract carries, and who owns tutor training
   now, are both standing unanswered questions** in these records — this mail is
   the first time the client has pressed on either.
2. 🔴 **"Entrano tutti col mio account" is a shared-credentials proposal**, and it
   comes from the client, not from ROMI. If it were accepted, tutor test activity
   would all be attributed to one named user, which defeats record ownership and
   any audit of who did what during testing. 🔑 **Nobody has answered it either
   way** — so it is neither agreed nor refused.
3. ⚠ **Tutor user provisioning is the question underneath it.** The second question
   only arises because the tutors have no users of their own yet. Whether they are
   to get licensed users, community access, or nothing before go-live is not
   recorded anywhere.
4. ⚠ **Unanswered as at this sweep.** The mail is ~6 hours old at the watermark; no
   reply exists in the mailbox.

## 🟢 2026-10-30 - both questions answered, and the shared account is refused

🟢 **Elena Spini replied the next morning**, Gmail `1a18c4325074df92`,
**2026-10-30 10:02:40Z**, to Marco Montesi, cc Fabrizio Paganelli,
`amministrazione@pienissimo.com` and Aurel Mrruku — about eight hours after the
plan was settled internally in
[the 10:01 alignment](../meetings/2026-10-30%20Rapido%20Allineamento%20Aurel%20Elena.md).

### 1. Training

> _"possiamo organizzarci verso **la fine della prossima settimana (da giovedì in
> poi)** oppure all'inizio di quella successiva, **sempre prima del go-live**. Ci
> coordiniamo volentieri in base alle vostre agende."_

So the window is **5–6 November or the week of 9 November**, before **16
November**. ⚠ **Still no date, and still no owner named to the client** — though
Elena Spini is plainly doing it.

🔴 **The duration is recorded twice and the two disagree.** In the 10:01 call she
said _"penso che in **2 ore** me la cavo"_, for the commercial part only. In her
`#tproj-pienissimo` recap at **15:30 CET** the next step reads _"Elena - rifare
**un'ora** di formazione ai commerciali, appena l'ambiente di test è stabile e
allineato alla PROD"_. **Nothing reconciles one hour with two**, and the recap adds
a precondition the mail does not mention: **the test environment being stable and
aligned to production**.

⚠ **"Rifare" says this is a repeat.** How many training hours the contract carries
remains unanswered.

### 2. Users — the shared account is refused in substance

> _"contiamo di rilasciare l'utenza con la profilazione corretta **a partire da
> mercoledì** (ora hai accesso come admin); stiamo chiudendo gli ultimi test
> interni … **Anche gli altri tutor avranno un'utenza dedicata e profilata**, così
> da poter testare in autonomia."_

🔑 **So "entrano tutti col mio account" is answered no**, without being refused in
those words. Point 2 of this note closes: each tutor gets a dedicated, profiled
user. **Shared credentials are off the table.**

**The sequence, from the internal call:**

| When | What |
| ---- | ---- |
| **Tue 3 Nov 14:30–15:30 CET** | ROMI walk the `Agente` permissions — Elena Spini, Aurel Mrruku, Anita Aga, Rexhina Hysi optional. Invite `Test PS Tutor`, Gmail `1a18c2bf516096d6` |
| **Wed 4 Nov** | Marco Montesi's user loses admin, takes the restricted `Agente` profile |
| On his confirmation | the other agents get users of their own |

🟢 **The permissions already exist** and were built by **Rexhina Hysi** — an
`Agente` profile and permission set, with restrictive test users that could not
touch bundles or orders, testable in UAT. 🔴 **And she is full-time on another
project**, leaving Anita Aga as the only developer on Pienissimo.

🔑 **Tutors test in UAT, not production** — Aurel Mrruku, _"Non in produzione"_.

### What is still open

1. 🔴 **Licences are not confirmed.** Asked whether they have them, Aurel Mrruku
   said **_"disabilitiamo qualcosa che abbiamo noi"_** — free one of ROMI's own.
   That is a workaround, not a provision, and nobody has counted what is needed
   against what is held.
2. 🔴 **Nobody knows how many tutors there are.** Elena Spini: _"devo capire
   innanzitutto **quanti sono sti cavoli di tutor**."_ The only count on hand is
   **six agent codes supplied — five agents plus Marco Montesi** — and that is an
   agent count, not a tutor count.
3. 🔴 **A question is now back with the client and unanswered.** Elena Spini's mail
   closes: _"ti chiedo la cortesia di **confermare se dobbiamo predisporre
   l'accesso all'ambiente di test per tutti gli agenti presenti nel file Excel
   allegato**"_ — attachment `Utenti Area Commerciale.xlsx`. ⚠ **Not opened**: it
   holds staff records. **The provisioning cannot start until he answers.**
4. ⚠ **Training content is unprepared, by her own account** — _"Cacchio gli devo
   dire?"_ — though she has done it before and expects to prepare.
5. 🔑 **A separate tutor test session is booked for the same Tuesday**, `Test PS
   Tutor` 14:30–15:30, cc Rexhina Hysi — **two hours after the production e2e test
   with the client** at 09:30–11:30. Both land on 3 November.
