---
id: RISK-sandbox-password-in-transcript
type: risk
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-08
updated: 2026-09-08
severity: high
source: notes/meetings/2026-09-08 Flussi MKT Parte 2.md
---

# Risk - a sandbox password was spoken aloud and preserved in a meeting transcript

**A Salesforce UAT sandbox password was read out in a recorded meeting on
8 September and transcribed verbatim by Gemini into a Google Drive document. A
second person then signed in under the credential's owner rather than under their
own user. The value is not reproduced in this repository.**

## What happened

In [Flussi MKT Parte 2](../meetings/2026-09-08%20Flussi%20MKT%20Parte%202.md),
Fabrizio Mastracci needed sandbox access and One Password would not release the
entry — it held only the MKT and production items, not the sandbox. To unblock
him, **Elena Spini spoke Aurel Mrruku's UAT sandbox password aloud**, prefacing it
with _"che siamo impazziti con il tema degli accessi"_.

Fabrizio Mastracci signed in and worked in the sandbox for the rest of the call.

## What the exposure actually is

| | |
| --- | --- |
| **Credential** | a Salesforce **UAT sandbox** user password belonging to Aurel Mrruku |
| **Channel** | spoken on a recorded Google Meet |
| **Where it now lives** | the Gemini transcript document on Drive, **and** the meeting recording, both shared with the meeting's invitees and reachable from the calendar event |
| **Not affected** | production — `pienissimo.my.salesforce.com` has never been deployed to |

⚠ **The transcript is the durable part.** A password said in a call decays; a
password typed into an auto-generated document that is indexed, shared and linked
from a calendar invitation does not. Nobody in the call appeared to notice it was
being transcribed — Aurel Mrruku had checked earlier in the same session whether
the transcript was running.

🔴 **The password is weak and structurally guessable.** Its form is a short
company-derived word, a digit run and one punctuation mark. It is not a
high-entropy secret that happens to have leaked; it is one that a list attack
reaches anyway. **This note deliberately does not record the value** — see
[docs/publishing.md](../../docs/publishing.md).

## Shared login, not a shared org

The more durable finding is that **Fabrizio Mastracci has no user of his own** in
the Pienissimo sandbox. Elena Spini's instruction was explicit — _"usa quello di
Aurel"_ — and both sandboxes were reachable that way.

Consequences that outlast the password:

- **Audit trail.** Everything Fabrizio Mastracci does in UAT is attributed to
  Aurel Mrruku. The org check reads `LastModifiedBy` as evidence; it is now
  wrong for an unknown set of records.
- **Utenti and Profili are still an empty section of the data-model workbook**,
  unopened across four sessions
  ([OI-24](../items/OI-24%20Data%20model%20workbook.md)). Nobody has designed who
  gets a user, so the answer in practice is that people borrow one.
- **Permission sets already reach one user each** against eight active users, a
  standing finding from three consecutive org checks.

## Where this sits in the pattern

This is the **second** credential disclosure in five days and the **fourth**
authentication finding in six:

| Date | Finding |
| ---- | ------- |
| 03/09 | community pages accept a bare record id — [no application-level auth](Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md) |
| 04/09 | WooCommerce JWT credentials circulated in plaintext on two channels, `exp` ~60 years out — [the risk](Risk%20-%20Salesforce%20integration%20credentials%20were%20circulated%20in%20plaintext.md) |
| 02/09 | one static Anticipay bearer token serves both environments — [OI-106](../items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md) |
| **08/09** | **a sandbox password spoken into a transcript, and a shared login** |

⚠ **The 04/09 risk asked for rotation "before this pattern reaches production".
Production is now closer, not further**: the client has been given a 21 October
go-live and a first production deploy is estimated at two weeks
([OI-134](../items/OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md)).

## What to do

1. **Rotate the sandbox password.** Cheap, and it ends the transcript exposure's
   usefulness.
2. **Give Fabrizio Mastracci his own user** with a permission set scoped to what
   the marketing work needs. This is the fix; rotation alone leaves the next
   person borrowing a login.
3. **Decide what happens to the transcript and recording.** Deleting them
   destroys the only record of a session this note itself relies on, so the
   sensible order is rotate first, then decide. **This sweep did not touch either
   file** — every external source is read-only.
4. **Do not treat this as closed by rotation** while Utenti and Profili remain an
   empty section of the workbook.
