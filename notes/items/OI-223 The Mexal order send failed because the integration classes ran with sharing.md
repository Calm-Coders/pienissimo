---
id: OI-223
type: open-item
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-10-08
updated: 2026-10-08
depends_on: [OI-134]
source: notes/meetings/2026-10-08 Internal Test.md
---

# OI-223 - The Mexal order send failed because the integration classes ran with sharing

**Orders stopped reaching Mexal with an access error, not a mapping error: the
integration classes declared `with sharing`, so the executing user had no
visibility on the class that sends the order. Aurel Mrruku found it live at the
08/10 internal session and changed the sharing mode across roughly forty classes
the same morning.**

## The evidence by mail

Two Salesforce sandbox exception mails arrived from the Pienissimo Partial
Sandbox on 08/10, before the session's fix:

| Time (UTC) | Trigger | Error |
| ---------- | ------- | ----- |
| 09:33:59 | `OrderTrigger` AfterInsert | `INSUFFICIENT_ACCESS_ON_CROSS_REFERENCE_ENTITY` on an Order, at `OrderMexalIntegrationService.markOrdersQueued` line 376 |
| 09:44:48 | `QuoteTrigger` AfterUpdate | `CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY`, wrapping the same `OrderTrigger` failure, via `QuoteTriggerHandler.createOrdersForSignedQuotes` line 209 |

Both chains end in the same place: `markOrdersQueued` cannot update the Order it
was handed. (Record ids are not reproduced here.)

## The diagnosis

From [the session](../meetings/2026-10-08%20Internal%20Test.md): Aurel Mrruku
_"ha identificato un problema nel server di integrazione […] causato dalla
presenza del modificatore `with sharing` invece di `without sharing`, il quale
impediva all'utenza di avere la visibilità necessaria sulla classe di invio
degli ordini"_.

⚠ **Elena Spini had read the same failure as DocuSign missing from order
creation.** Aurel Mrruku established the cause was the Mexal callout and the
class's sharing mode. Recorded because the wrong reading was in the room first.

## The fix

Four commits by Aurel Mrruku on 08/10 between 11:58 and 12:29 CEST, all titled
_"without sharing class"_ — `6c9bfe2`, `6101790`, `9e3f901`, `f292b72` — all in
`DevMain`. They flip `with sharing` to `without sharing` across the integration
stack: the Mexal sync, search, invoice, order-send and logger classes, the
Anticipay services, the Account, Opportunity, Order, OrderItem and
BundleComponent trigger handlers, and the bundle and quote controllers —
roughly forty classes.

## Why it stays on the record after being resolved

🔴 **This is a broad change to the sharing model, made in four rapid commits on
the day of a client e2e session, with no test run.** `without sharing` means
those classes no longer enforce the running user's record access. For the
controllers invoked from a community page — `BundleProductAssignmentController`,
`BundleTranchController`, `OrderAssetsController` — that widens what a guest or
low-privilege user's request can reach. **Nothing in this sweep verified the
blast radius**, and the Prod deploy is due on the **13/10** confirmation.

⚠ Noted as a fact of the diff and not acted on: the standing instruction
forbids writing or proposing Apex tests. The coverage gap this change sits in is
[OI-64](OI-64%20The%20bundle%20Apex%20test%20suite%20is%20broken.md) and
[OI-66](OI-66%20No%20test%20classes%20for%20the%20Biglietto%20stack.md).
