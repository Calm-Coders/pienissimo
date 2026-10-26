---
id: OI-252
type: open-item
status: open
owner: Fabrizio Mastracci
with: Rebecca Marmo
org: ROMI
raised: 2026-10-16
updated: 2026-10-16
depends_on: [OI-250]
source: notes/meetings/2026-10-16 UAT Flussi MKT Biglietti.md
---

# OI-252 - The Food Marketing Festival needs its own journey template

**One event does not fit the single standard ticket flow: free and paid tickets
together, three ticket types, and funnels launched reactively on how downloads
are going. Fabrizio Mastracci will leave a duplicable template journey pointed
at that campaign, on the condition that its entry structure is never changed.**

## The event that does not fit

At [the 16/10 UAT session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)
(`01:47:48`) Rebecca Marmo described it:

> _"per quanto riguarda il Food Marketing Festival … essendo un evento che è
> particolare, gratuito, a pagamento, ci sono tre tipologie di biglietti,
> facciamo invii particolari, tipo quest'anno abbiamo inviato prima solo ai
> gratuiti o prima solo quelli a pagamento. Guardavamo gli scarichi, quindi
> funnel partivano, anche più di un funnel partivano in base a come si stavano
> andando gli scarichi e le nomine. Quindi sono funnel che sì sono studiati, ma
> molti vengono studiati qualche giorno, cioè oggi per domani"_

Sabatino Rinaldi added the communications reason: a paid holder gets a different
reminder treatment from a free one, and the free cohort's handling depends on how
the paid cohort is downloading.

🟢 **The tour was explicitly cleared.** Rebecca Marmo: _"Il tour invece in realtà
non è che è così tanto problematico, perché lì semplicemente magari sono meno
inv[ii], potrebbe andare bene anche la logica come per gli altri eventi."_ So
the exception is **one event**, which runs **once a year** — most recently
September 2026.

## The agreed shape

Elena Spini first offered to treat it as a deferred edge case — _"possiamo
considerarlo come un caso limite da gestire in un secondo momento, ma da
gestire"_. Fabrizio Mastracci then offered something concrete (`01:55:09`):

> _"per questo caso particolare io poi ti lascio un template … che è praticamente
> puntato a questa campagna, questo evento particolare e poi tu da lì ogni volta
> fai l'invio, duplichi e modifichi. … te lo lascio con gli weight che te li puoi
> proprio cambiare come ti pare. Puoi mettere le mail come ti pare."_

🔑 **The condition is the important half:**

> _"è importante che tu come ingresso di questo flusso mantieni sempre lo stesso
> o comunque la stessa struttura di quello che ti ho dato io. Cioè, tu non puoi
> prendere un giorno, ti crei una lista CSV, la importi e dici voglio mandare le
> mail a tutte quelle persone perché questo comporta un errore dal momento che ci
> sono mille logiche dietro questo flusso dei biglietti."_

So the template may vary **waits and mail content**, and must not vary **the
entry criteria**. Elena Spini generalised the pattern: today's build is the
_"flusso standard"_; every future special case becomes flow 2, 3, 4.

## Why duplicating per event was refused

Rebecca Marmo proposed twice to duplicate the flow for each event, keyed on the
edition's codes. Fabrizio Mastracci refused both times with the same reason
(`01:52:04`): the journey's entry point is the **Invito Evento** object — the
link being present and the status — not the campaign, so re-keying it per
campaign _"vuol dire stravolgere tutto il flusso"_.

## Open

- 🔴 **Nothing is built and no date is set.** The commitment is to leave a
  template; no owner-side deadline was named, and it sits behind
  [OI-250](OI-250%20The%20reminder%20wait%20intervals%20must%20be%20configurable%20per%20edizione.md),
  whose interval design the template would inherit.
- 🔴 **The three ticket types are not modelled here.** Free versus paid drives
  different reminder treatment; nothing in this record says how the flow
  distinguishes them, and no requirement covers it.
- ⚠ **Whether this is Fase 1 is unruled.** The Food Marketing Festival next runs
  about eleven months after go-live, which argues for Fase 2 — but nobody said
  so, and Elena Spini's _"caso limite da gestire"_ left it open.
- ⚠ **The reactive launch pattern is unaddressed.** _"Oggi per domani"_ funnels
  started by watching download rates is an operating mode, not a configuration,
  and the agreed design has one journey per edition.

## What closing it looks like

A ruling on the phase, a template journey delivered and pointed at the Food
Marketing Festival campaign, documented entry criteria the client is told not to
change, and a statement of how free and paid cohorts are separated.
