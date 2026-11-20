---
id: OI-375
type: open-item
status: open
owner: Elena Spini
with: Gianpaolo Motta, Angelo Pastorelli, Andrea Galotto, Aurel Mrruku, Fabrizio Mastracci
org: both
raised: 2026-11-19
updated: 2026-11-20
depends_on: [OI-342, OI-343]
blocks: [go-live, fase-2]
severity: gating
uncertain: the PEC itself has still not been read - it is not in the Gmail mailbox and no copy was found in Drive, and its deadline under art. 1454 c.c. remains unknown; every statement of its contents here is Elena Spini's account of it on the 19/11 internal call. The surnames of Angelo Pastorelli and Andrea Galotto were established on 2026-11-20
source: notes/meetings/2026-11-19 INTERNA Check temi PEC.md
---

# OI-375 - Pienissimo sent a PEC contesting the implementation and suspending the go-live

**Pienissimo has sent ROMI a PEC — a legally registered Italian email — dated
17 November 2026, formally contesting the Salesforce implementation, suspending
the go-live of 16 November, placing ROMI in default with a notice to perform
under articles 1454 and 1662 of the Italian civil code, and contesting the
so-called "fase 2". It arrived the day after the client's users went live and
the day before ROMI sent the client its first written release note. It is the
single largest change of position on this project.**

## The document

⚠ **The PEC was not read in this sweep.** It is not in the ROMI mailbox searched
(`a.mrruku@romicompany.com`) and no copy was found in Drive. Everything below is
**Elena Spini's account**, given on
[the 19/11 internal call](../meetings/2026-11-19%20INTERNA%20Check%20temi%20PEC.md)
and in the marketing group DM at **08:00–08:01 CET on 19 November**.

The subject line, as she pasted it into Slack verbatim:

> _"Formale contestazione delle attivita di implementazione Salesforce –
> **Sospensione del golive del 16 novembre 2026** – Messa in mora e diffida ad
> adempiere ai sensi degli artt. 1454 e 1662 c.c. – **Contestazione della
> cosiddetta «fase 2»**"_

| | |
| --- | --- |
| Instrument | **PEC** (posta elettronica certificata) — a registered, legally admissible notice in Italy, not an ordinary mail |
| Dated | **2026-11-17** — _"La PEC e datata il 17 novembre"_ |
| Reached ROMI's awareness | **2026-11-18**, by telephone — Gianpaolo Motta called Elena Spini on her last day of leave for an urgent call with **Angelo** and **Andrea G.** (Andrea Galotto) |
| Reached the project team | **2026-11-19 08:00 CET**, marketing group DM |
| Legal basis cited | **artt. 1454 and 1662 c.c.** — notice to perform within a fixed term, and the client's power to object to work in progress on a contract for services |

🔑 **Article 1454 is the mechanism by which an Italian contract is terminated for
breach**: the notice fixes a deadline, and if performance does not follow the
contract is dissolved by operation of law. ⚠ **No deadline from the PEC is
recorded in any source read in this sweep.**

## The grounds, as ROMI understands them

Elena Spini named three, and a fourth emerged in discussion:

1. 🔴 **Reports and dashboards are missing**, and she accepts they are a contract
   deliverable — _"le dashboard che mancano, che sono nel contratto e mancano,
   ok?"_ → [OI-377](OI-377%20Reports%20and%20dashboards%20were%20never%20built%20and%20have%20no%20requirements.md).
2. 🔴 **Training is missing** — specifically the **marketing** training; she
   states the commercial training was delivered. Aurel Mrruku's answer:
   _"abbiamo fatto piu di 5 giorni da 8 ore di formazione col cliente … e tutto
   registrato"_ → [OI-378](OI-378%20Marketing%20training%20is%20undelivered%20and%20the%20client%20did%20not%20attend%20the%20final%20test.md)
   and [OI-246](OI-246%20Key%20User%20training%20cannot%20be%20completed%20before%20the%20new%20go-live.md).
3. 🔴 **"Fase 2" is contested in its entirety**, together with its additional
   cost: _"la cosiddetta fase due e la richiesta di ulteriori [importo] e loro si
   aspettano che tutti i punti della fase due sono inclusi nel contratto."_
   🔑 **The client's position is that everything ROMI has scoped as Fase 2 is
   already inside the Fase 1 contract.** ⚠ The euro figure is **not transcribed
   here**, per the standing rule and the precedent set for the Fase 2 offer
   ([OI-342](OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md),
   [the offer note](../The%20Fase%202%20offer.md)).
4. ⚠ **The 16 November go-live date is itself contested** — which ROMI disputes
   on the record, because the client proposed that date. Elena Spini: _"non puoi
   contestare il 16 quando io ti ho fatto il favore che il 16 andava bene?"_ See
   [OI-268](OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md).

⚠ **This list is not the PEC's own list.** It is what ROMI's project manager
recounted on an internal call; the document may contain more or fewer heads of
claim. Elena Spini declined to read it out — _"la PEC ve la risparmio perche e
veramente imbarazzante"_ — and said she is now building a point-by-point
rebuttal from the meeting record: _"sto prendendo tutti i punti nella fase due e
prendendo in quale momento nell'arco della vita [del progetto] loro hanno detto
mettetelo in fase due, tranquilli."_

