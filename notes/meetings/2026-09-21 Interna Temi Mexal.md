---
id: meeting-2026-09-21-interna-temi-mexal
type: meeting
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-21
updated: 2026-09-21
source: Drive transcript doc 1og6yJCOT1Q65Mv0-kMTngxwSFt5hllHVHkBs-C6Mn70 (read in full)
---

# 2026-09-21 Interna Temi Mexal

**ROMI only, 45m16s, 21/09 11:02 CEST.** Aurel Mrruku, **Andrea Di Cicco**, Elena
Spini. Requested by Aurel Mrruku on 18/09 17:57 CEST: _"su pienissimo ci dobbiamo
sentire con andrea perché voglio capire come vengono passati i bundle e i plus su
mexal"_. Transcript only — no Gemini notes.

**This is the most consequential technical session of the 18–21/09 window.** It
establishes that the tranche-to-invoice link **cannot be automated at all**, and
the consequence has not been put to the client.

## The finding

🔑🔴 **Mexal exposes no field through which Salesforce can set an invoice due
date.** There are two different dates and they are not related one-to-one:

| Field                | Level                        | Who sets it                                    |
| -------------------- | ---------------------------- | ---------------------------------------------- |
| `data scadenza riga` | order line, sent with the order | Salesforce                                  |
| **`Data scadenza PG`** | scadenziario / invoice     | **Mexal, derived from the `modalità di pagamento`** |

Aurel Mrruku queried the scadenziario with `info true` and established that the
field named in the shared `scoperto clienti` Excel **does not exist**; the real
field is `Data scadenza PG`. Andrea Di Cicco confirmed it. Aurel Mrruku had also
spent a weekend and his whole research budget reading the documentation and the
public web, and found **nothing anywhere stating that the order-line due date
becomes the invoice due date** — because `Scad PG` is computed by Mexal from the
payment method.

🔴 **Only two outbound APIs exist from Salesforce to Mexal: customer and order.**
An `evasione riga` API would create an invoice per order line from the order — but
**Fabrizio Paganelli ruled that invoices are created by hand on Mexal**, so it is
not used. Andrea Di Cicco: _"Fabrizio ha detto 'No, le fatture le creiamo
direttamente noi a mano su Mexal, non deve essere automatizzata questa cosa.'"_

🔴 **So the invoice due date does not exist until a human types it**, and the
agreed process becomes: the administration user opens Salesforce, reads the
tranche due dates, and **reproduces them by hand** when creating each invoice in
Mexal. Salesforce then re-syncs through `get fatture` / the scadenziario.
→ [OI-143](../items/OI-143%20The%20tranche%20invoice%20date%20must%20be%20re-keyed%20by%20hand%20into%20Mexal.md)

Andrea Di Cicco states the failure mode without softening it:

> _"Se non vuoi una cosa automatica, eh, c'è possibilità d'errore manuale e non si
> aggiornano. […] nel momento in cui ci sta questo errore gli si dice devi
> aggiornare Salesforce con la data corretta."_

Aurel Mrruku's version: if the date does not match, _"va tutto a p\*\*\*\*\*\*"_ —
the tranches will not update.

🔑 Andrea Di Cicco's definition, worth keeping: **_"queste trance in realtà lato
loro si traducono in fatture […] sarebbe l'incipit della fattura."_**

## The bundle consequence

🔴 **A bundle goes to Mexal as one order line, and one line cannot carry n tranche
dates.** Aurel Mrruku: _"se mi fanno passare solo una riga, come cavolo farò io a
passare la data di scadenza a loro?"_ The same holds for Performance Plus — one
product, x instalments.

His workaround is to **split the bundle into separate lines**: _"se per i bundle
per qualche motivo vogliono poi mandare tutti gli item del bundle come singolo
item, lo gestisco anche in quel modo là."_ He had already concluded this over the
weekend and opened the call with it: **_"anche i bundle sono costretto a
separarli, quindi devo cambiare un attimo il modo in cui si calcola la somma
totale nei bundle"_**.

⚠ **This contradicts the standing ruling that a bundle is transmitted as a single
element**, and it changes how a bundle's total is computed.
→ [OI-144](../items/OI-144%20Bundles%20must%20be%20split%20into%20order%20lines%20for%20Mexal.md)

