---
id: meeting-2026-09-29-pre-uat-mkt
type: meeting
status: active
owner: Elena Spini
org: ROMI
raised: 2026-09-29
updated: 2026-09-29
source: Drive, Trascrizione, 2026-09-29 09:31 CEST (doc 1myOdoLyhPyuFA-S0xR6DeSY1c7ntNn2n6JnuuQpvDq8, 56,157 characters, read in full)
---

# 2026-09-29 Pre UAT Check giro MKT

**A ROMI-internal marketing review that turned up a forgotten requirement, a
channel nobody had costed, and a send rule that contradicts the client's own
document — the day before the ticket UAT.** 29/09, 09:31 CEST, **56m06s**,
**Aurel Mrruku · Elena Spini · Fabrizio Mastracci**. No client present.

Booked as a pre-UAT alignment on the marketing round. Elena Spini has moved the
recurring internal follow-up from Monday to **Tuesday**.

## 🔴 The ticket is a document, and the record had forgotten it

The session's largest finding, at `00:30:00`–`00:40:00`, with the file open on
screen: what the participant receives is
`Pienissimo_Scheda di Partecipazione ai corsi_da firmare.pdf` — **handed over by
the client on 26 June 2026** — carrying the QR code, dynamic event and participant
fields, and a seven-page enrolment pack to be printed and brought to check-in.

Aurel Mrruku had understood the deliverable as a QR code for the handheld scanner:
_"Serviva solo il QR Code per scaneggiare col palmare… e basta."_ Elena Spini took
the omission: _"Questa è la base di tutto questo progetto, va fatto, non è una
scelta, purtroppo, perché noi l'abbiamo dimenticato."_ Asked whether it was hard,
Aurel Mrruku: _"Sì che è difficile. È tanto difficile, ma davvero tanto difficile."_

🟢 The DocuSign signature on it is dropped. 🔴 The document is not.
→ [OI-194](../items/OI-194%20The%20ticket%20is%20a%20signed%20participation%20document%20not%20just%20a%20QR%20code.md)

## 🔴 WhatsApp means mobile, and the community has no mobile design

At `00:45:00`–`00:50:00`, reading the client's WhatsApp template, Aurel Mrruku drew
the consequence: _"Di WhatsApp vuol dire che devono aprire la community da mobile.
Noi non abbiamo mai parlato di mobile fino adesso."_ He also said the channel was
new to him — _"La prima volta che la sento"_ — which Elena Spini disputed.

The community's custom components have **no mobile mockup and no responsive
specification**. Fabrizio Mastracci confirmed the client bought WhatsApp credits,
reading them off Pienissimo's own Salesforce contracts.
→ [OI-195](../items/OI-195%20WhatsApp%20sends%20imply%20a%20mobile%20community%20that%20was%20never%20designed.md)

## 🔴 All-or-nothing sending, against the client's own exit rule

`00:00:00`–`00:15:00`. Tickets go only when **every** participant is named. A buyer
who names three of five receives nothing. The client's `SEGMENTI FUNNEL
BIGLIETTI.docx` says that buyer has already left the funnel and will not be chased
again. Neither Aurel Mrruku nor Fabrizio Mastracci raised that document.

Elena Spini logged it as an open point for the **30/09 client session**.
→ [OI-196](../items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md)

## 🟢 What was settled

- **One ticket per participant, direct.** Each participant receives their own
  ticket at their own address; the referente is **not** copied and no flow notifies
  them. Elena Spini: _"Ogni partecipante riceve il suo biglietto personale."_
  Aurel Mrruku had proposed copying the referente and withdrew it.
- **Two campaigns, technically.** Fabrizio Mastracci put the model and Aurel Mrruku
  confirmed it: flow 1 runs on **the Account's principal contact, not on campaign
  members**; each ticket line then becomes a campaign member of a **second**
  campaign, which is where the tickets are sent. Matches
  [the campaign parent and child model](../objects/The%20campaign%20parent%20and%20child%20model.md).
- **Transactional, not scheduled.** Aurel Mrruku assumed a nightly job; Fabrizio
  Mastracci offered either, and can listen to record creation instead —
  _"posso leggere quando si crea quell'informazione, una sorta di transazionale"_.
  Aurel Mrruku: _"sarebbe ottimo."_
- **Reminders stop on confirm or rinuncia**, as already held in
  [OI-81](../items/OI-81%20Event%20communication%20funnel.md).

## 🟢 A dated route out of the Marketing-Cloud-in-sandbox block

[OI-134](../items/OI-134%20The%20marketing%20flows%20cannot%20be%20tested%20before%20a%20production%20release.md)
has blocked since 08/09 because Marketing Cloud cannot be installed in the UAT
sandbox. Aurel Mrruku committed to putting the objects and a test record set into
**production by Monday 5 October** — _"lo faccio venerdì e ci lavoro nel weekend"_ —
and a session is booked to check it: **`PIENISSIMO - Interna Check PROD per MKT`,
Mon 05/10 09:30–10:30 CEST**, Aurel Mrruku and Fabrizio Mastracci.

What Fabrizio Mastracci asked for: a test Account, **five ticket rows**, a contact,
an order and a campaign — he can create the campaign himself. Aurel Mrruku refused
to export UAT data, _"sono dati sporchi"_, and will build a clean set.

Aurel Mrruku also reported he began moving structures to production on **Sunday
27/09**, with a first batch on 28/09 — configurations, permissions, community and
tickets still missing.
See [the resolved coverage risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md).

## ⚠ Carried out of the session unresolved

- **Attachments from Marketing Cloud are unproven.** Fabrizio Mastracci has never
  sent a marketing mail with one and must test it.
- **Winter '27 campaign features.** Present in the sandbox, absent from production
  until the release, so the campaign layouts have to change —
  _"devo cambiare un po' layout delle campagne."_
- **The WhatsApp templates are not built.** Asked directly: _"non ho ancora fatto."_
- **Rinuncia after partial entry** — see
  [OI-196](../items/OI-196%20Whether%20tickets%20are%20sent%20when%20the%20buyer%20names%20only%20some%20participants.md).

## The forecast on record

On tomorrow's ticket UAT, Aurel Mrruku: **_"col cavolo che riusciamo domani, però.
Andrà male anche domani."_** Elena Spini, on the project: _"e questo progetto è un
casino, quindi non mi stupirebbe niente."_
