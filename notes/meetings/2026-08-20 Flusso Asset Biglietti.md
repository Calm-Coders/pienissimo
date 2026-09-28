---
id: MTG-2026-08-20
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-08-20
updated: 2026-08-24
source: Gmail - Elena Spini, "[ROMI-PIENISSIMO] Flusso Asset/Biglietti", sent 2026-08-20 18:08 CEST, forwarded to Aurel Mrruku 2026-08-24 16:38 UTC
---

# 2026-08-20 Flusso Asset Biglietti

The **asset session Elisa Migliano called** — the one Elena Spini flagged on
07 August with _"ci sono delle cose di cui non abbiamo mai parlato"_. Held
20 August 2026. Recovered on 2026-08-24.

> **This is a human minute, not an auto-summary.** Elena Spini wrote it and sent
> it **to the client** the same evening (20 Aug 18:08 CEST) — to Fabrizio
> Paganelli, amministrazione, Marco Montesi and Rebecca Marmo, cc Sabatino
> Rinaldi. It therefore carries more weight than a Gemini note: the client has
> had it for four days without contradicting it. It reached ROMI's technical lead
> only on 24 August, when Elena forwarded it.
>
> A recording and a Gemini transcript also exist, linked from the canvas under
> `20.08.206`. Two high-level flow diagrams were attached to the original mail as
> PNGs.

## Attendees

- **Pienissimo** — Fabrizio Paganelli, Elisa Migliano, Marco Montesi, Rebecca Marmo.
- **ROMI** — Elena Spini.

⚠ Aurel Mrruku was not in this meeting, and the technical decisions below were
taken without ROMI's technical lead present.

## 1. How events and tickets are actually classified

Rebecca Marmo set out the current Zoho structure: **Evento → Edizione Evento
(anno) → Evento Biglietto (tipologia: Gold / Executive / Diamond) → Evento
Biglietto Prodotto**.

Fabrizio Paganelli then gave the constraint that changes the build:

- **Mexal article codes are transversal across years.** There is no code per
  edition.
- Classification happens on three levels: **Evento** (macro name) → **Tipo
  Biglietto** (derived from the article code) → **Edizione**, and the edition is
  **determined by the order date, not by the product**.
- **Mexal supports at most three article classifications**, which is not enough
  for event, ticket type and variants such as omaggio or aggiuntivo.

This is the first client-side statement of where the edition/year comes from,
and it contradicts the built design. See
[OI-46](../items/OI-46%20Bundle%20classification%20picklists.md).

## 2. The Salesforce target: Campagna Padre, Campagna Figlio, Campaign Member

Elena Spini proposed and the meeting accepted a three-level campaign structure —
**Campagna Padre** (a grouping container for statistics) → **Campagna Figlio**
(the annual edition, e.g. _"Food Marketing Festival Aprile 2026"_, carrying
dates, venue and check-in) → **Campaign Member** (the participants, associated
automatically when the participant list is confirmed).

Agreed that campaigns are **created manually once a year**, roughly **10 a
year**, with cloning to speed it up; Fabrizio Paganelli confirmed the volume is
manageable by hand. Written up as
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md).

## 3. Ticket type and who owns the registry — decided

- Rebecca Marmo described the current burden: every product has to be tagged by
  hand (Gold, Gold omaggio, Gold aggiuntivo…) to feed marketing-automation
  segments.
- Fabrizio Paganelli proposed deriving all of it from the product master (event
  + ticket type) instead of repeated manual tagging.
- **Decision: the "tipo biglietto" field is added and maintained manually on the
  Salesforce side**, because Mexal cannot carry more than three classification
  dimensions. Keeping the registry current is **amministrazione's
  responsibility — Fabrizio Paganelli and Elisa Migliano** — with periodic
  verification reminders.
- For go-live, the **one-off mass update of existing products is done by the ROMI
  team**, so as not to load it onto Rebecca Marmo.

This is the ruling [OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md)
had been waiting for.

**Left open:** clarify the marketing segmentation logic (tags vs segments) with
Fabrizio Mastracci at ROMI, to establish whether the new product-master field
also covers the segmentation need.

## 4. Correcting a mis-booked payment

- The case: an instalment recorded against the wrong tranche of a bundle, which
  then needs the asset's state corrected in Salesforce.
- Elena Spini's proposal was the **button visible only while the asset is
  available** — [OI-91](../items/OI-91%20Aggiornamento%20Incasso%20button.md).
- Fabrizio Paganelli proposed a more automated alternative: compare the **Mexal
  scadenziario** day over day, detect the discrepancy and correct ticket
  availability automatically.
- **Decision: taken to Andrea Di Cicco** as ROMI's Salesforce/Mexal flow owner,
  with Fabrizio Paganelli to brief him in advance on the three-level hook —
  **ordine → fattura → scadenziario**. See
  [OI-92](../items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md).

## 5. Opportunity: "Da ricontattare"

Confirmed that the state is set **manually by the tutor** after an
appointment or demo, with a **mandatory reason**.

**Decision: marking "Da ricontattare" does not generate a task automatically.**
An informational **banner** is added instead, as a reminder so the follow-up is
not forgotten.

⚠ The 24 August internal session then specified a validation rule and a *task*
automation around the same state — see
[the Lead/Opty session](2026-08-24%20Interna%20per%20update%20flusso%20Lead-Opty.md)
and the reconciliation note in
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md).

## 6. Quote validity and the close

- Quote sent → opportunity to **In trattativa** → quote valid **5 days by
  default**, the date settable and modifiable by the tutor rather than fully
  automatic, so that "sotto evento" cases with compressed timing can be handled.
  **ROMI to assess technical feasibility.**
- **On day 2** after sending: automatic reminder task for the tutor **plus** an
  email to the client — copy and template **to be supplied by Marco Montesi and
  Elisa Migliano**.
- **At 5 days with no answer**: the quotation moves automatically to **"in attesa
  di accettazione"**, while the **opportunity stays in "trattativa"**, because
  there is no definitive outcome yet.
- **Two separate reason fields confirmed** — "motivazione da ricontattare"
  (opportunity phase) and "motivazione ricontatto preventivo" (trattativa phase)
  — kept apart **at Marco Montesi's request**, as different moments and causes.
- **Close confirmed**: quote accepted → order generated → opportunity to **chiusa
  vinta only when the order is incassato**.

That last line is independent confirmation of the `Incassato` rule the design
diagram carries, and bears on
[OI-69](../items/OI-69%20Order%20state%20model.md).

## Next steps as minuted

| Owner | Action |
| ----- | ------ |
| Elena Spini | Check with Andrea Di Cicco the technical feasibility of the incasso/asset correction automation (ordine → fattura → scadenziario) |
| Elena Spini | Decide whether quote validity stays fixed at 5 days or becomes editable in "sotto evento" periods |
| Fabrizio Paganelli | Answer Mirko Merendi's mail on integration technical details and prepare further questions, ideally before the 26/08 meeting |
| Marco Montesi, Elisa Migliano | Supply the copy for the automatic quote-reminder emails |
| Marco Montesi, Elisa Migliano | Finalise the split and content of the two "motivazione da ricontattare" fields |

The first of these was actioned four days later at
[the 24 August Follow-up Interno](2026-08-24%20Follow-up%20Interno.md).
