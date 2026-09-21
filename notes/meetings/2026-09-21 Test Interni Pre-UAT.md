---
id: meeting-2026-09-21-test-interni-pre-uat
type: meeting
status: resolved
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-21
updated: 2026-09-21
source: Gemini notes doc 1PgRNilAaz9Ew5erzfYbmTcKjHEaGjuObl5NTDXyLHeg (read in full)
---

# 2026-09-21 Test Interni Pre-UAT

**ROMI only, 1h18m, 21/09 16:48 CEST.** Aurel Mrruku, Elena Spini, **Anita Aga**,
**Rexhina Hysi**. The first internal end-to-end walkthrough before UAT, three days
before the client sees the platform.

⚠ **Two artifacts exist for this booking.** A first 16:00 recording produced no
usable notes — _"non c'era abbastanza conversazione in una lingua supportata"_,
and its transcript ends after 10m34s — because the team was still in the client
WooCommerce call. **The 16:48 recording is the session.** A `Parte 2` was booked
for 22/09 17:00–18:00.

## Agreed

- 🔑 **Two Lead record types, `diretta` and `standard`**, to simplify the working
  path (`00:06:24`).
  → [OI-149](../items/OI-149%20Two%20Lead%20record%20types.md)
- 🔑 **The Opportunity type is determined from a picklist on the Lead**, read at
  qualification (`00:27:41`). This is the selection mechanism
  [OI-140](../items/OI-140%20Three%20Opportunity%20record%20types.md) lacked.
  → [OI-150](../items/OI-150%20Opportunity%20type%20comes%20from%20a%20Lead%20picklist.md)
- **The quote's shipping address is set equal to the billing address by a trigger
  at creation** (`00:32:12`).
- 🔑 **A signature step is added after acceptance** — a `firmato` flag and a
  `signed by` field — before the contract counts as concluded and the order is
  generated (`00:45:34`). Anita Aga and Rexhina Hysi own the fields.
  → [OI-151](../items/OI-151%20Quote%20signature%20step%20before%20the%20order%20is%20generated.md)
- **Quote and order are one-to-one**, and the order's lookup to the Opportunity is
  populated by resolving the opportunity id **through the quote**. Aurel Mrruku's
  closing decision: order-to-opportunity links are mapped systematically via quote
  ids (`00:58:59`, `01:01:03`).
- **Lead conversion uses custom trigger logic, not the standard component**, with
  deduplication (`01:21:18`).
- **Test precondition for order creation**: quote `accettato`, opportunity
  `in trattativa` (`01:09:17`).

## What broke, and what it explains

🔑 **The `QuoteTrigger` exceptions in the mailbox are this session.** A trigger
error blocked quote creation and order generation; Rexhina Hysi traced it to the
quote trigger and asked Anita Aga to deploy the handler and the trigger; **Aurel
Mrruku identified a before-save error caused by a non-existent method**
(`01:15:45`).

Two `info@salesforce.com` exception mails arrived from the **partial sandbox** at
**21/09 16:01:14Z and 16:04:35Z** (18:01 and 18:04 CEST):

> `QuoteTrigger: execution of BeforeInsert / BeforeUpdate caused by: line 8,
> column 25: Method does not exist or incorrect signature: void beforeSave(List<Quote>,
> Map<Id,Quote>) from the type QuoteTriggerHandler`

The resolution sits at `01:15:45` into a session that began 16:48 CEST — about
18:04. **The timestamps match exactly.** So the cause is a **partial deploy: the
trigger was deployed without the handler method it calls**, and it was fixed
during the session. Not a live defect — but it is a trigger deployed broken into
the environment the client tests in three days.

🔴 **A permissions problem was worked around with credential sharing.** Elena
Spini could not see quote fields as her own user; Aurel Mrruku found the user
lacked full permissions. Rexhina Hysi offered to assign them; **Aurel Mrruku
instead told Elena Spini to log out everywhere and log back into the sandbox
using his own user** (`01:04:54`, `01:07:02`). It restored visibility. ⚠ It is
also the pattern that cannot be used in UAT, where client users log in as
themselves, and it is the same permission-set gap
[OI-117](../items/OI-117%20Administrative%20fields%20lock%20once%20the%20Mexal%20customer%20code%20is%20set.md)
records.

🔴 **A quote-creation error was attributed to community guest-user permissions**
by Rexhina Hysi (`01:12:44`), and worked around by setting the quote to accepted
and clicking the email link. Unresolved. ⚠ Two days earlier
`QuoteTriggerHandler` was changed to `without sharing`
([OI-156](../items/OI-156%20QuoteTriggerHandler%20runs%20without%20sharing.md)) —
the two facts are adjacent and nobody has connected them in writing.

🔴 **Lead conversion breaks when an existing P.IVA is reused on the same account**
(`01:19:19`). Discussed, not resolved.

## Also recorded

- 🔴 **DocuSign credentials are still owed by the client.** Aurel Mrruku is to
  send a reminder on 22/09; the session notes _"si attende la configurazione di
  DocuSign da parte del cliente"_ (`00:46:58`). ⚠ In the same day Elisa Migliano
  wrote that **the DocuSign contract had arrived** and asked for the Salesforce
  account id to put in it, and Elena Spini supplied the production technical
  user. So procurement is in motion and the credentials are the remaining step.
- **Quote expiry is 5 days**, and **an automatic task fires after two days if the
  quote is not accepted** (`00:50:28`). Anita Aga and Rexhina Hysi are to
  configure task creation for quotes not accepted within their terms.
- **An order reaches `chiusa vinta` once payment is received (`incassato`)** —
  Elena Spini (`00:48:40`). The concept remains central to the flow even after the
  guest-facing button was removed
  ([OI-136](../items/OI-136%20Public%20participant%20link%20can%20mark%20an%20order%20Incassato.md)).
- **Rexhina Hysi proposed a direct button in the HTML email template** to reach
  the community quote page; Elena Spini approved (`00:44:28`).
- Contracts reviewed: _"un anno Pienissimo"_ and its `plus` variants, checking
  paragraph consistency in the generated documents (`00:38:12`).
- Tranches were created on the quote with the due date in the tranche name
  (`00:33:32`).
- Elena Spini reported a label-tooltip display problem on the opportunity path.
- Aurel Mrruku is to surface **order display and management on the Account page**.
- Elena Spini is to ask **Fabrizio Mastracci** about Marketing Cloud template
  modules for lead creation (the notes say _"Fabrizio Romi di Marketing Cloud"_;
  the identification as Fabrizio Mastracci is **inferred** from his owning the MKT
  flows, and no other Fabrizio at ROMI appears in this record).
- Aurel Mrruku may build an HTML page to test lead creation if needed.

## Next day

Objectives set for 22/09: a call with **Mirko Merendi** to verify the API flow,
payloads, and normal and bundle orders against Mexal, and **to change the causale
from 1 to 10** (`01:17:38`) — which is Mirko Merendi's own 11 August instruction
for test use, recovered at
[the 11:02 Mexal internal](2026-09-21%20Interna%20Temi%20Mexal.md).

⚠ The notes conflate two bookings. The calendar shows **`Test Mexal` 22/09
15:00–17:00** with Mirko Merendi and Kreosoft, and **`Test Interni Pre-UAT - Parte
2` 22/09 17:00–18:00** internal.

⚠ A real test email address and a P.IVA appear in the notes. **Neither is recorded
here.**
