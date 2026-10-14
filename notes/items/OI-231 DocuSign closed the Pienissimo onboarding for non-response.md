---
id: OI-231
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: Pienissimo
raised: 2026-10-13
updated: 2026-10-14
blocks: [go-live]
severity: gating
source: Gmail thread 1a135af854a55901, 2026-10-13T14:34:16Z
---

# OI-231 - DocuSign closed the Pienissimo onboarding for non-response

**DocuSign's onboarding consultant closed the Pienissimo onboarding project on
13 October because nobody answered her, and handed the account to the Account
Team. Pienissimo's administration forwarded the notice to ROMI the same
afternoon asking whether it was needed — eight days before go-live, and on the
same day the client signed a quote through DocuSign in the UAT session.**

## What arrived

**Mavi Carone** (Onboarding Consulting, DocuSign), to
`amministrazione@pienissimo.com`, cc `lorenzo.laurita@docusign.com`,
**2026-10-13 10:25 CEST**:

> _"Ho provato a contattarvi riguardo al progetto di onboarding, ma non ho
> ricevuto risposta. Pertanto, completerò il progetto di onboarding e passerò la
> gestione del tuo account all'Account Team in copia. Se si tratta di un errore
> e desideri procedere con il tuo onboarding, ti prego di metterti in contatto
> con noi e ti guideremo attraverso i prossimi passaggi."_

Forwarded by `amministrazione@pienissimo.com` at **14:34:16Z** to Aurel Mrruku
and Elena Spini, **cc Sabatino Rinaldi**, with one question:

> _"abbiamo ricevuto questa mail che riportiamo in crono. Vi è necessaria per la
> configurazione di Docusign?"_

⚠ **The client does not know whether it mattered.** That is the finding as much
as the closure is.

## 🟢 What it confirms

A **production DocuSign account exists** in the name of PIENISSIMO SRL, with a
production account number stated in the mail. 🔑 That settles a question open
since June, when Elena Spini asked ROMI for a DocuSign contact so Pienissimo
could buy licences, and July, when the client wavered — _"forse non vogliono
DocuSign"_ — against Sabatino Rinaldi's telephone confirmation that they were
proceeding. **The licences were bought.** The account number is deliberately not
copied here.

## 🔑 And it is in use, today

At [the 13/10 Feedback Test UAT](../meetings/2026-10-13%20Feedback%20Test%20UAT.md)
Fabrizio Paganelli sent a quote for acceptance, opened the DocuSign mail, signed,
and the Quote completed and produced an Order. **The signature path works
without the onboarding.** So the closure is not an outage.

🔴 **What it costs is the vendor-side support**, at the worst moment: go-live
**21/10**, the Zoho contract ending **31/10**, and
[the 2,500-envelope plan](OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)
still with no plan document behind the figure. ⚠ Envelope volume, templates and
production configuration are exactly what an onboarding engagement covers, and
there is no record of any of the three being set up.

## Open

- 🔴 **Answer the client's question.** Owner: Elena Spini. The mail is addressed
  to her and Aurel Mrruku, with Sabatino Rinaldi copied, and has no reply in any
  source.
- 🔴 **Decide whether to reopen the onboarding.** The mail says to contact them if
  the closure was a mistake. Nobody has.
- ⚠ **No record of DocuSign production configuration** — templates, branding,
  sending identity, envelope allowance. The signature worked in the test; what it
  used is not established.
- ⚠ **Whether the envelope allowance covers the ticket volume.** OI-194 puts the
  figure near 2,500 with no document behind it.

## 🔴 2026-10-14 — ROMI read it, discussed it internally, and still has not answered the client

Elena Spini raised it with Aurel Mrruku in a DM at **08:31 CEST**:

| Time | Who | What |
| --- | --- | --- |
| 08:31:17 | Elena Spini | _"la mail di Elisa >> Completamento dell'Impegno di Onboarding di Docusign \| PIENISSIMO SRL"_ |
| 08:31:32 | Elena Spini | _"tutto ok no? non dobbiamo far nulla?"_ |

**No reply from Aurel Mrruku is in the record.** The conversation moves to other
projects and does not return to it.

🔴 **So the state is: ROMI has seen the closure, the PM has asked internally
whether anything needs doing, nobody answered her, and nobody answered
`amministrazione@pienissimo.com`** — whose question of 13/10 14:34:16Z,
_"Vi è necessaria per la configurazione di Docusign?"_, is **unanswered a second
day**, six days before go-live.

⚠ **Her framing — _"tutto ok no? non dobbiamo far nulla?"_ — is a reasonable
first reading and may well be right**: the signature path demonstrably works
without the onboarding, as the 13/10 and 14/10 sessions both showed. **What is
missing is anyone establishing it rather than assuming it.** The envelope
allowance behind OI-194's ~2,500 figure, the production templates and the sending
identity are exactly what an onboarding would have settled, and
[OI-232](OI-232%20A%20DocuSign%20envelope%20was%20signed%20under%20the%20wrong%20signer%20name.md)
— where the signer identity comes from — is an open question about that same
configuration.

⚠ She attributes the mail to **Elisa** (_"la mail di Elisa"_). It was sent by
`amministrazione@pienissimo.com`, the shared mailbox; the DocuSign original is
Mavi Carone's. **Not corrected in the record, and recorded here as her wording.**
