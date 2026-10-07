---
id: ref-business-blueprint
type: reference
status: active
owner: Elena Spini
org: ROMI
raised: 2026-10-02
updated: 2026-10-07
source: Drive 1oa5iIHxu86wx6v7qZaBjM7g5Sk7bmuK9
---

# The Business Blueprint delivered to the client

**`Business_Blueprint_Pienissimo.docx` was delivered to Pienissimo on 2026-10-02
at 13:55:56Z. It is dated 02/10/2026 and ends with signature lines for ROMI Srl
and Pienissimo Srl. It had been sitting unread by every sweep since 24/09; this
is the first time it has been opened.**

Drive id `1oa5iIHxu86wx6v7qZaBjM7g5Sk7bmuK9`, owner Elena Spini, last modified
**2026-10-02T13:52:42Z** — three minutes before the mail. ~590 KB.

## What it is

A ten-chapter functional blueprint: project goal and Fase 1/Fase 2 perimeter,
deliverables, users and profiles, the three integration flows, initial data
loading, implementation detail in four process blocks, marketing and
communication, reports, training, and commercial notes.

🔴 **It is a second signature-bearing document.** Until now
[REQUISITI.it.md](../REQUISITI.it.md) was the text the client signs. This one
carries its own signature block, was delivered as a deliverable in its own right
("Business Blueprint (BBP) e Data Model" is the first item on its own deliverable
list), and the repository does not hold it.

The mail asks the client to re-read it **ahead of the autonomous testing that
starts next week** and to leave comments inside the document.

## What it settles that the record did not have

- **Fase 2 is enumerated.** GLS shipping notifications, Teachable videocorsi,
  Pienissimo Pro orders towards Pienissimo Software SRL, **complex automations for
  multi-edition events (e.g. Mastery)**, the Info Point app integration, and
  **credit notes plus wrong-collection logic** — all explicitly outside Fase 1,
  to be quoted separately.
- **Two profiles only**: standard `Amministratore di Sistema` and an ad-hoc
  `Commerciale & Marketing`. Record visibility stays open — commercials keep
  seeing each other's opportunities and orders — and permissions are used to
  protect structural configuration.
- **Post-go-live support is one month** from the release of each feature.
  **Training is up to 20 hours within at most 2 months.** No penalties for
  schedule slippage.
- **Product master data is born on Mexal** and imported nightly; the bundle is the
  only product that is born in Salesforce. Invoices import read-only.
- **Bundle rules**: at most two levels, at most one bundle per order, and
  **a bundle may consist of a single product** _"se il business lo dovesse
  richiedere"_. 🟢 This already covers the request the client made on 02/10 for a
  single-product bundle, which Aurel Mrruku read as wanting one code for
  WooCommerce and another for Mexal.
- **Bundle codes reach WooCommerce manually and verbally**, stated as a deliberate
  design simplification because the annual count is small.
- **Asset life cycle: seven states** — Ordinato, Disponibile, Rinuncia, Assegnato,
  Utilizzato, Non Utilizzato, Annullato. 🟢 **`Inviato` is absent**, independently
  confirming the withdrawal recorded in
  [OI-74](items/OI-74%20Asset%20state%20machine.md).
- **Lead has two record types** with full state lists and the PERSO/ERRATO exit
  taxonomy spelled out value by value.

## 🔴 Divergences the delivered text carries

