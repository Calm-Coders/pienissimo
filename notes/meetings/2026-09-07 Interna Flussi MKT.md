---
id: MTG-2026-09-07-flussi-mkt
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-09-07
updated: 2026-09-07
source: Drive - "[PIENISSIMO]- Interna Flussi MKT - 2026/09/07 10:00 CEST - Appunti di Gemini", summary, Decisioni and details read 2026-09-07
---

# 2026-09-07 Interna Flussi MKT

**ROMI-internal session, 7 September 2026, 10:00 CEST, roughly one hour.**
Present: **Aurel Mrruku**, **Fabrizio Mastracci**, **Elena Spini**. No client.

The first marketing-flow session since **19 August**, and the forum
[OI-81](../items/OI-81%20Event%20communication%20funnel.md) had been waiting for.
It produced one agreed decision that changes a built page, one new build action,
and three questions that only Rebecca Marmo can answer.

## Concordato — rinuncia moves off the email and into the community

**The rinuncia option is removed from the marketing email. The user lands on the
community instead, and rinuncia happens there.** See
[the decision note](../decisions/Decision%20-%20rinuncia%20moves%20from%20the%20marketing%20email%20to%20the%20community.md).

Aurel Mrruku's argument, accepted by both others: handling rinuncia at whole-order
or bundle level **inside Marketing Cloud** is too complex and risks invalidating
the child-campaign data structure the model depends on. Putting the action on the
community page means the system knows exactly **which assets** the user is acting
on, and avoids the partial-completion problem an email button creates.

This is a **change to a page that already exists** — the participant registration
page merged in PR #31
([the build](../objects/The%20Landing%20Page%20community.md)) — and to
[OI-78](../items/OI-78%20Participant%20data%20collection.md). It is not built.

## What the session confirmed about the model

Recorded because it is the first time ROMI's marketing side has been walked
through the object model, and it agreed with the record:

- **Campaign hierarchy is in use as designed**: a parent campaign
  (`Food Marketing Festival`) with per-edition children (`Food Marketing Festival
  2026`), and CampaignMembers attached to the child
  ([the model](../objects/The%20campaign%20parent%20and%20child%20model.md)).
- **Orders — from Sales Cloud or from the shop — generate Assets that are the
  tickets**, related to the account and to the reference contact.
- **Asset states named in session: `disponibile`, `utilizzato`, `annullato`.**
- **The purchase carries only the buyer.** At the moment of sale Pienissimo has
  the restaurateur, not the individual participants — which is exactly why the
  data-collection step exists.
- **Collection runs through the community**: the buyer receives a link by email,
  enters the participants against the tickets bought, and that generates the QR
  code, the contact and the CampaignMember tied to the product and event date.
  Aurel Mrruku presented this as already solving the missing-names problem.

## 🟢 The `30 vs 60` question is answered, in the sense that matters

[OI-81](../items/OI-81%20Event%20communication%20funnel.md) has carried
`30 vs 60` as undecided since 19 August. This session states it as **a window,
not a choice**: communications run **between 30 and 60 days before the event** to
reduce no-show, and the **data-collection mail is scheduled roughly 60 days
before**.

⚠ **This is ROMI deciding internally, and OI-81 warned about exactly that.** The
confirmation was Elisa Migliano's and Rebecca Marmo's to obtain from Matteo
Distaso, and no source records that happening. The number is now settled in the
build without being settled with the client. It is corroborated by the **20
August recap** (see below), which is Fabrizio Mastracci's own writing to the
client and says _"avviato 30-60 giorni prima dell'evento"_ — so the window is at
least documented to Pienissimo. **The single trigger figure is still ROMI's
choice.**

## 🔴 New build action — a flag for tickets whose data is not yet filled in

Fabrizio Mastracci asked for the check to be **simple on the Salesforce side** so
that Marketing Cloud queries and triggers do not have to reconstruct it: a field
or checkbox marking assets whose participant data the buyer has not completed.

Owner **Aurel Mrruku**. New row —
[OI-126](../items/OI-126%20An%20asset%20flag%20for%20incomplete%20participant%20data.md).

⚠ This overlaps [the invitation build](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md)
committed the same day, which carries `Status__c` and `URL_Status__c` on
`Event_Invitation__c` but **nothing on the Asset**. Whoever builds this should
check whether the invitation object already answers it before adding a field.

## 🔴 Three questions for Rebecca Marmo

Raised by Aurel Mrruku and unanswered in the room —
[OI-127](../items/OI-127%20What%20a%20total%20rinuncia%20does%20to%20orders%20and%20assets.md):

