---
id: OI-46
type: open-item
status: open
owner: Fabrizio Paganelli
with: ROMI
org: both
raised: 2026-07-23
updated: 2026-08-25
source: meetings/open-items.md row 46
---

# OI-46 - Bundle classification picklists

**anno solare** (master) → **evento** (dependent picklist, showing only that
year's events) + **tipologia di bundle** (independent of both — "Anno con
Pienissimo", "…Ripetente", other).

The event seed is **7 canonical events**: Tour, Food Marketing Festival,
Pienissimo Live, Academy, Sold Out, O.D.B. Live, Camerieri Venditori, Mastery —
Happy Team sells nothing.

⚠ **Use "anno solare", never "anno accademico".** The academic year (May →
September) is a distinct Pienissimo concept used for ticket generation. Keeping
them separate is deliberate.

Values are re-created clean from Fabrizio Paganelli's lists, **not** migrated
from `LIVELLO_3`/`LIVELLO_4`.

**Fields built, data absent.** `Anno_Solare__c`, `Evento__c` and
`Bundle_Type__c` all exist on `Product2` and are **populated on zero bundles**.

## ✅ 2026-08-24 - the event list arrived, and it is not the list we built

[`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md) was
read on 2026-08-24, seventeen days after Fabrizio Paganelli sent it. Its
`Lista Eventi` sheet is the definitive list, and it **contradicts the seed above
in three ways**.

### It is eleven events, in four types

The sheet carries a second column, `tipologia evento`, that nobody requested and
that the register has no field for:

| Type                              | Events                                                                  |
| --------------------------------- | ----------------------------------------------------------------------- |
| `Evento a pagamento`              | Academy, Camerieri Venditori, Happy Team, Mastery, Odb, Pienissimo Live |
| `Evento a pagamento/gratuito`     | Food Marketing Festival — attendable **both** ways                      |
| `Evento gratuito`                 | Sold Out, Tour                                                          |
| `Evento annullato`                | Golden Numbers                                                          |
| `Evento in fase di ridefinizione` | Pienissimo Intensive                                                    |

**Golden Numbers and Pienissimo Intensive appear nowhere else in this project's
record.** Neither has any article in `Lista Prodotti`, consistent with being
cancelled and under redefinition. Whether either belongs in the picklist is a
decision nobody has taken.

### 🔴 "Happy Team sells nothing" is wrong, and the built picklist is wrong because of it

The seed above excludes Happy Team on the strength of the 2026-07-23 transcript,
where the line is _"c'è Happy Team, ma durante l'Happy Team non vendiamo
niente"_ — **"we don't sell anything _during_ Happy Team"**, a statement about
selling _at_ the event. It was read as "Happy Team has nothing to sell".

The registry says otherwise: **`CS-00154 HAPPY TEAM` is a priced article**, with
a complimentary twin, and it is a **component of the Academy bundle at quantity
2**. Happy Team tickets are sold, bundled, and must generate assets.

`Product2.Evento__c` in `force-app` is a restricted picklist and **has no
`Happy Team` value**. A Happy Team article therefore cannot be classified at
all, and the asset it generates has no event. **This is a build defect, not a
paperwork gap.**

### Two more built values do not match the client's names

| Client's name                       | Built value |                                               |
| ----------------------------------- | ----------- | --------------------------------------------- |
| `Camerieri Venditori`               | `Camerieri` | truncated                                     |
| `Odb` (articles read `O.D.B. LIVE`) | `Odb Live`  | inconsistent with both                        |
| —                                   | `ND`        | invented; no counterpart in the client's list |

Since values are _"re-created clean from Fabrizio Paganelli's lists"_, the
client's spelling governs. Align the picklist to `Lista Eventi`.

### ⚠ The anno solare dependency has no source

`Evento__c` is already built as a dependent picklist controlled by
`Anno_Solare__c`, with a specific matrix — Food Marketing Festival on 2026 and
2028, Mastery on 2026 and 2027, Pienissimo Live on 2026 only, and so on.

**The workbook contains no year column of any kind.** The only year anywhere in
it is the literal `2026` inside the six Tour article names. So that matrix has
**no client source — it is ROMI guesswork**, and it is the controlling half of
the mechanism this item specifies. Ask Fabrizio which events run in which
calendar years, and do not treat the current mapping as agreed.

### Where this leaves the item

**Still open**, but for the opposite reason to before: the input is no longer
missing, the configuration is now known to be wrong. Fix the picklist, get the
year matrix, and decide on the two unknown events. `Anno_Solare__c`, `Evento__c`
and `Bundle_Type__c` all exist on `Product2` and are still **populated on zero
bundles**.

## How it arrived

✅ **Something was delivered on 2026-08-07 — and on 2026-08-18 we learned what.**
Fabrizio Paganelli wrote to a thread titled **"Lista Eventi, Codici prodotto,
esempio Bundle"** at 12:17 CEST that day; Elena Spini thanked him 21 minutes
later and added Aurel to the thread. His message could not be retrieved for
eleven days — it survived only as an empty quoted stub — so the record could not
say whether the event list had arrived.

Aurel Mrruku asked Elena to forward it on 2026-08-14. **She forwarded it on
2026-08-18 at 09:41 CEST.** Fabrizio's message carries **no body text and one
attachment, `Prodotti e Bundle.xlsx`** — see
[the workbook](../The%20Prodotti%20e%20Bundle%20workbook.md). The empty stub is
explained: the content was always the attachment.

⚠ **Do not close this item yet. Nobody has opened the file.** Whether it
contains the definitive 7-event list is **unverified** — the mail subject says
"Lista Eventi", the filename says "Prodotti e Bundle". No connected tool can
read a Gmail attachment, and the file is in neither Drive nor Slack. **It needs
a human to download it.** Until then this stays `in-progress`: the delivery is
confirmed, its sufficiency is not. Do not re-request the list from the client.

Re-requested at the 2026-08-06 session alongside
[prices](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) and
[bundle-only codes](OI-48%20Bundle-only%20article%20codes.md) — one day before
that thread.

## 🔴 2026-08-24 - the client says the edition is not on the product at all

The [20 August asset session](../meetings/2026-08-20%20Flusso%20Asset%20Biglietti.md) supplied the client source this item has never
had — and it **contradicts the built design** rather than filling it in.

Fabrizio Paganelli, minuted to the client:

- **Mexal article codes are transversal across years.** There is no code per
  edition.
- Classification is three levels — **Evento** (macro name) → **Tipo Biglietto**
  (from the article code) → **Edizione**, and the edition is **determined by the
  order date, not by the product**.

The built `Product2.Anno_Solare__c` picklist, and the `Anno_Solare__c` →
`Evento__c` dependency matrix, both assume the year is an attribute _of the
product_. On the client's account it is an attribute _of the order_. That is not
a missing-values problem; it is the wrong mechanism.

**What the design uses instead** is the active child campaign, resolved at order
time — see
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md).
That is what makes the year unnecessary on the product.

Two further complications from the same week:

- The period is an **event edition, not necessarily a calendar year**. Elisa
  Migliano's [19 August](../meetings/2026-08-19%20Flussi%20MKT%20Biglietti.md) example was the academic year **2026-2027**, which
  a calendar-year picklist cannot express.
- Rebecca Marmo described the current Zoho hierarchy as **Evento → Edizione
  Evento (anno) → Evento Biglietto (tipologia) → Evento Biglietto Prodotto** —
  four levels, against the two the Salesforce build has.

**Do not add values to `Anno_Solare__c`.** The question is now whether the field
should exist. This needs Aurel Mrruku's ruling before any further work on the
picklists, and it is the single most consequential thing this sweep found.

## 2026-08-25 - org check: the fields exist and are populated on one product

Verified read-only against **Pienissimo UAT**. Both disputed fields are
configured, and both are effectively empty.

| Field                     | Configured values                                                                                             | Populated on |
| ------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------ |
| `Product2.Anno_Solare__c` | `Anno Solare 2026 · 2027 · 2028`                                                                              | **1 of 280** |
| `Product2.Evento__c`      | `Tour · Food Marketing Festival · Pienissimo Live · Academy · Sold Out · Odb Live · Camerieri · Mastery · ND` | **1 of 280** |

🔴 **`Happy Team` is confirmed absent from `Evento__c`** — the client's own
workbook prices it and places it in the Academy bundle at quantity 2. The gap
this item records against the client's list is real and measured, not inferred.

**The population figures change what the fix costs.** One product out of 280
carries either value, so correcting or removing the fields breaks essentially no
data. The decision that
[OI-46](OI-46%20Bundle%20classification%20picklists.md) actually turns on —
whether `Anno_Solare__c` should exist at all, given that the client states
article codes are transversal across years and the edition comes from the order
date — can be taken **without a migration**. If the edition moves to
[the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md),
dropping the field costs one record.

The register's `build_state` describes these as "populated on zero bundles". One
product now carries them; the substance of that line is unchanged.
