---
id: obj-product-evento
type: object
status: active
owner: Anita Aga
org: ROMI
raised: 2026-10-12
updated: 2026-10-12
depends_on: [OI-47, OI-76]
source: git 7f8ead3, branch DenAnita12, 2026-10-12T17:53:19+02:00
---

# The Evento field on the product

**`Product2.Evento__c`, label "Evento di origine": a restricted picklist of the
ten Pienissimo events, dependent on `Anno_Solare__c`. It is the first field that
takes the event out of the article-code string and puts it somewhere an admin
maintains — and it is on a developer branch, not in `DevMain`.**

## What is built

| Property | Value |
| -------- | ----- |
| API name | `Evento__c` |
| Label | `Evento di origine` |
| Type | Picklist, **restricted** |
| Controlling field | `Anno_Solare__c` |
| Required | no |
| History tracking | off |

**Eleven active values** — the ten events plus `ND` — each available under
`Anno Solare 2026`, `2027` and `2028`. **Two values are deactivated**:
`Camerieri` and `Odb Live`.

## 🔑 Why it matters

[The article code namespace](The%20article%20code%20namespace.md) ends on exactly
this point: _"stop reading meaning out of a code or a name, put it in a field an
admin maintains"_, and records that the client had **not** added such fields, so
_"the fields exist on the Salesforce side and there is nothing upstream to
populate them from"_. That is the gap
[OI-47](../items/OI-47%20Product%20flags%20at%20import.md) and
[OI-76](../items/OI-76%20Ticket%20type%20picklist%20on%20the%20product.md) exist
for.

🔑 **Its eleven values are the client's own event table**, which arrived the same
morning in
[the Regole Codifica Codici Articolo workbook](../The%20Regole%20Codifica%20Codici%20Articolo%20workbook.md)
— ten events with two-letter code prefixes. The two deactivated values are the
two spellings that workbook does **not** use in its code rows. ⚠ Somebody
reconciled the picklist against that list; **no commit message, note or message
says so**, and the inference is recorded as an inference.

## 🔴 Two things it is not

1. **Not in `DevMain`.** `7f8ead3` is on `DenAnita12`
   (`git merge-base --is-ancestor 7f8ead3 DevMain` → false at `a061f55`). The
   commit message is _"Edits done while testing the fluxs"_ and the field arrives
   alongside LWC and flexipage changes. Nothing has been opened to merge it.
2. **Not populated.** A restricted picklist with no upstream source is a field
   an admin fills by hand. The Mexal article sync writes `Product2` nightly and
   nothing in this sweep shows it writing this field. ⚠ Whether the sync should
   derive it from the code's first two characters is **the decision OI-47 and
   OI-76 were raised to force, and it has not been taken.**

⚠ `Anno_Solare__c` as the controlling field means the dependency is
year-of-event, so the same event in two years is two picklist entries to
maintain. Recorded as a shape, not as an objection.
