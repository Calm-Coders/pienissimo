---
id: OI-260
type: open-item
status: resolved
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-19
updated: 2026-10-21
blocks: [go-live]
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-260 - Generating the quote PDF failed with an internal server error

**The quote PDF would not generate during the walkthrough. `Genera PDF` returned
_"si è verificato un errore di server interno"_ in front of four client people,
on the first day of the key-user test week, and the error mail went only to a
developer who was not in the call.**

## What happened

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`01:16:19`, after the quote lines and both tranches were in place, Elena Spini
described the expected behaviour — _"genera PDF e questo ci porterà in automatico
lo stat[o] in trattativa"_ — and Marco Montesi pressed it:

> **Elena Spini:** _"Genera PDF. A posto. S[i] è verificato un errore di server
> interno."_

She screenshotted it and then said what she could not do about it:

> _"purtroppo arrivano tutte le mail ad Aurel, quindi io non non posso neanche
> vedere cosa è successo."_

🔴 **So the only diagnostic — the Apex exception mail — is addressed to one
person, and that person was not in the session.** She messaged him live and got
no reply: _"gliel'ho chiesto e vediamo, però non mi sta rispondendo."_

## What is known and what is guessed

- 🟢 **It worked earlier the same day.** Elena Spini: _"prima l'ho fatto e
  funzionava"_ — so this is not a permanently broken path.
- ⚠ **Two explanations were offered in the room and neither was tested.** Elena
  Spini: _"possibile anche che ci stanno lavorando i ragazzi"_ (a deploy in
  flight) and _"magari semplicemente sono stati configurati male quei quei
  prodotti"_ (bad test articles — see
  [OI-261](OI-261%20Test%20article%20codes%20pollute%20the%20product%20registry.md)).
  Fabrizio Paganelli endorsed the second: _"i prodotti sono … da rivedere."_
- 🔑 **A deploy in flight is a real possibility and is checkable.** Four pull
  requests merged into `DevMain` at **12:34–12:52 CEST on 19/10** (`#101`–`#104`),
  and **`#102` changed `QuotePdf.page` and `QuotePdfController.cls`** among the
  quote surfaces. The session started at 15:01 CEST. **Whether the UAT org was
  mid-deploy, or carried that change at all, is not established here** — this
  sweep did not open the org — but it is the first thing to check, and
  `QuotePdfController` is the class the failing button runs.
- 🔴 **The quote stayed behind.** The automatic move to `In trattativa` depends on
  the PDF, so the test quote never advanced and the rest of the demonstration had
  to be done on a pre-existing record.

## Open

- 🔴 **Nobody has read the exception.** It exists, it is in one inbox, and no
  source records it being opened.
- 🔴 **Not reproduced, not scoped.** Whether it affects every quote or only ones
  carrying the bad test articles is unknown — which is the difference between a
  blocking defect and a data-cleanup side effect.
- ⚠ **It is the second client-facing failure in four days**, after
  [OI-254](OI-254%20Creating%20a%20Referente%20and%20an%20Account%20failed%20for%20the%20client.md)
  on 16/10, and both were watched by the people who are meant to sign off the
  system.

## What closing it looks like

The exception is read, the cause named, the fix deployed, and one clean
end-to-end quote-to-PDF run recorded in UAT — before Fabrizio Paganelli's team
reaches the quote step in their own tests.


## 2026-10-21 — resolved: it was user permissions

🟢 **Cause found and fixed, confirmed by the client that it works.** At
[the 10:01 session](../meetings/2026-10-21%20Check%20Dati%20Migrazione%20e%20OP.md)
(`01:25:17`) Aurel Mrruku explained it:

> _"erano dei permessi, ma l'abbiamo aggiustato in teoria … stavamo facendo i
> permessi per le vostre utenze, mancavano dei campi sui permessi, per quello
> andava in errori."_

Fabrizio Paganelli confirmed it started working the same evening as the 19/10
failure: _"infatti ho visto che dopo la sera mi funzionava, quindi immaginavo che
ci stavate lavorando sopra."_

So the suspicion recorded on 19/10 — that `#102`'s 12:35 redeploy of
`QuotePdfController` had broken it — is **wrong**. The redeploy was concurrent
with field-level permission work on the client users, and the missing field
permissions were the cause. ⚠ **The exception text was never read**; the diagnosis
is Aurel Mrruku's account, not a log.

⚠ **Nobody told the client it was fixed**, which is why he re-raised it. Elena
Spini: _"Mi sono dimenticata di avvisarti alla fine, Fabrizio, ti volevo scrivere
che riprova e poi alla fine mi sono persa."_ The same gap as the 19/10 finding
that the error mails all reach Aurel Mrruku and the client cannot see them.
