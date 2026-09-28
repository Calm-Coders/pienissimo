---
id: MTG-2026-08-19
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-08-19
updated: 2026-08-24
source: Drive - "[ROMI-PIENISSIMO] - Flussi MKT Biglietti" Gemini notes and transcript, doc 1mvGlaupEkH3Va8BuWjmxrHp8u0gonl9-gMZIJsS9GkI
---

# 2026-08-19 Flussi MKT Biglietti

The **marketing session on the ticket funnel**, held 19 August 2026. Recovered
on 2026-08-24: until then the record said only that this meeting may have run
and left no minute of any kind. It ran, and it is fully minuted.

> **Provenance.** The canvas *Link utili Pienissimo* gained a `19.08.206` MKT
> entry between the 21 August sweep (which re-read the canvas link-for-link and
> found nothing) and 24 August. The entry links a Drive recording and a Gemini
> notes-plus-transcript document. Neither existed on any source when the 19, 20
> and 21 August sweeps ran.

⚠ These are **Gemini auto-notes**, not a human minute. Per `drill-meeting`,
speaker attribution in this project is chronically unreliable. Attribution below
is taken from the notes' own Dettagli section and is marked where it matters.

## Attendees

- **Pienissimo** — Marco Montesi, Matteo Distaso, Rebecca Marmo; Elisa Migliano
  joined later in the call.
- **ROMI** — Elena Spini, [Fabrizio Mastracci](../people/Fabrizio%20Mastracci%20-%20marketing%20automation%20ROMI.md).

## What was agreed

- **Asset creation rule** — a ticket asset is created when an **order** carrying
  an event-type product is generated, so that quoting does not spawn assets that
  later have to be deleted by hand. See
  [OI-53](../items/OI-53%20Asset%20generation%20rule.md), which records a wording
  conflict inside this same document.
- **Products are created on Mexal, bundles on Salesforce.** Anything with an
  economic value is created in Mexal and carried to Salesforce by batch; the
  bundle layer is Salesforce-only. See
  [OI-47](../items/OI-47%20Product%20flags%20at%20import.md).
- **Ticket availability follows the tranche, chronologically.** Where an order is
  paid in instalments the ticket becomes available only when its own tranche is
  paid, and an unpaid earlier tranche blocks the later events. See
  [OI-75](../items/OI-75%20Ticket%20availability%20rule.md).

Left explicitly **da approfondire**: how availability is corrected when an
instalment is booked against the wrong invoice — which is what
[OI-91](../items/OI-91%20Aggiornamento%20Incasso%20button.md) and
[OI-92](../items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
became.

## What it establishes for the build

- **The asset state set as the client narrates it**: `ordinato` (not yet paid) →
  `pagato` / disponibile → `assegnato` (QR sent) → `utilizzato` (scanned), plus
  `annullato` on a name-change request, and an automatism **three days after the
  event** moving unscanned tickets to `non utilizzato`.
- **`rinuncia` is described here as a funnel concept, not an asset state.** It is
  one of the marketing tags (`rinuncia`, `iscritto`, `presente`) and the effect of
  a decline link that removes the contact from later communications; Rebecca Marmo
  described it as applying to the whole participation, not to one ticket. This is
  evidence for [OI-74](../items/OI-74%20Asset%20state%20machine.md) but it does
  **not** rule on whether `Rinuncia` is a seventh Asset status — nobody put that
  question in those terms.
- **The `genera biglietto` flag creates a Campaign.** When a product arrives from
  Mexal with the flag set, a Salesforce automatism creates a campaign named after
  the product. Elena Spini is minuted clarifying that a Salesforce Campaign here
  is a **container for members**, not a marketing campaign. See
  [OI-77](../items/OI-77%20Mexal%20event%20product%20creates%20the%20Campaign.md).
- **Two marketing flows**, not one: a no-show reduction send at **30 or 60 days**
  before the event, and a second close to the event that collects the participant
  list. The 30-vs-60 figure is explicitly unresolved — an action asks Matteo
  Distaso to confirm which. See
  [OI-81](../items/OI-81%20Event%20communication%20funnel.md).
- **Email style is a constraint, not a preference.** Matteo Distaso specified
  plain text with no header, images or buttons, written so as to read as coming
  from Giuliano personally. This rules out the graphical newsletter template a
  Marketing Cloud build would default to.
- **Invoicing is tied to a ticket type and an event edition** over a period —
  Elisa Migliano's example was the academic year 2026-2027, which is not the
  calendar year the built `Anno_Solare__c` picklist assumes. See
  [OI-46](../items/OI-46%20Bundle%20classification%20picklists.md).

## Actions recorded, with owners

| Owner | Action | Date given |
| ----- | ------ | ---------- |
| Matteo Distaso | Enter the supplied DNS records in the control panel | by Friday (2026-08-21) |
| Matteo Distaso | Finish the forms | by Wednesday next week (2026-08-26) |
| Rebecca Marmo, Matteo Distaso | Send screenshots of the current funnel flows so they can be rebuilt | next day |
| Rebecca Marmo, Matteo Distaso | Send newsletter and header graphics for Marketing Cloud | — |
| Fabrizio Mastracci | Send a recap email with the timings discussed | — |
| Elena Spini | Send the updated asset schema by email | — |
| Elena Spini | Design the button logic for correcting mis-assigned instalments and circulate the proposal | — |
| Elisa Migliano, Fabrizio Mastracci | Agree the event-edition specification | by the next meeting |
| Elisa Migliano, Rebecca Marmo | Confirm with Matteo whether sends go at 30 or 60 days | — |
| Elisa Migliano, Rebecca Marmo | Prepare a structured walkthrough of the client-side flow | for the next day's meeting |

The last row is the **20 August session** —
[Flusso Asset/Biglietti](2026-08-20%20Flusso%20Asset%20Biglietti.md) — which is
why the two meetings must be read in order.

The DNS and forms actions are
[OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md); both dates have
now passed with no confirmation on any source that either was done.
