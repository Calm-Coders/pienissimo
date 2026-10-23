---
id: OI-268
type: open-item
status: resolved
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-20
updated: 2026-10-23
depends_on: [OI-246, OI-244, OI-267, OI-274]
blocks: [go-live]
severity: gating
requirement: CTX-02
supersedes: [OI-243]
source: Gmail 1a158b6e3e4cee81
also_source: notes/meetings/2026-10-21 Check Dati Migrazione e OP.md
---

# OI-268 - The client proposed a go-live calendar of 16 November

**On 20 October the client sent ROMI a full go-live calendar of their own,
proposing 16 November, a data migration across the 13–15 November weekend, and
invoicing left on Zoho until 13 November. It is the third date on this project
and the first one the client proposed. ROMI has not answered it, internally
rejects both the weekend and the 16th, and would counter with 9 November.**

Sent by Sabatino Rinaldi to Elena Spini at **11:31 CEST**, cc Fabrizio
Paganelli, Marco Montesi, Elisa Migliano, `amministrazione@pienissimo.com`,
Matteo Distaso and Rebecca Marmo; forwarded to Aurel Mrruku and Fabrizio
Mastracci at **09:48:52Z** with the single word _"FYI"_ (Gmail
`1a158b6e3e4cee81`). It reports their internal review of Friday 16 October.

## The proposed calendar, verbatim

> _"Abbiamo valutato la data del 16 novembre e vi proponiamo questa
> organizzazione:_
>
> - _nel weekend-giorni 13-14-15 novembre facciamo la migrazione dati (siete
>   disponibili anche nel week end?)_
> - _16 novembre: rilascio dell'ambiente di produzione e chiusura delle vostre
>   attività di progetto;_
> - _fino al 13 novembre: formazione interna, presa di confidenza con lo
>   strumento e gestione degli eventi Pienissimo Live e Pienissimo LAB. In questo
>   periodo la fatturazione resta su Zoho e Mexal;_
> - _dal 16 novembre: avvio operativo effettivo su Salesforce, con fatturazione
>   tra Salesforce e Mexal."_

Their reason is commercial load, not build state:

> _"Novembre è un mese molto carico per i commerciali e partire in quel momento
> significherebbe chiedere loro di imparare un nuovo sistema mentre vendono il
> Pienissimo Live. Preferiamo arrivare al 1° dicembre con persone formate, per
> non dover poi correggere errori operativi."_

⚠ **The rationale does not match the date it supports.** It argues for arriving
at **1 December** with trained staff while proposing operational start on
**16 November**. Nothing in the mail reconciles the two, and no source says
which governs. Recorded as the client's own inconsistency, not resolved here.

⚠ **Pienissimo Live runs 24–26 November** per the mail's §4 — *after* the
proposed go-live, during the period the rationale says should be protected from
a new system.

## 🔴 It puts invoicing on Zoho for thirteen days past the contract

**Zoho CRM expires 31 October 2026** (`zoho_expiry: 2026-10-31` in the
register). The proposal keeps invoicing on _"Zoho e Mexal"_ until **13
November** and starts Salesforce invoicing on **16 November**.

| Date set | Gap after Zoho expiry |
| -------- | --------------------- |
| Signed register — 21 October | none; ~10 days of dual run |
| [OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md) — 2 November | **2 days** with neither system |
| **This proposal — 16 November** | **16 days**, 13 of them with invoicing explicitly assigned to Zoho |

🔑 **This is the first time the client has written Zoho into a go-live plan**, and
they have written it past its own end date. Neither the mail nor
[the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md)
mentions the expiry. See
[the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md).

## 🔴 ROMI's answer, agreed internally and not sent

From [the 17:01 internal call](../meetings/2026-10-20%20Follow-up%20Interno.md)
and the marketing group DM the same morning:

1. **Counter with a 9 November release.** Elena Spini: _"io gli vorrei dire di
   fare la settimana prima … che facciamo il 9 rilascio, il 16 se vogliono
   possono avere la produzione pronta, ma noi il rilascio lo facciamo prima."_
   Aurel Mrruku: _"siamo costretti a farlo prima … perché si deve fare anche la
   migrazione dei dati"_, plus connected apps and the WooCommerce integration.
2. 🟢 **The release is not what takes the time.** _"il rilascio in produzione si
   può fare molto prima. Basta che loro ci diano la conferma che le cose stanno
   bene, io lo faccio anche domani."_
