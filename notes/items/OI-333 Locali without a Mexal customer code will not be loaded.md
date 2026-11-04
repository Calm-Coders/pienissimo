---
id: OI-333
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-04
updated: 2026-11-04
depends_on: [OI-310]
blocks: [go-live]
source: notes/meetings/2026-11-04 Continuazione Test e2e PROD.md
---

# OI-333 - Locali without a Mexal customer code will not be loaded

**A Locale is a child Account and its parent is resolved by the parent's Mexal
customer code. The client's Locali list — delivered 4 November and described by him
as provisional — has many rows with no Mexal code, which cannot be attached to a
parent. Aurel Mrruku argued against loading them; the client agreed within twenty
minutes to load only the coded rows.**

## The rule

Aurel Mrruku, in
[the 04/11 session](../meetings/2026-11-04%20Continuazione%20Test%20e2e%20PROD.md):

> _"i locali devono avere il riferimento dell'account, quindi il codice Mexal
> dell'account."_
>
> _"se un locale non ha un'azienda, per me non è collegato a un parent, quindi
> non verrà mai usato, perché quando fai le offerte lo devi per forza collegare a
> un'azienda quell'offerta."_

So an uncoded Locale is not merely incomplete — it is unreachable, because quotes
are created only on companies: _"i preventivi si devono creare solo sulle
aziende."_

Fabrizio Paganelli saw the cost immediately: _"questa la vedo più dura. Comunque
ci proviamo."_

## 🟢 The decision, settled by mail the same hour

| Time (UTC) | Who                | What                                                                                                                              |
| ---------- | ------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| 15:50      | Fabrizio Paganelli | `Lista Locali` + `Locali Salesforce.xlsx`: _"Anche questa è provvisoria. Inoltre ci sono molti locali senza codice cliente mexal. Li potete caricare ugualmente?"_ |
| 16:03      | Aurel Mrruku       | _"Secondo me è meglio di non caricare i locali che non hanno un'azienda per non rischiare di avere record zombi in produzione."_   |
| 16:21      | Fabrizio Paganelli | **_"Caricate allora solo quelli che hanno codice mexal."_**                                                                       |

🔑 **The reason given is production hygiene** — "record zombi" — not effort, and the
client accepted it without argument.

## Where it stands

🟢 **Decided.** 🔴 **Open on three counts:**

1. 🔴 **Nobody knows how many rows are excluded.** The workbook was **not opened** —
   it carries real customer records — so the count of uncoded Locali is unknown to
   this record. ⚠ The client's own words were _"molti"_.
2. 🔴 **There is no path back for the excluded rows.** No one said who re-codes
   them, when, or whether they are re-delivered in the 12-13 November delta
   ([OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)).
   A venue that exists in the client's business and not in Salesforce is a venue a
   tutor cannot quote against.
3. ⚠ **The file is provisional and is the only Locali source.** A second version is
   implied by _"provvisoria"_ and has no date.

## What was verified working

In the same session Fabrizio Paganelli created a Locale in production end to end
and the dependent behaviour held:

- 🟢 Locale created as a child Account with city, name and **`Tipologia Attività`
  multi-select** — _"Tipologia attività molto importante perché puoi scegliere più
  di uno."_
- 🟢 The Locale and its activity type are **carried onto the quote automatically**
  when the Locale is chosen — _"lo prendi in automatico la tipologia perché avevi
  scelto il locale."_
- 🟢 **Both creation paths end in the same place** — from the parent company or from
  the Locale itself: _"è la stessa cosa, solo che sono due punti diversi di
  creazione delle opportunità."_ The opportunity links to the parent either way.
- 🆕 Aurel Mrruku offered a quick action to create a Locale from the parent Account
  — recorded in [OI-330](OI-330%20The%20product%20selection%20screen%20is%20unusable%20for%20multiple%20products.md).

**Closing it:** the coded Locali in production, attached to their parents, and a
recorded answer for the uncoded ones.
