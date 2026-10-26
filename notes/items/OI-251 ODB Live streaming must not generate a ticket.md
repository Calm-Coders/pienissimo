---
id: OI-251
type: open-item
status: open
owner: Fabrizio Paganelli
with: Sabatino Rinaldi
org: Pienissimo
raised: 2026-10-16
updated: 2026-10-16
depends_on: [OI-255]
source: notes/meetings/2026-10-16 UAT Flussi MKT Biglietti.md
---

# OI-251 - ODB Live streaming must not generate a ticket

**Streaming-only events have no ticket, no QR and no check-in. The article code
for ODB Live will be flagged in Mexal as not generating a ticket, and attendance
will be tracked in Zoom instead. Fabrizio Paganelli took the registry change;
the attendance half rests on a Zoom-to-CRM link nobody has verified.**

## How it surfaced

At [the 16/10 UAT session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)
(`01:59:11`) Rebecca Marmo assumed every ticket runs through the single
invitation funnel and asked how online-event communications work. Sabatino
Rinaldi corrected the premise: **ODB Live has no tickets.**

> _"Sono si iscrivono a una diretta su Zoom. … ODB Live tu acquisti
> eventualmente su W[oo]commerce quel biglietto, quel prodotto che è un prodotto
> digitale, lo paghi €200, arriva su Mexal. Ok, questo ha pagato. Una volta che
> ha pagato può entrare nelle nostre comunicazioni di remind di Zoom. … Non c'è
> da scaricare un biglietto, non c'è da far nulla."_

## 🟢 The existing design already covers it

Elena Spini (`02:00:27`): the product carries a **generates-a-ticket yes/no**
property, and the value comes from Mexal.

> _"con Fabrizio e [E]lisa abbiamo adottato una logica per cui un prodotto viene
> definito con genera biglietto, sì o no? Quindi se Sabatino dice che questo
> evento non deve generare un biglietto, allora sul CRM non si genererà un
> biglietto perché ci viene detto da Mexal."_

So no Salesforce change is required. **The action is in the Mexal article
registry**, and Fabrizio Paganelli took it (`02:07:18`):

> _"Allora, mi segno che l'ODB sarà un codice articolo senza generazione del
> biglietto e siamo a posto."_ … _"Adesso me lo sono segnato, così modifico
> l'anagrafica degli articoli."_

## 🔑 The objection, and the answer it got

Fabrizio Paganelli raised the consequence nobody else had (`02:04:16`): a
ticketed event records attendance through the QR scan at the door. With no
ticket there is no scan, so **nothing records who actually attended**, and
editions accumulate indistinguishably.

> _"nel l'ODB che ci sarà nel 2028 se non lo tieni monitorato ti trovi anche
> quelli del 2027. Capito cosa voglio dire?"_

Sabatino Rinaldi's answer is **Zoom**:

> _"Zoom è uno strumento che ti traccia anche quanti peli nel naso ha chi ha
> partecipato … Quanti iscritti avevi? 1000 e ti dice tutti i nomi, cognomi,
> dati. Quanti hanno partecipato? 500. … poi è ovvio che andiamo a intrecciare i
> dati nel CRM."_

Fabrizio Paganelli accepted on exactly that condition — _"l'importante è che tu
da qualche altra parte hai il monitoraggio di chi ha effettivamente poi
partecipato"_.

## Open

- 🔴 **The attendance half depends on an unverified integration.**
  Cross-referencing Zoom attendance into the CRM is the whole answer to Fabrizio
  Paganelli's objection, and the connector is unestablished —
  [OI-255](OI-255%20The%20Salesforce%20to%20Zoom%20connector%20is%20unverified.md).
  Sabatino Rinaldi said he would do it by hand if necessary; **no owner, no
  date, no mechanism** is recorded for the hand version either.
- 🔴 **Which article codes are affected is not listed.** Only _"ODB Live
  streaming"_ was named. Whether other digital products — videocorsi, books —
  carry the same flag correctly is not established here, and the books and
  video-course orders are themselves still blocked
  ([OI-241](OI-241%20Books%20and%20video%20courses%20wait%20on%20a%20WooCommerce%20instance%20move.md)).
- ⚠ **Nothing verifies the flag is set.** The change is in the client's Mexal,
  not in this repository or the Salesforce org, and this sweep did not open
  either.
- ⚠ **Rebecca Marmo believed those events did have tickets in the CRM** —
  _"noi del CRM poi ce l'avevamo il biglietto"_ — and was told otherwise by her
  own colleague. Recorded because it means the marketing side has been planning
  communications on a wrong premise.

## `Soldout` is explicitly not this case

Fabrizio Paganelli recalled a hybrid in-person/streaming event; Sabatino Rinaldi
identified it as **`Soldout`**, which has a room component and is therefore
handled as an ordinary ticketed event: _"Soldout ha l'evento anche in sala e
quindi va gestito come qualsiasi altro evento."_

## What closing it looks like

The ODB Live article is flagged in Mexal, a CRM order for it demonstrably
produces no asset and no QR, the list of no-ticket article codes is written
down, and a named path — connector or manual — carries Zoom attendance back for
cross-reference.