3. 🔴 **Refuse the weekend.** All three ROMI people declined it in writing within
   nine minutes on 20/10, in Slack `C0C38JJ9D1T`: Aurel Mrruku 11:55:45 CEST
   _"io non ci sono nei weekend"_; Elena Spini 11:58:23 _"per 2 dati del cavolo
   mo il weekend?"_; Fabrizio Mastracci 11:59:30 _"io non voglio esserci"_.
   A ROMI colleague the transcript renders as **Giampaolo** advised exactly this
   shape — accept the postponement as the client's own request, refuse the
   weekend.
4. 🔴 **Elena Spini is unavailable on the proposed date itself**, 16–18 November:
   _"io non ci sono il 16"_ and _"NON ho intenzione di esserci"_ (11:51 CEST),
   restated in the call as _"i 16 17 18 non ci sono"_. **The project manager has
   declined the client's proposed go-live day.**

⚠ **The reply is still owed.** She said in the call _"Entro sera manderò una
risposta a sta schifezza"_, then at 19:33:53 CEST asked the internal group for
feedback first and said she wanted to answer _"asap domani mattina"_, calling the
mail _"chilometrica"_. **As at this sweep the client's proposal is 10 hours old
and unanswered.**

🔑 **Her reaction to the manner of it is itself a finding**: _"non mi è mai
capitato MAI che fosse il cliente a mandarmi il calendario delle azioni e delle
cose da fare per il golive"_ and _"questi si fanno i conti senza l'oste"_
(11:49–11:50 CEST). Aurel Mrruku's reading: _"così è quando sei agile con loro."_

## 🔴 What the register says, and why this sweep did not change it

Unchanged: `go_live: 2026-10-21`, version 1.6, and `CTX-02` in both prose
documents, in the nine places
[OI-124](OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md) lists.

The rule OI-124 set and OI-243 followed is that **the register does not move on
a proposal awaiting a reply**, because `REQUISITI.it.md` is the signable text.
That rule holds tonight with the proposer reversed: **16 November is the
client's proposal and ROMI has not accepted it** — and internally rejects two of
its three load-bearing elements. Writing it in would record as contractual a
date ROMI has not agreed to.

**So the project now carries three dates and agreement on none:**

| Date | Proposed by | Status |
| ---- | ----------- | ------ |
| **21 October** | agreed and signed | 🔴 **in the register; it is tomorrow, and no go-live is scheduled** |
| 2 November | ROMI, 15/10 | never acknowledged by the client; now superseded by their own proposal |
| 16 November | the client, 20/10 | unanswered by ROMI; weekend and date both internally refused |

🔴 **The 22 October trigger named by the 19/10 trace now fires with client-side
evidence behind it.** From 22 October the register states a go-live that
demonstrably did not happen, and the client's own mail — scheduling internal
training *"fino al 13 novembre"* — is written proof they are not going live on
the 21st. **This is a human's decision and it is due now.** When it is taken,
`CTX-02`, the `M` priority definition, both milestone tables, the §14 Fase 2
rule, `go_live:` and the dual-run assumption at
`requirements/pienissimo-requirements.yaml:469` change **in both languages in
one session**.

## The rest of the mail

The other seven sections are tracked separately:
[OI-269](OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md) ·
[OI-270](OI-270%20The%20client%20wants%20a%20test%20company%20created%20in%20production.md) ·
[OI-272](OI-272%20A%20standard%20contract%20expiry%20alert%20rule%20is%20requested.md) ·
[OI-273](OI-273%20How%20the%20event%20date%20fields%20must%20be%20filled%20for%20multi-day%20events%20is%20unanswered.md) ·
[OI-250](OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md)
(11 intervals became 15) ·
[OI-242](OI-242%20The%20community%20Rinuncia%20button%20must%20show%20the%20public%20refusal%20text.md)
(confirmed) ·
[OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md)
(§7, the agreed tracciato) ·
[OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md)
(§2 and §8, the 23 October session).

🟢 **Also confirmed in writing**: Food Marketing Festival and Tour go to Fase 2;
the Ri.Ba. unpaid-instalment test and scadenzario variations go to Fase 2, with
the ticket returning to _"non disponibile"_ on a missed collection; Performance
Plus activation, contract and renewal tests _"sono andati bene"_.

## 2026-10-21 — agreed, with the weekend removed and the freeze removed

