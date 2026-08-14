---
id: OI-37
type: open-item
status: open
owner: ROMI
org: ROMI
raised: 2026-06-16
updated: 2026-08-14
depends_on: [risk-phase2-dispute]
source: meetings/open-items.md row 37
---

# OI-37 - E-commerce parallel flow build

The e-commerce path alongside the commercial one: **GLS** delivery-confirmation
integration (greenfield), the **Teachable** completion API, and nightly
scheduled opportunity creation — a book generates an opportunity at +15 days, a
video course immediately, with a 48-working-hour task SLA.

Architecture is decided: **Record Types** separate commercial from e-commerce,
because the stages, automation and visibility genuinely differ.

⚠ **Do not build this.** GLS and Teachable are two of the three items ROMI has
declared **out of contract** and belonging to a separately quoted evolutiva —
see [the scope dispute](../risks/Risk%20-%20the%20phase%202%20scope%20dispute%20is%20unresolved.md).
The tracker still carries this as ordinary open work, which is precisely how a
disputed item gets built by accident.

The dispute has run four consecutive meetings.
[OI-83](OI-83%20No%20phase%202%20estimate.md) records that no estimate exists and
that the decision-maker was never told.

The Record Types decision stands regardless of who pays for the integrations.
