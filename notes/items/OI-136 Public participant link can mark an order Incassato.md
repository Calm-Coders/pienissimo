---
id: OI-136
type: open-item
status: in-progress
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-15
updated: 2026-09-21
depends_on: [OI-78, OI-86]
blocks: [go-live]
requirement: [BIG-18, INT-16, ORD-01]
source: org-status-check against Pienissimo UAT 2026-09-15 08:37-08:47Z; source read on DevMain at f51365b
evidence: force-app/main/default/classes/ParticipantRegistrationController.cls:1,193-236; force-app/main/default/lwc/participantRegistrationPage/participantRegistrationPage.html:184
---

# OI-136 - Public participant link can mark an order Incassato

**Anyone holding a participant invitation link can move the linked Salesforce
Order to `Incassato` from a public page, with no login.** This is now on
`DevMain`, not only in the org.

## What is built

`ParticipantRegistrationController` is declared `public without sharing`
(line 1) and exposes an `@AuraEnabled` method `markOrderIncassato(String token)`
(line 193). The method resolves the invitation from the token, collects the
Orders linked to that invitation's visible Assets, and issues:

```apex
new Order(Id = orderRecord.Id, Status = 'Incassato')
```

The participant registration LWC renders the button as **"Segna ordine
incassato"** (`participantRegistrationPage.html:184`), shown whenever
`canMarkOrderIncassato` is true — which `buildPage` sets for any visible ticket
whose Order is not already `Incassato` (line 361).

The page is the public participant landing reached from the invitation URL, so
the caller is the Landing Page guest user, not a named Salesforce user.

## What is and is not the weakness

🟢 **The token itself is strong.** `EventInvitationService.generateToken()` is
`EncodingUtil.convertToHex(Crypto.generateAesKey(256))` — 64 hex characters from
a cryptographic RNG. It is not guessable, and it is a real improvement on the
raw `AccountId:CampaignId` key it replaced
([the batch note](../objects/Aurel%20requested%20the%20participant%20invitation%20batch.md)).

🔴 **The weakness is what the token authorises and for how long.**

1. **`Incassato` is a payment state, not a participant-data state.** Every other
   action on this page writes participant details or sets a ticket to
   `Rinuncia`. This one asserts that an order has been collected. Nothing in the
   record says a customer-side actor was ever meant to set it.
2. **The token does not expire and cannot be revoked except by regenerating it**,
   which invalidates the link already sent. It rides in a URL query parameter, so
   it reaches browser history, referrer headers, proxy logs and any forward of
   the invitation mail.
3. **`without sharing` plus guest access means no record-level check applies**,
   and the action leaves no attribution: the Order shows the guest user, so
   "who marked this collected" is unanswerable.
4. **It is not one order.** `collectLinkedOrderIds` gathers every Order behind
   the invitation's visible Assets, so one click can move several.

## What a person must decide

1. **Should the public page be able to set `Incassato` at all?** If the intent
   was "the referent confirms they have paid", that is a different state and a
   different word. If it was a convenience for internal staff, it does not belong
   on the guest page.
2. **If it stays, what bounds it?** An expiry on `Token__c`, a one-shot
   consumption, or a separate confirmation state that amministrazione promotes to
   `Incassato`.
3. **Who is accountable for the resulting figure?** `Incassato` is the terminal
   state of the order lifecycle agreed on 2026-08-06
   (`Ordinato -> Fatturato -> Incassato`), and **Elisa Migliano is the operational
   authority on administration and invoicing** and has not been asked.

## This is the fourth instance of one pattern

It belongs with
[the community-authentication risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md),
which has tracked the same shape since 3 September. PR #44 **half-fixed** that
risk's first surface and **widened** it at the same time: the participant page's
five entry points now take a token instead of raw ids, but the token is opaque
rather than signed or expiring, and one of the five is a new write to order
payment state. `QuoteAcceptanceController` is untouched — still
`public without sharing`, still `loadPage(String quoteId)` and
`submitAction(String quoteId, String action)` on a bare record id.

