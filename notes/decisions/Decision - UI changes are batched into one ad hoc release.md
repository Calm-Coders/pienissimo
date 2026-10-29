---
id: decision-ui-changes-batched
type: decision
status: resolved
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-10-29
updated: 2026-10-29
depends_on: []
blocks: []
source: Slack D0B5QHS2T7H 2026-10-29 12:18 CET
---

# Decision - UI changes are batched into one ad hoc release

**ROMI stopped accepting user-interface changes one at a time. From 29 October the
client is asked to collect every UI request into a single file, which ROMI will
deliver as one dedicated release. The client has been told, and the file is the
client's to compile.**

## The decision

Aurel Mrruku, Slack DM `D0B5QHS2T7H`, **2026-10-29 12:18:48 CET**, answering Elena
Spini's question about whether a 16:9 bundle screen could be squeezed in:

> _"no elena **non prendiamo altri requisiti sulla UI** che diventa un casino.
> chiedi tutte le modifiche che vogliono e **facciamo in un unico rilascio**"_

Elena Spini in thread, **13:03:07 CET**: _"lo aggiungiamo al file che ho chiesto di
fare a Marco allora"_ — so a collection file already existed, requested of **Marco
Montesi**, and the UI asks join it.

## The client has been told

Elena Spini, reporting back the same afternoon at **16:02:51 CET**:

> _"**le modifiche UI gli ho detto di metterle tutte tutte in un file e faremo
> rilascio ad hoc** come hai richiesto 😉"_

🔑 **This is unusual in these records**: an internal ruling that reached the client
the same day it was made. Contrast
[OI-295](../items/OI-295%20Leads%20imported%20from%20Zoho%20must%20be%20distinguishable%20from%20new%20leads.md),
where the decision sat inside a ROMI DM.

## What it leaves open

1. ⚠ **The release has no date.** _"Rilascio ad hoc"_ is a shape, not a schedule,
   and the first items are already in the queue —
   [OI-299](../items/OI-299%20Bundle%20creation%20offers%20the%20wrong%20Anno%20Accademico%20values%20and%20too%20few%20Bundle%20Type%20values.md)'s
   16:9 request among them. Whether it lands before or after the 16 November
   go-live is unstated.
2. ⚠ **It is not a Change Request ruling.** This decides *when* UI changes are
   delivered, not whether they are in scope or chargeable. The client's answer on
   the Change Request regime
   ([OI-285](../items/OI-285%20ROMI%20asked%20the%20client%20to%20route%20future%20out%20of%20scope%20requirements%20through%20change%20requests.md))
   is still outstanding — **six days** as at this sweep — so the two could collide:
   a batched file of UI changes is exactly the material a CR regime would price.
3. ⚠ **The file is not in these records.** Marco Montesi owns it; no id, link or
   contents are known here, so its growth cannot be tracked from the repository.
4. 🔑 **Field and data changes were explicitly not batched.** Elena Spini's _"per la
   parte del campi np no?"_ went unchallenged, so picklist and field work continues
   to flow normally. The boundary is "UI", and nobody has defined where it runs.
