---
id: meeting-2026-11-09-interna-review-temi-fase-2
type: meeting
status: resolved
owner: Elena Spini
with: Aurel Mrruku
org: ROMI
raised: 2026-11-09
updated: 2026-11-09
depends_on: []
blocks: []
source: Drive 1p__NBvyxF3ZID5vFVSu4plbF97tpofU4QrgeN85abLo
---

# 2026-11-09 - INTERNA Review temi Fase 2

**The internal half-hour before the client call, 00:26:39, Aurel Mrruku and Elena
Spini alone. It is the most explicit statement in this record of what the Fase 2
plan costs and who is available to build it: the client forced the scadenziario
release forward into December, Aurel Mrruku said in terms that he cannot do
December, the post-go-live support line has fallen out of the slides, and the
per-release day allowance is disputed between the two people who produced it.**

## Attendees

- **Aurel Mrruku** (ROMI) — invited as optional, attended
- **Elena Spini** (ROMI)
- 🔴 **Nobody from Pienissimo.** This is a ROMI-internal preparation call.

## Sources

- Transcript document `1p__NBvyxF3ZID5vFVSu4plbF97tpofU4QrgeN85abLo` (21,364
  chars), owner `e.spini@romicompany.com`, created 2026-11-09 09:31:51Z. **Read
  once, in full.** The recording ends on a sign-off, so the transcript is
  complete.
- 🔑 **The Drive meeting folder `1l8dNzb-Jj0QMRyaqNemt0U4L02E2lhcb` holds one
  shortcut only**, to this transcript. No separate Gemini notes document exists
  for this session, which is the reverse of the usual pattern.
- ⚠ Speaker labels are the usual auto-generated ones and are garbled in places;
  attribution below is reconstructed from content. Where a line could belong to
  either speaker it is not quoted.

## 🔑 Why the release plan changed

Elena Spini had shown Fabrizio Paganelli a first version of the Fase 2 slides
before they went to Daniela Morgese, and he asked for the release priorities to
be reordered. Her account of it:

> _"in realtà prima c'erano meno rilasci, adesso avevo voluto più spacchettare in
> più cose per avere più rilasci … Lui ha voluto a tutti i costi avere a dicembre
> questa cosa"_

🔑 **The thing he wanted in December is the scadenziario.** What had been one
release — infopoint, scadenziario and note di credito together — was broken apart
to put the scadenziario first: _"si è dovuto spacchettare praticamente questo
rilascio per lui. Ha detto che è assolut\[amente\] prima possibile bisogna fare
sta cosa dello scadenziario."_

⚠ **He also asked for Aurel Mrruku to be present**, having seen the slides
without him: _"ha detto 'Eh, però qua ci doveva essere anche Aurel.'"_

## 🔴 The developer said no to December, on the record

> **Aurel Mrruku:** _"Ti dico già che **non lo posso fare dicembre**."_

And the reason, which is a resourcing statement, not a technical one:

> _"io devo iniziare per forza su **un altro progetto che è enorme** … non ho le
> risorse a disposizione. Re\[xhi\]na è iniziato con un altro progetto. Sara e
> Ana\[Anita\] devono fare vision e io c'ho un sacco di progetti in parallelo.
> Quando dico un\[o\] sto parlando di una **decina**."_

> _"**Non facciamo la fase due, Elena, basta, consegniamo fase uno.** … Perché non
> si può lavorare in questo modo."_

Elena Spini's answer was not a date but an escalation: _"comunque lo dobbiamo
fare … se tu sei troppo pieno per altro … dovrò capire con Giampaolo, non lo
so."_ Aurel Mrruku's reply to substituting someone: _"ci metterà di più un'altra
persona."_

🔴 **And he is away for part of December**: _"molto probabilmente **dal 17 fino al
22 non ci sarò**"_, plus _"fino il 7 siamo in vacanza"_ in January.

→ [OI-349](../items/OI-349%20Fase%202%20has%20no%20developer%20committed%20for%20December.md)

## 🔑 What the scadenziario release actually requires

Aurel Mrruku described the client's ask as a reversal of the state machine, not an
update:

> _"Ma capisci cosa ci sta chiedendo, vero? Che dobbiamo far **tornare indietro
> tutto il flusso dell'ordine e degli asset e dei link**."_

He had already verified it a week earlier: _"Abbiamo visto che viene passato lo
stato da Mexal\[e\], cambia lo stato dello scadenzar\[io\] e abbiamo visto che
**non cambia niente sull'asset** … **non ci sono le logiche**."_ The client's
reading, reported by Elena Spini: _"lui ha detto che è **super facile**, … che in
realtà è una cosa è un aggiornamento e basta."_

⚠ **The communications question was raised and left open.** Aurel Mrruku: _"se
sono inviate le comunicazioni come faremo?"_ Elena Spini believes the flow never
reaches the point where mails have gone out, _"però lo dobbiamo riconfermare"_.

This is [OI-331](../items/OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md),
now dated — see
[the Fase 2 offer](../The%20Fase%202%20offer.md).

## 🔴 Post-go-live support has fallen out of the slides

