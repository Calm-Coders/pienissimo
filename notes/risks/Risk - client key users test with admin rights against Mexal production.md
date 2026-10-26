---
id: risk-key-users-admin-mexal-prod
type: risk
status: open
owner: Elena Spini
org: both
raised: 2026-10-19
updated: 2026-10-19
depends_on: [OI-240, OI-262]
source: notes/meetings/2026-10-19 Test UAT Commerciali.md
---

# Risk - client key users test with admin rights against Mexal production

**Pienissimo's key users are running their own test week on System Administrator
profiles, in an org whose Account fields are wired to the Mexal production
environment. The only control in place is a verbal warning given once, in a
session where the person warned was simultaneously on another call.**

## The two facts, both from the record

**Admin rights.** Elena Spini to Marco Montesi,
[19/10](../meetings/2026-10-19%20Test%20UAT%20Commerciali.md) `00:25:14`:

> _"per questa prima fase di test hai un'utenza da super admin, quindi puoi fare
> cose che in realtà poi … come ruolo commerciale non potrai"_

She confirmed the same profile for Sabatino Rinaldi at `00:43:18` —
_"verrete creati con utenza di amministratore"_ — and the rights were exercised
during the walkthrough: Marco Montesi forced a lead stage transition the normal
path refuses, and she told him he could (_"lo puoi forzare, soprattutto adesso
che poi hai questi super permessi"_).

**Mexal production.** Same session, `00:31:03`, with the Account's Mexal fields
editable on screen:

> _"fate molta attenzione, cioè tu adesso vedi la matitina, cioè vuol dire che tu
> puoi andare a editarli, ma in realtà siamo collegati con l'ambiente di M[ex]al
> di produzione, quindi attenzione a tutto ciò che è M[ex]al."_

> _"fate tutti i test che volete, però mi raccomando, cioè con molta attenzione …
> o poi devi sentirti con Fabrizio a tuo rischio e pericolo."_

## Why the mitigation is weaker than it sounds

- 🔴 **It is a verbal warning, given once, and not repeated in writing.** No mail,
  no Slack message and no written test protocol in this sweep carries it.
- 🔴 **It was given to someone who was on another call.** For most of the window
  around it Marco Montesi's audio carries an unrelated conversation; he says so
  himself. **Whether he heard this specific warning cannot be established from
  the transcript**, and he acknowledged it with _"chiaro, chiaro, chiaro"_ in the
  middle of that bleed.
- 🔴 **Five client-side users now, and the test week is unsupervised.** Sabatino
  Rinaldi declined a ROMI session for the rest of the week — _"dacci il tempo di
  usarla"_ — so **19–23/10 runs with no ROMI person watching**, and their own
  review is Friday 23/10.
- ⚠ **Sabatino Rinaldi's stated intent is read-only** — _"devo solo guardare,
  quindi non farò nulla"_ — which an administrator profile does not enforce.
- ⚠ **Precedent exists for test data reaching production.** The 16/10 UAT ran the
  marketing chain in production with fake data, and
  [OI-256](../items/OI-256%20A%20test%20contact%20phone%20number%20did%20not%20reach%20the%20CRM.md)
  records a test write landing on a real production contact.

## What would reduce it

Either the interim commercial profile that
[OI-240](../items/OI-240%20Marco%20Montesi%20needs%20a%20Salesforce%20user%20before%20go-live.md)
has deferred since 15/10 is decided and assigned — which also gets the key users
testing the permissions they will actually hold — or the Mexal fields are made
read-only for these users for the duration of the test week, or the warning is
reissued in writing with the specific fields named. **None of the three is in
hand.**

⚠ **The profile question is also blocking three build items** (OI-233, OI-247
and OI-250), so deciding it pays twice.
