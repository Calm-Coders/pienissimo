---
id: meeting-2026-09-23-test-pre-demo
type: meeting
status: active
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-23
updated: 2026-09-23
depends_on: [OI-164, OI-174]
uncertain: the transcript is machine-garbled; nothing here is a quotable attribution
source: Google Drive, "Pienissimo test Pre Demo - 2026/09/23 16:35 CEST - Transcript"
---

# 2026-09-23 - Test Pre Demo

**1h33m internal dress rehearsal for the 24/09 Lead UAT.** Aurel Mrruku, Anita Aga and
Rexhina Hysi. Called in the dev group at 16:34 CEST — _"bejm 1 mbledhje per recap per
neser ?"_ — and run 16:35–18:09 CEST.

## ⚠ The transcript is not usable as evidence

The session was held in Albanian and Italian; the automatic transcription rendered it as
English word-salad (_"Gotch. opportunity."_, _"Mercy guest. Say those get user the bug."_).
**No sentence in it can be attributed to a speaker with confidence, and no decision can be
read out of it.** It is recorded here because the artifact exists and because two threads
are legible from the surrounding vocabulary alone — both of which are corroborated
independently, and **only the corroboration is relied on**.

## What the session was, on independent evidence

1. **A full walk of the demo path** — the recurring vocabulary is lead → account →
   contact (`is primary`, duplicates on `romicompany.com`) → opportunity → quote
   (`preventivo`) → DocuSign envelope. That is precisely the 24/09 UAT agenda:
   `Lead diretta/standard` and `Opportunità vendita standard + preventivo DocuSign`.
2. 🔴 **DocuSign envelopes did not arrive.** The legible fragments cluster on
   `envelope recipient address`, `deliverability`, `spam promotions` and repeated
   frustration. **Independently corroborated 3 minutes after the call ended**: Aurel
   Mrruku in `#team-romi-tech`, 18:12:11 CEST — _"La posta di romi mi sta bloccando le
   mail di docusign. a me e anche a Rexhina Hysi. A chi possiamo chiedere?"_ →
   [OI-174](../items/OI-174%20ROMI%20mail%20blocks%20DocuSign%20envelopes%20to%20the%20dev%20team.md)
3. ⚠ `guest user handler` appears in the fragments, consistent with the checkout-link
   guest path, but nothing corroborates that it was tested. **Not recorded as a fact.**

## What happened immediately afterwards

- **18:28:13 CEST**, Elena Spini to Aurel Mrruku by DM, after trying the build:
  _"grazie per aver messo i colori e resto tutto + carino MA 2 cose però: 1. il rt è
  sempre blank 2. dal rt Diretta mi aspetto solo 2 status (new/qualificato) del lead
  (avevamo detto possiamo togliere anche il path e ciao)"_ →
  [OI-164](../items/OI-164%20Web%20to%20Lead%20leads%20arrive%20without%20a%20record%20type.md)
- **18:47:45 CEST**, Aurel Mrruku: _"domani in mattinata fanno le ragazze che mi stavo
  occupando di docusign."_ The record-type fix is handed to the developers **for the
  morning of the UAT day**.
- **18:40 and 18:47 CEST**, Anita Aga (`7d0f990`, PR #57) and Rexhina Hysi (`7eab757`)
  pushed the evening's work. Neither is on `DevMain` at the time of this sweep.
