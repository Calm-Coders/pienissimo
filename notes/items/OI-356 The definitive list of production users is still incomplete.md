---
id: OI-356
type: open-item
status: in-progress
owner: Elena Spini
with: Fabrizio Paganelli, Aurel Mrruku
org: both
raised: 2026-11-10
updated: 2026-11-12
depends_on: [OI-341]
blocks: [go-live]
severity: gating
source: notes/meetings/2026-11-12 Check Pre-Import.md
---

# OI-356 - The definitive list of production users is still incomplete

**Four days before the client's users start work, the production org holds the
seven commercial agents and nothing else that the business needs. Marketing and
Performance Plus have no users and no profiles. The list was first asked for on 10
November; on 12 November it was agreed, counted and still not delivered.**

## How it was raised

Elena Spini, ROMI DM, **2026-11-10 09:26:09Z**, third of three items:

> _"PIENISSIMO - **non abbiamo la lista finale degli utenti da attivare per PROD**
> ti torna? ci avevano mandato solo quella degli agenti…."_

Aurel Mrruku, 09:31:22Z: _"**sul 3 punto non ti saprei dire come procedere**"_.
🔴 The DM ends there. Tutor training ran the next day; operational start is 16/11.

## What was counted on 12 November

🔑 Read live out of the production org by Aurel Mrruku on the
[Check Pre-Import call](../meetings/2026-11-12%20Check%20Pre-Import.md):

| | |
| --- | --- |
| Licences | **12 total · 10 used · 9 in real use · 3 free** |
| Agents in production | the generic commercial user, **Sara, Barbara, Martina, Davide, Carmen, Valentina** — seven |
| Also present | `amministrazione` (used by Fabrizio Paganelli and Elisa Migliano), two system admins (`Romi Company` and `pienissimo amministrazione`) |
| To be freed | 🟢 the old `Romi Company` admin — _"Romi company lo possiamo anche togliere"_, blocked only by record ownership (_"ci sono dei record che devo pulire prima di disattivare"_, guest-user default owner) |
| ROMI's own licence | 🟢 offered back — _"anche la licenza nostra di Tech\[y\] puo essere riciclata"_, which would free two more |

## What is missing

| Needed | State |
| --- | --- |
| **Marketing user** — Rebecca Marmo, on `marketing@pienissimo.com` | 🟢 agreed on the call. 🔴 **No profile exists** |
| **Performance Plus user** — a shared mailbox, to see all of Sales read-only and edit **only** the contract activation date | 🟢 agreed. 🔴 **No profile exists** |
| The written list for everyone else | 🔴 **never delivered.** Elena Spini offered a template: _"Se volete vi mando io un template che popolate"_ |

🔴 Aurel Mrruku on the profiles: _"Non ce l'ho ancora un profilo, pero **lo posso
fare tra settimana prossima**"_ — i.e. after the 16 November start →
[OI-363](OI-363%20The%20marketing%20and%20Performance%20Plus%20profiles%20do%20not%20exist.md).

## Settled on the call

- 🟢 **Marco Montesi gets no named production user.** He will use the generic
  commercial user, so his departure
  ([OI-357](OI-357%20The%20client%20commercial%20lead%20and%20the%20web%20counterpart%20are%20both%20leaving.md))
  costs nothing on the Salesforce side — Elena Spini: _"poi chiunque verra come
  referente commerciale si prendera questa utenza e non dovra neanche cambiare
  niente."_
- 🟢 **Password resets go out Monday 16/11, 09:00-09:30**, with a joint check —
  and may not be needed: _"alcuni gli agenti sono gia in produzione, hanno gia
  fatto accesso"_, Fabrizio Paganelli, _"Tutti l'hanno gia fatto tutti."_
- ⚠ Elena Spini will be absent on **16-17 November**.

## What is owed

- The marketing and Performance Plus profiles, built and assigned **before 16/11**.
- The written user list, by role, from Pienissimo.
- Whether the six tutors ever completed MFA/passkey enrolment
  ([OI-300](OI-300%20Tutor%20training%20and%20tutor%20test%20access%20are%20unplanned.md)) — ⚠ still
  unevidenced for anyone but Fabrizio Paganelli, and those are **UAT** users; no
  production user exists for any tutor.
