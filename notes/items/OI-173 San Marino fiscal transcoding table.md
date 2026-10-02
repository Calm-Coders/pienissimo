---
id: OI-173
type: open-item
status: resolved
owner: Elena Spini
with: Mirko Merendi
org: both
raised: 2026-09-23
updated: 2026-10-02
depends_on: [OI-97, OI-159]
blocks: [go-live]
source: notes/meetings/2026-09-23 Check Data Import.md
---

# OI-173 - San Marino fiscal transcoding table

**Raised by Fabrizio Paganelli at
[Check Data Import](../meetings/2026-09-23%20Check%20Data%20Import.md) (`00:37:39`),
scheduled by Aurel Mrruku at `00:41:10`.**

## What is needed

Both the customer anagrafica and the order carry fields that follow from **fiscal
residence** under San Marino law:

- activation of **fatturazione elettronica**,
- the **sezionale IVA** to use,
- the flag for **including the PDF attachment** on the invoice.

🔴 **Anticipay does not derive any of this.** The P.IVA lookup returns the registry data;
it does not say which fiscal treatment follows. So a **transcoding table** —
fiscal residence → the three settings — has to exist somewhere and be agreed with
Kreosoft.

## Why this is not [OI-97](OI-97%20Fiscal%20residence%20on%20the%20customer%20registry.md)

🟢 **`OI-97` is resolved and stays resolved.** It settles **how the fiscal-residence
value is obtained** — Salesforce derives Mexal's five-way `residenza fiscale` from the
country code, agreed 02/09.

🔴 **This row is what follows from that value.** Knowing a customer is Italian rather
than Sammarinese does not by itself say to switch on electronic invoicing, which VAT
sezionale to use, or whether to attach the PDF. That mapping is new, is client-side
accounting policy, and nothing in the record carries it.

## Why it is the same question Mirko Merendi asked by mail

This is the fourth bullet of Mirko Merendi's customer-field list of **22/09 15:54:41Z**
([OI-159](OI-159%20Mexal%20order%20fields%20Salesforce%20does%20not%20populate.md)):
_"Se il cliente è italiano: attivazione fatturazione elettronica, sezionale IVA 3 e
inclusione allegato PDF «FT»"_. Fabrizio Paganelli's reply of **23/09 12:16:50Z** answers
every other line and leaves this one open on purpose:

> _"di questo punto ne parliamo domani insieme (ho già anticipato la cosa nel corso della
> call di oggi)"_

🟢 **The two threads are the same item, and both point at the same meeting.**

## Where it is due

**Thu 24/09 10:00–11:00 CEST, `[ROMI-PIENISSIMO] - Temi Mexal Anagrafiche/Indirizzi`** —
Elena Spini, Aurel Mrruku, Mirko Merendi, Fabrizio Paganelli, `amministrazione@`.
Invitation sent 23/09 08:44:28Z. This slot **replaced** the orders/migration session that
was postponed in the Check Data Import call.

## Open

- 🔴 **Agree the table and where it lives** — Salesforce field, Mexal procedure, or a
  lookup on the account.
- ⚠ The **Italian** case (`sezionale IVA 3`) and the **San Marino** case are different
  branches of the same rule; only the Italian one has a stated value so far.
- ⚠ No register row covers fiscal treatment. **Allocating a requirement id is a human's
  call.**

## 🟢 2026-09-24 — RESOLVED at the 10:00 call, and the table arrived the same morning

[Temi Mexal Anagrafiche/Indirizzi](../meetings/2026-09-24%20Temi%20Mexal%20Anagrafiche%20Indirizzi.md),
22m45s, with Mirko Merendi and Fabrizio Paganelli. **Both questions this note left open
are answered.**

### Agree the table and where it lives — answered

It lives in **Salesforce**, as a table the administration maintains. The user sets one
value on the customer master and **a trigger populates the rest**; the same values go to
Mexal on order creation. Aurel Mrruku proposed it, Mirko Merendi and Fabrizio Paganelli
both accepted it in the call.

🔑 **The key is `residenza fiscale`, derived from the customer's two-letter ISO country
code on the `ragione sociale` — not the billing address.** Fabrizio Paganelli was explicit:
_"se il cliente è estero ma c'ha un punto vendita in Italia vale il cliente estero."_

### The Italian and San Marino branches — answered