> **Aurel Mrruku:** _"23 secondo te non ci sarà supporto post go live? Ne avete
> parlato di supporto post go live? Chi farà il supporto post\[\]… saranno almeno
> 23 ore di colla\[call\] al giorno con loro."_
>
> **Elena Spini:** _"Tra l'altro qua dentro non… **qua non l'aveva più messo.** …
> E lo dobbiamo mettere. **Non gliel'ho detto, alla fine non l'ha promesso.**"_

⚠ **The "23" is the transcript's rendering and its meaning is not established** —
it reads as a date in context (the Fase 1 support window after go-live) but could
be a duration. The substance is not in doubt: Fase 1 support after the
16 November start is in nobody's plan.

→ [OI-348](../items/OI-348%20Fase%201%20post%20go-live%20support%20is%20unassigned%20and%20unpriced.md)

## 🔑 The estimate dispute, in the open

Elena Spini had costed each release's release-day activity at **one day**. Aurel
Mrruku's objection, which is the substance of the call:

> _"però hai calcolato per ogni un rilascio doc\[umentazione\]… **non funziona
> così**. Elena è una cosa rilasciare cinque funzionalità insieme"_
>
> _"per fare una documentazione di un rilascio ci metti **da 2 ore a 4 ore** …
> 6 \* 2 sono 12 ore, sono 1 giorno e mezzo solo di documentazione. … Per fare il
> training ci metti in media **4 ore per rilascio** … **4 \* 6 fanno 24 ore**
> … 3 giorni e **siamo già a 5 giorni con documentazione e training per sei
> rilasci**. Ne vuoi parlare poi di b\[ug\] fixing?"_

He also separated the release itself from the day held for it: _"Un rilascio lo
faccio in **due ore** in media … però \[se\] qualcosa va male, tu devi tenere
tutto il giorno libero per quel rilascio."_ And he named the shape of a release:
_"una fase di preparazione dei dati, fase di prerilascio, rilascio, fase di post
rilascio, manual step, test con il cliente."_

🟢 **Elena Spini moved the numbers in the call, and the moved numbers are in the
plan.** _"Piuttosto qua aggiungiamo due giorni e due giorni a rilascio perché è un
rilascio in più. Siamo 9 e 11"_ and, for maintenance, _"due giorni al mese da
dicembre … per ora facciamo fino ad aprile"_ → _"forse facciamo 10"_.

🔑 **Both figures appear in `Pienissimo_Project_Plan_Fase2` as modified the same
afternoon**: the per-release transversal line moved from `7 - 9` to `9 - 11`
days, and a new `Maintenance` row reads _"2 giorni al mese (fino ad aprile)"_ at
`10` days. See [the Fase 2 offer](../The%20Fase%202%20offer.md) and
[OI-308](../items/OI-308%20Fase%202%20maintenance%20was%20left%20out%20of%20the%20estimate.md).

⚠ **Aurel Mrruku's view of the maintenance floor is higher than what was
written**: _"Mant\[enenza\] deve prevedere come minimo due giorni al mese, come
minimo ogni mese"_, and on 30 October he put it at three to four days a month.

⚠ **Commercial remarks about ROMI's own margin and pay were made on this call and
are deliberately not recorded here**; they are internal and bear on no
requirement.

## 🔑 The Info Point workaround was invented here

Elena Spini removed Info Point from the early release by offering the client a
manual bridge, repeating what Elisa Migliano had explained about what Info Point
is for — restaurant referents adding their own contacts, today against Zoho:

> _"Vi mette\[iamo\] vi diamo un template su un Excel e poi vi fate l'import
> massivo di tutti sti cavoli di contatti … mettermi l'ID di quell'account, il
> riferimento di quell'account e poi far salire il contatto"_

🔴 **Info Point itself is _"l'integrazione che manca totale"_** and moves to
February. → [the decision](../decisions/Decision%20-%20the%20Info%20Point%20check-in%20is%20bridged%20by%20a%20manual%20contact%20import.md)

## Dates stated on this call

| What | Date |
| --- | --- |
| Scadenziario release | **dicembre**, _"idealmente dal 14"_ |
| Annullamento and cambio nome | **14 gennaio**, driven by _"l'Academy del 19"_ |
| Info Point | **15 febbraio** — moved out of the January release |
| Eventi multi-edizione | _"sarebbe il rilascio 4"_ |
| Plan end | **aprile** |
| Aurel Mrruku unavailable | **17 - 22 December**, and to **7 January** |

⚠ **The transcript garbles the 14 December / 14 January pair**; both appear and
the reconstruction above follows the sequence of the conversation. The authority
is the offer deck, which states them unambiguously — see
[the Fase 2 offer](../The%20Fase%202%20offer.md).

## What this meeting did not settle

- **Who builds Fase 2**, and whether Gianpaolo Motta has been asked
  ([OI-349](../items/OI-349%20Fase%202%20has%20no%20developer%20committed%20for%20December.md)).
- **Whether Fase 1 support after 16 November is priced anywhere**
  ([OI-348](../items/OI-348%20Fase%201%20post%20go-live%20support%20is%20unassigned%20and%20unpriced.md)).
- **Whether the communications already sent block a state reversal**
  ([OI-331](../items/OI-331%20A%20reversed%20collection%20cannot%20move%20the%20order%20and%20asset%20states%20back.md)).
- **Whether the day total moves.** Elena Spini: _"la stima … aumenterà, non può
  diminuire"_, said on the client call an hour later. 🔴 **The offer's `150
  giornate` is unchanged.**
