# Publishing the status page

The repository stays **private**. Only the contents of [`site/`](../site/) are
ever published.

Everything in `site/` is served on a public URL with no authentication — that is
deliberate, because the page is meant to be readable by people and by AI agents
that have no GitHub or Cloudflare credentials. Treat `site/` as a public folder
inside a private repository.

## What may go in `site/`

**Permitted:** delivery phase, milestone dates, item counts, workstream status,
role names without person names.

**Not permitted:** individual names, email addresses, phone numbers, meeting
transcripts or quotes, **catalogue prices**, commercial terms, credentials,
endpoint URLs, tokens, authentication schemes, org aliases, or any description
of a security weakness.

Two categories are specific to this project and easy to leak by accident:

- **Catalogue prices and article codes.** Every price currently in UAT is a ROMI
  placeholder — see
  [the risk](../notes/risks/Risk%20-%20placeholder%20prices%20could%20reach%20the%20client.md).
  Publishing an invented price for a client's own product is worse than
  publishing a real one. No prices, real or placeholder, go in `site/`.
- **The Mexal WEBAPI credentials**, which arrived by email on 15 July. They must
  not appear in `site/`, in `notes/`, in the recaps, or in a commit.

## Before every deploy

Run the leak check from the repository root:

```bash
grep -rnEi "rinaldi|migliano|montesi|paganelli|morgese|parmeggiani|marmo|mastracci|spini|mrruku|di ?cicco|galotto|merendi|bocchieri|\b(anita|sara)\b|rexhina|calm.?coders|@pienissimo|@romicompany|@calmcoders|passepartout|webapi|token|jwt|password|placeholder" site/
```

No output means the page is clean. If a match is legitimate — the word "token"
in an unrelated sentence — narrow the pattern rather than skipping the check.

Also confirm no file under `site/` references `anar_PIE_ricla.xlsx`, the org
alias, or any `OI-NN` body text copied verbatim from the trackers.

## How it would be hosted

**Nothing is deployed yet.** `site/` exists and is sanitized; no public URL has
been created for this project.

When one is wanted, follow the pattern used on the sister project:

- **Cloudflare Pages, direct upload** of the `site/` folder with `wrangler` —
  not a Git connection. Direct upload needs no GitHub App installed on the
  `Calm-Coders` organisation, so Cloudflare holds no access to the private
  repository at all. The trade-off is that deployment is a command rather than
  automatic on push, and no branch gets a public preview URL.
- GitHub Pages cannot serve a private repository on the organisation's current
  Free plan.
- **Give the project name a random suffix** so the URL is not guessable from the
  client name. That is obscurity, not security — the page and `_headers` ask
  crawlers not to index it, but anyone with the URL can read it. Publish
  accordingly.

Record the project name and live URL here once one exists, and add it to
[MAP.md](../MAP.md).

## The other publication channel

This project also publishes **artifacts on claude.ai**, listed in
[README.md](../README.md). They are private unless shared, but several have been
shared with the client, and at least one — the catalogue analysis — is built on
placeholder prices. The rules above apply to anything shared onward, and the
README's standing note about which artifacts are still accurate should be kept
current.