| `residenza fiscale` | Treatment                                                                                                                                                               |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `I` — Italy         | the three e-invoicing fields are filled                                                                                                                                 |
| `S` — San Marino    | **the same treatment, in future** — Mirko Merendi: _"fra poco entrerà in vigore anche la fatturazione elettronica sanmarinese interna"_. Few San Marino customers today |
| foreign / extra-EU  | left blank in the table; Salesforce treats anything absent as foreign, with its own code                                                                                |

The three Mexal customer fields, filled **only for Italian customers** (API names from
Mirko Merendi's 08:46:51Z mail):

- `gest_fatt_el` — activate electronic invoicing
- `serie_fatt_el` — VAT sectional, value **3**
- `cod_modu_allega` — PDF-in-XML attachment module, value **`FT`**

### Delivered

**`Nazioni e Residenza Fiscale.xlsx`**, attached by Fabrizio Paganelli to the
`Ordine cliente` thread at **24/09 10:08:51Z**: the country list with the four linked
fields; countries not present carry a row with no code.

## Carried forward, not blocking this row

- ⚠ **Two-character versus three-character ISO.** Mexal uses two-letter ISO; Aurel
  Mrruku's country data comes from Google Maps as a three-letter code. A conversion is
  owed, and he named **Kosovo** as a code some lists omit. Both sides agreed the residue
  is marginal and gets fixed by hand.
- 🟢 The `.xlsx` was opened on 2026-10-02 and implemented — see below.

## 2026-10-02 - the table is built and live in UAT

The file holds 29 rows: `IT` → residence `I`, e-invoicing `S` (Fattura B2B), sectional 3,
attachment `FT`; the 26 other EU countries → `C` (Estero CEE); `SM` → `R` (Repubblica San
Marino); and an **Altri Paesi** row → `E` (Estero Extra CEE). Every non-Italian row is
e-invoicing `N`, sectional 1, attachment `FT`.

🔴 **The code it replaces disagreed with it.** `MexalCustomerCreateService` derived the
values from `BillingCountry` in hard-coded Apex and **omitted** `gest_fatt_el`,
`serie_fatt_el` and `cod_modu_allega` for every non-Italian customer, where the table sends
`N` / `1` / `FT`. It also returned `V` for the Vatican, which the table does not have
(the Vatican now falls to `E`).

Built as agreed on 24/09, deployed to Pienissimo UAT (`0AfMA00000Cq7zN0AR`):

- **Custom Metadata `Residenza_Fiscale__mdt`**, 29 records from the file, editable by the
  administration in Setup. Matched on the two-letter ISO code, the three-letter one (from
  the file's _Elenco Paesi_ sheet) or the Mexal country name; any other country takes the
  `Predefinito` row; a blank country gets nothing.
- `FiscalResidenceResolver` reads it; `MexalCustomerCreateService` now sends
  `tp_nazionalita`, `gest_fatt_el`, `serie_fatt_el` and `cod_modu_allega` from the row.
- **`Account.Residenza_Fiscale__c`**, read-only, set by `AccountTrigger` before insert and
  update from `BillingCountry`; on the Azienda record page and the Account layout.
- 🟢 **Existing UAT accounts back-filled** the same day by anonymous Apex in five batches
  (Mexal customer sync bypassed, duplicate rules allowed), **8,144 updated, 0 errors**.
  Result: `I` 7,956 · `C` 100 · `E` 50 · `R` 38 · blank 51 (no billing country). Every
  account with a country now carries a value.
- 🔴→🟢 **English country names broke it, found in UAT the same day.** Aurel Mrruku's
  test account (Milan) got `E` because Salesforce's standard address search writes the
  country as **`Italy`**, not `IT` — every hand-entered account would hit it. Fixed
  (`0AfMA00000Cq9pt0AB`): a **`Nomi_Alternativi__c`** column on the table carries English
  names and variants (comma-separated, administration-editable), and the Mexal customer
  payload now sends **`cod_paese` as the row's two-letter code** — before, it sent the
  raw `BillingCountry`, so `Italy` would have reached Mexal verbatim. Unlisted countries
  still send the raw value. In UAT only that one account was misclassified.
- ⚠ A country change alone does **not** re-send an existing customer to Mexal: the
  update trigger watches only email, phone, P.IVA and name.
