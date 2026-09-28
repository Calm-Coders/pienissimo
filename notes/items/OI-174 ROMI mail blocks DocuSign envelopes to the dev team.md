---
id: OI-174
type: open-item
status: open
owner: Aurel Mrruku
with: Angelo Pastorelli
org: ROMI
raised: 2026-09-23
updated: 2026-09-24
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

## 🟢 2026-09-24 — the question is answered: client-domain recipients are unaffected

**The test this note asked for happened, in front of the client, by accident rather than
by design.**

At [UAT: Lead e Opportunità](../meetings/2026-09-24%20UAT%20Lead%20e%20Opportunita.md)
`01:31:50`, Aurel Mrruku sent a quote and asked Fabrizio Paganelli
(`fabrizio.p@pienissimo.com`) to check his mail:

> **Fabrizio Paganelli:** _"Sì, l'ho ricevuta."_

He signed in the DocuSign test environment and at `01:45:31` received the completed PDF —
_"il PDF del preventivo firmato"_ — which reached Aurel Mrruku as well.

🟢 **So the block is ROMI-side only.** This is a developer nuisance, not a demo blocker,
and the 24/09 session was not at risk from it. The trigger armed on 23/09 —
_"if the next run finds no test to a client-domain address, say that the signature step
was demonstrated on faith"_ — **is discharged by evidence, not by assumption.**

🔴 **The ROMI-side block is unchanged and was reconfirmed live.** Elena Spini, same
passage: _"ci ha scritto anche Elisa, e gli abbiamo dato l'utenza di Aurel, la M di
Aurel, però non è stato ricevuto niente."_ Nothing records the gateway question reaching
Danilo, or anyone.

### 🔑 Why the DocuSign credentials never arrived

The same passage explains a gap the record has carried since 21/09. Aurel Mrruku:

> _"Siccome non ci avete ancora fornito un'utenza DocuSign, abbiamo mandato una mail, ma
> non abbiamo ancora un'utenza, abbiamo creato noi una utenza di test in ambiente di test
> per testare"_

Elisa Migliano, `01:33:14`:

> _"A me serviva l'ID per compilare il contratto e io infatti l'ho preso e l'ho compilato,
> però non sapevo altri, cioè io non sapevo dovessi darvi le credenziali, tutto qua."_

🔑 **The hand-off never happened because nobody told her it was hers.** The client's
DocuSign contract arrived on 21/09; the credentials were never requested of the person
holding them. Everything demonstrated on 24/09 ran on a **ROMI-created test account in the
DocuSign demo environment**, so the production swap is still owed.

## Open

- 🔴 **Get the ROMI mail gateway to release DocuSign mail** — now a developer-productivity
  item rather than a UAT blocker.
- 🔴 **Ask Elisa Migliano for the DocuSign credentials.** She now knows they are owed;
  nothing records them being sent.
- 🔴 **The production DocuSign swap is unbuilt and untested.**