1. **What happens to the order** when a customer renounces entirely?
2. **What happens to the assets**?
3. **Elena Spini mentioned a credit for future events.** Nobody could say whether
   that is real, how it is represented, or who tracks it.

Action on **Fabrizio Mastracci** to contact Rebecca Marmo, and on the group to
schedule a call with her. ⚠ That is the **third** commitment in the record to get
Rebecca Marmo into a session —
[OI-86](../items/OI-86%20Who%20hosts%20the%20participant%20landing%20page.md) has
been waiting on a call with her that was never scheduled, and
[OI-81](../items/OI-81%20Event%20communication%20funnel.md) records that she was
to join **all** flow, field and ticket calls from 6 August onwards.

## Passaggi successivi

| Owner               | Action                                                                    |
| ------------------- | ------------------------------------------------------------------------- |
| Fabrizio Mastracci  | Ask Rebecca Marmo: the rinuncia process, the assets, and total rinuncia    |
| The group           | Schedule a call with Rebecca Marmo on the marketing flows                  |
| Fabrizio Mastracci  | Check WhatsApp template availability and how it integrates with Salesforce |
| Aurel Mrruku        | Build the Salesforce flag for assets with incomplete participant data      |
| Fabrizio Mastracci  | Start configuring the flow for the first marketing email                   |
| Aurel Mrruku        | Send Fabrizio Mastracci the trigger specification by chat                  |
| The group           | Follow-up **Tuesday 8 September 14:30** — booked as `Flussi MKT Parte 2`   |

⚠ **The plain-text style constraint was not restated.**
[OI-81](../items/OI-81%20Event%20communication%20funnel.md) has flagged since 24
August that Matteo Distaso specified plain text — no header, no images, no
buttons, written as if from Giuliano personally — and that this has never been put
in front of the person building it. **Fabrizio Mastracci was in this room and it
still was not said**, while he is now starting the first email's configuration.
Nothing in the summary, decisions or details mentions it.

## The 20 August recap arrived the same morning, by forward

Elena Spini forwarded Fabrizio Mastracci's own **20 August** recap of the 19
August `Flussi MKT Biglietti` session to Aurel Mrruku at 08:48:04Z with the body
_"FYI"_. It was originally sent to Marco Montesi, Matteo Distaso and Rebecca Marmo
at Pienissimo, cc Elena Spini. **This is the first time its text is in the
record** — see
[the 19 August minute](2026-08-19%20Flussi%20MKT%20Biglietti.md), which was
reconstructed without it.

It confirms, in ROMI's own words to the client:

- **Two flows to rebuild from Zoho.** *Nurturing pre-evento* starting 30–60 days
  out — the contact enters a segment by CRM tag, receives the first email or
  WhatsApp asking for participant names, then reminders **up to 10–11
  communications** until either a name is entered or Rinuncia is clicked. And
  *raccolta partecipanti e invio biglietti*, which fires when the data is filled
  in, tags the contact `iscritto` and sends the ticket and QR code by email and
  WhatsApp.
- 🟢 **`Rinuncia` cancels every ticket and is not partial** — _"che annulla tutti
  i biglietti, non è parziale"_. That is a direct answer to one of the questions
  the 7 September session raised as open, and it is **three weeks older than the
  question**.
- The Zoho tags are **`Rinuncia`, `Iscritto`, `Presente`**, they mirror the ticket
  states on Salesforce, and marketing uses them **after** the event too — a survey
  to those who attended, an offer to those who registered and did not.
- **The style constraint again, in writing**: _"solo testo, senza
  header/immagini/pulsanti, per restare personali"_. Fabrizio Mastracci had
  received the test mail _"[TEST] CF1: i tuoi biglietti sono pronti"_ and was
  recreating it on Marketing Cloud as the reference.
- 🔴 **Deliverables owed by the client, with dates that have passed by two and a
  half weeks**: DNS records from **Matteo Distaso** and segment/logic/mail detail
  from **Rebecca Marmo** _"entro venerdì"_ (21 August); a **landing-page document
  and hidden-field list** the following Wednesday (26 August), at a named Google
  Sheet. Still owed: segment and criteria screenshots, flow screenshots, the text
  of the other email and WhatsApp communications, logos and images.
  ([OI-14](../items/OI-14%20Marketing%20forms%20and%20subdomain.md)).

⚠ The landing-page spreadsheet link in the mail body is **corrupted in transit** —
the `gid` fragment carries a control character where a digit should be. The file
id is `1KPZ8pwEg3FFyXDdKu-gkXPtI13Yb5fGi`. **It was not opened this run** and is
not otherwise in the record.
