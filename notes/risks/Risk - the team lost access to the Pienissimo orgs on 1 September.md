---
id: RISK-org-access-2026-09-01
type: risk
status: open
owner: Aurel Mrruku
with: Elena Spini
org: ROMI
raised: 2026-09-01
updated: 2026-09-01
severity: medium
uncertain: whether access was restored; the conversation moved to a voice call and nothing was written down afterwards
source: Slack DM Aurel Mrruku - Elena Spini (D0B5QHS2T7H), 2026-09-01 09:37-10:23 CEST
---

# Risk - the team lost access to the Pienissimo orgs on 1 September

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
