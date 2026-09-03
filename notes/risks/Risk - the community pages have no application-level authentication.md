---
id: RISK-community-auth
type: risk
status: open
severity: gating
owner: Aurel Mrruku
with: Rexhina Hysi
org: ROMI
raised: 2026-09-03
updated: 2026-09-03
depends_on: [OI-68, OI-78, OI-102]
requirement: INT-16
source: force-app/main/default/classes/QuoteAcceptanceController.cls, force-app/main/default/classes/ParticipantRegistrationController.cls, read at DevMain after PR #31
---

# Risk - the community pages have no application-level authentication

**Both pages in [the Landing Page community](../objects/The%20Landing%20Page%20community.md)
authorise on a Salesforce record id and nothing else. A quote can be accepted by
anyone who has its id.**

## What the code does

`QuoteAcceptanceController` and `ParticipantRegistrationController` are both
`public without sharing`. Their `@AuraEnabled` entry points take raw ids:

```apex
public static PageResponse submitAction(String quoteId, String action)
public static PageResponse loadPage(String accountId, String campaignId)
public static ContactResponse findContact(String accountId, String campaignId, String email)
```

The whole of the participant page's access check is `resolveAccess`, which parses
the two ids, queries the Account and the Campaign, and throws only if either
**fails to parse or does not exist**:

```apex
if (accounts.isEmpty() || campaigns.isEmpty()) {
  throw invalidLink();
}
```

There is no token, no signature, no expiry, no nonce, and no test that the caller
has any relationship to the record. The quote page does less still — it parses
the id, checks the status is in `{In Trattativa, In Attesa Accettazione}`, and
writes.

## What that allows

- **Accepting or rejecting someone else's quote.** `submitAction` flips
  `Quote.Status` to `Accettato` or `Rifiutato` for any actionable quote whose id
  reaches it. Under the agreed design this is the event that generates the order
  ([OI-68](../items/OI-68%20Quote%20acceptance%20landing%20page.md)) — a
  commercial commitment, triggered by an unauthenticated call.
- **Reading a customer's ticket holdings.** `loadPage` returns the account name,
  campaign, event dates and every visible Asset with the holder's name, email and
  phone.
- **Confirming whether an email belongs to a company.** `findContact` answers
  that question for any account id, which is an enumeration oracle over personal
  data.

**Salesforce record ids are not secret.** This project hands them out
deliberately: the marketing mail carries the Account id in the landing-page link
([OI-78](../items/OI-78%20Participant%20data%20collection.md)), and the
WooCommerce checkout link carries the opportunity id in clear
([the payload contract](../The%20WooCommerce%20payload%20contract.md)). An id that
is mailed to customers is a bearer token that never expires and cannot be
revoked.

⚠ **Whether the site's guest user can reach these methods at all was not
verified** — that needs the org, and this session did not open it. If the guest
profile denies access, the exposure narrows to authenticated community members
and the finding becomes about horizontal privilege rather than anonymous access.
**It does not become a non-issue**: `without sharing` plus id-only authorisation
means any community member can act on any other member's quote. Confirm at the
next `org-status-check`.

## Why this is the pattern and not an incident

**Third instance in eight days of an internet-facing entry point with no
application-level authentication:**

1. **`INT-16`** — the WooCommerce endpoint, `global without sharing`, no token or
   signature check anywhere in the class, still unauthenticated after a full
   rewrite
   ([OI-102](../items/OI-102%20Salesforce%20endpoint%20and%20token%20for%20the%20WooCommerce%20plugin.md)).
2. **The checkout link**, which carries the opportunity id in clear and has no
   signature field in the envelope at all.
3. **These two pages.**

The register's own `INT-16` recommends a **signed** token. Nothing built so far
has one. This is worth fixing once, as a shared pattern, rather than three times.

## What would fix it

The cheapest correct shape is the one the project has already written down and
not built: a **signed, expiring token** in the link, verified server-side before
any read or write, with the record id carried inside it rather than as the
parameter. That covers all three surfaces.

**Nothing has been changed in the code by this session** — this is a finding from
a read, raised for a human to schedule. It is marked `gating` because it is a
write path on commercial records, reachable from a link, five weeks before
go-live.