| Topic | Blueprint says | The record says |
| --- | --- | --- |
| WooCommerce sync trigger | _"non diventa visibile/sincronizzato su Salesforce finché il suo stato non è COMPLETATO"_ | **IN LAVORAZIONE or COMPLETATO**, verified live against the delivered plugin on 2026-08-27 (`ORD-12`), which explicitly supersedes the COMPLETATO-only rule |
| Marketing subdomain | §7.1 says **`mail.pienissimo.com`**; the deliverable list says **`marketing.pienissimo.com`** | Two different subdomains inside the same document |
| `Rinuncia` granularity | §7.4: renouncing affects **every asset of the referente principale** — header level | The 01/10 logic document mailed to the same people the night before says **per edition** ([OI-75](items/OI-75%20Ticket%20availability%20rule.md)) |
| Quote states | The state table lists Bozza, In Trattativa, In Attesa di Accettazione, Accettato, Rifiutato | The acceptance flow in the same section ends at **`Firmato`**, which shipped on 29/09 and is absent from the table |
| Mappatura edizione | _"servono ad associare **manualmente** i prodotti alle rispettive campagne"_ | Aurel Mrruku corrected exactly this wording at the 12:22 Interna hours earlier: the **data** is entered by hand, the **association** is automatic at order creation |
| Dedup engine | _"**Data Claud** applica regole di Identity Resolution"_ for the Unified Individual golden record, on `email AND phone` | Fase 1 names Sales Cloud and Marketing Cloud. ⚠ Data Cloud is not in the stated perimeter and no licence for it appears anywhere in the record |

⚠ A broken internal cross-reference too: the Contract block cites the Strategist
role at **§3.2**, and chapter 3 has no subsections.

## What the client did with it

Fabrizio Paganelli and Sabatino Rinaldi read it at 15:00 CEST and replied at
14:19:31Z objecting to _"il paragrafo Regole di Business Aggiuntive, sia il punto 1
che il punto 2"_. **This document has no such paragraph** — the objection belongs
to [the 01/10 logic document](The%20agreed%20Asset%20and%20ticket%20send%20logic%20document.md).
See [OI-203](items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md).

## What it does not say

🔴 **No go-live date.** The only date it commits to is the Zoho licence expiry,
**31 October 2026**. It does not state Fase 1 go-live, which the register has at
**21 October** since
[OI-124](items/OI-124%20Go-live%20moved%20from%206%20to%2021%20October.md).

It also does not mention the sole-trader Anticipay gap Fabrizio Paganelli raised
that morning ([OI-202](items/OI-202%20Anticipay%20does%20not%20recognise%20sole%20traders%20absent%20from%20the%20registro%20imprese.md)),
and it promises `Insoluto` reporting that nothing supports
([OI-206](items/OI-206%20The%20Insoluto%20concept%20has%20no%20invoice%20due%20date%20and%20no%20invoice%20record.md)).

## 🟢🔑 2026-10-05 - the first written client acceptance, with three questions

Marco Montesi, `marco.m@pienissimo.com`, **Responsabile Area Commerciale**,
replied on the delivery thread at **13:20:02Z**:

> _"Ciao Elena, **direi che torna tutto**, giusto tre precisazioni:"_

**This is the first time a Pienissimo signatory has accepted a ROMI document in
writing.** It matters because the same thread carries Fabrizio Paganelli and
Sabatino Rinaldi's rejection of a *different* document three days earlier, and
Elena Spini's 02/10 mail established that the two had been confused
([OI-203](items/OI-203%20The%20client%20contested%20the%20agreed%20ticket%20logics%20before%20confirming%20them.md)).
The Blueprint carries signature lines for ROMI Srl and Pienissimo Srl.

⚠ It is an acceptance by the **sales** lead. Fabrizio Paganelli owns the product
registry and is the day-to-day referent; Elisa Migliano owns administration.
Neither has replied to the Blueprint, and Sabatino Rinaldi **had not read it**
as of 17:15 the same day, when Elena Spini asked everyone to before the 06/10
meeting.

### His three precisazioni

1. 🔑 **Recall Tutor opportunities are also created in bulk by Pienissimo** —
   _"potrebbe essere generata dal Tutor ma anche massivamente da noi, come ad
   esempio a seguito di una lista di contatti che manifestano interesse a
   seguito di un'azione di survey post evento."_ A second origin for the record
   type, and a mass insert —
   [OI-182](items/OI-182%20A%20WooCommerce%20opportunity%20record%20type%20replaces%20Recall%20Tutor.md).