⚠ **Not yet raised with anybody.** This was found by the 2026-09-15
`org-status-check` against UAT, which reported it to the dev group as its most
severe non-matching finding, and confirmed here by reading the merged source on
`DevMain`. **No swept source shows it being discussed by a human**, and no
decision is recorded either way.

## Relation to the register

- **BIG-18** still describes the landing page as "reached by a link carrying the
  Account ID". The build replaced that with the token on 2026-09-15 (PR #44) —
  see the dated supersession recorded against BIG-18 in the register and in both
  prose documents.
- **INT-16** is the unresolved "id in clear vs signed token" question for the
  WooCommerce checkout link. The participant page has now adopted a random
  opaque token — **not a signed one** — while the checkout link still sends the
  Opportunity id in clear. The same trade-off is now live in two places and has
  been decided aloud in neither.

## 🟢 2026-09-16 - the button was removed, on a branch, by nobody's stated decision

**`4132dab` (Rexhina Hysi, 16/09 09:24:55 CEST, `DEV_ComponentBundle`),
commit message `remove incasato button`.** 78 lines out of the controller, 37
out of the LWC JavaScript, 10 out of its template — **3 insertions, 122
deletions**.

It is a **complete** removal of the write path, not a hidden one:

- `@AuraEnabled markOrderIncassato(String token)` — deleted in full, with its
  savepoint, its `FOR UPDATE` query and its `update ordersToUpdate`.
- `collectLinkedOrderIds` — the helper that gathered *every* Order behind the
  invitation, the multiple-order problem of point 4 above — deleted.
- `PageResponse.canMarkOrderIncassato` and the loop in `buildPage` that set it —
  deleted, so the flag no longer reaches the page at all.
- The **"Segna ordine incassato"** button and its handler — deleted from the
  template and the controller.

No `Order` DML of any kind remains in `ParticipantRegistrationController`. The
page keeps what it was for: participant details and `Rinuncia`.

### 🔴 But it is not on `DevMain`, and no pull request proposes it

`4132dab` is on **`DEV_ComponentBundle` only**. As at 16/09 22:00 CEST GitHub
lists **no pull request** from that branch — the open PR is **#47**, from
`DevAnita`, unrelated. The branch has since taken three more commits
(`b834c51`, `65818d0`, `01c40e6`, `46d22c5`) on bundles, the quote acceptance
email and quote PDF generation, so the fix now travels with unrelated work.

**The guest-reachable write to `Order.Status` is still on `DevMain` and still in
UAT tonight.** This row stays open until the removal merges.

⚠ The branch is behind `DevMain` — it does not yet carry PR #45 or the 15/09
knowledge commit. That is an ordinary base merge, not a loss: a pull-request
merge is three-way and will not delete the notes it lacks. It does mean
**somebody must merge `DevMain` in before this can be reviewed cleanly.**

### ⚠ Why it happened is not recorded anywhere

The sequence is: this row and the 15/09 `requirements-check` report were written
at **23:51 CEST on 15/09**, into the dev group `C0BQD34LLF4`; the removal
commit is **09:24 CEST the next morning**, nine and a half hours later. That
ordering is suggestive and **it is all there is**. Nobody replied to the report,
no message on any swept channel mentions the button, the commit has no
description, and there is no pull request to carry one.

**So the second 15/09 trigger has half fired.** It asked for any source showing a
human *discussing* the button — approving it, questioning it, or using it. What
arrived is a human **acting** on it, silently. The engineering problem is
answered; **the question this row actually asked is not**:

- Nobody decided whether a customer-facing actor should ever assert that an
  order is collected. The capability was removed, not ruled on.
- **Elisa Migliano still has not been asked**, and she is the operational
  authority on invoicing.
- If the intent was ever _"the referent confirms they have paid"_, that need is
  now unserved and unrecorded, and will come back as a change request.

⚠ **Attribution:** the removal is Rexhina Hysi's, from the commit. **That the
report caused it is inference from timing and from nothing else.** Do not record
it as cause.

