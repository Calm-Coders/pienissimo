---
id: OI-339
type: open-item
status: open
owner: Elena Spini
with: Aurel Mrruku
org: both
raised: 2026-11-05
updated: 2026-11-05
depends_on: [OI-310]
blocks: []
source: Slack DM D0B5QHS2T7H, 2026-11-05 15:54-16:33 CET
---

# OI-339 - The client was locked out of production during the migration load

**Fabrizio Paganelli was blocked from working in production on 5 November and will
stay blocked until Monday 9 November, because the bulk migration load was running
and the Mexal API calls were being switched off around it. He was not told by ROMI
in writing; Elena Spini phoned him. The data ROMI needs back from him is due on
Friday 6 November.**

## What was said

Elena Spini and Aurel Mrruku, DM `D0B5QHS2T7H`, 5 November:

| Time (CET) | Who | Said |
| --- | --- | --- |
| 15:54 | Aurel Mrruku | _"non deve fare test in prod oggi che li sto togliendo anche le comunicazioni con le api"_ |
| 15:56 | Elena Spini | _"in realtà a me stava dicendo che stava facendo il lavoro della mappatura edizione ecc"_ |
| 16:00 | Aurel Mrruku | _"da 3 ore che mi sto occupando del deploy e migrazione"_ · _"ha fatto delle porcherie diretamente in prod …"_ · _"e non ha avisato"_ |
| 16:04 | Elena Spini | _"ha paura che le cose non vanno e vuole fare ancora test li -.- lo chiamo e lo fermo asp"_ |
| 16:08-16:13 | Aurel Mrruku | _"produzione non e per fare test a tapetto"_ · _"poi devo cancellare tutto …"_ · _"abbiamo delle date condivise con loro"_ · _"ci devono fornire i datti entro venerdì"_ |
| 16:10 | Elena Spini | _"comunque prima di andare live ovviamente deve fare tutto il giro"_ · _"non è testa tutto il 16"_ |
| 16:33 | Elena Spini | **_"Fabrizio bloccato in PROD fino a lunedì"_**, one ❤️ |

⚠ **Whose work the _"porcherie"_ were is not established.** Aurel Mrruku's phrasing
was _"il nostro fabrizio"_, which would mean Fabrizio Mastracci (ROMI), while the
surrounding exchange — edition mapping, wanting more tests, the call to stop him —
is about Fabrizio Paganelli (Pienissimo). **Both readings fit the text and neither
is confirmed. No attribution is made here.**

## Why it is an open item and not housekeeping

1. 🔴 **It removes four of the client's remaining working days in Prod.** The user
   go-live is 16 November; Elena Spini's own point — _"prima di andare live
   ovviamente deve fare tutto il giro"_ — is that his end-to-end pass still has to
   happen, and 9-11 November is also the training window
   ([OI-300](OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)),
   with the migration on 12-13 November.
2. 🔴 **Nothing was sent to the client in writing.** The block was conveyed by
   telephone. No mail in this window states it, so the only record is this DM.
3. 🔑 **It collides with the data ROMI is waiting for** — _"ci devono fornire i
   datti entro venerdì"_, i.e. **6 November**, while the person who supplies it is
   the one being kept out of the system.
4. ⚠ **It is the mirror image of the client testing in Prod.** The production org is
   simultaneously the migration target, the client's test environment and the live
   system, which is the condition that produced
   [OI-315](OI-315%20Production%20test%20records%20cannot%20be%20deleted.md) and
   [OI-313](OI-313%20The%20ticket%20nomination%20email%20fired%20for%20assets%20still%20in%20ordinato.md).
   Aurel Mrruku states the consequence himself: _"poi devo cancellare tutto …"_.
5. ⚠ The Mexal API calls were deliberately switched off for the load, and
   [the consent flow was deactivated](../flows/The%20Update%20Contact%20Consent%20flow%20in%20production.md)
   for the same reason. 🔴 **No record says the API side was switched back on.**