2. **Can they edit the `Perso`/`Errato` filter values themselves?** —
   _"Le voci che ci sono nei filtri Perso/Errato possono essere modificati e
   implementati in autonomia da noi?"_ A self-service picklist-administration
   question, which is the permission model in
   [OI-186](items/OI-186%20The%20Salesforce%20user%20list%20and%20profiles%20were%20never%20agreed%20with%20the%20client.md).
   The register's `rifiutato` reason `sostituito da altro preventivo` was
   settled on 28/09; nothing says who may add a value.
3. **Are the mail and WhatsApp follow-ups set once and then only changeable
   through support?** — _"devono essere settati all'inizio e poi per
   modificarli dobbiamo passare sempre dall'assistenza, corretto?"_

🟢 **Question 3 was answered hours later, in a different room.** The 05/10
Performance Plus UAT agreed as a `Concordato` that **email templates are
editable directly in production** by the administrator, who can change the HTML
for mass updates or personalise a single customer's mail — and Aurel Mrruku
owes a preview-and-personalise feature. So the answer to Marco Montesi is
"no, you can edit them yourselves", and **nobody has told him.**

🔴 **No reply has been sent to any of the three.** They are the only
constructive client feedback on a signature-bearing document this project has.

## Update 2026-10-07 — Elena Spini answered, two of three

Elena Spini replied to Marco Montesi on the thread at **14:57:40Z**, cc Fabrizio
Paganelli, `amministrazione@`, Sabatino Rinaldi, Rebecca Marmo, Aurel Mrruku and
Fabrizio Mastracci — **two days after his message**, and the sweep's standing
"nobody has replied to Marco Montesi" is discharged.

**1 — mass Opportunity creation for Recall Tutor.** Declined for now:
_"Attualmente non è stato pensato né richiesto un flusso di creazione massiva di
Opportunità, consiglio di provare ad utilizzare la piattaforma ed eventualmente
si potrebbe pensare di includere questo nuovo requisito in una fase
successiva."_ ⚠ A **Fase 2 candidate created in mail, with no Fase 2 row** — the
same pattern as [OI-196](items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md).
⚠ It also contradicts the reading that the Blueprint was accepted whole: Marco
Montesi's point 1 was a statement about how the business actually works, not a
request, and the answer is that the platform does not do it.

**2 — editing the Perso/Errato picklist values.** Answered: they can be changed
_"direttamente dall'amministratore di sistema, nel vostro caso dagli utenti
Fabrizio/Elisa che useranno l'utenza Amministrazione Pienissimo."_ 🟢 Consistent
with the same day's ruling that UAT credentials go to those two only, and with
Elena Spini's 12:34:50Z mail asking Elisa Migliano to verify the address for the
UAT user.

**3 — the mail and WhatsApp follow-ups. Not answered; bounced back.** Elena
Spini: _"Non ho capito cosa intendi. Mi puoi dettagliare nello specifico di quale
flusso parli?"_

🔴 **That is the question the record already had an answer to.** The 05/10
Performance Plus UAT agreed email templates are editable directly in production
by the administrator — recorded above. The answer went back as a request for
clarification instead, and the question is now open on Marco Montesi. ⚠ It
matters more than it did on 05/10, because the flows he is asking about are the
**11 email + 11 WhatsApp funnel** written out on 06/10
([the funnel note](The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)),
whose governance — who may change a message, and whether a change needs ROMI —
is not written anywhere.

⚠ **Direction still has not read the document.** See
[OI-218](items/OI-218%20Direction%20has%20not%20seen%20the%20Business%20Blueprint%20before%20the%2013%20October%20confirmation.md):
Fabrizio Paganelli raised it at the 07/10 UAT against the **13 October**
production confirmation, and Sabatino Rinaldi undertook to forward the Blueprint
to Daniela Morgese.
