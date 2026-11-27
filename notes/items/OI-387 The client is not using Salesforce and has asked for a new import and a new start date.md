---
id: OI-387
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Paganelli, Aurel Mrruku, Sabatino Rinaldi
org: both
raised: 2026-11-27
updated: 2026-11-27
depends_on: [OI-375, OI-376, OI-380, OI-385]
blocks: [fase-1-closure, go-live]
severity: gating
uncertain: Fabrizio Paganelli's request of 25 November is attested only inside Elena Spini's status post of 27/11 - no mail, message, document or recording carrying it was found in any source this account can reach, so its exact wording, channel and recipient are unknown. Nothing states what the new import covers, which data it moves, whether it replaces or adds to the 13 November migration, or whether it is Fase 1 or Fase 2. That the client still has working Zoho access past the 31 October contract expiry is an inference from "hanno continuato a lavorare su Zoho", not a stated fact
source: Slack C0B5T3RB4FM 2026-11-27 17:00:00 CET
---

# OI-387 - The client is not using Salesforce and has asked for a new import and a new start date

**Pienissimo is not using the platform. ROMI's own weekly status of 27 November
records that the client has gone on working in Zoho, and that on 25 November
Fabrizio Paganelli asked for a fresh data import and a new start date on
Salesforce. The go-live of 16 November did not produce adoption, and the project
now has neither a start date nor an estimated end date.**

## What the status post says

Elena Spini, `#tproj-pienissimo`, **27 November 17:00:00 CET** - the first
weekly status on this channel since the PEC:

> _"**Avvio sulla piattaforma: Pienissimo non la usa ancora.** In questi giorni
> hanno continuato a lavorare su Zoho e **Fabrizio P. (25/11) ci chiede una nuova
> importazione dei dati e una nuova data di avvio su Salesforce**."_

And as a red flag in the same post:

> _"**Avvio senza data:** hanno proseguito su Zoho e serve una nuova importazione
> dei dati."_

| | |
| --- | --- |
| Is the client using Salesforce? | 🔴 **No** - _"non la usa ancora"_, stated by ROMI |
| What they are using instead | 🔴 **Zoho**, still, on 27 November |
| What the client asked for | A **new data import** and a **new start date**, Fabrizio Paganelli, **25/11** |
| Where that request is recorded | 🔴 **Nowhere this account can reach** - only inside this status post |
| New start date | 🔴 **None.** Elena Spini owns it: _"dopo il 30/11, fissare con il cliente perimetro e nuova data di avvio"_ |
| Estimated project close | 🔴 _"da definire dopo la call del 30/11"_ |
| Estimated days to finish | 🔴 _"da definire dopo la call del 30/11, dipende da cosa esce"_ |

## Why this is an item

1. 🔴 **It is the first explicit statement in the record that the go-live did not
   take.** The project's position since 16 November has been that Fase 1 is in
   production - _"Per noi tutto quello concordato per la Fase 1 e in PROD dal
   16/11"_
   ([OI-380](OI-380%20The%20client%20wants%20the%20scadenziario%20and%20the%20credit%20notes%20as%20soon%20as%20possible.md)).
   Both can be true at once, and together they are the dispute: delivered but
   not adopted.
2. 🔴 **A second migration is now a client request, not just a ROMI plan.**
   [OI-385](OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md)
   recorded _"la nuova migrazione"_ appearing in the 25/11 calendar mail with a
   definite article and no antecedent. This post supplies the antecedent - a
   client request of the same day - **without supplying the request itself.**
3. 🔴 **The data in production is going stale while the dispute runs.** The last
   import on record is
   [13 November](../meetings/2026-11-12%20Check%20Pre-Import.md); every working
   day the client spends in Zoho widens the gap the new import has to close, and
   nothing records how that is reconciled with records already created in
   Salesforce.
4. ⚠ **It changes what the 30 November call has to settle.** That meeting was
   called to fix the perimeter of what remains
   ([OI-385](OI-385%20A%20scope%20perimeter%20call%20and%20a%20new%20migration%20are%20planned%20for%2030%20November.md));
   it now also has to produce a start date and a migration plan, in one hour,
   without the technical lead.
5. ⚠ **The Zoho contract question becomes live again.** The project's own frame
   has the Zoho CRM contract expiring **31 October 2026**, and
   [the risk note](../risks/Risk%20-%20go-live%20now%20falls%20after%20the%20Zoho%20contract%20expires.md)
   has carried that since. The client working in Zoho on 27 November implies an
   extension nobody has recorded. ⚠ **This is an inference from the quoted line,
   not a stated fact.**

## What is owed

- 🔴 **Fabrizio Paganelli's request of 25 November itself** - its wording,
  channel and recipient - so the new import has a traceable origin.
- 🔴 **A written scope for the new import**: which objects and files, whether it
  replaces or supplements the 13 November load, how existing Salesforce records
  are reconciled, and whether it is Fase 1 or Fase 2.
- 🔴 **A new start date**, which nobody can set before 30 November by ROMI's own
  plan.
- 🔴 **Why the client has not adopted the platform** - no source states a reason,
  and the PEC
  ([OI-375](OI-375%20Pienissimo%20sent%20a%20PEC%20contesting%20the%20implementation%20and%20suspending%20the%20go-live.md))
  is the only candidate in the record.
- ⚠ **Whether Pienissimo's Zoho contract was extended past 31 October**, and
  until when.
- ⚠ **An estimate**: the status post leaves both the close date and the days to
  finish undefined, which means the project currently has no forecast at all.
