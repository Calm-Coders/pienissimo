---
id: OI-48
type: open-item
status: open
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-07-23
updated: 2026-09-02
blocks: [OI-13]
source: meetings/open-items.md row 48
---

# OI-48 - Bundle-only article codes

Fabrizio Paganelli is to create roughly **ten new bundle-only article codes** —
one per event, using a "(B)" naming convention — flagged "use only in bundles"
via [the product flags](OI-47%20Product%20flags%20at%20import.md).

He is to send **3–5 examples to ROMI before September** so Aurel Mrruku can
build the bundle-selection logic. **Placeholder or fake samples are explicitly
acceptable** to start, because the real codes cannot yet be hidden on the
website and would risk misuse.

Committed "for tomorrow" on 23 July. Re-requested on 2026-08-06.

## ✅ 2026-08-24 - answered, but not with what was asked for

[`Prodotti e Bundle.xlsx`](../The%20Prodotti%20e%20Bundle%20workbook.md) was
read on 2026-08-24. Its `Esempio di Bundle` sheet delivers **one worked bundle**
— `PACK-93`, _ACADEMY 2026 - UN ANNO CON PIENISSIMO (NUOVI)_ — which is the
"esempio Bundle" the mail subject promised.

**It is not the deliverable this item describes.** The ask was ~10 **new**
bundle-only article codes on a **"(B)" naming convention**, 3–5 of them sent
before September. What arrived is:

- **No `(B)` codes.** The convention appears nowhere in the workbook.
- **No new codes at all.** Every code in the example is an existing article from
  `Lista Prodotti`, or a `BLO-`/`PACK-` code from the legacy Mexal structure.
- **One example, not 3–5** — though it is a complete one, which the ask did not
  guarantee.

What it does deliver instead is
[the real shape of a bundle](../objects/A%20bundle%20is%20two%20levels%20deep.md):
`PACK-93` → five `BLO-` blocchi → the articles inside each, with quantities.
That is arguably more useful to
[the bundle-selection logic](OI-13%20Bundle%20effort%20estimate%20and%20client%20demo.md)
than five invented codes would have been, and it settles
[the code namespace](../objects/The%20article%20code%20namespace.md).

⚠ **The `(B)` convention may be obsolete rather than forgotten.** Its purpose
was to mark codes tutors cannot sell directly. `Product2.Solo_Bundle__c` — the
[flag from OI-47](OI-47%20Product%20flags%20at%20import.md) — already does that
job in a field, which is the better mechanism and the one the project chose. If
so this item should be **retargeted, not chased**: ask Fabrizio to set the flag
on the right articles rather than to mint new codes.

**Kept open** pending that confirmation. Do not re-request the `(B)` codes from
the client before asking whether they are still wanted.

## How it arrived

✅ **A delivery on 2026-08-07 is now confirmed — its contents are not.** Fabrizio
Paganelli wrote to a thread titled **"Lista Eventi, Codici prodotto, esempio
Bundle"** at 12:17 CEST that day and Elena Spini thanked him 21 minutes later.
His message was unretrievable for eleven days — only an empty quoted stub
survived inside her reply.

**Elena forwarded it on 2026-08-18 at 09:41 CEST**, on Aurel Mrruku's
2026-08-14 request. The message has **no body text and a single attachment,
`Prodotti e Bundle.xlsx`** — see
[the workbook](../The%20Prodotti%20e%20Bundle%20workbook.md).

⚠ **Still open. Nobody has opened the file.** Whether it carries the "(B)"
bundle-only codes, or the 3–5 examples Aurel needs to build the
bundle-selection logic, is **unverified**: the subject says "Codici prodotto"
and "esempio Bundle", the filename says "Prodotti e Bundle". No connected tool
can read a Gmail attachment and the file is in neither Drive nor Slack — **a
human must download it.** Do not re-request from the client in the meantime.
Same thread covers [OI-46](OI-46%20Bundle%20classification%20picklists.md). It sits with
[the events list](OI-46%20Bundle%20classification%20picklists.md) and
[the prices](OI-87%20Real%20catalogue%20prices%20still%20outstanding.md) in the same
queue, owed by the same person, all three feeding
[the bundle demo](OI-13%20Bundle%20effort%20estimate%20and%20client%20demo.md) that
still has to be shown to Pienissimo.

