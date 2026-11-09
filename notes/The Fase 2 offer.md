---
id: fase-2-offer
type: reference
status: active
owner: Andrea Galotto
with: Elena Spini
org: ROMI
raised: 2026-11-02
updated: 2026-11-09
depends_on: [OI-308]
source: Drive 1nE19jesbBpP2JXdnDOZfAnB--fhaEKMCMrgf9RxkWbY and 1b329SMXkcG3kivDfvoziCFuk2I19DlQQqS_UTQtKFeA
---

# The Fase 2 offer

**The Fase 2 commercial offer exists. It was created on 2 November by Andrea
Galotto and sits beside Elena Spini's project plan, which was updated the same
morning. Together they define six releases from November 2026 to 26 March 2027,
with a client approval deadline of 13 November. The two documents disagree on the
day count by a factor of two, and neither carries a maintenance line.**

Read from Drive on 2026-11-02 — both are Slides decks, no figures transcribed
beyond those stated here.

| Document | Id | Owner | Created | Modified |
| --- | --- | --- | --- | --- |
| `Pienissimo Offerta Fase 2` | `1T1gExUUq4_fUkXjJY3b_fa66kPrHNmI6N_3wLXbldaY` | Andrea Galotto | 2026-11-02 09:21Z | 2026-11-02 14:45Z |
| `Pienissimo_Project_Plan_Fase2` | `1b329SMXkcG3kivDfvoziCFuk2I19DlQQqS_UTQtKFeA` | Elena Spini | 2026-10-27 | 2026-11-02 09:40Z |

## The release plan

| Release | Content | Go-live | Plan estimate |
| --- | --- | --- | --- |
| Analisi | Workshop, solution design, Business Blueprint Fase 2 | Dec 2026 | 5-7 gg |
| **R0** | **Contratti post-vendita da palco** (standard courses **and** Performance Plus) | **Nov 2026, before Pienissimo Live 24-26/11** | **5-7 gg** |
| R1 | Info Point app integration + advanced ticket handling | 15/01/2027 | 15-20 gg |
| R2 | Note di credito, incassi errati, scadenziario changes, insoluti Ri.Ba. | 12/02/2027 | 10-13 gg |
| R3 | Multi-edition and multi-day events (Mastery) | 26/02/2027 | 8-10 gg |
| R4 | Ordini Pienissimo Pro: Salesforce → Zoho (Pienissimo Software SRL) | 12/03/2027 | 3-5 gg |
| R5 | GLS → Salesforce, Teachable → Salesforce, Performance Plus expiry alerts, transactional comms | 26/03/2027 | 5-7 gg |
| Trasversale | UAT, bug fixing, deploy and training, per release | — | 7-9 gg |

🔑 **Fase 1 dates, now stated in a client-facing document for the first time**:
**go-live tecnico 09/11**, **data migration 12-13/11**, **operational start on
Salesforce 16/11**. Confirms
[OI-268](items/OI-268%20The%20client%20proposed%20a%20go-live%20calendar%20of%2016%20November.md)
and the 9 November technical release.

🆕🔑 **A new deadline nobody in these records had: _"Approvazione Fase 2 entro il
13/11"_** — the client must approve Fase 2 **by 13 November**, the same day as the
data handover.

🆕 **The event calendar is on the timeline**: **Pienissimo Live 24-26/11**,
**Academy 19-21/01**, **Camerieri e Venditori 06/04**.

🟢 **Every release includes one month of post-go-live support at no extra charge**,
stated as the offer's value-add.

## The day count contradicts itself

🔴 **The offer deck says `150 giornate`. The project plan totals `58 - 78`.** Both
were touched on 2 November, both are client-facing, and nothing in either
reconciles the two. ⚠ **No reading is offered here**: the figures are quoted as
they stand.

The offer deck also carries a per-release and total commercial value
(**€35,000 + IVA**, three instalments 40% / 30% / 30%, delivery in five months).
The project plan says explicitly _"la quotazione economica seguirà in separata
sede"_ — so the plan was written before the pricing existed and has not caught up.

⚠ **The plan's own ordering is inconsistent**: the estimate table puts R2 in
`feb - mar` and R3 in `gen - feb`, while the timeline's go-live markers run
R2 12/02 → R3 26/02; R5 is dated `gen - feb` in the table against a 26/03 go-live.

## What it folds in from the open items

🔑 **Items ROMI had ruled on internally are now written into a client document.**

- **R0 is [OI-304](items/OI-304%20Contracts%20for%20WooCommerce%20stage%20sales%20are%20not%20generated.md)**,
  priced and dated. ⚠ It covers **both** standard courses and Performance Plus,
  whereas on the 2 November call Fabrizio Paganelli agreed to the extra days
  _"solo per la parte della Plus corsi"_.
