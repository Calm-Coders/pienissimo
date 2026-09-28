---
id: ref-integrazioni-workbook
type: reference
status: active
owner: Andrea Di Cicco
org: ROMI
raised: 2026-08-24
updated: 2026-08-24
source: Drive - "Integrazioni pienissimo.xlsx", file 1JKOIOS8dwiyBOVATsX7J0uufuLyjr-ij, created 2026-08-24 14:41 UTC
depends_on: [OI-58]
---

# The Mexal integration mapping workbook

**`Integrazioni pienissimo.xlsx`** — the field-level mapping between the Mexal
WEBAPI and Salesforce. Created by **Andrea Di Cicco** on 2026-08-24 at 14:41 UTC
and placed in the Drive folder `[Pienissimo] Fase Progettuale`. Presented at
[the Follow-up Interno the same afternoon](meetings/2026-08-24%20Follow-up%20Interno.md).

This is the first artifact that states the integration at field level. Until now
[OI-58](items/OI-58%20Mexal%20integration%20mechanics.md) rested on meeting
narration.

## 🔴 Do not copy values out of this file

⚠ **It contains real customer records** — a live company name, street address,
town, province, VAT number, personal email address and telephone number are used
as the worked example on the Clienti sheet. Per
[docs/publishing.md](../docs/publishing.md), record that the file exists and what
it covers; **never copy the values** into `notes/`, the recaps, `STATUS.md` or
[site/](../site/).

This is the **third** artifact with the same problem — the master design diagram
and `anar_PIE_ricla.xlsx` carry real customer data too.

## What it covers

An entity list, each row giving the Mexal manual page reference, the HTTP method
and the sync cadence:

| Entity | Method | Cadence as noted |
| ------ | ------ | ---------------- |
| Clienti | POST | records changed in the last 24h |
| Agenti | POST | once a day |
| Condizioni pagamento | GET | once a day |
| Destinazioni / indirizzi spedizione | GET | marked _da verificare_ |
| Fatture (Documenti) | GET | — |
| Prodotti (Articoli) | GET | — |
| Ordini clienti | GET | — |
| Scoperto cliente (**Scadenziario**) | GET | — |
| Cliente | POST | pushed when the Account is created in Salesforce |
| Ordine | POST | with a button to re-send to the gestionale |

Below the entity list, a per-field mapping for the customer payload: the Mexal
field name, an example value, the corresponding field in the current interchange
files, and a Salesforce-side column specification with type, mandatory flag and
comments.

The **Scadenziario appears here as a GET endpoint**, which is what makes the
20 August proposal in
[OI-92](items/OI-92%20Mexal%20Scadenziario%20as%20the%20trigger%20to%20reverse%20an%20asset.md)
technically reachable rather than hypothetical.

## What it does not settle

- **The invoice-to-order-line link.** Andrea Di Cicco took the action to study
  the detail call that would confirm payment status; instalment invoices against
  order lines were named as the hard part and are unresolved.
- **Agent vs supplier filtering** on the read calls — the group has to ask
  Fabrizio Paganelli which field distinguishes them.
- It is a **ROMI-authored working document**, not a client-agreed contract, and
  not a Kreosoft-supplied specification. Mirko Merendi's outstanding technical
  mail to Fabrizio Paganelli is still separate and still unanswered.

## Related and still owed

The **Mexal WEBAPI credentials** have been promised by mail since July and have
still not arrived; this workbook does not contain them, and they must never enter
the repository if they do.
