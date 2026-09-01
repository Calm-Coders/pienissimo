---
id: MTG-2026-09-01-anticipay
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-09-01
updated: 2026-09-01
source: Drive - "[ROMI-PIENISSIMO] - Follow-up Integrazione Anticipay - 2026/09/01 10:02 CEST - Appunti di Gemini", doc 1CiCRPuxOoZvqmlUTRahWyewjAuDw4n0wgOMzs4vK0dU
---

# 2026-09-01 Follow-up Integrazione Anticipay

**Client-facing session, 1 September 2026, 10:02 CEST, ~20 minutes.** Gemini
notes, a full transcript and a recording all exist and all three were read for
this note. It is the follow-up booked on
[25 August](2026-08-25%20Integrazione%20Anticipay.md), which was made cancellable
if the API material arrived first — it arrived on 31 August and the call **ran
anyway**, as a review rather than a chase.

**Present and speaking:** Elena Spini, Aurel Mrruku (ROMI); Andrea Parmeggiani
(Pienissimo Software), Elisa Migliano (`amministrazione@`).
⚠ **Fabrizio Paganelli was invited and is addressed twice in the room** — Andrea
Parmeggiani's _"però Fabri dite se serve qualche dato in più"_ and Elena Spini's
_"sì, Fabrizio, secondo me consideriamo solo la parte di Anticipay"_ — but he
never speaks. `uncertain:` whether he was present. Sabatino Rinaldi was invited
and does not appear.

**This is the meeting [the 1 September trace](../traces/Source%20trace%202026-09-01%20Anticipay%20API%20drill.md)
called _"the single most valuable thing outstanding on this project"_.** It was
drilled on the night of 1 September, the same day it ran.

## What it settled — the field selection, which is the whole point

🟢 **[OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)
is decided.** The action Fabrizio Paganelli and Elisa Migliano had held **with no
date since 25 August** was discharged in the room. Aurel Mrruku walked point 6 of
the documentation field by field and the group took every field.

| Field                       | Where it lands                                      | Decided by                                |
| --------------------------- | --------------------------------------------------- | ----------------------------------------- |
| `ragione_sociale`           | `Account.Name`                                      | standing                                  |
| `indirizzo`, `citta`, `provincia`, `cap` | the standard billing address block     | Aurel Mrruku, unopposed                   |
| `pec`                       | **a new ad-hoc field on Account**                   | Elisa Migliano — _"il campo PEC è fondamentale"_ |
| `nome_legale_rappresentante` | **a new ad-hoc text field on Account**             | Elisa Migliano                            |
| `codice_fiscale_legale_rappresentante` | new field on Account                     | Elisa Migliano                            |
| `data_di_dascita_legale_rappresentante` | new field on Account                    | Elisa Migliano                            |
| `luogo_nascita_legale_rappresentante` | new field on Account                      | Elisa Migliano                            |
| `indirizzo_legale_rappresentante` | **one single free-text field**                  | Andrea Parmeggiani, accepted by Aurel Mrruku |

**All eleven fields are taken. Nothing was dropped.**

Two shape decisions inside that:

- **The legal representative lives on the Account, not as a Contact.** Aurel
  Mrruku proposed a typed Contact record — _"posso creare anche un record, un
  contatto tipo legale rappresentante se serve"_ — and Elisa Migliano overruled
  it: the data _"andrebbero messe all'interno dell'account… perché poi dopo il
  tema del legale rappresentante è fondamentale per la firma dei contratti."_
  Aurel Mrruku accepted with a reservation on the record — _"lo vedo come una
  struttura più complessa dei semplicemente dei campi sull'account, ma fa niente,
  per il momento li lascio come account."_
- **The representative's address is one text field, not a structured address.**
  Andrea Parmeggiani: _"non è importante, secondo me, che salviamo il CAP del
  legale rappresentante. Va bene un testo tutto completo."_ Note the asymmetry —
  the **company** address is structured (street+civico together, then città,
  provincia, CAP as separate fields), the **person's** address is not.

## 🔴 Anticipay covers Italian companies only, and this answers a requirement question nobody asked

Andrea Parmeggiani, unprompted:

> _"Poi diamo per scontato che la richiesta facciamo solo per aziende italiane
> perché Anticipay dà i dati solo per aziende italiane. Quindi la nazione non
> l'ho inserita perché è scontato che sia Italia, altrimenti torna sempre non
> trovato."_

So `nazione` is **deliberately absent from the payload**, and **a non-Italian VAT
number always returns "record non trovato"** — indistinguishable, on the wire,
from an unknown Italian company.

⚠ **This is a direct answer to the second half of `INT-18`**, which the register
still carries as _"Anticipay VAT check timing and **foreign-VAT handling**"_.
Foreign VAT handling is not deferred, not phase 2 and not unspecified — **it is
not possible through this integration at all**. Nobody in the room connected the
remark to the requirement, and it is recorded in
[OI-73](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md).

## The environment split, and the token decision

🟢 **The `:env` parameter was invented in this call.** Aurel Mrruku proposed two
distinct paths so that continuous testing never touches production; Andrea
Parmeggiani agreed on the spot — _"facciamo due path diversi"_ — and committed to
mail the final paths. **He did so at 12:46 CEST, two and a half hours later**,
which is v2 of the documentation. The
[1 September trace](../traces/Source%20trace%202026-09-01%20Anticipay%20API%20drill.md)
hypothesised exactly this and was right.