- **R1 carries [OI-269](items/OI-269%20Event%20communications%20must%20be%20differentiated%20by%20ticket%20type.md)** —
  _"Comunicazioni mirate … Messaggi differenziati per tipo di biglietto, ad esempio
  Gold ed Executive"_. ROMI blocked it internally on 27 October and
  🔴 **the client was never told; this deck is the telling, if it is sent.**
- **R1 carries the edition-move work** — _"Spostamento biglietti tra edizioni … Es.
  FMF 2026 → FMF 2027, oggi gestito a mano"_, the territory of
  [OI-291](items/OI-291%20Changing%20an%20edizione%20date%20does%20not%20update%20its%20product%20mappings.md).
- **R2 carries the Ri.Ba. work.** 🔴 **[OI-212](items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
  is an unfixed defect in production, and the Ri.Ba. territory is now dated
  12 February 2027 in a paid phase.** ⚠ R2's wording covers _insoluti_ and
  _variazioni di scadenziario_, which is adjacent to but not the same as OI-212's
  fault; **nothing says the defect itself is in or out.**
- **R5 carries [OI-272](items/OI-272%20A%20standard%20contract%20expiry%20alert%20rule%20is%20requested.md)**,
  now specified for the first time: notify the tutor and the referring salesperson
  **15-30 days before expiry**.
- 🆕 **A scope boundary on transactional comms**: automatic messages on opportunity
  creation and a **5-day quote-validity reminder**, _"configurazione a cura di
  Pienissimo, con affiancamento ROMI"_ — **the client configures, ROMI assists.**

## 🔴 There is still no maintenance line

**Neither document prices ongoing maintenance.** The offer's only recurring
commitment is _"un mese di supporto post go-live"_ per release; the plan's only
recurring line is per-release UAT and training.

This matters because on the **same day**, on a call with the client, **Elena Spini
said maintenance is in the proposal** (_"C'è anche la parte di maintenance nella
proposta"_) and **Aurel Mrruku described it as eight hours a month**. He had
written **three to four days a month** on 30 October. See
[OI-308](items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md).

## Relationship to the earlier estimate

[The Fase 2 estimate](The%20Fase%202%20estimate.md) of 27 October is the internal
working figure these decks descend from. The packages are recognisable but the
numbers moved, and the earlier estimate's **10 days for edition moves** — the line
Aurel Mrruku recorded dissent on, wanting 15-20 — now appears as **R3 at 8-10**.
⚠ **Nothing records that reduction being discussed with him.**

## 2026-11-03 - R0 now has its own document, and the day count is still unreconciled

🟢🔑 **R0 is specified separately and does not wait on this offer.**
[The stage-sale contract functional analysis](The%20stage%20sale%20contract%20functional%20analysis.md)
went to the client at **18:00:14Z** and asks, as **OP-3**, for **written confirmation
of the R0 classification by 5 November** — explicitly noting that _"La proposta di Fase
2 era attesa entro il 13/11"_. 🔑 **So the 13 November approval deadline this note
records is not a gate on R0**; development begins the week of 9 November on the
standalone confirmation.

🆕 **R0's dates are now fixed and sit outside the Fase 1 go-live**: development week of
**09/11**, joint tests week of **16/11**, **release 18 or 19 November**, final check
**23/11**, Pienissimo Live **24-26/11**. _"Lo sviluppo non entra nel go-live del 16/11:
Aurel non vuole rischiare la parte già in produzione."_

🆕 **A recap meeting**: **Thursday 5 November 12:00-12:30**, covering the Fase 2 contents
_"compreso questo primo rilascio"_.

### 🔴 The 150 vs 58-78 discrepancy is known to ROMI and unresolved

🔑 **It is not an oversight.** In
[the internal follow-up](meetings/2026-11-03%20Follow-up%20Interno.md):

> **Aurel Mrruku:** _"Sai cosa faranno qua? Metteranno una media o il 58?"_
> **Elena Spini:** _"in realtà mi sa che poi lui ha detto la media … lo scopriremo."_

Aurel Mrruku's verdict: _"è un bagno di sangue."_ ⚠ **So both figures stand, nobody has
reconciled them, and ROMI expects to be told which applies** rather than deciding.

🆕🔑 **The governance route was set the same morning.** On
[the e2e call](meetings/2026-11-03%20Test%20e2e%20PROD.md), Elena Spini reported that
**Andrea Galotto** — ROMI, sales side, who interfaces with **Daniela** — told her to do a
pass with whoever runs the project before a direct call with Daniela. Fabrizio Paganelli
agreed: _"Facciamo un passaggio prima io e te, dai, prima di coinvolgere loro due."_

- **Step 1**: Elena Spini and Fabrizio Paganelli review the activity list, which Elena
  Spini says **is already defined** — _"la lista dell'attività ed è già definita, però poi
  c'è il preventivo"_.
- **Step 2**: **Andrea Galotto and Daniela** take the quote and the numbers.

⚠ **Daniela appears to be Pienissimo-side** — Fabrizio Paganelli asked _"Andrea, chi è
Andrea? Andrea vostro"_ about Andrea Galotto, and undertook to brief Daniela himself.
**Inferred, not established.**

### 🔴 The maintenance line is unchanged

⚠ **Nothing on 3 November added one, mentioned one, or revisited the figure.** The
offer's only recurring commitment is still one month of post-go-live support per
release, and the client has still heard _"quei 8 ore al mese"_ against the three to four
days a month in
[the estimate](items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md).
**Ten days to the 13 November approval deadline.**

### ⚠ R0's price is understated against its own scope

🔴 **6-7 days, _"diciamo 7 giorni alla fine"_**, against 5-7 in this offer — and the
analysis omits the DocuSign return-trigger rewiring, the second PDF template and the
bundle classification, all of which Aurel Mrruku named as required. Aurel Mrruku:
_"Ho la paura che abbiamo messo davvero poche giornate."_ Elena Spini: _"non posso
chiedere più i giorni."_ 🔴 **And he has no one to share it with** —
_"il lavoro lo devo fare io"_.

## 🔴 2026-11-05 - a V.2 exists, it renumbers the releases, and it disagrees with itself

**`Pienissimo Offerta Fase 2_V.2`, Drive `1_ilgbQZf_2TXHrJ2DNiRQdgc9ZY4FtQAq7tDqLvZ6j0`,
created by Elena Spini at 11:52Z on 5 November and last modified 11:57Z — five
minutes before the 12:00-12:30 recap call. V1 was itself touched at 11:51Z.**

The release plan recorded above is **no longer stable**: the detail slides and the
timeline now put the **scadenziario, note di credito, incassi errati and insoluti**
work in **R1**, and Info Point / annullamento in **R2**, while the deck's own summary
band still carries the old order. One slide dates that R1 _"dicembre 2026"_. The two
superseded slides survive in the file, retitled `RILASCIO X`. Full detail and the
four conflicting dates are in
[OI-342](items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md).

🟢 **Unchanged in V.2**: six releases, `150 giornate`, Fase 2 complete 26/03/2027,
R0 contratti da palco in November _"In produzione prima di Pienissimo Live
(24-26/11)"_, the analysis and Business Blueprint in December 2026, one month of free
post-go-live support per release, €35,000 + IVA total, three instalments
40% / 30% / 30%, five months from start. R0 now carries its own per-release line.

🔴 **Still no maintenance line** ([OI-308](items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md)),
and 🔴 **the `150` against the project plan's `58 - 78` is still unreconciled** —
eight days before the 13 November approval deadline this note records.

🆕 **The Fase 2 governance now has meetings.** Elena Spini held the recap call on
5 November (_"ho appena fatto la call con loro per la fase 2 🤢"_, 13:05 CET) and the
same evening sent invitations for Monday 9 November: an **internal** `[PIENISSIMO] -
INTERNA Review temi Fase 2` at **10:00-10:30** and `[ROMI-PIENISSIMO] - Review temi
Fase 2` with the client at **10:30-11:30** (Gmail `1a1acbb192f4f8ba`,
`1a1acbab3267bdb0`). ⚠ Both sit immediately before the 11:30-13:00 tutor training on
the technical go-live day, and Fabrizio Paganelli is recorded absent on the 9th.

🆕 **A deploy on the 18th is waiting on the client's word.** Aurel Mrruku to Elena
Spini, 18:02 CET: _"t ah risposto per il deploy del 18? che era sulla fase 2"_ → _"ha
detto che domani mattina manda l OK e se ha problemi dubbi ci scrive / chiama"_. ⚠
**Which release that is, and whether it is the R0 release of 18-19 November already
recorded below, is not stated.** The OK is promised for the morning of 6 November.


## 🔑 2026-11-09 - the offer is now seven releases to 12 April 2027, with maintenance

**`Pienissimo Offerta Fase 2_V.4`, created by Andrea Galotto at 20:34:39Z on
9 November and last modified 21:43:06Z**, is the current offer. It supersedes V1,
V.2 and the `.pptx` V.3. Read from Drive on 2026-11-09; **no euro figures are
transcribed here**, per the standing rule.

The client saw this plan on
[the 09/11 review](meetings/2026-11-09%20Review%20temi%20Fase%202.md) and accepted
it. ⚠ **He has not been sent the deck** — Elena Spini owed a final check with
Andrea Galotto first, after which _"Andrea manda \[a\] Daniela"_.

### The seven releases

| Release | Content | Go-live |
| --- | --- | --- |
| Analisi | Workshop, solution design, Business Blueprint; requirements for R1-R6 _"a partire dallo scadenziario"_ | **nov - dic 2026** |
| **R0** | Contratti post-vendita da palco | **Nov 2026**, _"in produzione prima di Pienissimo Live (24-26/11)"_ |
| **R1** | **Aggiornamento scadenziario** — nightly Mexal rate check, and 🔑 _"Rata non più pagata: **l'asset torna da Disponibile a Ordinato**"_ | **14/12/2026** |
| **R2** | Annullamento e cambio nome biglietti; annullo before send; spostamento tra edizioni; **import contatti provvisorio** | **14/01/2027**, _"prima dell'Academy (19/01/2027)"_ |
| **R3** | **Info Point** ⇆ Salesforce: check-in, contatti non iscritti, biglietti orfani, multiple endpoints both ways, post-event anomaly report | **15/02/2027** |
| **R4** | Eventi multi-edizione e multi-giorno, reference case **Mastery**; check-in per day | **08/03/2027** |
| **R5** | Pienissimo Pro → Zoho; GLS → Salesforce; Teachable → Salesforce; Performance Plus expiry alerts; email and WhatsApp transactional; per-ticket-type communications | **22/03/2027** |
| **R6** | Note di credito: button on the order, partial storni on multi-event bundles, manual asset annullo, tranche rectification, Mexal alignment | **12/04/2027** |

🔑 **`150 giornate`, `7 rilasci in produzione`, `12 aprile 2027` for the complete
Fase 2 go-live** — the day count unchanged from the six-release version.

### 🟢🔑 Maintenance exists now

A dedicated slide, **`Maintenance di rilascio`**, _"COPERTURA **10 giornate, da R0
a R6**"_: post-go-live optimisation of fields, layouts, automations and
communications; monitoring of what is already in production at each release;
integration monitoring for **Mexal, Info Point, Zoho, GLS and Teachable**; and
adaptation to Salesforce releases. _"La maintenance di rilascio è rendicontata a
ogni SAL; le attività oltre le 10 giornate sono quotate a parte."_

The separate value-add is unchanged: **one free month of post-go-live support after
the last release**. → [OI-308](items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md)

### Caveats the deck states about itself

> _"Rilasci incrementali: ogni release va in produzione dopo i propri UAT. **Date
> indicative, da consolidare nella Business Blueprint; l'ordine dei rilasci può
> seguire le priorità di Pienissimo.**"_

⚠ So every date above is explicitly provisional, which is how the scadenziario
came to be moved to the front in the first place.

### The project plan has not followed

🔴 **`Pienissimo_Project_Plan_Fase2`, modified 09/11 14:15:44Z, still carries six
releases ending 26/03** and a different meaning for each release number, plus **two
estimate slides that disagree with each other**. Its new estimate slide does carry
the maintenance row — _"2 giorni al mese (fino ad aprile)"_, `10` gg — and raises
the per-release transversal line from `7 - 9` to `9 - 11` gg, giving `60 - 80 + 10`.
→ [OI-342](items/OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md)

🔑 **The plan still carries the Fase 1 dates and the approval deadline**: go-live
tecnico **09/11** — today — migration **12-13/11**, operational start **16/11**,
and **_"Approvazione Fase 2 entro il 13/11"_**.

### 🔑 Two things the roadmap implies that no item covers yet

1. 🔑 **Zoho is in Fase 2 as a live destination.** R5 sends Pienissimo Pro orders
   from Salesforce **to Zoho (Pienissimo Software SRL)**, go-live 22/03/2027.
   ⚠ **The Zoho CRM contract expired on 31 October** and no source has mentioned it
   for a seventeenth sweep; this deck commits to integrating with it sixteen months
   later. **Which Zoho tenancy is meant — the expired CRM or Pienissimo Software's
   own — is not stated.**
2. ⚠ **R4's multi-entry tracking may be dropped.** Fabrizio Paganelli on the call:
   _"c'è caso che sia anche un elemento che viene soppresso, perché se la direzione
   dice 'No, no, a me non me ne frega niente del multiingresso'"_; Elena Spini
   agreed it can be removed. **It is priced inside R4 regardless.**
