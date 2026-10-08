---
id: OI-222
type: open-item
status: open
owner: Elena Spini
with: Marco Montesi
org: both
raised: 2026-10-08
updated: 2026-10-08
depends_on: [OI-179]
blocks: [go-live]
severity: gating
source: Gmail thread 1a0fce6a8bb04fdb message 1a11c39cd17ae456
---

# OI-222 - The commercial mail and WhatsApp notification flows are unspecified

**Answering Elena Spini's request for detail, Marco Montesi listed on 08/10 the
automated mail and WhatsApp messages Zoho sends today on the commercial funnel —
five distinct triggers plus the quote-validity reminders. None of them is in the
Business Blueprint, in the register or in the build, and go-live is 21 October.**

## How it arrived

Marco Montesi's third precisazione on the Business Blueprint (05/10) asked
whether the customer mails and WhatsApp messages have to be set up once and
afterwards changed only through support. Elena Spini replied on 07/10 at
14:57:40Z — _"Non ho capito cosa intendi. Mi puoi dettagliare nello specifico di
quale flusso parli?"_ — and on **2026-10-08 at 15:55:11Z** he answered in the
same thread, in line, cc Fabrizio Paganelli, Sabatino Rinaldi, Rebecca Marmo,
Elisa Migliano's mailbox, Aurel Mrruku and Fabrizio Mastracci.

## What he named

> _"Abbiamo diversi casi dove adesso partono mail/WA automaticamente in funzione
> di determinate condizioni"_

| Trigger | Message |
| ------- | ------- |
| Opportunity created from a form | welcome, and a tutor will take the request in hand **within 48 hours** |
| The customer does not answer | a tutor called, here are the tutor's contact details, you will be called back |
| Opportunity set to **Perso** with reason **NON RISPONDE** | informs the customer they were called several times |
| Within the **5 days** of quote validity | messages to **both the customer and the tutor** |
| At quote expiry | message at the end of validity |

⚠ He qualified the list himself: _"Magari ce ne sono altri che sono legati alla
specifica configurazione di Zoho e che potrebbero non servirci su Salesforce"_,
and deferred to Elisa Migliano for additions. **So the list is explicitly
incomplete.**

## Why this is gating and not a detail

- It is a **new requirement surface arriving 13 days before go-live**, on the
  commercial funnel, from the commercial lead.
- It is **not the marketing ticket funnel.** The 11 email + 11 WhatsApp sequence
  in [the marketing send logics](../The%20marketing%20ticket%20send%20logics%20as%20written%20by%20Marketing.md)
  fires on event participation. This set fires on **opportunity and quote
  lifecycle events** and has a different owner.
- The **48-hour** and **5-day** windows are concrete commitments to a customer,
  and neither appears in any project record before this mail.
- 🔴 **His original question is still unanswered.** Whether these are
  administrator-editable or support-only was what he asked on 05/10; the record
  held the answer for templates from 05/10 (admin-editable in Prod) and nobody
  has given it to him. It is the governance question for the 11+11 funnel too.
- **WhatsApp has no confirmed channel.** Whether the sends run in parallel with
  email or as a backup is one of the two questions put to Rebecca Marmo and
  unanswered since 06/10.

## What closing it looks like

The complete list — Marco Montesi's five plus whatever Elisa Migliano adds —
each with its trigger condition, channel, recipient, timing and template, a
ruling on whether each is Fase 1 or Fase 2, and an answer to who may edit them
after go-live.
