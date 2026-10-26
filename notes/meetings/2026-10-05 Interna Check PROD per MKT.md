---
id: MTG-2026-10-05-interna-check-prod-mkt
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-111, OI-134, OI-177, OI-196, OI-197, OI-199, OI-203]
source: Drive 1xkAPFYBqdZr_s35FUCxg2MCpPL9NUPh1MPK6SRAUzAc (transcript)
---

# 2026-10-05 Interna Check PROD per MKT

**ROMI-internal, 10:01 CEST.** Aurel Mrruku · Elena Spini · **Fabrizio
Mastracci**. The session booked on 29/09 to hand the marketing builder a
working production org ([OI-177](../items/OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md)).
Grepped for the decisive passages rather than read end to end.

## 🔴 Production was not clean

Aurel Mrruku opened with _"Finita alle 4:00 di mattina oggi"_ and then:
_"Abbiamo un grande problema in produzione. L'account di Docusign … Non riesco
a entrare. Errore. username password non vanno bene."_ He could not reach
`Firmato`, so he **created orders directly in production and bypassed fields**
to give Fabrizio Mastracci records to look at — _"volevo proprio fare un giro
pulito"_ and could not. The DocuSign sign-in was only resolved five hours
later, live in
[the client UAT](2026-10-05%20UAT%20Performance%20Plus%20e%20Gestione%20date%20pagamento.md).

⚠ This is the second consecutive working day on which Prod data was made by
bypassing field values; the 02/10 Interna recorded the same phrase.

## 🟢🔑 The ticket send date is built, and it comes from the Campaign

The open point the logic document's own risk table called its biggest
([#1 of ten](../The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md)) is
closed. `Data invio biglietti` now exists **on `Event_Invitation__c`**, and its
value is the Campaign's:

> **Aurel Mrruku:** _"allora data invio biglietti. Hai il campo data invio
> biglietti… E praticamente lo prendo la campagna."_
> **Fabrizio Mastracci:** _"la data invio che cosa deve avere, che attributo
> deve avere?"_
> **Aurel Mrruku:** _"La data che mettono sulla campagna."_

And Elena Spini gave the business reason — the case Fabrizio Paganelli excluded
at the 30/09 UAT: _"magari uno paga prima, però la data invio è tra, non so,
due settimane, quindi l'invio effettivo … deve partire da questa data invio
biglietto che è un dato che viene messo a livello di campagna."_

🔑 So the build now honours **`Data invio automatico biglietti` on `Campagna
Figlia`** — the field the Campi Oggetti workbook has carried since July and
which the 02/10 sweep flagged as a documented home the design was ignoring.

## 🔴🔑 The Campaign on the invitation was "the first one it found"

Problem #2 of the same table, live in production:

> **Elena Spini:** _"cioè è l'edizione, io vedo l'edizione su … event
> invitation."_
> **Aurel Mrruku:** _"Sì, però è **la prima campagna che ha trovato**. Perché
> io ho messo la prima campagna che ha trovato."_

Asked to do better, he described the missing shape himself: _"ci devono creare
due record oppure un'entità in mezzo che mette insieme un legame tanti a tanti,
perché tanti eventi devono essere collegati a tante edizioni, tanti biglietti
per un ordine può essere collegata a tante edizioni. Questa è l'idea. Posso
fare, **però non l'abbiamo pensata**."_

🟢 He then did, the same day: _"ma ti genero n link per ordine"_ — one per
edition — which Elena Spini confirmed with a worked case. Commit `4a6fe3f`
landed at 17:39 CEST and
[the decision](../decisions/Decision%20-%20Event%20Links%20belong%20to%20Order%20Campaign%20pairs.md)
is in the repository.

## ⚠ The client does not want the link as proposed

Elena Spini, on `Rinuncia` sitting at event/edition level on the page:
_"**Ma loro non vogliono neanche quel link**, se ti ricordi, per come glielo
stiamo proponendo."_ Aurel Mrruku on the same design: _"ma non l'hanno pensata
sta cosa."_ The internal view of
[OI-203](../items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md),
stated nine hours before the per-edition rebuild was committed.

## Other

- Fabrizio Mastracci wrote his two send logics into the marketing group DM the
  same morning — _"Ho messo le logiche sulla nostra chat"_ — recorded in
  [the marketing send contract](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md).
- He confirmed `Data_Invio_Biglietto__c` is _"popolato solo su campagne
  figlie"_.
- ⚠ **Rebecca Marmo shared a document** of what marketing did before, which he
  expects to recreate in Marketing Cloud — _"quello che mi ha condiviso
  Rebecca, che è quello che loro facevano e che secondo me si aspettano di
  ricreare su marketing cloud."_ Elena Spini asked for it to be opened in the
  call. **Not identified in Drive by this sweep.**
