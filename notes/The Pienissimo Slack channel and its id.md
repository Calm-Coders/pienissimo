---
id: slack-channel
type: reference
status: active
updated: 2026-09-28
---

# The Pienissimo Slack channel and its id

**`#tproj-pienissimo` exists. Its channel id is `C0B5T3RB4FM`.**

This note exists because three consecutive `requirements-check` runs (24/09, 25/09
and the 25/09 nightly) reported the channel as *not findable in the workspace* and
flagged the skill for naming a scope that might no longer exist. **The channel was
there the whole time.**

## Why it looked missing

`slack_search_channels "tproj-pienissimo"` returns **no match**. The channel is
reachable two other ways:

- **Message search.** A workspace-wide `slack_search_public_and_private` for
  `pienissimo` returns its messages, and each result carries
  `Channel: #tproj-pienissimo (ID: C0B5T3RB4FM)`.
- **Direct read.** `slack_read_channel` with `channel_id: C0B5T3RB4FM` works
  normally.

So the channel-name lookup is the unreliable step, not the channel. **Do not
conclude a Slack channel is absent from a `slack_search_channels` miss** — search
messages, or read the id directly.

## What is in it

It is **ROMI-internal project reporting, not a working channel**. Elena Spini posts
a structured status — `Status attività` / `Next step` / `Red flags` / `Notizie
positive` / estimated close date / days remaining — in the same shape she uses for
her other projects (`#tproj-life365` carries the identical template). Traffic is
low: **one message in the 25/09→28/09 window.**

⚠ **It is worth reading on every sweep even so.** The 28/09 post carried three facts
that appear nowhere else: the **12/10 PROD objective** behind the 16/10 marketing
UAT, the **Infopoint deferral to Fase 2**, and a **days-to-finish estimate**. A
low-traffic channel is not a low-value one.

## Related

The group DM **`C0BQD34LLF4`** is a different thing — the dev group (Aurel Mrruku,
Anita Aga, Sara Aga, Rexhina Hysi), which is where the nightly report is posted and
where the developers talk. See
[.agents/skills/requirements-check/SKILL.md](../.agents/skills/requirements-check/SKILL.md).
