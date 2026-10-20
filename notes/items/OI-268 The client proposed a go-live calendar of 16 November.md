---
id: OI-268
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-20
updated: 2026-10-20
depends_on: [OI-246, OI-244, OI-267]
blocks: [go-live]
severity: gating
requirement: CTX-02
supersedes: [OI-243]
source: Gmail 1a158b6e3e4cee81
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

## What closing it looks like

One date, agreed by both parties in writing, with the weekend question settled
and the Zoho gap either closed or consciously accepted — then the register moved
in both languages in the same session.
