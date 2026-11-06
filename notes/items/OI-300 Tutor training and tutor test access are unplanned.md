---
id: OI-300
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-10-29
updated: 2026-11-06
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

## 🟢🔑 2026-11-02 - the licence count is answered: twelve, with one spare

The question this row has carried as _"licences unconfirmed"_ was settled on
[the 09:32 call](../meetings/2026-11-02%20Tema%20Contratti%20WooCommerce.md), with
Elena Spini sharing the figures on screen.

🟢 **Twelve Salesforce licences in total.** Aurel Mrruku: _"12 rimangono ancora
due, ma tieni in considerazione che la nostra poi deve essere tolta."_

The allocation was walked aloud and comes to eleven:

| Area | Count |
| --- | --- |
| Commerciale / tutor | **7** |
| Amministrazione | 1 |
| Marketing | 1 |
| PL / digital | 1 |
| **Allocated** | **11** |

Of the remaining two, **one is ROMI's own** working licence — Aurel Mrruku:
_"uno vostro per forza, perché devo agganciare tutte le integrazioni … mi serve
un'utenza per andare in produzione"_, _"fin quando finisco tutti i rilasci"_. So
**one genuinely spare**.

🔑 **The seven commerciali are partly named at last** — Fabrizio Paganelli listed
_"la Barbara, la Martina e la Carmen, la Valentina e la Sara, Marco"_ among the
tutors, six names plus one unnamed, _"quindi nel commerciale sono sette"_. ⚠ **This
is a licence allocation, not a tutor headcount**; how many tutors exist is still
unanswered.

