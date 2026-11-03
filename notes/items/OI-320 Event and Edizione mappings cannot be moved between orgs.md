---
id: OI-320
type: open-item
status: open
owner: Fabrizio Paganelli
with: Aurel Mrruku
org: both
raised: 2026-11-03
updated: 2026-11-03
depends_on: [OI-315]
blocks: [go-live]
source: notes/meetings/2026-11-03 Test e2e PROD.md
---

# OI-320 - Event and Edizione mappings cannot be moved between orgs

**Every event, edition and edition-product mapping the client built in UAT has to be
rebuilt by hand in production. The reason is that Evento and Edizione carry no
external id, so there is nothing to join the two orgs on. The client had been told
this work would not be repeated.**

## What happened

Sending the test quote for acceptance in
[the 3 November e2e session](../meetings/2026-11-03%20Test%20e2e%20PROD.md) failed
with **_"mappatura mancante"_**. 🟢 Aurel Mrruku: _"meno male che l'abbiamo messo il
blocco"_ — **the guard works and stopped a quote without a mapping.**

Fabrizio Paganelli asked to carry over the mappings he had already built:

> _"questa qui non si può copiare dall'ambiente di test, vero? Perché la mappatura
> l'avevamo già fatta nell'ambiente di test … gli eventi, le edizioni e tutta la
> mappatura."_

🔑 **Aurel Mrruku refused, on a stated technical ground:**

> _"non lo puoi fare perché tu devi creare gli eventi in produzione. Gli eventi in
> produzione hanno un ID diverso degli eventi [di UAT], anche le edizioni, quindi non
> li puoi importare."_

> _"**Se avessi un ID esterno l'avrei fatto in 10 minuti, ma non ce l'ho un ID
> esterno.**"_

Not even an Excel round-trip works, for the same reason: _"tu devi avere per forza un
ID esterno, un ID di collegamento e io non ce l'ho perché non è che li ho importati da
un altro sistema per usare gli ID per collegarsi."_

## 🔴 The client's reaction

> _"Però è un lavoro cinese. **Io l'avevo detto che era una cosa che non dovevamo
> rifare.**"_

> _"adesso doverli rifare è una rottura di coglioni, scusate il termine"_ ·
> _"Mi ven da piangere"_ · _"Mi segno a rifare tutta la mappatura."_

🔑 **Twice, half in jest, he said he would invoice ROMI for the extra hours** — _"dopo
tanto qualche ora in più ce la dovrete fatturare"_, and when Aurel Mrruku deflected to
amministrazione, _"lo faccio a ROMI Company"_. ⚠ **Treated here as friction, not as a
commercial claim**, but it is the second time in a week the client has reacted to
unplanned manual work.

🔑 **He named the expensive part, and it is not the mapping**: _"La mappatura è la
meno. La p\*\*\*\*\*\*\* è creare tutte le edizioni da data quella roba lì. Poi ti
sbagli una data, la mappatura non funziona."_

## The agreed order of work

1. **The product registry is corrected first** — Aurel Mrruku: _"lo facciamo dopo che
   è messa a posto i prodotti"_. See
   [OI-327](OI-327%20The%20blow%20product%20codes%20carry%20the%20wrong%20gruppo%20merceologico.md).
2. **The production test records are deleted** — the client will not start until they
   are. See [OI-315](OI-315%20Production%20test%20records%20cannot%20be%20deleted.md).
3. **Fabrizio Paganelli rebuilds events, editions and mappings by hand.** Gemini's
   next-steps list it as _"Rifare mappatura edizioni"_.

⚠ **No date and no volume.** Nobody said how many events and editions this is, and
that is the whole cost.

## The underlying gap worth fixing

🔑 **Evento and Edizione have no external id.** That is why nothing can be migrated,
and it will recur at every future release and for any reload. ⚠ **Nobody undertook to
add one**, and no register row covers it.

## Related

- [OI-96](OI-96%20Edition%20mapping%20table%20on%20Salesforce.md) — the mapping table itself
- [OI-310](OI-310%20The%20production%20load%20needs%20a%20pre-load%20and%20a%20delta%20run.md)
