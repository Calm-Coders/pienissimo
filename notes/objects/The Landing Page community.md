---
id: OBJ-landing-page-community
type: object
status: active
owner: Rexhina Hysi
with: Aurel Mrruku
org: ROMI
raised: 2026-09-03
updated: 2026-09-03
source: git PR #31 (Calm-Coders/pienissimo), merged to DevMain 2026-09-03T15:02:59Z; Salesforce site-publication notices 2026-09-03
---

# The Landing Page community

**An Experience Cloud site carrying both external-facing pages this project has
been designing since 6 August landed in one pull request on 3 September, and it
is in no tracker.**

## What was merged

PR **#31**, branch `DevMain_RexhinaPien`, opened by **Rexhina Hysi** at
14:21:11Z and merged to `DevMain` by **Aurel Mrruku** at **15:02:59Z** — 41
minutes later. **82 files, +4,402 lines, no deletions.** Commit titles:
_"updates on comunity"_, _"quote comunity page"_, _"comunity page"_, _"delete
unneccessary pages"_, _"update controller"_.

| Component                                   | What it is                                                  |
| ------------------------------------------- | ------------------------------------------------------------ |
| `sites/Landing_Page.site-meta.xml`          | the site                                                    |
| `networks/Landing Page.network-meta.xml`    | the community network                                       |
| `profiles/Landing Page Profile`             | the site's profile                                          |
| `digitalExperiences/.../Landing_Page1`      | 67 files — home, login, register, forgotPassword, error, newsDetail, serviceNotAvailable, tooManyRequests, checkPasswordResetEmail |
| `lwc/participantRegistrationPage`           | 212 HTML / 335 JS / 299 CSS                                 |
| `lwc/quoteAcceptancePage`                   | 188 HTML / 179 JS / 308 CSS                                 |
| `classes/ParticipantRegistrationController` | **576 lines**                                               |
| `classes/QuoteAcceptanceController`         | **268 lines**                                               |

It was published to the Pienissimo UAT sandbox the same day: the site welcome
mail went out at **09:51Z**, and Salesforce confirmed _"Landing Page was
published successfully"_ at **13:48Z** and again at **14:10Z**, live at
`ability-customization-52152--partial.sandbox.my.site.com`. **So it was published
before it was merged.**

## What it settles, by building rather than deciding

🟢 **[OI-68](../items/OI-68%20Quote%20acceptance%20landing%20page.md) and
[OI-78](../items/OI-78%20Participant%20data%20collection.md) share one surface.**
Both notes ended with the same open question — whether the quote page and the
participant page are the same thing — and both are now answered: one Experience
site, two LWCs.

🟢 **The quote page uses the agreed status values.** `In Trattativa` and `In
Attesa Accettazione` are actionable; the outcomes are `Accettato` and
`Rifiutato`. That is exactly the lifecycle
[OI-59](../items/OI-59%20Quote%20workflow%20configuration.md) fought for, and the
first time built code has matched it.

🔴 **[OI-86](../items/OI-86%20Who%20hosts%20the%20participant%20landing%20page.md)
is answered by build and still open in the record.** The question was Salesforce
community versus the marketing platform's own page, and it was to be decided on
Rebecca Marmo's call — **which has never been scheduled beyond "after 17
August"**. A developer was told to _"work on the Pienissimo community"_ in a
Slack DM on 2 September; the community was merged the next day. **Nothing in the
record decided this. Somebody should say so out loud before Parte 2.**

## Where the build departs from the agreed design

🔴 **The quote page skips DocuSign entirely.** OI-68's agreed flow is: link →
landing page showing preventivo + contratto + condizioni generali → **Accetto
sends the documents via DocuSign** → **on signature** the quote flips to
`Accettato` and the order is generated. What was built is
`QuoteAcceptanceController.submitAction`, which sets `Quote.Status` directly on
the button click:

```apex
update new Quote(Id = quoteRecord.Id, Status = nextStatus);
```

No envelope, no signature, no order generation. ⚠ It lands the day after
[OI-111](../items/OI-111%20DocuSign%20licences%20are%20not%20confirmed%20with%20the%20client.md)
recorded that **nobody has confirmed the client owns DocuSign** — but **nothing
in the PR, the commits or any message connects the two.** Do not report this as a
decision to drop DocuSign; report it as a page that does not use it, and ask.

⚠ **The participant page's field list should be checked against OI-78.** That
note records an unsettled divergence — the 6 August session specified name,
surname, email **and phone**; the 19 August diagram dropped the phone. The built
`TicketRow` carries `firstName`, `lastName`, `email` **and `phone`**, so the
build has picked a side. Fine, but it picked it silently.

## How the pages are addressed

Both controllers are entered with **bare Salesforce record ids** and nothing else:

- `ParticipantRegistrationController.loadPage(accountId, campaignId)` and
  `findContact(accountId, campaignId, email)`
- `QuoteAcceptanceController.loadPage(quoteId)` and
  `submitAction(quoteId, action)`

That matches how the links were always described — the 19 August diagram has the
marketing mail carrying **a link with the Account ID embedded in it**, and the
WooCommerce checkout link carries the opportunity id in clear
([the payload contract](../The%20WooCommerce%20payload%20contract.md)). It also
means the id **is** the credential. See
[the authentication risk](../risks/Risk%20-%20the%20community%20pages%20have%20no%20application-level%20authentication.md).

## Coverage

⚠ **844 uncovered Apex lines added in one day**, against a deficit last measured
at 1,571 lines and zero covered
([the deploy risk](../risks/Risk%20-%20production%20deploy%20is%20blocked%20by%20Apex%20coverage.md)).
Recorded because the coverage records are the brief for the test suite when it is
requested. **Not to be acted on** — the suite is written once, as its own task,
before the production deploy.

## Verified against

The repository at `DevMain` after the merge, read directly. **The org was not
opened this session**, so what is deployed beyond the two publication notices is
`org-status-check`'s to confirm.