🟢🔑 **This is settled.** At
[the 10:01 client session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
both sides confirmed **16 November 2026** as the operational go-live, and the two
elements ROMI had internally refused were both resolved in ROMI's favour.

**The agreed calendar:**

| When | What |
| ---- | ---- |
| ~**9 November** (Mon) | Technical release to production, plus the manual configuration steps. A release, not a go-live — Elena Spini: _"un rilascio tecnico per permetterci di arrivare poi il 16 a dire 'Ok, è tutto pronto'."_ |
| 9–12 November | 🟢 **The client keeps invoicing on Zoho.** First historical-order import runs in parallel, from the data available. |
| Thu **12 November** | Last invoicing day on Zoho. |
| Fri **13 November**, 09:00 | Client hands over the second extract; second import runs. |
| Mon **16 November**, 09:00 | 🔴 **Invoicing live on Salesforce.** Aurel Mrruku, Elena Spini, Fabrizio Paganelli and Sabatino Rinaldi all on duty, 10-minute response undertaking. |

**What changed from the client's 20 October proposal:**

- 🟢 **The 13–15 November weekend migration is gone.** Aurel Mrruku: _"cerchiamo
  di non lasciare mai le immigrazioni e i deploy in weekend. Perché non abbiamo
  mai tutti i membri dei team operativi."_ Elena Spini: _"il 14[-]15 è weekend."_
  Nobody defended it.
- 🟢 **The operational freeze the client refused is gone**, which is what
  unblocked the date. The two-phase import separates the Salesforce release from
  the order migration: _"puoi avere una settimana di ordini non migrati in sales
  force. Dividiamo le tematiche … e così siamo tranquilli e non ci fermiamo manco
  un giorno, manco un secondo."_ Fabrizio Paganelli: _"Se è così va bene. Se è
  così va bene. Per me va bene."_
- 🟢 **ROMI's refusal of the 16th itself is withdrawn.** Elena Spini had said
  privately _"io non ci sono il 16"_; in the call she and the group committed to
  being on it.

**Where the client's date came from.** Fabrizio Paganelli: _"è una proposta questa
che … l'abbiamo ragionata ieri anche con la direzione che era qui"_ — settled with
their management on 19 October, the day before the mail. Elena Spini's objection
was the notice, not the date: _"nessuno mi aveva anticipato il tema … ci eravamo
sentiti lunedì, me lo potevate anticipare."_

⚠ **ROMI's written reply exists and is not in the swept mailbox.** Elena Spini
refers to it repeatedly — _"io ho risposto anche alla mail che mi ha mandato
Sabatino"_, _"come abbiamo scritto anche nella mail"_ — but it was sent from
`e.spini@romicompany.com` and this procedure sweeps `a.mrruku@romicompany.com`.
Its exact wording, and therefore whether 16 November is accepted in writing or
only verbally, is **not in evidence here.**

⚠ **There is no contingency day.** Aurel Mrruku asked for two freeze days, Friday
13 **and** Monday 16 — _"la cosa migliore è di prevedere due giorni di fermo, non
uno … venerdì e lunedì"_ — and did not get them: the client needs the 16th as a
working invoicing day. If the second import fails, it fails on a live day.

🔴 **The Zoho gap is now a fact, not a proposal.** Invoicing runs on Zoho to
12 November against a contract expiring 31 October: a **12-day** overrun, agreed
by both parties, and **Zoho was not mentioned once in either of the two client
sessions** —
[the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md).

🔴 **And it is agreed on top of a gating unknown.** The ticket-balance migration
([OI-274](OI-274%20The%20historical%20ticket%20balance%20has%20no%20migration%20path.md))
surfaced in the same call, has no built solution, and sits on the critical path
to the 16th.

## What closing it looks like

🟢 The date is agreed. What remains is the paperwork and the build:

1. **The register still says 21 October** — today, and from tomorrow a date that
   demonstrably did not happen. This run moved it to 16 November in the YAML and
   both prose documents; **the Italian wording needs a human's eye** because it
   is the text the client signs.
2. The 27 October Go/No-Go set by
   [OI-243](OI-243%20Go-live%20moved%20from%2021%20October%20to%202%20November.md)
   has lapsed and nothing replaced it. ⚠ **Neither 21/10 session mentioned a
   Go/No-Go at all.**
3. Someone has to ask the client whether they hold Zoho past 31 October.

## 2026-10-23 - the calendar is now agreed in writing by both sides

🟢🔑 **This is the written confirmation the 21/10 entry said was missing.** Four
messages on Gmail thread `1a158b6e3e4cee81` on 23 October close the evidential
gap: ROMI's own reply is now in the swept mailbox, the client restated the
calendar in their own words and accepted it, and ROMI confirmed it point by
point. **Nothing about the dates changed; the agreement stopped being verbal.**

### What arrived, in order

| When (UTC) | Who | What |
| ---------- | --- | ---- |
| **10:06:07** | Elena Spini → Aurel Mrruku, Fabrizio Mastracci | Forwards her own reply of **21 October 09:53** with _"FYI"_ — 🟢 **the mail the 21/10 entry recorded as not in evidence here.** ⚠ And with it the reason: _"avendo fatto rispondi a tutti purtroppo non eravate in copia (comunque NON hanno risposto e ora sto sollecitando e vi metto in cc)"_ |
| **10:09:04** | Elena Spini → Sabatino Rinaldi, Fabrizio Paganelli, cc the client's whole group + Aurel Mrruku + Fabrizio Mastracci | The chase. 🟢 _"riteniamo che la data del 16/11 rimanga per noi un target del tutto raggiungibile"_ — **ROMI's written acceptance of 16 November.** Also carries the ticket-scope position and the Change Request ask, tracked at [OI-285](OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md) |
| **10:41:34** | Fabrizio Paganelli, _"ti rispondiamo io e Sabatino"_ | 🟢🔑 **The client restates the calendar and accepts it** (verbatim below) |
| **13:14:42** | Elena Spini | Point-by-point confirmation, adding the two ROMI-side commitments |

### 🟢🔑 The client's own restatement, verbatim

> _"Dal 9 al 11 novembre i commerciali e l'amministrazione continuano a lavorare
> su Zoho_
>
> _Il 12 – 13 novembre interrompiamo la fatturazione e procediamo con la
> migrazione degli ordini non fatturati da Mexal a Salesforce. Dobbiamo anche
> caricare i dati storici come da mail di questa mattina._
>
> _Il 16 novembre lavoriamo tutti su Salesforce (marketing, commerciale,
> amministrazione)_
>
> _Se il giro è questo procediamo come da voi indicato."_

🔑 **This is the strongest acceptance in the record** — the client writing the
plan back in their own words and committing to it, signed _"Sabatino/Fabrizio"_,
i.e. including the project lead who escalated on 21 October.

### 🟢 ROMI's two added commitments

> 1. _"Dal 9 al 11 novembre i commerciali e l'amministrazione continuano a
>    lavorare su Zoho **>> ok, il 9/11 noi procederemo con il deploy in
>    Produzione**"_
> 2. _"Il 12 – 13 novembre … **>> entro il 13/11 mattina ore 9 noi dobbiamo
>    ricevere il file con gli ordini da caricare in Produzione.**"_
> 3. _"Il 16 novembre … **>> ok**"_

🔑 **The 13 November 09:00 extract deadline is now stated to the client**, not
just agreed in a call. It is the hard edge of the whole migration: everything in
[OI-244](OI-244%20Historical%20orders%20will%20be%20migrated%20from%20Mexal%20by%20spreadsheet.md),
[OI-275](OI-275%20The%20Mexal%20order%20key%20is%20not%20unique%20without%20the%20order%20date.md)
and [OI-276](OI-276%20Dummy%20import%20editions%20are%20needed%20to%20load%20historical%20orders.md)
has to be built, tested and runnable against a file that arrives that morning.

### ⚠ Small drift from the 21/10 table, recorded not reconciled

The 21/10 call minuted _"9–12 November: the client keeps invoicing on Zoho"_
with **12 November the last invoicing day**. The client's written version says
Zoho runs **9–11 November** and invoicing **stops on the 12th**, with 12–13
November given to the migration. 🔑 **One day moves**, nobody noted it, and
**the written version is the later evidence** — so the register's
`go_live: 2026-11-16` is unaffected but the intermediate dates should be read
from this thread, not from the 21/10 note.

### 🔴 Zoho, a seventh run unasked

The agreed plan now has the client **invoicing on Zoho from 9 to 11 November in
their own writing**, against `zoho_expiry: 2026-10-31` in the register — and
🔴 **Zoho is still not named by anyone as a problem**, in this thread or in
[the 23/10 call](../meetings/2026-10-23%20Import%20Ordini%20Migrazione.md).
That is now seven consecutive sweeps where the question is unasked while both
sides write plans that depend on the answer. See
[the risk](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md).

### 🟢 Status

**Resolved and now evidenced in writing on both sides.** What the "what closing
it looks like" list below still leaves open:

1. 🟢 The register was moved on 21/10 and the move is now backed by written
   mutual agreement rather than a verbal one. ⚠ **The Italian wording in
   `REQUISITI.it.md` still needs a human's eye** — unchanged, three runs on.
2. ⚠ The lapsed 27 October Go/No-Go is **still** unreplaced. Neither the
   thread nor the 23/10 call mentions a Go/No-Go.
3. 🔴 Nobody has asked about Zoho — see above.