## 🔴 2026-08-26 - the twin codes are needed after all

The note above parks this item on the theory that the `(B)` convention is
**obsolete rather than forgotten**, because `Product2.Solo_Bundle__c` does the
same job in a field. The
[26 August Mexal review](../meetings/2026-08-26%20Review%20Temi%20Integrazione%20Mexal.md)
reverses that reading.

Aurel Mrruku, unambiguously:

> _"se vuoi due prodotti come abbiamo fatto per fare i test, uno per generare il
> biglietto e l'altro per non generare il biglietto, devi per forza avere due
> prodotti, non lo puoi fare un unico prodotto."_

Fabrizio Paganelli accepted and named the convention himself: _"se un codice
articolo è visibile, se non è il bundle, avrà il codice A. L'altro codice che è
visibile a tutor avrà il codice B."_ **Two codes per article, not one code with a
flag.** The flag survives as the marker that tells Salesforce which is which.

So the item is **not retargeted** — the twin codes are wanted. What has changed is
that they will be minted as part of
[the full registry re-creation](OI-98%20The%20Mexal%20article%20registry%20is%20being%20re-created.md)
rather than as ten additions to the existing one, and the `(B)` string itself was
never mentioned. **Ask for the convention when the new registry arrives; do not
chase `(B)` specifically.**

Fabrizio Paganelli will **configure two such articles as a test next week**, which
is the 3–5 examples this item asked for, arriving by a different route.

## 🟢 2026-09-01 - the examples were sent, and this sweep cannot read them

**Fabrizio Paganelli mailed `Anagrafica Articoli.xlsx` on 1 September at 14:04Z**
to Elena Spini, Aurel Mrruku and Andrea Di Cicco, ahead of the 2 September
session. His own description of the attachment, in full:

> _"per l'incontro di domani vi invio un estratto di anagrafica articoli con solo
> i corsi — ho aggiunto anche **una ipotesi di nuovi codici da gestire solo nei
> bundle** — poi ho un paio di domande da valutare anche in base ad un vostro
> parere."_

**"Una ipotesi di nuovi codici da gestire solo nei bundle" is this item.** It is
the first client-side material on bundle-only codes since the 26 August session,
and it arrived as a proposal to react to rather than as a fait accompli — which
is what _"anche in base ad un vostro parere"_ invites.

🔴 **The workbook has not been read.** This sweep cannot open a Gmail attachment.
The mail body is the whole of what the record holds, so **nothing below the body
is known**: not how many codes, not the naming convention, not whether it matches
the `A`/`B` twin scheme Fabrizio Paganelli named himself on 26 August, and not
what his _"paio di domande"_ are.

This is the **third time** the same gap has cost this project a day — the
WooCommerce payload on 27 August, `Documentazione API - Salesforce.pdf` on
31 August, and now this. Both previous ones were closed by Aurel Mrruku
downloading the file by hand, and both turned out to carry findings no inference
had produced.

⚠ **It is needed before the 2 September meeting, not after it.** The questions in
it are addressed to ROMI and the meeting is the forum for answering them; walking
in having not opened the attachment wastes the session Fabrizio Paganelli
prepared it for. **This is the cheapest outstanding ask in the record.**

## 2026-09-02 - the codes arrived, and the convention is a third one

`Anagrafica Articoli.xlsx` was read on 2026-09-02 -
[the decode](../The%20Anagrafica%20Articoli%20workbook.md). **This item's
deliverable is in it.**

**Ten bundle-only codes**, one per event except Food Marketing Festival which
gets three (one per tier): `SFAC0001`, `SFCV0001`, `SFFM0001`, `SFFM0002`,
`SFFM0003`, `SFHT0001`, `SFMS0001`, `SFOD0001`, `SFPL0001`, `SFSO0001`. All ten
are flagged `Utilizzabile solo in bundle`, which is `Product2.Solo_Bundle__c`.

