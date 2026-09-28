---
id: RISK-org-access-2026-09-01
type: risk
status: resolved
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-01
updated: 2026-09-02
severity: medium
uncertain: which production org Elena Spini could not reach on 1 September; she works across several clients and never named it
source: Slack DM Aurel Mrruku - Elena Spini (D0B5QHS2T7H), 2026-09-01 09:37-10:23 CEST
resolved_by: Aurel Mrruku, direct confirmation 2026-09-02; corroborated by org-status-check 2026-09-02T08:05-08:14Z
---

# Risk - the team lost access to the Pienissimo orgs on 1 September

> ✅ **Resolved 2026-09-02.** Aurel Mrruku answered the ask below — _"yes its
> working, we have fixed it"_ — and an org inspection the same morning reached
> the sandbox independently. Read [the resolution](#2026-09-02---resolved)
> before acting on anything here. The account of 1 September is kept intact,
> because the uncertainty it refused to guess at is exactly what got answered.

**On the morning of 1 September, ROMI's technical lead could not get into the
Pienissimo sandbox and ROMI's project manager could not get into production.**

The record is a Slack DM, in full:

- **09:37 CEST — Aurel Mrruku:** _"non posso accedere alla sandbox di
  pienissimo"_, immediately followed by _"ci possiamo sentire 5 min"_.
- **09:38 — Elena Spini:** _"chiama quando vuoi"_. A call follows.
- **10:22 — Elena Spini:** _"comunque quando vuoi vediamo quella rottura di
  1password ma anche io non accedo a PROD -.- perché"_.

Nothing after that says the problem was fixed.

## Why it is worth a note rather than a shrug

**Fase 1 development is due to end on 10 September.** An org-access outage on
1 September costs days that the
[compressed calendar](Risk%20-%20the%20whole%20remaining%20build%20lands%20after%20Ferragosto.md)
does not have. Aurel Mrruku is the only person building the Salesforce side of
Anticipay, WooCommerce and Mexal.

It also lands in a week where the sandbox is the **only** place several findings
can be checked: the deleted `Biglietto__c` recycle-bin window closes around
**12 September**
([the dataset risk](Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md)),
and the unversioned `WoocommerceOrderService`
([the deploy risk](Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md))
can only be read out of the org. **Both of those decay, and both need org
access.**

## What is uncertain, and must not be guessed

- **Whether access was restored.** They moved to a voice call at 09:38 and the
  channel carries no resolution. It may have been fixed in five minutes.
- **Which PROD Elena Spini meant.** The DM is a Pienissimo conversation, but she
  works across several clients and did not name the org. Do not assume it is the
  Pienissimo production org.
- **Whether 1Password is cause or coincidence.** _"quella rottura di 1password"_
  reads as a known, pre-existing annoyance being mentioned in passing, not as a
  diagnosis.

## A sequence worth noticing, without claiming it is a cause

On **31 August 15:41–15:47Z** — the previous afternoon — three Salesforce
notices arrived for the `techromi@pienissimo.com` account: an account
verification, an unrecognised-browser sign-in notice (Chrome / Windows 10), and
**a new verification method added to the account**. Aurel Mrruku forwarded the
last of these to Sara Aga at 15:47Z.

[The 31 August trace](../traces/Source%20trace%202026-08-31.md) deliberately did
not ingest these, correctly, as routine authentication traffic with no project
content. With an access failure the next morning they are worth **re-reading as
context** — but the notices concern a different org
(`ability-customization-52152.my.salesforce.com`, not the Pienissimo UAT org
`00DMA000004nMMr2AM`), so on the evidence held **they are not the cause**. No
credential or verification value has been read or copied.

## The ask

**One line from Aurel Mrruku:** is org access working now? If it is, this note
closes as a blip. If it is not, it is the highest-priority item on the project,
ahead of every open design question, because nothing else can be built or
verified without it.

✅ **Answered on 2026-09-02.** See below.

## 2026-09-02 - Resolved

**Asked directly whether org access was working, Aurel Mrruku answered:** _"yes
its working, we have fixed it"_. That is the line this note was waiting for, and
it closes as the blip it hoped to be.

It does not rest on that alone. An `org-status-check` run on **2026-09-02,
08:05-08:14Z** authenticated to the Pienissimo UAT org (`00DMA000004nMMr2AM`) as
`a.mrruku@pienissimo.uat` and completed a full inventory - 1,072 org components,
Metadata API listings, Tooling field, permission and coverage queries, and
targeted aggregates - with no authentication failure anywhere in the run. The
lockout does not reproduce for that principal.

### What this does not establish

Aurel Mrruku's _"we"_ is **not** evidence about Elena Spini's production login.
The original question of **which** PROD she meant is untouched: she works across
several clients, never named the org, and the note's own instruction not to
assume it was Pienissimo production still stands. If her access matters, it
needs its own line from her.

Nor does anything here bear on _why_ it broke. The 31 August verification
notices remain what [the note above](#a-sequence-worth-noticing-without-claiming-it-is-a-cause)
said they were - context on a different org, not a cause - and "we have fixed
it" names no mechanism. 1Password is still neither confirmed nor excluded.

### What it unblocks

Both decaying findings this note guarded can now be worked from inside the org:

- the `Biglietto__c` recycle-bin window, which still closes around
  **12 September** and is unaffected by this
  ([the dataset risk](Risk%20-%20the%20Biglietto%20UAT%20ticket%20dataset%20was%20deleted.md));
- the unversioned `WoocommerceOrderService`, which the same 2 September run
  found **already committed and byte-identical to the deployed class**
  ([the deploy risk](Risk%20-%20a%20clean%20deploy%20would%20orphan%20the%20live%20WooCommerce%20endpoint.md)).
  That evidence closes that risk too, but it is **not amended here** - it needs
  its own pass.
