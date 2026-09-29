---
id: OI-195
type: open-item
status: open
owner: Aurel Mrruku
with: Fabrizio Mastracci
org: ROMI
raised: 2026-09-29
updated: 2026-09-29
depends_on: [OI-81, OI-86, OI-134]
blocks: [go-live]
severity: gating
requirement: BIG-06
source: notes/meetings/2026-09-29 Pre UAT Check giro MKT.md
---

# OI-195 - WhatsApp sends imply a mobile community that was never designed

**The first marketing flow goes out by mail *and WhatsApp*. A WhatsApp recipient
opens the participant-registration link on a phone. The community page was built
with no mobile design, no mockups and no responsive specification, and its
technical lead learned WhatsApp was in scope during this session.**

## How it surfaced

At [the 29/09 pre-UAT marketing session](../meetings/2026-09-29%20Pre%20UAT%20Check%20giro%20MKT.md)
(`00:45:00`–`00:50:00`), reading the client's own WhatsApp template, Aurel Mrruku
drew the consequence himself:

> _"Tu parli di WhatsApp. Di WhatsApp vuol dire che devono aprire la community da
> mobile. Noi non abbiamo mai parlato di mobile fino adesso."_

And on scope: _"La prima volta che la sento la parte di WhatsApp."_ Elena Spini
disagreed — _"pure l'altra volta abbiamo parlato di WhatsApp"_ — and Fabrizio
Mastracci confirmed the client has **bought WhatsApp credits**, reading them off
Pienissimo's own Salesforce contracts during the call.

⚠ **Both statements are recorded and neither is corrected.** WhatsApp is in the
record: [OI-81](OI-81%20Event%20communication%20funnel.md) carries it from the 20
August recap — the second flow _"tagga il contatto `iscritto` e manda il biglietto e
il QR code via email e WhatsApp"_. So the channel was documented. **What is new is
that nobody had drawn the mobile consequence, and the person who has to build for
it had not registered the channel at all.**

## What is actually missing

Aurel Mrruku, on the community components:

> _"I componenti sono custom, non sono stati generati per mobile… cambia il layout
> completamente. Noi abbiamo usato le best practice, però non è che abbiamo un
> mockup come si vede da una parte, come si vede dall'altra parte."_

The interactions he named as unverified on a phone: the **rinuncia button**, the
**confirm button**, the **participant data entry**, and the **expand/collapse of a
list of ten contacts**.

🔴 **No mobile mockup, no responsive acceptance criterion and no mobile test exists
on any source.** `mobile` appears in exactly one note in the vault
([OI-24](OI-24%20Data%20model%20workbook.md)) and in no requirement row.

⚠ His stated fallback is to ship what exists and see: _"io lo faccio vedere quello
che c'è a sto punto me ne frego."_ Said in evident frustration at the end of a bad
week; recorded because it is the only disposition anyone has stated, **not because
it was agreed**.

## The credits question, separately

Fabrizio Mastracci will not wire WhatsApp into the reminder ladder by default,
because **_"brucia un sacco di crediti il WhatsApp"_** and the reminders run to
10–11 communications ([OI-81](OI-81%20Event%20communication%20funnel.md)). His plan:
deliver the mail flow, show the client how to configure WhatsApp, and let them
decide when to switch it on. 🔴 **This has not been put to the client**, and it
changes what the client receives at go-live.

⚠ No catalogue figure is copied here. That the client holds WhatsApp credit lines
on their own Salesforce contracts is recorded; the quantities and prices are not.

## Needed

1. A decision on whether the community is in scope for mobile before go-live — and
   if so, who tests it and against what.
2. Whether flow 1's WhatsApp leg ships enabled or dark.
3. ⚠ Fabrizio Mastracci **has not yet built the WhatsApp templates**: asked
   directly, _"non ho ancora fatto"_. Marketing UAT is **16 October**
   ([OI-177](OI-177%20The%20marketing%20flow%20UAT%20needs%20production.md)).
