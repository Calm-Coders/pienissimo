---
id: OI-147
type: open-item
status: open
owner: Aurel Mrruku
org: both
raised: 2026-09-18
updated: 2026-09-21
source: notes/meetings/2026-09-18 Data Model Parte 6.md
---

# OI-147 - Unused tickets close three days after the event

Agreed at [Data Model Parte 6](../meetings/2026-09-18%20Data%20Model%20Parte%206.md)
(`01:06:32`), proposed by Elena Spini and accepted by the group.

**Three days after an event ends, every unscanned ticket is set automatically to
`non utilizzato`.** The rule makes the earlier per-ticket fields redundant and they
were removed.

**Tickets are bound to their event and cannot be carried into the following year**
— Aurel Mrruku, explicitly.

## The exception nobody has solved

Elisa Migliano raised customers who cannot attend. **Today they are handled by
editing the academic year on the record**, to avoid producing a wrong stock
movement — and she is worried about the long-term traceability of doing so
(`01:09:31`).

Aurel Mrruku's answer is reporting rather than data change: the system keeps every
unused ticket against its contact and company, so customers can be identified by
report across previous child campaigns (`01:15:41`, `01:16:54`). Elisa Migliano
found the macro view hard to picture; he offered to build a dedicated report.

## Open

- 🔴 **Nothing builds either half** — neither the three-day closure job nor the
  unused-ticket report.
- 🔴 **The rinuncia path is unreconciled.** The 17/09 internal ruled that
  **rinuncia is blocked once an asset is filled in**; this note says an unattended
  ticket closes itself after three days; and the client's current practice is to
  edit the academic year. **Three mechanisms, one situation.**
- ⚠ The three-day delay has no stated source and no configuration point.
- ⚠ No register row covers it.