## Not agreed with anyone outside ROMI

🔴 Aurel Mrruku: **_"Dobbiamo per forza fare un passaggio con loro. Se mi
confermano sta cosa, io vado a bomba… Se non gli va bene, io non ho altra
soluzione per loro, perché l'informazione che mi mette a disposizione Mexal è
quella."_**

Elena Spini doubted the client would accept it — _"non so se questa cosa loro va
bene… per ogni ordine loro dovrebbero andare a fare questo passaggio"_. Aurel
Mrruku: only for bundles and plus. Elena Spini: **_"sono la maggior parte,
presumo."_**

Andrea Di Cicco on how to present it: _"non vendiamogliela come problemi, ragazzi
… veniamo come soluzione."_

⚠ **The plan was to raise it with Fabrizio Paganelli in the 16:00 call the same
day. It was raised there and cut off** when Daniela Morgese pulled him into
another meeting — see
[2026-09-21 Test WooCommerce e Temi Mexal](2026-09-21%20Test%20WooCommerce%20e%20Temi%20Mexal.md).
**As of this sweep the client has not been told.**

## Mirko Merendi's 11 August answers, re-read

Elena Spini surfaced Andrea Di Cicco's pre-holiday questions mail, which Mirko
Merendi answered in blue on 11 August. Read in-session:

- On `scoperto clienti`: **only causale `F` applies.**
- 🔑 **_"la [causale] utilizzata è 1. Se volete fare dei test potete utilizzare la
  10."_** ← this is the origin of the _"cambiare il valore del codice da 1 a 10"_
  action item recorded at the pre-UAT test session.
- **Nothing in it addresses due dates.** Aurel Mrruku: _"Non mi interessa i get,
  Elena, mi interessa invia ordine e non ho un esempio di invio ordine."_

⚠ Both Aurel Mrruku and Elena Spini conceded the approach had been wrong —
_"abbiamo sbagliato un po' nell'approccio"_ — because Andrea Di Cicco had not
been told what the CRM side had agreed about splitting plus orders and bundles.

## The client's import extraction, reviewed live

🔴 Aurel Mrruku opened Fabrizio Paganelli's `ARTICOLI` extraction and found the
agreed classification **not populated**: **_"Non ha fatto niente,
praticamente."_** The fields the data model added — whether the article generates
a ticket, whether it is included in bundles — are empty. `natura articolo` exists
and carries short codes. Roughly a thousand articles. And:
**_"Aveva detto che farebbe performance plus, performance plus rinnovo. Se vedi
non ha fatto bundle."_**
→ [OI-154](../items/OI-154%20The%20client%20import%20extraction%20is%20missing%20the%20article%20classification.md)

- Fabrizio Paganelli had told Elena Spini by phone to wait, because more doubts
  arose during the extraction.
- 🔴 Aurel Mrruku confirmed the Excel numeric-rounding problem Fabrizio Paganelli
  reported by mail — _"quando diventa numero fa un arrotondamento sull'Excel"_ —
  the same failure mode as
  [the article-code risk](../risks/Risk%20-%20normalising%20an%20article%20code%20merges%20two%20products.md).
- Aurel Mrruku granted Drive access to Rexhina Hysi and Anita Aga (rendered
  "Regina" and "Ana" in the transcript, the same garbling as 17/09).

## Source custody

⚠ Andrea Di Cicco may need to build a **custom LWC** for the Mexal filtered call.
Aurel Mrruku asked him to record which components, so they can be taken into git,
and said plainly: **_"In teoria si parte dalla sandbox e va in produzione e invece
qua in Romi non sempre succede."_** Aurel Mrruku will take Andrea Di Cicco's
production version into the sandbox.

⚠ **Andrea Di Cicco is still working on this project.** He attended two Pienissimo
sessions in this window and is on the 22/09 `Test Mexal` invitation, which
weakens the premise of
[OI-139](../items/OI-139%20Andrea%20Di%20Cicco%20is%20winding%20down%20with%20four%20integration%20questions%20unanswered.md).

⚠ A long passage concerns **Teatro Franco Parenti**, a different client of Andrea
Di Cicco's (a marketing-call escalation, Data Cloud and Einstein activation
lead-times). **Not ingested**, by the same convention the 18/08, 31/08 and 01/09
traces applied.
