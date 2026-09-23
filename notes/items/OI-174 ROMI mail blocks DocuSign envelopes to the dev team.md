---
id: OI-174
type: open-item
status: open
owner: Aurel Mrruku
with: Angelo Pastorelli
org: ROMI
raised: 2026-09-23
updated: 2026-09-23
blocks: [go-live]
severity: gating
source: Slack #team-romi-tech C0A43NQLZ24, Aurel Mrruku 2026-09-23 18:12:11 CEST
---

# OI-174 - ROMI mail blocks DocuSign envelopes to the dev team

**Found during the internal dress rehearsal for the Lead UAT**, and reported three
minutes after the call ended.

> **Aurel Mrruku**, `#team-romi-tech`, **23/09 18:12:11 CEST**:
> _"@here La posta di romi mi sta bloccando le mail di docusign. a me e anche a
> @Rexhina Hysi. A chi possiamo chiedere? Grazie"_

**Angelo Pastorelli**, 18:50:40 CEST: _"Chiedi a Danilo"_. ⚠ Nothing in this record says
the question reached anyone named Danilo, or that anything was changed.

## Why it matters tomorrow

🔴 **`Opportunità: vendita standard + preventivo DocuSign` is the second half of the
24/09 UAT session**, 15:00–17:00 CEST, with the client in the room. The signature step
cannot be demonstrated if the envelope never lands in the recipient's inbox.

- It affects **at least two ROMI accounts** — Aurel Mrruku's and Rexhina Hysi's — so it
  is a mail-gateway policy, not one mailbox's spam folder.
- ⚠ **Whether it also affects a `@pienissimo.com` recipient is untested.** If the block
  is ROMI-side only, a client-addressed envelope may be unaffected — and the UAT sends to
  the client. **Nobody has checked**, and the difference decides whether this is a demo
  blocker or a developer nuisance.
- 🟢 The chain itself works: quote → DocuSign → signed → order ran end to end in the
  21/09 pre-UAT session, and the DocuSign metadata is on `DevMain` (PR #54, PR #56).
  **This is delivery, not logic.**

## Open

- 🔴 **Get the ROMI mail gateway to release DocuSign mail before 15:00 CEST on 24/09.**
- 🔴 **Test one envelope to a client-domain address** so the UAT risk is known rather
  than assumed.
