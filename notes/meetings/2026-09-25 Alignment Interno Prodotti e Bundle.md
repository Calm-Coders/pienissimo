---
id: meeting-2026-09-25-alignment-prodotti-bundle
type: meeting
status: active
owner: Rexhina Hysi
org: ROMI
raised: 2026-09-25
updated: 2026-09-25
source: Drive, Appunti di Gemini + Trascrizione, 2026-09-25 15:31 CEST (doc 1DisqUxshAuQWViGEbKzQPtBJvPU_UrM8IzInN3kLDdg, read in full)
---

# 2026-09-25 Alignment Interno Prodotti e Bundle

**A ten-minute internal working call, two hours after
[the second UAT session](2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md), to turn
its rulings into field changes.** 25/09, 15:31 CEST, **10m57s**. Invited:
Rexhina Hysi (organiser), Aurel Mrruku, Anita Aga (ROMI only). Arranged in the dev
group DM at 15:19 CEST — Aurel Mrruku: _"bejm nje call ?"_ — and recorded twice
(two `Registrazione` files).

⚠ **This note leans on the Gemini summary, not the transcript.** The call was held
in Albanian and the automatic transcript is largely unusable — it mixes Albanian,
Italian, Russian and Thai fragments and drops most words. Field names below are the
ones **Gemini's own summary states**, plus the handful legible verbatim in the
transcript. **Treat any field not named here as unrecorded, not as absent.**

## Product and bundle field cleanup

Aurel Mrruku walked the product and bundle field list and said which to drop and
which to keep (`00:00:06`). Named for **removal**: `product family`,
`bundle selling price`, `product price`. Named as **kept**: `is active`.
Anita Aga confirmed the mandatory fields as they went.

Legible in the transcript but **not** corroborated by the summary, so uncertain:
`parent` / `cod parent` not needed, a "solo bundle" field and a "plus" field to be
dropped, `product description` retained, and `product name` required.

🟢 Two of the morning's rulings were restated here and match the record:

- the bundle year is the **anno accademico**, not the anno solare — the reversal in
  [OI-46](../items/OI-46%20Bundle%20classification%20picklists.md);
- `Evento` needs a different name — the rename to **`Evento di origine`** recorded
  at [the UAT session](2026-09-25%20UAT%20Recall%20Tutor%20e%20Bundle.md).

## Bundle prices and discounts are awkward to configure

Aurel Mrruku and Rexhina Hysi went through `Configura Bundle` (`00:03:04`,
`00:06:03`). Two problems, both stated by Gemini and visible in the transcript:

- 🔴 **The price set on the bundle does not match the price computed from its
  lines.** Aurel Mrruku: _"çmimi vendos në Nuk është i njëjtë me çmimin që
  kalkulohet nga vendosja e bandla"_ — the price you set is not the same as the one
  the bundle calculates. Rexhina Hysi's reading: you then have to add enough
  products to make the total reach that price.
- **Discounts have to be set line by line.** Rexhina Hysi wanted either a single
  discount and price applied to every line at once, or the field made mandatory per
  line; setting them one at a time is _"e bezdishme"_ — tedious — and the screen
  moves back and forth.

This is the operator-facing face of the same constraint the client saw in the
morning: `Configura Bundle` **blocks saving when the lines do not add up to the
bundle price**, recorded in
[OI-181](../items/OI-181%20Stage-sale%20bundles%20need%20their%20tranches%20defined%20at%20bundle%20creation.md).
⚠ Nothing here decides whether the block stays, loosens, or gains a bulk-edit path.

## QR code at ticket creation - assigned to Rexhina Hysi

Aurel Mrruku asked Rexhina Hysi to make the **QR code generate when the Biglietto
is created**, and to attach it — as a standard document or as an image — to the
record (`00:06:03`). Rexhina Hysi accepted both: _"kur të krijohet bileta do
bëhet"_, and said she would look at how to see it as a photo. Gemini records them
as her two action items:

1. **Generate the QR code** at ticket creation.
2. **Link the QR code** to the corresponding standard document.

🟢 **This is the first owner and commitment the QR generation has had.** The
mechanism itself was settled at
[Temi QR Code Biglietti](2026-09-22%20Temi%20QR%20Code%20Biglietti.md) on 22/09.

## Left for the next call

Aurel Mrruku closed by saying they would go through what remained, **including the
`Biglietti luxury` section** (_"do shohim pjesën Bilete luxo"_). ⚠ No date was set
and the transcript ends there.

## Cost

The Gemini notes and transcript together: one Drive document, read in full.
