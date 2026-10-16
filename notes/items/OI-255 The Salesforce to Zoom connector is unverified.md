---
id: OI-255
type: open-item
status: open
owner: Sabatino Rinaldi
with: Aurel Mrruku
org: both
raised: 2026-10-16
updated: 2026-10-16
blocks: [OI-251]
source: notes/meetings/2026-10-16 UAT Flussi MKT Biglietti.md
---

# OI-255 - The Salesforce to Zoom connector is unverified

**Attendance tracking for streaming events now depends on Zoom data reaching
the CRM. Nobody has named a connector, established Pienissimo's Zoom
subscription tier, or taken ownership — and the client is relying on an answer
it believes it got before the contract was signed.**

## How it surfaced

At [the 16/10 UAT session](../meetings/2026-10-16%20UAT%20Flussi%20MKT%20Biglietti.md)
(`02:07:18`), immediately after agreeing that ODB Live would generate no ticket
([OI-251](OI-251%20ODB%20Live%20streaming%20must%20not%20generate%20a%20ticket.md)),
Sabatino Rinaldi raised it:

> _"mi ricordo che Andrea di Romi i primi tempi, questa fu una domanda che gli
> fece all'inizio, voi in marketing cloud avete il collegamento diretto con
> Zoom, giusto?"_

Asked who, he named **Andrea Galotto**, and placed the conversation
_"ancora prima di firmare il contratto"_.

## What each party actually said

| Who | Position |
| --- | --- |
| **Fabrizio Mastracci** | The pre-contract answer may have been about **the CRM, not Marketing Cloud** — _"forse sales force si riferiva al CRM"_ |
| **Aurel Mrruku** | _"c'è un connettore standard"_, but **documentation first** — _"dobbiamo anche capire documentazione cosa si può, cosa non si può fare"_ |
| **Elena Spini** | _"Forse tramite connettore, non lo so"_, then the general preference: _"se è meglio è sempre meglio scegliere i connettori standard"_ |
| **Sabatino Rinaldi** | Not worried: _"Anche se non ce lo fa stesso, se lo faccio da solo non è un problema"_, and capability _"dipende dall'abbonamento che hai di Zoom"_ |

His understanding of the direction of travel is the operative one:

> _"Zoom va solo a pescare le informazioni del contatto dal CRM, poi fa tutto
> lui."_

⚠ **That is the opposite direction from what OI-251 needs.** Zoom pulling
contacts out of the CRM is a send-side convenience. Fabrizio Paganelli's
attendance objection requires **Zoom participation data flowing back into the
CRM** for cross-reference. Both were discussed as one thing and nobody separated
them.

## Open

- 🔴 **No connector is named**, by either side. _"Un connettore standard"_ is not
  an artefact.
- 🔴 **Pienissimo's Zoom subscription tier is unknown**, and Sabatino Rinaldi
  himself made capability conditional on it. Nothing in the record states it.
- 🔴 **No owner for the integration.** Sabatino Rinaldi offered to do it himself
  _"se lo faccio da solo"_ with no mechanism, date or scope; ROMI took no action.
- 🔴 **No phase.** It is not in Fase 1 scope, not in the Fase 2 exclusion list in
  `Pienissimo_Project Plan v3.pptx`, and not in the register.
- ⚠ **A pre-contract claim is load-bearing.** The record now contains a client
  expectation attributed to a ROMI person who was not in the room and does not
  appear in any other source. It is **not established that the claim was made**
  — only that Sabatino Rinaldi remembers it — and Fabrizio Mastracci's
  CRM-versus-Marketing-Cloud correction suggests a plausible misunderstanding.
  **Nobody undertook to go and check.**

## What closing it looks like

Someone states Pienissimo's Zoom plan, names the connector or the API, says
which direction the data moves and who owns it, and places it in a phase.
Settling it also settles whether OI-251's attendance answer is real.