Ten codes is the number this item asked for, and they arrived four days after
Fabrizio Paganelli's "next week" commitment of 26 August.

The mechanism is exactly what was agreed on 26 August - a twin article per
sellable ticket, the flag distinguishing them.

The naming is neither convention that was agreed. Not the `(B)` suffix of
23 July, not the `codice A` / `codice B` Fabrizio Paganelli named himself on
26 August. It is `SF` + two letters for the event + four digits. **Do not search
the registry for a `B` code** - it does not exist. The `SF` prefix is evidently
"Salesforce", and it is the right instinct: these codes are not in Mexal and
cannot be, which is the whole point of them.

**They are unpriced.** All ten have an empty `Prezzo Listino`, against 33 priced
non-bundle rows. Whether a bundle-only article is meant to carry no price at all,
or a price that was simply not filled in, decides how
[the bundle spread](OI-43%20Spread%20variance%20does%20not%20block%20saving.md)
computes, and it is **not stated anywhere**. Ask before loading.

`SFPL0001` is named `PIENISSIMO LIVE LIVE` - a probable typo, and the name is
seller-facing.

Pienissimo Intensive has **no bundle twin** despite carrying 8 articles, the
largest event block in the sheet. Either it is excluded from bundles on purpose
or the list is incomplete. Unasked.

**This item is not closed by the delivery**, because those three questions
remain and all three are cheap: the price rule, the `LIVE LIVE` name, and
whether Intensive is deliberately out. One mail to Fabrizio Paganelli covers all
three.

## 2026-09-02 - the ten codes are in the org

Loaded into Pienissimo UAT the same day they were read, as `RecordType = Item`
with `Solo_Bundle__c` and `Genera_Biglietto__c` both true, and
`Tipo_Biglietto__c` set on the four that carry a tier. `Code__c` and
`ProductCode` both hold the `SF` code. Verified by query after insert; all ten
present.

**This closes the delivery half of the item.** What keeps it open is unchanged
and is entirely questions for Fabrizio Paganelli: the ten are **unpriced** with
no stated rule, `SFPL0001` is named `PIENISSIMO LIVE LIVE`, and **Pienissimo
Intensive has no bundle twin**. None of the three blocked the load; all three
should be asked before anyone sells against these codes.

Build detail in
[the workbook note](../The%20Anagrafica%20Articoli%20workbook.md).

## 2026-09-02 — the pricing question is answered, and the author is corrected

**The ten bundle-only codes are priced normally.** Elisa Migliano asked whether
to put zero on them — _"prezzo di listino sui ci metto zero, dico bene?"_ — and
Aurel Mrruku answered against it at the
[2 September session](../meetings/2026-09-02%20Follow-up%20Anagrafica%20Articoli.md):

> _"volendo tu puoi mettere un prezzo di listino, ma quando lo agganci a quel
> bundle che stai formando, hai il diritto di specificare qual è il prezzo di
> quel prodotto in quel bundle… così sai anche il prezzo originale."_

She accepted. So the workbook's blank price column is **not** the specification:
each of the ten carries its real list price, and the bundle-specific value is set
on the association. That is the same mechanism
[OI-93](OI-93%20Bundle%20components%20should%20be%20priced%20articles.md) asks for,
which makes the two consistent for the first time.

🟢 **This closes the first of the three cheap questions this note left open for
Fabrizio Paganelli.** The other two — `SFPL0001` named `PIENISSIMO LIVE LIVE`,
and Pienissimo Intensive having no bundle twin — **were not raised**, because the
workbook was decoded after the meeting.

⚠ **Authorship correction.** The mail came from `fabrizio.p@pienissimo.com` and
the record has read the workbook as Fabrizio Paganelli's. On the recording
**Elisa Migliano says she made it**: _"ieri vi ho mandato quel file"_, _"questo
qui è un file che ho fatto io a mano, ci ho aggiunto anche i campi che avevamo
definito insieme l'altro giorno."_ They were sitting in the same room and share
the mailbox in practice; the correction is about who to ask, not about who owns
the registry. **Ask Elisa Migliano about the file's contents.**
