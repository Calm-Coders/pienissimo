---
id: OI-48
type: open-item
status: open
owner: Fabrizio Paganelli
org: Pienissimo
raised: 2026-07-23
updated: 2026-08-26
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
