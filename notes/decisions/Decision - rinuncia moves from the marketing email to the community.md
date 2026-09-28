---
id: DEC-2026-09-07-rinuncia
type: decision
status: resolved
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-07
updated: 2026-09-07
depends_on: [OI-78]
source: notes/meetings/2026-09-07 Interna Flussi MKT.md
---

# Decision - rinuncia moves from the marketing email to the community

**Agreed ROMI-internally at
[the 7 September marketing session](../meetings/2026-09-07%20Interna%20Flussi%20MKT.md).**
The rinuncia option is removed from the marketing email. The recipient lands on
the community page through the platform, and renounces there.

## Why

Aurel Mrruku's argument, accepted by Elena Spini and Fabrizio Mastracci:

- **Handling rinuncia at whole-order or bundle level inside Marketing Cloud is
  too complex**, and risks invalidating the child-campaign data structure the
  whole event model rests on.
- **On the community page the system knows exactly which assets are in scope.**
  An email button does not — it carries a recipient, not a set of tickets.
- **It avoids the partial-completion problem.** A buyer may have named some
  participants and not others; a guided path in the community can present the
  actual state and a clear rinuncia option against it.

## What it changes

🔴 **It changes a page that already exists.** The participant registration page
merged in PR #31 on 3 September
([the build](../objects/The%20Landing%20Page%20community.md)) has no rinuncia
path. This is unbuilt work on
[OI-78](../items/OI-78%20Participant%20data%20collection.md), landing after the
Fase 1 development deadline of 10 September.

🔴 **It reverses a requirement that was itself new.** The rinuncia button in the
event invitation emails is named at
[the internal follow-up the same evening](../meetings/2026-09-07%20Follow-up%20Interno.md)
as one of the **unforeseen marketing requirements that caused the project delay**.
It was added, then moved, inside a fortnight.

⚠ **What the button must actually do is not specified** —
[OI-127](../items/OI-127%20What%20a%20total%20rinuncia%20does%20to%20orders%20and%20assets.md).
Cancelling the assets is known behaviour: Fabrizio Mastracci's 20 August recap to
the client states rinuncia _"annulla tutti i biglietti, non è parziale"_. What
happens to the **order** behind them, and to the **credit toward future events**
Elena Spini mentioned, is open and is Rebecca Marmo's to answer.

## What it does not change

- The **nurturing flow still sends the communications** — 30 to 60 days out, up to
  10–11 of them ([OI-81](../items/OI-81%20Event%20communication%20funnel.md)). Only
  the *action* moves; the mail still has to link to the community.
- **The `Rinuncia` tag still exists on the Zoho side** and still mirrors a ticket
  state, so the marketing segmentation that uses it after the event — offers to
  people who registered and did not attend — is unaffected.
- ⚠ It says nothing about the **`Rinuncia` state on the asset state machine**
  ([OI-74](../items/OI-74%20Asset%20state%20machine.md)), where the master diagram
  and the 19 August minute already disagree about whether it is a state or a
  marketing tag. **That contradiction is untouched and now has a page depending
  on it.**
