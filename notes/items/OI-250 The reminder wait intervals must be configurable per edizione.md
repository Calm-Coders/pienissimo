---
id: OI-250
type: open-item
status: in-progress
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-10-16
updated: 2026-10-27
depends_on: [OI-186]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-10-16 UAT Flussi MKT Biglietti.md
---

# OI-250 - The reminder wait intervals must be configurable per edizione

**The ticket invitation flow applies one wait interval to all 11 reminders. The
person who runs the sends calculates a different gap before each one, by hand,
against the calendar. A hybrid design was agreed on 16 October — up to 11
interval fields on the Edizione, a blank field stopping the sequence — and it
is new build scope arriving the morning after the Fase 1 perimeter was frozen.**

## What exists

At [the 16/10 UAT session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)
(`00:14:30`) Fabrizio Mastracci described the field as built: a single
`weight interval` on the Edizione campaign, read by the Marketing Cloud journey
as the number of days between **every** send.

> _"Se io ho 11 email che vado a mandare e metto il weight interval qui che sarà
> due, mi manda la prima mail oggi, la prossima mail fra 2 giorni, la prossima
> fra 4, la prossima fra 6 e così via"_

He also stated the intention to make the campaign fields the journey reads
**mandatory** (`01:08:27`), so a campaign cannot be created without them.

## Why it does not work

Rebecca Marmo owns the sends and the intervals are not uniform (`01:09:37`):

> _"io dalla prima alla seconda mail passano due giorni, dalla terza alla quarta
> cinque, cioè variano"_

And they are a judgement, not a formula (`01:18:46`):

> _"quando programmo l'invio dei biglietti, weight me li calcolo io, guardo la
> il calendario e me li calcolo io a mano … magari non so il sabato preferisco
> non inviare comunicazioni, preferisco il venerdì, cioè lì è a preferenza
> nostra."_

🔑 **Putting the interval in the journey instead is the wrong fix, and the
reason is recorded.** Fabrizio Mastracci (`01:12:09`): a static journey step is
shared by every campaign using that journey, so changing it for one edition
changes it for all; a dynamic one means duplicating the journey and reworking an
11-mail flow with a loop each time. Sabatino Rinaldi asked for the journey
approach twice and was refused on those grounds.

## The agreed design

Two proposals converged. Aurel Mrruku offered 11 auto-created child records per
campaign (`weight 1` … `weight 11`), demonstrated with standard Tasks on screen
and intended as a custom object; Rebecca Marmo asked for **days of waiting, not
dates** (_"Io voglio giorni di attesa perché la data così ho paura che vada"_)
and he accepted.

Elena Spini proposed the flatter form (`01:28:19`) and Fabrizio Mastracci closed
on it (`01:31:13`):

|                     | Agreed                                                                             |
| ------------------- | ---------------------------------------------------------------------------------- |
| Where               | **Up to 11 interval fields on the Edizione campaign**                              |
| Unit                | **Days of waiting**, not dates                                                     |
| Default             | Prefilled — Fabrizio Mastracci referred to a default of `2`                        |
| Fewer than 11 sends | **A blank field stops the sequence there.** Five filled fields mean five reminders |
| Who fills them      | The campaign owner, at campaign creation                                           |

> **Fabrizio Mastracci:** _"Schermata iniziale dove hai un massimo di 11 campi
> che devi compilare tu … Dove non li compili vuol dire che il valore è assente
> e quindi l'invio della mail non parte."_

## Open

- 🔴 **It is not decided.** Elisa Migliano asked whether a decision was needed
  in the session; Elena Spini said no — _"Adesso vorrei solo capire se
  effettivamente questa soluzione può avere senso"_ — pending the client's own
  **internal meeting at 15:00 CEST on 16/10**. Elisa Migliano and Rebecca Marmo
  owe ROMI the outcome. **Nothing in any source records it.**
- 🔴 **Who may edit the fields is unresolved**, and Aurel Mrruku raised it as a
  blocker in its own right (`01:33:00`): _"Dobbiamo anche capire questi campi
  quando possono essere modifi[cabili], permessi da capire chi lo deve fare
  questa cosa"_. That is the fourth requirement now waiting on profiles that do
  not exist — see
  [OI-186](OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md).
- 🔴 **Both builders stated the cost.** Fabrizio Mastracci must rebuild the
  journey's wait logic 11 times as formula fields (_"devo fare 11 volte una
  formula"_) and depends on Aurel Mrruku shipping the fields to production
  first: _"io prima di tutto sicuramente dipendo da Aurel … e poi io devo
  ristravolgere"_.
- ⚠ **Nothing is built.** No commit in this sweep touches the Edizione campaign
  fields.

## 🔑 Why this is a governance finding as well as a build item

**The freeze announced on 15 October limits Fase 1 to _"affinamenti minori o
piccole correzioni puntuali"_**
([OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md)).
This is an 11-field schema change plus a journey rebuild plus a permission
decision, agreed the next morning, and **the freeze was named by nobody in the
room**.

Elena Spini made the process objection without invoking it:

