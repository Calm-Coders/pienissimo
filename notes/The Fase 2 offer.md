---
id: fase-2-offer
type: reference
status: active
owner: Andrea Galotto
with: Elena Spini
org: ROMI
raised: 2026-11-02
updated: 2026-11-02
depends_on: [OI-308]
source: Drive 1T1gExUUq4_fUkXjJY3b_fa66kPrHNmI6N_3wLXbldaY and 1b329SMXkcG3kivDfvoziCFuk2I19DlQQqS_UTQtKFeA
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
