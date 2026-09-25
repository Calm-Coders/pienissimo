---
id: OI-177
type: open-item
status: open
owner: Elena Spini
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-24
updated: 2026-09-24
blocks: [go-live]
severity: gating
source: Slack DM D0B5QHS2T7H, Elena Spini 2026-09-24 20:18 CEST
---

# OI-177 - The marketing flow UAT needs production

**Elena Spini, DM to Aurel Mrruku, 24/09 20:18 CEST:**

> _"aggiungo che abbiamo un problema per il flusso MKT >> perchè per fare gli UAT a
> Fabrizio servono le cose in PROD --- capiamo anche questo domani"_

## Why it matters

- **The marketing UAT session is booked for 2 October** — `Flussi MKT`, one of the six
  sessions confirmed on 21/09. A pre-UAT check is booked for **Tue 29/09 09:30–10:30**
  (`[PIENISSIMO] - Pre UAT: Check giro MKT`, invitation 24/09 06:41:08Z, to Aurel Mrruku
  and Fabrizio Mastracci).
- Every other UAT topic runs in the Partial Copy sandbox. **This one cannot**, and the
  reason is structural rather than a scheduling problem: the marketing setup described in
  the Business Blueprint — the sending subdomain, DKIM/SPF authentication, the IP
  warm-up — lives on real DNS and a real sending reputation, not in a sandbox.
- 🔴 **Nothing records whether production Marketing Cloud is configured**, or who would
  authorise a client acceptance test against it.

⚠ _"a Fabrizio"_ is read here as **Fabrizio Paganelli**, the client-side referent who
takes the UAT sessions. That is an inference from the UAT context and is **not stated**;
Fabrizio Mastracci is the ROMI marketing lead on the same topic. **Confirm before acting.**

## The second half of the same problem

A hand-off between the two has stalled. Elena Spini, same DM, **08:38:52 CEST**, relaying
Fabrizio Mastracci:

> _"rimango in attesa delle indicazioni finali di aurel per completare i flussi che ci
> sono stati richiesti"_

Aurel Mrruku's answer, 08:59–09:00: _"ma di che indicazioni finali si tratta?"_,
_"a me non risulta di aver chiesto altre info"_, _"l'oggetto con i campi l'avevo
condiviso"_ — and he asked for a group to be created _"cosi tracciamo tutto"_. 🔴 **Each
believes the other owes the next move, with the marketing flows unbuilt and the session
eight days out.** Nothing records the group being created.

The Business Blueprint commits ROMI to rebuilding **two** marketing funnels — nurturing
anti no-show, and participant collection
([OI-179](OI-179%20The%20Business%20Blueprint%20goes%20to%20the%20client%20with%20unchecked%20points.md)).

## Open

- 🔴 **Establish what specifically needs to be in production**, and whether the 02/10
  session can run without it.
- 🔴 **Unblock the Aurel Mrruku → Fabrizio Mastracci hand-off.** It is two people waiting
  on each other, which no amount of waiting resolves.
- ⚠ No register row covers a UAT environment constraint.