🔴 **The single shared token was asked about explicitly and confirmed
deliberately.** Aurel Mrruku: _"ma si può usare anche lo stesso token perché
praticamente l'ambiente è lo stesso?"_ Andrea Parmeggiani: _"sì, sì."_ That
converts [OI-106](../items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)
from an oversight to be pointed out into **a decision taken with both parties
awake**. Re-opening it now costs more than raising it would have.

Also agreed on environments:

- **The test environment is free and has no call limits** — _"non ci sono costi",
  "possiamo fare chiamate a piacere"_. It answers only from what Pienissimo
  already holds.
- **Production will be byte-identical in configuration**, the only difference
  being that the middleware forwards on to Anticipay. Andrea Parmeggiani:
  _"identico… che sarà sempre identica."_
- 🔴 **A tracked action: switch the test-environment call off when production goes
  live.** Aurel Mrruku raised it himself — with two identical configurations
  there is a standing risk of the test lane firing paid production lookups.
  _"lo mettiamo nei punti da tracciare."_ This has no due date and no ticket
  beyond this note.

**Happy path is `200`**, confirmed by Andrea Parmeggiani in the room.

## New: the codice destinatario SDI

Elisa Migliano asked whether Anticipay can supply the **codice destinatario SDI**,
which would be a **twelfth field** and is not in the documented contract. She was
explicit that it is not critical — Pienissimo routes electronic invoices by PEC —
but that Mexal has _"una valanga di clienti dove lo SDI non è valorizzato"_, so
recovering it would have value beyond this integration.

Andrea Parmeggiani took the action to check and reported a first impression in
the room: _"mi sembra da un'occhiata veloce di non trovarlo."_ Raised as
[OI-109](../items/OI-109%20Codice%20destinatario%20SDI%20as%20a%20twelfth%20Anticipay%20field.md).

## New: a dedicated data-model call

Elena Spini asked for one, and gave the reason plainly — **_"ancora non abbiamo
ricevuto niente"_**. The group agreed. Elisa Migliano immediately parked further
material into it: she holds _"tutta una serie di campi"_ beyond Anticipay,
naming **tipo fatturazione elettronica**, and proposed structuring them
separately.

⚠ **No date was set and no invitation has been sent** as of this sweep. It is the
natural forum for [OI-24](../items/OI-24%20Data%20model%20workbook.md), which has
been owed since July.

## What the call did NOT touch

Four of the six questions
[OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
derived from the documentation were **never raised in the room**. Recorded here
so nobody assumes a twenty-minute call closed them:

| Question                                                                                   | Status after this call                                                     |
| ------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------- |
| **The error response body**, one example per code                                          | 🔴 **still open** — only the `200` happy path was discussed                |
| Which fields Salesforce stores, and a date                                                 | 🟢 **answered in full** — see the table above                              |
| The token — one or two, rotation                                                           | 🟢 answered: **one, deliberately** ([OI-106](../items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)) |
| The date `env=test` becomes pass-through                                                   | 🔴 **still open** — not mentioned                                          |
| The `dascita` typo ([OI-105](../items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)) | 🔴 **still open** — nobody noticed it, and the field is now being built |
| Rate limits, timeout, cache TTL                                                            | ⚠ **partly** — test is free and unlimited; **production says nothing**     |

🔴 **The personal-data question in
[OI-108](../items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md)
was never raised, and the decision went the other way.** That note recommended
storing the company block and dropping the person block. The room took all five
legal-representative fields onto the Account. Elisa Migliano gave a business
purpose — **contract signature** — which is a real answer to _"what is it for"_
and it is the first one the record has. Retention, lawful basis, field-level
security and the erasure question were not mentioned by anyone.

## Actions

| Owner              | Action                                                                                 | Due                    |
| ------------------ | -------------------------------------------------------------------------------------- | ---------------------- |
| Aurel Mrruku       | Build a Postman collection and test the calls                                          | said _"entro stasera"_, update _"in un paio di giorni"_ |
| Andrea Parmeggiani | Check whether the **codice destinatario SDI** is available; add it to the mapping if so, and tell Aurel Mrruku | — ([OI-109](../items/OI-109%20Codice%20destinatario%20SDI%20as%20a%20twelfth%20Anticipay%20field.md)) |
| Andrea Parmeggiani | Configure separate test and production endpoints                                       | ✅ **done same day** — the `:env` parameter |
| Andrea Parmeggiani | Mail the final paths for both environments                                             | ✅ **done 1 Sep 10:46:38Z** |
| Elena Spini        | Organise a dedicated data-model call                                                   | no date set            |
| Aurel Mrruku       | Switch off the test-environment call when production goes live                         | at go-live; tracked nowhere else |

## Method note

**A twenty-minute call closed the item that three sweeps could not.** OI-95 had
been open since 25 August, blocked on a decision two people held with no date on
it, and every previous run's recommendation was _"get a date"_. The call did not
get a date — it got the decision. Worth remembering when the next item stalls on
an undated client action: the cheapest unblock may be a short call, not a chase.