## What it has already changed

- 🔴 **Fase 2 is stopped.** _"Quindi per ora fase due, stop."_ →
  [OI-342](OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md),
  [OI-349](OI-349%20Fase%202%20has%20no%20developer%20committed%20for%20December.md).
- 🔴 **All other Pienissimo work is frozen** →
  [OI-376](OI-376%20All%20Pienissimo%20work%20is%20frozen%20except%20reports%20and%20dashboards.md).
- 🔴 **ROMI's project manager may no longer speak to the client.** Elena Spini:
  _"ormai non posso piu parlare con il cliente"_ — approvals now go through
  **Gianpaolo Motta** and **Angelo Pastorelli** — both surnames established on
  2026-11-20, see the update below. ⚠ The 19/11 record said _"Giancarlo"_; that
  was a mis-hearing of **Gianpaolo**.
- 🟡 **R0 of Fase 2 stays in production for now**, on Elena Spini's instruction
  and after she wrote to Angelo — Aurel Mrruku offered to remove it
  (_"R0 lo tolgo da produzione … che e facile toglierlo"_) and she answered
  _"No, per ora lascialo."_

## The timeline ROMI will rely on

Aurel Mrruku's account, twice on the record and consistent across Slack and the
call:

- **Monday 16 November** — four hours of calls with the client, _"Lunedi andava
  tutto bene"_. He states he confirmed the release content in that meeting,
  including the date format: _"lunedi gli ho detto guarda che porto … il formato
  della data … li porto col rilascio del 18"_ → [OI-358](OI-358%20The%20org%20is%20not%20set%20to%20Italian%20date%20and%20number%20formats.md).
- Then _"e arrivata la direzione"_ — the client's management arrived, the call
  was deferred to after lunch, then past 17:00, then _"sono spariti"_. The same
  disappearance was recorded on 18/11 from the ROMI DM.
- **17 November** — the PEC is dated.
- 🔑 **"Abbiamo tutto registrato"** — Aurel Mrruku's position is that every
  session is recorded, and Elena Spini relays the same advice from Angelo:
  _"se tu hai sempre registrato le riunioni … basta solo che mi dici e stato
  detto quel giorno."_ That is what the preserved transcripts in `meetings/` and
  the per-meeting notes in `notes/meetings/` are for.

## What is owed

- **The PEC itself**, into the record — its exact heads of claim and above all
  **its deadline**. Nothing else on this item can be assessed without it.
- **ROMI's written reply**, with the point-by-point Fase 2 chronology Elena
  Spini is assembling.
- **A decision on whether the 18 November release stands**, since the client is
  contesting the go-live it followed → [OI-374](OI-374%20The%2018%20November%20release%20mail%20tells%20the%20client%20the%20order%20contract%20flow%20is%20live.md).
- ⚠ **Who speaks to the client, in writing.** The project manager has been
  stood down from client contact and no replacement is named in any source.

## 🔑 2026-11-20 - ROMI answered it, and the client met ROMI the next day

🟢 **ROMI replied on 19 November.** Angelo Pastorelli, signing as ROMI's legal
representative, contests the PEC in full — the reconstruction of the facts and
the legal qualifications both — reserves a detailed rebuttal for a separate
communication, and states that neither the reply nor continuing to work is
acquiescence. Full text and analysis:
[OI-379](OI-379%20ROMI%20replied%20to%20the%20PEC%20and%20contested%20it%20in%20full.md).

🔑 **Three names are settled by that document**, all previously listed as
unreachable:

| Was | Is |
| --- | --- |
| "Angelo" | **Angelo Pastorelli**, ROMI's legal representative → [person note](../people/Angelo%20Pastorelli%20-%20ROMI%20legal%20representative.md) |
| "Giancarlo" | **Gianpaolo Motta** — a mis-hearing; Giancarlo Spadini is Life365 |
| the PEC's addressee | **Sig. Giuliano Lanzetti**, Pienissimo's legal representative → [person note](../people/Giuliano%20Lanzetti%20-%20CEO%20of%20both%20Pienissimo%20companies.md), whose first name this confirms |

🔴 **The meeting of 20 November at 14:30 happened**, with Salesforce present, and
produced a demand rather than a settlement: the client wants **lo scadenziario
and le note di credito ASAP** — both Fase 2 scope, demanded under Fase 1 →
[OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md).
The reply landed badly: _"call iniziata malissimo (Daniela NERA per aver ricevuto
la pec di risposta) alla fine andata un po meglio"_.

🔴 **The deadline is still unknown.** Four more mail formulations and two Drive
searches on 20/11 found no copy of the PEC and no term. ROMI has now answered a
notice to perform whose term this repository cannot state — **a second day**.

🟢 **ROMI's position on the substance is on the record for the first time**, in
Elena Spini's status post: _"Per noi tutto quello concordato per la Fase 1 e in
PROD dal 16/11."_ ⚠ Her own red flag is the closure, not the delivery — _"Fase 1
senza data di chiusura"_ — with reports and dashboards, marketing training and
WhatsApp outstanding, and two of the three dependent on the client.
