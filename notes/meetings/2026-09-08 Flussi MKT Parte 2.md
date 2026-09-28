---
id: MTG-2026-09-08-flussi-mkt-parte-2
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-09-08
updated: 2026-09-08
depends_on: [OI-81, OI-126]
source: Appunti di Gemini, Drive 1_1hR-qPfRbLk8Bgx7bKvcoP5linsOa0R36D8RK4sMVk
---

# 2026-09-08 Flussi MKT Parte 2

**ROMI-internal marketing session that settled how the invitation link reaches
Marketing Cloud, and in doing so exposed that the marketing flows cannot be
tested end to end before a production release. 42m21s; drilled from the full
transcript.**

ROMI-internal, **14:32 CEST**, ran **42m21s**. Present: Elena Spini,
Aurel Mrruku, Fabrizio Mastracci. **Aurel Mrruku left at ~00:26**; the last
sixteen minutes are Elena Spini and Fabrizio Mastracci.

## 🟢 The invitation object carries the dates, so the flow does not compute them

Aurel Mrruku presented the object built in `d562af0` — he calls it _"event"_ and
_"event link"_; in source it is **`Event_Invitation__c`**
([the flow](../flows/Proposed%20event%20invitations%20for%20participant%20registration.md)).
It holds the triple **account + campaign + asset** and generates the unique URL.

The design question was where the send timing lives. Marketing Cloud must send
**60 days before the event**, but Elena Spini reported from that morning's client
session that the interval **varies by event and by the holiday calendar**.

Aurel Mrruku's first proposal was a nightly check for campaigns starting in 60
days. Fabrizio Mastracci countered with a formula field and a checkbox tier.
**Agreed instead: put both dates directly on the invitation record** —

- **`data evento`** — the event date
- **`data invio`** — the send date

so Fabrizio Mastracci's flow fires on `data invio = today` and needs **no query
against the Campaign at all**. Recorded under `Concordato` as _"inserire i campi
relativi alla data dell'evento e alla data di invio direttamente sull'oggetto
custom event link"_. The account's email goes on the same record for the same
reason.

🔴 **Aurel Mrruku named the cost himself**: the dates are editable on the
Campaign, so **triggers are needed to propagate a changed date onto every
invitation record**. That work is unbuilt and unestimated.

⚠ **Reminders were deliberately not settled.** Elena Spini's instruction was to
build to Rebecca Marmo's example flows as given and raise reminders at a
follow-up. Whether the reminder cadence also varies per campaign is open, and it
is the same "ROMI choosing for the client" pattern
[OI-81](../items/OI-81%20Event%20communication%20funnel.md) has carried since
August.

## 🔴 The flows cannot be tested end to end, and production is two weeks away

Fabrizio Mastracci asked for the minimum to test: the link engine, a test
account, an asset, and the date fields. What he got was **the sandbox only**, and
the sandbox cannot send:

- **No authenticated domain** exists in the sandbox — checked live during the
  call.
- The link must land on the **community**, which does not exist in production.
- Aurel Mrruku: production release needs _"almeno un paio di settimane"_ and
  _"non abbiamo ancora fatto dei UAT noi"_.

Agreed as a workaround: Fabrizio Mastracci **builds the flow logic in the sandbox
without sends**, and Aurel Mrruku writes the object and field details in chat by
end of day. That is [OI-134](../items/OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md).

⚠ **This was said the same afternoon Elena Spini told the client UAT begins
23 September.** Nobody in either place connected the two.

## 🔴 A sandbox password was read aloud and is in the transcript

To unblock the One Password failure, Elena Spini **spoke Aurel Mrruku's UAT
sandbox password aloud** and Fabrizio Mastracci signed in **as Aurel Mrruku**
rather than under his own user. Gemini transcribed it verbatim.

The value is **not reproduced here**. See
[the risk](../risks/Risk%20-%20a%20sandbox%20password%20was%20spoken%20aloud%20and%20preserved%20in%20a%20meeting%20transcript.md).

## The two funnels, and what is missing from them

Fabrizio Mastracci described the two Marketing Cloud funnels: one to **prompt the
customer to register**, one to send the **filled ticket** with logistics
(parking, venue). Elena Spini collected the material into a new Drive folder
**`02 Marketing`** during the call — two email PDFs and three funnel documents
([OI-81](../items/OI-81%20Event%20communication%20funnel.md)).

🔴 **The WhatsApp templates are not in Rebecca Marmo's material.** Both went
through the four attachments live and neither found them; Fabrizio Mastracci will
ask her directly. Elena Spini's framing was _"rispondete direttamente, almeno
capiscono che si devono muovere, dato che sono in ritardo su tutto"_ —
[OI-133](../items/OI-133%20The%20WhatsApp%20templates%20are%20missing%20from%20the%20marketing%20material.md).

⚠ Elena Spini confirmed the templates **do** exist on the client side — _"Sì, ce
l'hanno"_ — so this is a delivery gap, not a scope gap.

## Not this project

The last six minutes concern **Carol**, a different client. Not ingested.
