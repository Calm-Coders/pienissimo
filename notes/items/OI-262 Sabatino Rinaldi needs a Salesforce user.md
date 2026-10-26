---
id: OI-262
type: open-item
status: open
owner: Elena Spini
with: Sabatino Rinaldi
org: both
raised: 2026-10-19
updated: 2026-10-19
depends_on: [OI-240]
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# OI-262 - Sabatino Rinaldi needs a Salesforce user

**Sabatino Rinaldi asked for his own access mid-session and Elena Spini
undertook to create it the moment the call ended, on an administrator profile.
No source confirms it was created.**

## The exchange

At [the 19/10 session](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md)
`00:43:18`, Sabatino Rinaldi: _"volevo chiedere, io posso averlo un accesso?"_,
and when asked what he needed it for: _"io faccio i miei test paralleli … io non
devo fare, devo solo guardare, quindi non farò nulla."_

Elena Spini agreed with the same caveat she gave Marco Montesi — _"con la stessa
accortezza … perché verrete creati con utenza di amministratore"_ — and committed
twice: _"appena finita questa call faccio l'utenza"_ and, at the close,
_"vado a creare l'utenza Sabatino"_. He asked her once more before hanging up:
_"ti ricordi di darmi gli accessi?"_

## Open

- 🔴 **Nothing confirms the user exists.** The undertaking is verbal and same-day;
  no mail, message or calendar artefact in this sweep records it being done.
- 🔴 **Administrator profile, Mexal-production-connected org.** Same exposure as
  Marco Montesi's — see
  [the risk](../risks/Risk%20-%20client%20key%20users%20test%20with%20admin%20rights%20against%20Mexal%20production.md).
  His stated intent is read-only, which the profile will not enforce.
- ⚠ **He will hit the passkey prompt** at first login, as Elena Spini warned both
  new users in the session — recorded in
  [the meeting note](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md).
- 🔑 **This is the fifth client-side user**, after Fabrizio Paganelli, Elisa
  Migliano (sharing his login — unverified), and Marco Montesi. The licence count
  and the profile question are both still unanswered in the record.

## What closing it looks like

The user exists, he has logged in, and the profile he holds is written down —
along with whether a view-only profile should have been used instead.
