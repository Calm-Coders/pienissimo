---
id: OI-349
type: open-item
status: open
owner: Gianpaolo Motta
with: Elena Spini
org: ROMI
raised: 2026-11-09
updated: 2026-11-09
depends_on: []
blocks: []
severity: gating
source: notes/meetings/2026-11-09 INTERNA Review temi Fase 2.md
---

# OI-349 - Fase 2 has no developer committed for December

**The Fase 2 offer the client is to approve by 13 November puts its first paid
release in production on 14 December. On 9 November the only developer who has
ever worked on this build said plainly that he cannot do December, that he is
required on another large project, that the other three developers are committed
elsewhere, and that he is away from 17 to 22 December.**

## What was said

[The 09/11 internal review](../meetings/2026-11-09%20INTERNA%20Review%20temi%20Fase%202.md),
Aurel Mrruku to Elena Spini:

> _"**Ti dico già che non lo posso fare dicembre.**"_

> _"io devo iniziare per forza su **un altro progetto che è enorme**. … non ho le
> risorse a disposizione. **Re\[xhi\]na è iniziato con un altro progetto. Sara e
> Ana\[Anita\] devono fare vision** e io c'ho un sacco di progetti in parallelo.
> Quando dico un\[o\] sto parlando di una **decina**."_

> _"**Non facciamo la fase due, Elena, basta, consegniamo fase uno.** … Perché non
> si può lavorare in questo modo."_

And the availability, separately: _"molto probabilmente **dal 17 fino al 22 non ci
sarò**"_, plus January _"fino il 7 siamo in vacanza"_.

## What the plan assumes instead

| | |
| --- | --- |
| Offer R1 go-live | **14 December 2026** |
| Offer analysis window | **November - December 2026**, workshops for R1-R6 |
| Named developers | 🔴 **none, in either document** |
| Days for R1 | ⚠ the plan costs the scadenziario content at `10 - 13` gg in its R2 row; the offer prices R1 separately. **The two documents do not agree** — [OI-342](OI-342%20The%20Fase%202%20offer%20V2%20reorders%20the%20releases%20and%20contradicts%20itself.md) |

## Why it is gating

1. 🔴 **The commitment is about to be made to the client.** Approval is due
   **13 November**, four days after the capacity was denied internally, and the
   deck does not say who builds it.
2. 🔴 **The named alternative is slower, by the same person's account**: _"ci
   metterà di più un'altra persona."_ No alternative has been named at all.
3. 🔑 **The December release is the one the client pushed hardest for.** Fabrizio
   Paganelli forced the scadenziario forward — _"Ha detto che è assolut\[amente\]
   prima possibile bisogna fare sta cosa dello scadenziario"_ — and it is also the
   technically hardest, because it reverses the state machine
   ([OI-331](OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md)).
4. 🔴 **It compounds Fase 1 support**, which has no owner either
   ([OI-348](OI-348%20Fase%201%20post%20go-live%20support%20is%20unassigned%20and%20unpriced.md)),
   and Aurel Mrruku has told the client that production maintenance comes first.

## The escalation that was named and not evidenced

Elena Spini: _"se tu sei troppo pieno per altro … **dovrò capire con Giampaolo**,
non lo so."_ ⚠ **Nothing in this sweep's sources records her raising it with
him.** The ROMI weekly tech planning of the same afternoon
(`1cddUFvxSDopQ0veNOUyf8CLpRtMpYjiDxC49fNFkYp4`, Gianpaolo Motta on the
invitation) was checked and **carries no Pienissimo staffing discussion** — it is
a cross-project session about tooling.

See [Gianpaolo Motta](../people/Gianpaolo%20Motta%20-%20ROMI%20staffing%20authority.md).

## What is owed

- A named developer for R1, with dates, before the client approves on 13 November.
- A decision on whether 14 December survives the availability stated.
- Whether the capacity problem has been put to Gianpaolo Motta at all.