> _"avevamo provato a scrivervi in tutti i modi qual erano le logiche e ci
> troviamo sempre a ridosso di tutto a fare delle modifiche … Perché questa cosa
> dei weight è uscita al 16 di ottobre"_

⚠ **The two sides disagree about whether it was specified.** Rebecca Marmo:
_"Io pensavo di essere stata abbastanza chiara nella mail degli 11 invi in cui
il tempo non è fisso, però a quanto pare non è stato chiaro."_ Fabrizio
Mastracci replied that he had sent her two mails asking her to confirm the
logics. **Neither mail is in this repository**, so the record cannot say who is
right — only that both believe they wrote it down.

## What closing it looks like

The client reports its internal decision; the number of intervals and the
blank-stops-the-sequence rule are confirmed; a profile or permission set is
named for who edits them; the fields ship to production; and the journey reads
them. Whether it is Fase 1 at all is a scope ruling under the freeze, and that
is a human's call.

## 🔴 2026-10-20 — the client accepted the design and the field count grew to 15

**The client confirmed the hybrid design in writing and widened it in the same
sentence: the set is now 11 to 15 communications, not 11.** Aurel Mrruku read the
consequence straight off it and owns the build.

[Their 20/10 mail](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md),
§3, Sabatino Rinaldi:

> _"Per gli eventi a pagamento (Camerieri Venditori, Academy, Pienissimo Live,
> Mastery, Happy Team) va bene la vostra proposta: un set di 11–15 comunicazioni
> con ritardi orari impostati a livello di edizione. Vi chiediamo di procedere
> con la configurazione e con il lavoro sui template, che devono essere
> completamente personalizzabili."_

🟢 **So the shape agreed on 16 October stands** — per-edizione intervals, client
configurable — and it is now authorised for build with five event families named.

🔴 **But the schema change is bigger than this row recorded.** At
[the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md):

> Aurel Mrruku: _"Ma quindi campi? 15 campi."_ — Elena Spini: _"15 campi.
> Esatto."_

- **He builds the fields himself**: _"Faccio io i campi e basta."_
- 🔴 **Straight to production, with permissions set by hand**: _"Li faccio, li
  porto in prod i campi, però sarà un casino. Poi col permesso facciamo a mano in
  produzione il permesso e poi lo sovrascrivo."_ ⚠ That is a deliberate
  hand-edit in production followed by a source overwrite — **the sequence that
  [the credentials-in-the-org risk](../risks/Risk%20-%20integration%20credentials%20exist%20only%20in%20the%20org.md)
  and [the Mexal order risk](../risks/Risk%20-%20the%20Mexal%20order%20integration%20exists%20only%20in%20the%20org.md)
  both describe.** The permission question this row flagged as unresolved on
  16/10 is therefore answered by a manual step, not a design.
- ⚠ **`completamente personalizzabili` is new and unestimated.** The template
  work is now explicitly in scope alongside the interval fields, and nothing
  sizes it.

🔑 **It also arrived with a second piece of new scope in the same section** —
[OI-269](OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md),
communications differentiated by ticket type, which would branch the same journey
this row rebuilds. **Neither was costed and neither was called a change request
to the client**, four days after the Fase 1 freeze.

## 2026-10-23 - confirmed to marketing, and the fields are the blocker

🟢 **The scope is restated and confirmed.** Elena Spini to Fabrizio Mastracci,
marketing group DM `C0C38JJ9D1T`, **14:21:27 CEST**:

> _"**Marketing:** confermati gli 11-15 reminder per edizione e il tasto
> rinuncia. @Aurel mrruku farà i campi su Campaign"_

Two things to read off it:

- 🟢 **The "11-15" range is confirmed in writing**, which matches the 20 October
  finding that 11 interval fields had become 15. **It is still a range, not a
  number** — nothing says whether the build targets 11, 15, or a variable count.
- 🔑 **The fields are assigned to Aurel Mrruku**, on the **Campaign** object, in
  one clause and with no date.

🔴 **Marketing is blocked on them.** Fabrizio Mastracci, 14:35:26:
_"appena so queste cose e ho i campi mi attivo."_ So the Marketing Cloud journey
work — the thing this row exists to enable — cannot start, and the dependency is
a single ROMI build item with no deadline against a **9 November production
deploy**.

⚠ **Nothing in the repository shows the Campaign fields built.**
`origin/DevMain` is still `ebc2c5b` and no commit since the watermark touches
Campaign metadata. ⚠ **And the 20 October warning stands**: the permissions for
these fields go in by hand in production and are then overwritten.

## 2026-10-26 - the 15 fields are built and live in Prod

🟢 **Aurel Mrruku asked for exactly 15 numbered fields, visible on the Edizione
layout only, and explicitly not reusing any field already in Prod.** Built and
deployed to `Pienissimo Prod` (deploy `0AfSW000001K2wL0AS`, 23 components, 0
errors), and verified in the org afterwards:

- **`Campaign.Wait_Interval_1__c` … `Wait_Interval_15__c`**, Number(3,0), no
  default, not required. The description says days of waiting before reminder
  _N_, blank stops the sequence.
- **A new `Campaign-Edizione Layout`** — a copy of the Prod `Campaign Layout`
  with a `Wait Interval` section (1-8 left, 9-15 right). It is assigned to the
  **Edizione** record type (`Campagna_Figlio`) for System Administrator,
  Standard User, Marketing User, Contract Manager, Solution Manager, Read Only
  and Agente. Evento and the master assignment stay on `Campaign Layout`, so
  **Evento does not show the fields**.
- **FLS read+edit** on the System Administrator profile and the
  `Full_Permission` and `Campaign_Management` permission sets (30 rows inserted
  by anonymous Apex on the two sets — additive, nothing else touched).

⚠ **Still open:**

- **Prod has no Campaign Lightning record page**; the Dynamic Forms
  `Campaign_Record_Page` exists only in source and UAT, so Prod shows the
  fields through the layout and UAT through the page.
- **The old single `Wait_Interval__c` and `Orario_Fine__c` exist only in Prod**,
  not in source. Same day, at Aurel Mrruku's request, both were **removed from
  the Edizione layout** (deploy `0AfSW000001K34P0AS`, verified), so the layout
  now references only source-backed fields and deploys from source.
- 🔴 **Aurel Mrruku: `Wait_Interval__c` is to be deleted at the go-live
  deploy** (_"sono campi che si devono cancellare quando si andrà in prod"_).
  Not done yet; it is still on the shared `Campaign Layout` (Evento), and any
  journey reference has to go before Salesforce will allow the delete.
- 🟢 **`Orario_Fine__c` stays** — he reversed it minutes later (_"lascia
  l'orario fine"_). It was retrieved from Prod into source, put back on the
  Edizione layout (Prod deploy `0AfSW000001K3Ar0AK`), and added to the UAT
  record page next to Orario Inizio with the Edizione visibility rule.
- 🟢 **UAT now has the same build** (deploys `0AfMA00000D0cdh0AB` and
  `0AfMA00000D0Wzi0AF`, verified): the 15 fields plus `Orario_Fine__c`, the
  Edizione layout and its assignments on the same seven profiles, the same
  FLS, and — because UAT's Campaign page is the Dynamic Forms
  `Campaign_Record_Page` — a `Wait Interval` section on that page, visible
  only when the record type is `Campagna_Figlio`.
- **Who may edit the fields** is still the [OI-186](OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md)
  question; the grants above follow the existing Campaign pattern, not a
  client decision.
- **Unit:** the 20/10 client mail says _"ritardi orari"_; the fields are
  described as days, per the 16/10 agreement. Fabrizio Mastracci's journey has
  to read them — that work is unblocked from today.

## 2026-10-27 - the client accepted the 11-15 set, and asked for customisable templates

🟢🔑 **The count question is answered: a set of 11–15, with the delays set on the
edizione.** Sabatino Rinaldi's reply, quoted verbatim by Elena Spini in the ROMI
marketing group DM `C0C38JJ9D1T` at **09:18:10 CET**:

> _"Per gli eventi a pagamento (Camerieri Venditori, Academy, Pienissimo Live,
> Mastery, Happy Team) va bene la vostra proposta: **un set di 11–15
> comunicazioni con ritardi orari impostati a livello di edizione**. Vi chiediamo
> di procedere con la configurazione e con il lavoro sui template, **che devono
> essere completamente personalizzabili**."_

Three things follow:

1. 🟢 **The mechanism this row describes is accepted** — per-edizione delays, not
   per-journey hard-coding. The build is what the client agreed to.
2. 🟢 **The event set is named** for the first time: Camerieri Venditori,
   Academy, Pienissimo Live, Mastery, Happy Team. 🔑 **Food Marketing Festival
   and Tour are explicitly excluded and deferred to Fase 2 by the client itself**
   — _"li rimandiamo a una fase 2 (eventi di settembre), anche perché dobbiamo
   ancora definire il modello di biglietteria."_
3. 🆕 **A new requirement rides in: templates "completamente personalizzabili".**
   Nothing in this row, in the register or in the recaps covers template
   editability, and no note says what it means — who edits, in what tool, with
   what guardrails. **Unowned and undated.**

⚠ **The unit is still "ritardi orari".** The client has now written *hourly*
delays twice (20/10 and here) against fields agreed on 16/10 as days. **Third
sweep flagged, unreconciled** — and now with configuration work formally
requested on top of it.

🔴 **The blocking dependency is unchanged:** Fabrizio Mastracci's journey work
cannot start until the Campaign fields are usable to him, and he was out of the
27/10 alignment (_"i pomeriggi sono impegnato su altri fronti"_) — see
[the staffing risk](../risks/Risk%20-%20the%20delivery%20team%20shrinks%20before%20Fase%202.md).

⚠ **Source caveat.** Sabatino Rinaldi's mail **is not in this mailbox**; it is
known only through the quotation above and **its date is unknown**. See the same
caveat on
[OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md).
