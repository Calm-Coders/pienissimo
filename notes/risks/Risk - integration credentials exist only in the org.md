---
id: risk-named-credentials-org-only
type: risk
status: open
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-02
depends_on: [OI-94, OI-102]
blocks: [go-live]
requirement: [INT-18, INT-19]
source: org-status-check against Pienissimo UAT, 2026-09-02 08:05-08:14Z
evidence: Metadata API NamedCredential and PermissionSet listing vs force-app on all branches
---

# Risk - integration credentials exist only in the org

**Two named credentials, `Anticipay` and `DocuSign`, are configured in the
Pienissimo UAT org and exist in no branch of this repository.** So are three
permission sets: `DocuSign`, `Full_Permission` and `Sales_User`.

This is the **third** instance of the same pattern in six days, and the first
two both cost something:

| Component                                  | Discovered | Outcome                                                            |
| ------------------------------------------ | ---------- | ------------------------------------------------------------------ |
| The Biglietto Apex stack, 7 components     | 2026-08-31 | Deleted from the org 28 Aug. **Gone** — never in git on any branch |
| `WoocommerceOrderService`                  | 2026-08-31 | Caught in time; committed by 2026-09-02                            |
| `Anticipay` / `DocuSign` named credentials | 2026-09-02 | Still org-only                                                     |

## Why a named credential is the worst kind to lose

A named credential is not just configuration — it is **where the endpoint and
the authentication live**. Losing one does not produce a compile error or a
missing-component message. The callout simply fails at runtime, in an
integration, against a third party, with nothing in `force-app/` to say what the
value used to be.

The `Anticipay` credential is the sharper of the two. The
[middleware contract](../The%20Anticipay%20middleware%20API%20contract.md) was
only agreed on 1 September, the bearer token is
[a single static string shared across both environments](../items/OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md),
and nobody has written down where the org's copy of it came from. A sandbox
refresh takes both the credential and the only record of its configuration.

## What this does NOT mean

**It does not mean the Anticipay integration works.** It does not.
[The integration scaffolding](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)
still holds **zero** `Integration_Configuration__c` rows and **zero** object
permissions on that object, so the house callout engine has no endpoint and no
principal regardless of what named credentials exist. A credential with nothing
wired to it is scaffolding too.

Nor does it mean somebody did something wrong. A named credential is created in
Setup by hand; nothing in the normal workflow prompts you to retrieve it into
source. That is precisely why it keeps happening.

## 🔴 2026-09-02 - the Anticipay credential is probably pointing at a dead host

**Timing puts this beyond doubt as a question, even though the value has not been
read.**

| Time (2026-09-02) | Event                                                                                                              |
| ----------------- | ------------------------------------------------------------------------------------------------------------------ |
| 08:05–08:14Z      | the org check finds a named credential `Anticipay` already configured                                              |
| 08:21:59Z         | Aurel Mrruku reports `integration.pienissimo.com` **does not resolve** — `HTTP/1.1 404`, `Content-Type: text/html` |
| 10:18:26Z         | Andrea Parmeggiani moves the API to **`romi.pienissimo.com`** and sends v3                                         |
| 10:40:45Z         | Aurel Mrruku confirms _"adesso funziona"_                                                                          |

So the credential was created **before the host existed**, against the only
hostname anyone had — the one that never worked. **It almost certainly carries
`integration.pienissimo.com`.**

This sharpens the risk in a way nobody planned: the argument above was that a
named credential is dangerous because it holds the endpoint and nothing in
`force-app/` records it. Here the endpoint it holds is **known to be wrong**, and
because it is org-only there is no diff, no review and no deploy that would
surface it. It fails at runtime, as an HTML `404`, which
[OI-107](../items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)
shows the house engine would log as an **Apex parse error with no status code**.

**Check it in Setup before anything is wired to it**, and fix the host as part of
the same retrieve. ⚠ Read the endpoint only — do not copy the token anywhere.

## The ask

**Retrieve both named credentials and the three permission sets into
`force-app/` and commit them**, before anything else touches the sandbox. It is
a targeted retrieve, not a rebuild, and it closes the pattern rather than the
instance.

⚠ **Do not commit credential secrets.** A `NamedCredential` retrieve carries the
endpoint and the principal configuration; the password or token field comes back
masked, and it must stay that way. If a retrieve ever produces a live secret in
plain text, stop and treat it as
[the publishing rules](../../docs/publishing.md) require — the repository is
private, but git history is forever.