### Unchanged

🔴 **`QuoteAcceptanceController` is still `public without sharing` on a bare
`quoteId`**, and a live URL of exactly that shape — `/gestione-preventivo?quoteId=…`
with a raw 18-character Quote id — was pasted into Slack on 16/09 at 14:21 CEST.
The token pattern was applied to the participant page and **not** to the quote
page. The asymmetry this row and
[the authentication risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md)
describe is unchanged, and is now demonstrable from a link anybody in that DM can
click.

## 🟢 2026-09-17 - the removal reached `DevMain`, and the guest-reachable write is gone

**PR #48** (`Dev component bundle`, Rexhina Hysi, `DEV_ComponentBundle` →
`DevMain`) was opened at **12:54:26Z** and **merged at 14:29:39Z** as `f3b3837`.
It carries `4132dab` — the removal — together with five other commits of
unrelated bundle, quote-PDF and rinuncia work, exactly as this row predicted it
would.

Verified on `origin/DevMain`:

- `4132dab` is an ancestor of `DevMain`;
- **no `markOrderIncassato` or `canMarkOrderIncassato` anywhere in
  `force-app/`**;
- **no `"Segna ordine incassato"` button** remains in source — the only
  surviving occurrences are in this repository's own notes and recaps;
- `Incassato` survives only where it belongs: the `OrderStatus` standard value
  set, `OrderTriggerHandler`'s `CONFIRMED_STATUS`, `WoocommerceOrderService`'s
  `CREATED_STATUS`, and the trigger tests.

🔴 **What is closed is the code path, not the question.** Nobody has ruled on
whether a customer-facing actor may ever assert that an order is collected.
**Elisa Migliano still has not been asked**, and if the intent was ever _"the
referent confirms they have paid"_, that need is now unserved and unrecorded. A
merge is not a decision.

🔴 **`QuoteAcceptanceController` is still `public without sharing`** on a bare
`quoteId`, unchanged by any of today's five merges. The asymmetry this row
describes survives the fix.

⚠ **UAT still has the old code.** This is repository arithmetic against
`origin/DevMain`; **the org was not opened**, and the last org record is
2026-09-14. Nothing here shows the removal deployed.

## 🔑 2026-09-18 - the administrative need was scoped once and dropped

**The underlying need has a name now, and it was abandoned in the same breath.**

At [the 18/09 internal](../meetings/2026-09-18%20Interna%20Temi%20Mexal.md) Elena
Spini walked Aurel Mrruku through her earlier design for it: **a button on the
Asset, visible only once the asset is available and only to amministrazione
users**, to correct an incasso booked against the wrong tranche — _"serve per
correggere loro sbaglio di una fattura pagata in relazione a una trancia
errata"_. Stated frequency: **20–30 times a year**.

Aurel Mrruku objected on two grounds: **the asset is not always a product** (a
Performance Plus order is one product paid in x instalments, so there may be no
asset at all), and **the asset hangs off the offer, not the order**, so reaching
the tranches from it means a detour.

Elena Spini then dropped it: _"lo lascerei… se lo devono fare a mano, cioè punto"_
and _"lo lascio perdere, lo cancello."_

🔴 **So the record now holds a complete account of this need being designed,
costed, objected to and set aside — with no client in the room and no client
decision.** Elisa Migliano is the operational authority on invoicing and **still
has not been asked**, six days after the code that did it in the wrong place was
deleted. The trigger stands: *the code is gone; nobody ruled.*

⚠ And the concept is not going away. At
[the 21/09 pre-UAT session](../meetings/2026-09-21%20Test%20Interni%20Pre-UAT.md)
Elena Spini restated that **an order reaches `chiusa vinta` once payment is
received (`incassato`)** (`00:48:40`). The state matters; only the guest-facing
button is gone.

⚠ The adjacent reversal case — credit notes and storni — is in the same condition:
→ [OI-157](OI-157%20Credit%20notes%20and%20storni%20are%20unbuilt%20and%20undefined.md)