🔴 **Demand already exceeds supply and the answer was to share accounts.** Marco
Montesi asked on Friday for a licence for someone working on Performance Plus;
Fabrizio Paganelli named **Rebecca and Giordano** as the two people who would need
one in addition. The resolution: **Giordano on the PL account** (_"potrebbe usare
quello dei PL tranquillamente"_), **Rebecca probably marketing**.

⚠ **Elisa Migliano objected and was not answered**: _"la Rebecca non so se è
corretto che lei utilizzi quello del marketing."_ 🔑 **This is the shared-account
pattern this row already refused in substance on 30 October** — _"Anche gli altri
tutor avranno un'utenza dedicata e profilata"_ — reappearing for named individuals
five days later, with nobody noticing the contradiction.

🔴 **Still open from 30 October**: the Tue 3/11 14:30 permissions walk, Marco
Montesi off admin Wed 4/11, training from Thu 5/11, and **the client's answer on
whether test access is needed for every agent in `Utenti Area Commerciale.xlsx`**.

## 🟢🔑 2026-11-03 - users went out, training has dates, and the shared-account idea died the same day

**Three of the four things this row was waiting on happened.**

🟢 **Seven agent users were provisioned in production** during
[the e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) — Carmen, Davide S.,
Barbara, Segreteria, Sara D., Martina, Valentina V. Fabrizio Paganelli wrote the
covering mail live, ending _"mi raccomando, non toccate nulla in ambiente produzione"_
because ROMI is still configuring. 🟢 **Four had already completed verification by the
end of the call.** ⚠ **Links expire after 72 hours**, so the rest must act by
6 November.

🔴🔑 **Note where this happened: production, not a test environment.** The 30 October
undertaking was _"l'accesso all'ambiente di test"_ and _"poter testare in autonomia"_;
what was actually given is production access with an instruction to touch nothing.
⚠ **Nobody reconciled the two**, and Elena Spini's own aside on the call — _"dei test
che poi dovremmo fare, se Marco mi risponde, mi conferma, saranno poi in ambiente, non
questo"_ — suggests she still means a different environment.

🟢 **Marco Montesi is off System Administrator**, a day early against the Wed 4/11 date
this row carried. Elena Spini told him at **17:20Z** (Gmail `1a1a26d14b6484d1`):

> _"come concordato, siamo passati dal profilo di **System Administrator** a quello
> corretto da **Agente**"_ — visibility unchanged, _"sono stati disabilitati i campi
> riservati all'amministrazione … i campi sincronizzati con Mexal non sono più editabili
> manualmente da layout per preservare la coerenza dell'integrazione"_

🔑 **This is the first evidence that the `Agente` permission changes are in a live org**
— see [the permission note](../objects/The%20Agente%20permission%20set%20gained%20Mexal%20and%20Anticipay%20access.md).

🟢🔑 **The shared-account pattern was proposed again and superseded within hours.** On
the call, because Marco Montesi has no agent code — _"lui è responsabile, diciamo, non ha
un codice agente"_ — Fabrizio Paganelli's answer was that he should use the
**`segreteria`** user: _"teniamo segreteria a Marco. Gli facciamo utilizzare
segreteria."_ ⚠ Only **Martina** and **Elisa Migliano** can read that mailbox. Fabrizio
Paganelli: _"Che casino, che casinisti che siamo."_ **Elena Spini objected —
_"secondo me Marco deve avere la sua utenza"_ — and she was right: by 17:20Z he had his
own Agente user.** 🔑 **So this row's objection to shared accounts prevailed on this
one**, in practice if not in principle; Giordano on the PL licence and Rebecca on
marketing are **unchanged**.

🆕 **Training has candidate dates.** The thread ran four messages on 3 November:

- Marco Montesi, 11:18Z: a course on 4 and 5, so **next week** — _"due incontri
  ravvicinati, tipo lunedì e mercoledì"_. 🟢 He **confirms six users**.
- Elena Spini, 14:57Z: **sessions of an hour and a half**, _"possiamo iniziare così e
  verificare come va"_.
- Marco Montesi, 16:51Z: **mornings**, because one tutor is away in the afternoons —
  **11:30-13:00**, subject to confirmation.
- Elena Spini, 17:20Z: _"la fascia 11:30 - 13:00 per lunedì e mercoledì per me è
  perfetta. Resto in attesa della tua conferma definitiva con i tutor."_

🔑 **So training is Monday 9 and Wednesday 11 November, 11:30-13:00, 1.5 hours each,
awaiting Marco Montesi's final confirmation.** ⚠ **Monday 9 November is the technical
go-live** and Wednesday 11 is the eve of the data migration. Nobody noted the collision.
⚠ It also moves off the _"from Thu 5/11"_ this row carried.

🔴 **Still unanswered**: whether test access is needed for every agent in `Utenti Area
Commerciale.xlsx` — asked on 30 October, **fifth day**. ⚠ Marco Montesi's _"6 utenze"_
against the **seven** provisioned is unexplained; `Segreteria` being a mailbox rather
than a person would reconcile it, and nobody said so.

🔴 **And the headcount question stands**: how many tutors exist is still unknown.

## 🟢 2026-11-04 - training confirmed and invited, and a new question nobody answered

🟢 **Marco Montesi confirmed, 08:59Z**, in the `Trasferimento dati` thread:
_"per la formazione ti confermo **lunedì 9 e mercoledì 11 dalle 11:30 alle
13:00**. Gira pure a me il link meet che lo passo ai tutor."_ So the dates and the
window are final.

🟢 **Elena Spini sent the invitations, 17:31Z**: _"Inviti inviati."_

🆕🔑 **And asked the question this item exists for, in one line:**

> _"Le utenze dei tutor **le creo dopo il training o procedo già adesso?**"_

🔴 **Unanswered at this sweep.** It is the tutor-access half of this row reaching
the client in writing for the first time — and it arrives **five days** after the
original question about test access for every agent in `Utenti Area Commerciale.xlsx`,
which is still unanswered.

⚠ **The collision stands and is now committed, not just proposed.** Monday 9
November is the technical go-live and Wednesday 11 is the eve of the migration; the
client's own man is **absent on Monday 9** and _"full"_ on the 10th and 11th
([OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)).
Nobody has yet named the collision to anybody.

🆕 **Fabrizio Paganelli wants to attend the Wednesday 11 session** — _"io
parteciperei alla riunione che abbiamo prestabilito per anche il commerciale
mercoledì 11"_ — and had no invitation when he asked; Aurel Mrruku had none either
and guessed Elena Spini was waiting on Marco Montesi, which the 08:59Z mail had
already settled hours earlier.

## 🟢🔑 2026-11-05 - the question is answered: the users exist, before the training, in UAT

🟢 **Marco Montesi chose, 09:04 CET**: _"inviti ricevuti, **direi di attivare adesso
le utenze**, grazie."_ So the answer to _"le creo dopo il training o procedo già
adesso?"_ is **now**, and it is the client's call, in writing.

🟢 **Elena Spini confirmed at 18:13:22Z** (Gmail `1a1acea8a4ffcff0`):

> _"ti confermo che **le utenze in ambiente UAT per i 6 tutor richiesti sono state
> attivate**. Ognuno di loro ha appena ricevuto l'email con il link per impostare la
> password (ricorda che il link ha una validità di **24 ore**)."_

Two operational facts arrive with it:

- 🔑 **MFA is mandatory at first login** — _"Salesforce richiederà obbligatoriamente
  la configurazione di un metodo di verifica (MFA / passkey)"_ — with a
  `Guida Gestione Passkey` document shared
  (`1HQrxKbVXQz1Nk5kvq6JJhYd_To45KBa6daTDwVbleew`). **Six people must complete a
  passkey setup before they can be trained**, and the password link expires in 24
  hours, i.e. before the Monday session.
- 🔴 **It is UAT, not Prod.** The tutors will train on 9 and 11 November in the
  sandbox; **no production users exist for them**, with the operational start on
  16 November.

🔴 **And it nearly did not happen**: creating them hit `LICENSE_LIMIT_EXCEEDED` and
existing UAT users were deactivated to make room —
[OI-341](OI-341%20The%20UAT%20org%20ran%20out%20of%20Salesforce%20licences.md).

⚠ **The collisions in this row are unchanged.** Nobody has yet told anybody that the
training sits on the technical go-live and the eve of the migration, and 🆕 **two more
meetings were put into Monday morning the same evening** — an internal Fase 2 review
at **10:00-10:30** and one with the client at **10:30-11:30** (Gmail
`1a1acbb192f4f8ba`, `1a1acbab3267bdb0`, both sent 17:21Z) — immediately before the
11:30-13:00 training, on the day Fabrizio Paganelli is absent.

⚠ **Still unanswered**: test access for every agent in `Utenti Area Commerciale.xlsx`,
now **seven days** old.

## 2026-11-06 — the tutors used the org and the first thing they touched failed

🟢 **All six tutors were in the org on the morning of 6 November**, two working days
before their training, and Marco Montesi had chased them to complete the password
and MFA setup: _"ho ricordato a tutti i tutor di gestire la cosa prima possibile
oggi"_ (Gmail `1a1b0134c558b416`, 08:56:56Z).

🔴 **Lead qualification would not let any of them enter the agent**, which is
mandatory, so the flow stopped — the users had been created the previous evening
without agent codes. Elena Spini named it as her own error and fixed it inside
eighty minutes →
[OI-345](OI-345%20Lead%20qualification%20was%20blocked%20in%20UAT%20because%20the%20tutor%20users%20had%20no%20agent%20code.md).

⚠ **Whether the MFA/passkey setup was actually completed by all six is still
unreported** — the 24-hour password link issued at ~19:13 CET on 5 November expired
on the evening of 6 November, and no source confirms six successful enrolments.

🟡 **The training slots are confirmed by the client**: Monday **9** and Wednesday
**11 November, 11:30-13:00** (Marco Montesi, 04/11 09:59 CET). The Monday collision
with the two Fase 2 reviews and the technical go-live is unchanged, and still
unmentioned to anyone.
