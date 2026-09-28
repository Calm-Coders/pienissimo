---
id: meeting-2026-09-24-temi-mexal-anagrafiche-indirizzi
type: meeting
status: active
owner: Aurel Mrruku
with: Mirko Merendi
org: both
raised: 2026-09-24
updated: 2026-09-24
source: Drive, Appunti di Gemini + Trascrizione, 2026-09-24 10:01 CEST
---

# 2026-09-24 Temi Mexal Anagrafiche Indirizzi

**22m45s, 24/09 10:01 CEST.** Aurel Mrruku, Fabrizio Paganelli, Mirko Merendi (Kreosoft);
Elisa Migliano present. Elena Spini absent, announced the day before. Notes and full
transcript read (22,253 characters).

The shortest session of the project and one of the most productive: it **settled the
fiscal transcoding table, named the Mexal API fields, and produced two attachments the
same morning.**

## The fiscal rule, settled

Three Mexal customer fields must be filled **only for Italian customers**; for everyone
else they stay empty. Mirko Merendi at `00:05:19` named them verbally and sent the exact
API names by mail at 08:46:51Z:

| Purpose                          | Mexal API field   | Value    |
| -------------------------------- | ----------------- | -------- |
| Activate electronic invoicing    | `gest_fatt_el`    | set      |
| VAT sectional (`sezionale IVA`)  | `serie_fatt_el`   | **3**    |
| PDF attachment module in the XML | `cod_modu_allega` | **`FT`** |

- **San Marino will need the same treatment** once internal San Marino e-invoicing comes
  into force — Mirko Merendi: _"fra poco entrerà in vigore anche la fatturazione
  elettronica sanmarinese interna"_ — but Pienissimo has few San Marino customers today.
- **`residenza fiscale`** is the key: `I` for Italy, `S` for San Marino, a further code
  for foreign, and Mirko Merendi's instruction for the rest: _"lasciali vuoti tutto
  quello che non fa parte dell'Unione Europea"_.
- 🔑 **The rule keys on the customer master (`ragione sociale`), not the billing
  address.** Aurel Mrruku offered to derive it from the billing address and Fabrizio
  Paganelli refused: _"se il cliente è estero ma c'ha un punto vendita in Italia vale il
  cliente estero."_

### How it is built

Fabrizio Paganelli supplies a table maintained by the administration. Aurel Mrruku puts
it in Salesforce: the user sets **only the first column's value** on the account, and a
**trigger populates the remaining fields** from the matching row — the same set of values
then goes to Mexal on order creation. Agreed by all three.

⚠ **Two-character versus three-character ISO.** Mexal uses the two-letter ISO country
code; Aurel Mrruku's country data comes from **Google Maps** as a three-letter code with
the country name in capitals. A conversion is needed. He named **Kosovo** as a code some
ISO lists omit. Fabrizio Paganelli confirmed the residue is marginal and comes from
historic manual entry — once a province abbreviation was typed into the country field.
Both agreed such cases get fixed by hand.

## New scope: accounting competence dates

Fabrizio Paganelli asked for **`data inizio competenza contabile`** and **`data fine
competenza contabile`** on the order-line track to Mexal (`00:15:51`). This is the
`Gestione ratei di riga` line from
[OI-159](../items/OI-159%20Mexal%20order%20fields%20Salesforce%20does%20not%20populate.md),
and he explained why it exists: it served a **software platform product Pienissimo no
longer sells**, where an invoice was valid for a year and accruals were computed from
those dates. Selling only courses, the case does not arise.

> _"ad oggi possiamo lasciarlo non gestito"_ — but set it up now against future
> subscription-style products.

Mexal API names, from the 08:46:51Z mail: **`dt_inizio_rateo`**, **`dt_fine_rateo`**.
Aurel Mrruku asked for them specifically: _"non le ho mai viste queste due campi
sull'ordine."_ **Headroom, explicitly not build work for Fase 1.**

## Payment methods: 700 down to a handful

Aurel Mrruku asked for the payment-type values. Fabrizio Paganelli: Mexal accounting
holds about **700**, _"la stragrande maggioranza è tutta mondezza"_, and he would filter
to the ones actually used — _"così anziché dartene 150 te ne do cinque."_

🔴 **A standing synchronisation constraint was stated and not solved.** Aurel Mrruku,
`00:21:35`: if a payment type is added in Mexal it **must be added in Salesforce by hand
with the same nomenclature**. Mirko Merendi's reason: the values are the client's to
change, so no refresh procedure can own them. Nothing records who watches for drift.

## Who fills what, restated

Mirko Merendi confirmed which order fields Mexal computes for itself: the **causale**
from the customer type and whether products or services are sold; **contropartita di
riga** and the **agent commission** he calculates; **tipologia merce** comes from the
article master; **riferimento amministrazione PA** lives on the customer. Fabrizio
Paganelli took the opportunity to say he will audit the article master for gaps.

## Delivered the same day

Both attachments arrived by mail on the `Ordine cliente` thread at **10:08:51Z**, inside
two hours of the call:

- **`Nazioni e Residenza Fiscale.xlsx`** — the country list with the four linked fields;
  countries not present carry a row with no code.
- **`Codici Pagamento.xlsx`** — _"sono solo 4"_.

⚠ He said **five** in the call and sent **four**. Not reconciled.

Aurel Mrruku acknowledged Mirko Merendi's field list at 09:16:35Z: _"Presa visione"_.

→ [OI-173](../items/OI-173%20San%20Marino%20fiscal%20transcoding%20table.md) is resolved
by this session.
