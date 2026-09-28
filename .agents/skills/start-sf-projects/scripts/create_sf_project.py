#!/usr/bin/env python3
"""Create a guarded Salesforce DX project with a manifest and trace templates."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import shutil
import subprocess
import sys
import unicodedata
from pathlib import Path


GITHUB_OWNER = "Calm-Coders"

# Terms that must never reach the published status page. Extended per project with the
# real participant surnames once first-run research has identified them.
LEAK_TERMS = "token|jwt|password|secret|api[_-]?key|@gmail|@outlook"


def pages_project(slug: str) -> str:
    """Cloudflare Pages project name: stable per slug, not derivable from the client name alone."""
    suffix = hashlib.sha256(f"pages:{slug}".encode()).hexdigest()[:6]
    return f"{slug[:40]}-status-{suffix}"


def one_line(value: str) -> str:
    """Make user input safe for single-line Markdown fields."""
    return " ".join(value.replace("|", "\\|").split())


def derive_slug(name: str) -> str:
    ascii_name = unicodedata.normalize("NFKD", name).encode("ascii", "ignore").decode()
    slug = re.sub(r"[^a-zA-Z0-9]+", "-", ascii_name).strip("-").lower()
    slug = re.sub(r"-{2,}", "-", slug)
    if not slug:
        raise ValueError("Project name must contain at least one ASCII letter or digit.")
    if len(slug) > 100:
        raise ValueError("Derived project slug exceeds GitHub's 100-character limit.")
    return slug


def gmail_subject_tag(slug: str) -> str:
    return f"[ROMI-{slug.upper()}]"


def require_command(name: str) -> str:
    command = shutil.which(name)
    if not command:
        raise RuntimeError(f"Required command not found on PATH: {name}")
    return command


def run(command: list[str], cwd: Path | None = None, check: bool = True) -> subprocess.CompletedProcess[str]:
    completed = subprocess.run(
        command,
        cwd=cwd,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )
    if check and completed.returncode:
        detail = (completed.stderr or completed.stdout).strip()
        raise RuntimeError(f"Command failed ({completed.returncode}): {' '.join(command)}\n{detail}")
    return completed


def select_sf_command(sf: str) -> list[str]:
    current = [sf, "template", "generate", "project"]
    if run(current + ["--help"], check=False).returncode == 0:
        return current
    legacy = [sf, "project", "generate"]
    if run(legacy + ["--help"], check=False).returncode == 0:
        return legacy
    raise RuntimeError("Installed Salesforce CLI cannot generate projects.")


def readme(display_name: str, slug: str, slack: str | None) -> str:
    slack_value = one_line(slack) if slack else "None provided"
    subject_tag = gmail_subject_tag(slug)
    return f"""# {one_line(display_name)}

Salesforce DX project initialized with a deployment/retrieval manifest, a source-backed project context
trace, and a tool-neutral knowledge vault.

## Applications you need

Install these before working on the project. The first four are required for anything; the rest depend on
what you are doing.

| Application               | Version         | Why it is needed                                                                 |
| ------------------------- | --------------- | -------------------------------------------------------------------------------- |
| **Git**                   | any recent      | Version control. The repository is private, under `{GITHUB_OWNER}`.               |
| **Node.js + npm**         | 20 LTS or newer | Runs every `npm run` script: ESLint, Prettier, Jest (`sfdx-lwc-jest`), the Husky pre-commit hook, and `vault:check`. |
| **Salesforce CLI (`sf`)** | latest          | Authenticating to orgs, retrieving and deploying metadata.                        |
| **Salesforce org access** | -               | A sandbox or scratch org you are permitted to deploy to.                          |
| **Java JDK**              | 17 (11 minimum) | Required by the Apex Language Server inside the Salesforce VS Code extensions. Only needed if you edit Apex in VS Code. |
| **VS Code**               | latest          | Recommended editor. Accept the workspace extension prompt - see [`.vscode/extensions.json`](.vscode/extensions.json). |
| **Obsidian**              | 1.5+            | Reads [`notes/`](notes/) as a graph with backlinks. Optional - the vault is plain Markdown and works in any editor - but it is the intended cockpit. |
| **Python**                | 3.9+            | Only for the `start-sf-projects` scaffolder scripts.                              |
| **Cloudflare account**    | -               | Publishing the public status page, via `npx wrangler`. Needs the `pages (write)` scope. |

First-time setup:

```sh
npm install                 # installs dev dependencies and the Husky hook
sf org login web --alias <org-alias>
```

Open the repository root as your Obsidian vault - not a subfolder - so the links between `MAP.md` and
`notes/` resolve.

## Where to start reading

This repository holds more project knowledge than code. Read it in order, or you will load documents you
did not need:

1. [`MAP.md`](MAP.md) - current state, what is blocked, who owns it.
2. [`INDEX.md`](INDEX.md) - a router listing every artifact with its read cost.
3. [`notes/`](notes/) - atomic notes, one fact each. The source of truth.

[`AGENTS.md`](AGENTS.md) is the canonical instruction file for **any** AI agent - Claude Code, Codex,
Cursor, Gemini, Copilot. `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md` are thin pointers
to it, so all tools follow one contract. Rules for reading and writing the vault are in
[`notes/agent-protocol.md`](notes/agent-protocol.md), and [`JOURNAL.md`](JOURNAL.md) carries session
handoffs so you can switch tools mid-project.

Never open a file matching `meetings/*-transcript.*.md`. They are verbatim transcripts worth tens of
thousands of tokens. Search them with `rg` and read only the matching range.

```sh
npm run vault:check   # frontmatter, unique ids, and link integrity across notes/
```

## Project details

- Salesforce project key: `{slug}`
- GitHub: https://github.com/{GITHUB_OWNER}/{slug}
- Manifest: `manifest/package.xml`
- Default source directory: `force-app`
- Slack channel: {slack_value}
- Gmail subject tag: `{subject_tag}`
- Research trace: [`docs/project-context.md`](docs/project-context.md)

## Project intelligence

- Use `$drill-meeting` when a meeting transcript arrives. It preserves the source, extracts facts into `notes/`, then regenerates the bilingual recaps and trackers from those notes.
- Use `$drill-me` to run an interactive decision session against the current blockers and open items.
- Use `$requirements-check` to sweep **email, chat and Drive** for anything new since the last check, drill any new meeting, and fold the findings into the records. Each run writes a trace note under [`notes/traces/`](notes/traces/) that becomes the watermark for the next one.
- Use `$org-status-check` to compare the recorded requirements, committed source and what is **actually implemented in the Salesforce org**. It reports compliance, deployment drift and operability separately. Reporting is read-only; reconciliation and publishing [`STATUS.md`](STATUS.md) or its Notion mirror are explicit modes. Recurring Slack DM delivery remains disabled until a user explicitly authorizes it and the exact recipient id is verified.
- Project-local skills are available under `.agents/skills/` for open-standard agents and `.claude/skills/` for Claude Code. Tools without a skills mechanism can simply be told to follow `.agents/skills/drill-me/SKILL.md`.
- Meeting state lives in [`meetings/`](meetings/), with recaps in [`meetings/results/`](meetings/results/) and design proposals in [`meetings/proposals/`](meetings/proposals/). Those files are **rendered views** of `notes/`, not the place a fact lives.

## Internal status page

[`STATUS.md`](STATUS.md) is the shareable status view, regenerated from `notes/`. It is **internal** - it
names people and states the slippage plainly - and is mirrored to Notion, invite-only, for colleagues who
do not read the repository.

The mirror is not created by the scaffolder: the Notion page ids only exist once the pages do. Publishing
the first time is a one-time step for an agent session that has the Notion connector, described in
[`notes/The Notion mirror of the project status.md`](notes/The%20Notion%20mirror%20of%20the%20project%20status.md). Until then `STATUS.md` stands alone, which is a
perfectly good place to stop.

## Public status page

Not to be confused with `STATUS.md` above, which is internal. This one is public, and the two are
sanitized to different rules - never copy text from the internal surface into `site/`.

A sanitized delivery-status page is published from [`site/`](site/) while this repository stays private.

- Live URL: **https://{pages_project(slug)}.pages.dev**
- Source: [`site/index.html`](site/index.html), rebuilt from `meetings/open-items.md` and `meetings/DEVELOPMENT-RECAP.md`
- Hosting: Cloudflare Pages project `{pages_project(slug)}`, direct upload — see [`docs/publishing.md`](docs/publishing.md)
- The URL is public and unauthenticated by design, so any person or AI agent can read it without credentials.

Everything under `site/` is public the moment it is deployed. No names, contact details, commercial terms,
credentials or endpoint details belong there — run the leak check in [`docs/publishing.md`](docs/publishing.md)
before each deploy. Deploys are manual:

```sh
npx wrangler pages deploy site --project-name={pages_project(slug)} --branch=main
```

## Typical commands

```sh
sf org login web --alias <org-alias>
sf project retrieve start --manifest manifest/package.xml --target-org <org-alias>
sf project deploy start --manifest manifest/package.xml --target-org <org-alias>
```

Review the manifest and target org before retrieving or deploying. Project creation itself does not modify a Salesforce org.
"""


def context_template(display_name: str, slack: str | None) -> str:
    slack_status = "pending" if slack else "not applicable"
    slack_value = one_line(slack) if slack else "None"
    subject_tag = gmail_subject_tag(derive_slug(display_name))
    return f"""# Project Context: {one_line(display_name)}

Last updated: pending

## Research status

- Gmail: pending
- Gmail subject tag: `{subject_tag}`
- Slack: {slack_status}
- Slack channel: {slack_value}

## Executive summary

Pending first-run research.

## Requirements and scope

- Pending

## Decisions

- Pending

## People and ownership

- Pending

## Dates and milestones

- Pending

## Open questions

- Pending

## Evidence trace

| Source | Date | Author | Location | Finding | Reference |
| --- | --- | --- | --- | --- | --- |
| Pending | - | - | - | First-run research has not been recorded. | - |

## Search log

| Source | Searched at | Query or scope | Result |
| --- | --- | --- | --- |
| Gmail | pending | project name variants plus `subject:"{subject_tag}"` | pending |
| Slack | pending | {slack_value} | {slack_status} |
"""


def meeting_templates(display_name: str) -> dict[str, str]:
    name = one_line(display_name)
    return {
        "meetings/.gitkeep": "",
        "meetings/results/.gitkeep": "",
        "meetings/proposals/.gitkeep": "",
        "meetings/open-items.md": f"""# Open Items - {name}

Tracked meetings: none yet.

## Open

| # | Item | Owner | Raised | Last touched | Status | Notes |
| --- | --- | --- | --- | --- | --- | --- |

## Resolved

| # | Item | Owner | Resolved | Resolution | Evidence |
| --- | --- | --- | --- | --- | --- |
""",
        "meetings/open-items.it.md": f"""# Punti aperti - {name}

Riunioni tracciate: nessuna.

## Aperti

| # | Punto | Responsabile | Aperto | Ultimo aggiornamento | Stato | Note |
| --- | --- | --- | --- | --- | --- | --- |

## Risolti

| # | Punto | Responsabile | Risolto | Risoluzione | Evidenza |
| --- | --- | --- | --- | --- | --- |
""",
        "meetings/DEVELOPMENT-RECAP.md": f"""# Development Recap - {name}

Last updated: not yet.

Status: complete / in progress / blocked.

## 1. Project frame

- No meeting evidence recorded yet.

## 2. Data model

- No meeting evidence recorded yet.

## 3. Automation and flows

- No meeting evidence recorded yet.

## 4. Integrations

- No meeting evidence recorded yet.

## 5. Analytics and reporting

- No meeting evidence recorded yet.

## 6. Security and access

- No meeting evidence recorded yet.

## 7. Configuration and environments

- No meeting evidence recorded yet.

## 8. Resolved decisions

- None recorded.

## 9. Blocking decisions

- None recorded.
""",
        "meetings/DEVELOPMENT-RECAP.it.md": f"""# Riepilogo sviluppo - {name}

Ultimo aggiornamento: non ancora disponibile.

Stato: completato / in corso / bloccato.

## 1. Quadro del progetto

- Nessuna evidenza da riunioni ancora registrata.

## 2. Modello dati

- Nessuna evidenza da riunioni ancora registrata.

## 3. Automazioni e flussi

- Nessuna evidenza da riunioni ancora registrata.

## 4. Integrazioni

- Nessuna evidenza da riunioni ancora registrata.

## 5. Analisi e reportistica

- Nessuna evidenza da riunioni ancora registrata.

## 6. Sicurezza e accessi

- Nessuna evidenza da riunioni ancora registrata.

## 7. Configurazione e ambienti

- Nessuna evidenza da riunioni ancora registrata.

## 8. Decisioni risolte

- Nessuna decisione registrata.

## 9. Decisioni bloccanti

- Nessuna decisione registrata.
""",
    }


def site_templates(display_name: str, slug: str) -> dict[str, str]:
    """Starter files for the public status page. Everything here is served publicly."""
    name = one_line(display_name)
    project = pages_project(slug)
    index = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow, noarchive">
<title>__NAME__ &mdash; Delivery Status</title>
<style>
  :root {
    --bg:#fff; --surface:#f7f8fa; --border:#e2e5ea; --text:#14171c; --muted:#5f6672;
    --ok:#1c7a4a; --warn:#a35c00; --stop:#b3261e; --idle:#6a707c;
  }
  @media (prefers-color-scheme: dark) {
    :root {
      --bg:#0f1216; --surface:#171b21; --border:#262c35; --text:#e8eaee; --muted:#9aa2ae;
      --ok:#5cc48c; --warn:#e0a640; --stop:#f08a80; --idle:#8b93a0;
    }
  }
  :root[data-theme="dark"] {
    --bg:#0f1216; --surface:#171b21; --border:#262c35; --text:#e8eaee; --muted:#9aa2ae;
    --ok:#5cc48c; --warn:#e0a640; --stop:#f08a80; --idle:#8b93a0;
  }
  :root[data-theme="light"] {
    --bg:#fff; --surface:#f7f8fa; --border:#e2e5ea; --text:#14171c; --muted:#5f6672;
    --ok:#1c7a4a; --warn:#a35c00; --stop:#b3261e; --idle:#6a707c;
  }
  * { box-sizing:border-box; }
  body {
    margin:0; background:var(--bg); color:var(--text);
    font:16px/1.6 ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing:antialiased;
  }
  .wrap { max-width:60rem; margin:0 auto; padding:2.5rem 1.25rem 4rem; }
  header { border-bottom:1px solid var(--border); padding-bottom:1.5rem; margin-bottom:2rem; }
  .eyebrow { font-size:.75rem; letter-spacing:.09em; text-transform:uppercase; color:var(--muted); margin:0 0 .4rem; }
  h1 { font-size:clamp(1.7rem,4vw,2.4rem); line-height:1.15; margin:0 0 .6rem; letter-spacing:-.02em; }
  .sub { color:var(--muted); margin:0; font-size:.95rem; }
  .banner {
    background:var(--surface); border:1px solid var(--border); border-left:4px solid var(--warn);
    border-radius:8px; padding:1rem 1.15rem; margin:0 0 2.25rem;
  }
  .banner strong { display:block; margin-bottom:.2rem; }
  .banner p { margin:0; color:var(--muted); font-size:.93rem; }
  h2 { font-size:1.05rem; margin:2.5rem 0 .9rem; padding-bottom:.45rem; border-bottom:1px solid var(--border); }
  h2:first-of-type { margin-top:0; }
  .metrics { display:grid; grid-template-columns:repeat(auto-fit,minmax(8.5rem,1fr)); gap:.75rem; }
  .metric { background:var(--surface); border:1px solid var(--border); border-radius:8px; padding:.9rem 1rem; }
  .metric .n { font-size:1.7rem; font-weight:600; line-height:1.1; letter-spacing:-.02em; }
  .metric .l { font-size:.78rem; color:var(--muted); margin-top:.25rem; }
  .streams { display:grid; grid-template-columns:repeat(auto-fit,minmax(15rem,1fr)); gap:.75rem; }
  .stream { background:var(--surface); border:1px solid var(--border); border-radius:8px; padding:1rem 1.1rem; }
  .stream h3 { margin:0 0 .5rem; font-size:.98rem; }
  .stream p { margin:0; font-size:.88rem; color:var(--muted); }
  .pill {
    display:inline-block; font-size:.7rem; font-weight:600; letter-spacing:.05em; text-transform:uppercase;
    padding:.15rem .5rem; border-radius:999px; border:1px solid currentColor; margin-bottom:.55rem;
  }
  .p-ok{color:var(--ok);} .p-warn{color:var(--warn);} .p-stop{color:var(--stop);} .p-idle{color:var(--idle);}
  .scroll { overflow-x:auto; -webkit-overflow-scrolling:touch; }
  table { border-collapse:collapse; width:100%; font-size:.9rem; min-width:34rem; }
  th, td { text-align:left; padding:.6rem .7rem; border-bottom:1px solid var(--border); vertical-align:top; }
  th { font-size:.74rem; text-transform:uppercase; letter-spacing:.06em; color:var(--muted); font-weight:600; }
  tbody tr:last-child td { border-bottom:none; }
  td.num { white-space:nowrap; color:var(--muted); font-variant-numeric:tabular-nums; }
  ul.timeline { list-style:none; margin:0; padding:0; }
  ul.timeline li {
    display:grid; grid-template-columns:6.5rem 1fr; gap:.8rem; padding:.5rem 0;
    border-bottom:1px solid var(--border); font-size:.9rem;
  }
  ul.timeline li:last-child { border-bottom:none; }
  ul.timeline time { color:var(--muted); font-variant-numeric:tabular-nums; }
  footer { margin-top:3rem; padding-top:1.25rem; border-top:1px solid var(--border); color:var(--muted); font-size:.82rem; }
  footer p { margin:0 0 .5rem; }
  @media (max-width:30rem) { ul.timeline li { grid-template-columns:1fr; gap:.1rem; } }
</style>
</head>
<body>
<div class="wrap">

<header>
  <p class="eyebrow">Romi &middot; Salesforce delivery</p>
  <h1>__NAME__ &mdash; Delivery Status</h1>
  <p class="sub">Status pending first-run research</p>
</header>

<div class="banner">
  <div>
    <strong>Not yet reported</strong>
    <p>This page is regenerated from the project trackers. Until the first meeting is processed there is
    no evidenced status to publish.</p>
  </div>
</div>

<h2>At a glance</h2>
<div class="metrics">
  <div class="metric"><div class="n">0</div><div class="l">Tracked items</div></div>
  <div class="metric"><div class="n">0</div><div class="l">Open</div></div>
  <div class="metric"><div class="n">0</div><div class="l">In progress</div></div>
  <div class="metric"><div class="n">0</div><div class="l">Stale</div></div>
  <div class="metric"><div class="n">0</div><div class="l">Resolved</div></div>
  <div class="metric"><div class="n">0</div><div class="l">Decisions logged</div></div>
</div>

<h2>Workstreams</h2>
<div class="streams">
  <div class="stream">
    <span class="pill p-idle">Not started</span>
    <h3>Pending definition</h3>
    <p>Workstreams are added here once meeting evidence defines them.</p>
  </div>
</div>

<h2>Timeline</h2>
<ul class="timeline">
  <li><time>Pending</time><span>No milestones recorded yet</span></li>
</ul>

<footer>
  <p>Generated from the internal meeting trackers held in a private repository. Individual names, contact
  details, commercial terms and integration credentials are deliberately excluded from this page.</p>
  <p>Status is reported as evidenced by processed meeting sources. Where a source is unreachable, its
  content is reported as missing rather than inferred.</p>
</footer>

</div>
</body>
</html>
"""
    return {
        "site/index.html": index.replace("__NAME__", name),
        "site/_headers": """/*
  X-Robots-Tag: noindex, nofollow, noarchive
  Referrer-Policy: no-referrer
  X-Content-Type-Options: nosniff
""",
        "site/robots.txt": "User-agent: *\nDisallow: /\n",
        "docs/publishing.md": f"""# Publishing the status page

The repository stays **private**. Only the contents of [`site/`](../site/) are ever published.

Everything in `site/` is served on a public URL with no authentication — that is deliberate, because the
page is meant to be readable by people and by AI agents that have no repository credentials. Treat
`site/` as a public folder inside a private repository.

## What may go in `site/`

Permitted: delivery status, phase, item counts, milestone dates, roles.

Not permitted: individual names, email addresses, phone numbers, meeting transcripts or quotes,
commercial terms and pricing, credentials, endpoint URLs, tokens, authentication schemes, or any
description of a security weakness.

Before every deploy, run the leak check from the repository root, extending the pattern with the
surnames of everyone named in `docs/project-context.md`:

```sh
grep -rnEi "{LEAK_TERMS}|<surnames>" site/
```

No output means the page is clean.

## How it is hosted

GitHub Pages cannot serve a private repository on a Free plan, so the page is hosted on Cloudflare
Pages by **direct upload** — not a Git connection. Cloudflare therefore holds no access to the private
repository, and no branch ever gets its own public preview URL.

- **Project:** `{project}`
- **Live URL:** https://{project}.pages.dev

The project name carries a suffix so the URL is not guessable from the client name alone. That is
obscurity, not security — the page and `_headers` ask crawlers not to index it, but anyone with the
link can read it, and so can any AI agent you hand it to. That is the point of the page; keep the
content publishable.

## Updating

Refresh `site/index.html` from `meetings/open-items.md` and `meetings/DEVELOPMENT-RECAP.md` whenever a
new meeting is processed with `$drill-meeting`. Re-run the leak check above, then redeploy:

```sh
npx wrangler pages deploy site --project-name={project} --branch=main
```

Pushing to `main` does **not** update the live page on its own.

If `wrangler` reports that it is not authenticated, run `npx wrangler login` once and repeat the
deploy. The account needs the `pages (write)` scope.
""",
    }


VAULT_CHECK_JS = r"""#!/usr/bin/env node
/**
 * Vault integrity check - tool-neutral, dependency-free.
 *
 * Enforces the rules in notes/agent-protocol.md so the knowledge graph stays
 * readable by any agent (Claude, Codex, Cursor, Gemini) and by GitHub:
 *   - every note carries id / type / status / updated frontmatter
 *   - ids are unique
 *   - relative markdown links resolve to real files
 *   - no [[wikilinks]] (unresolvable outside Obsidian)
 *   - no Dataview/Bases blocks outside notes/dashboards/ (render-only)
 */

import { readdirSync, readFileSync, statSync, existsSync } from 'node:fs';
import { join, dirname, resolve, relative, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const REQUIRED = ['id', 'type', 'status', 'updated'];
const ROOT_DOCS = ['MAP.md', 'INDEX.md', 'AGENTS.md', 'JOURNAL.md', 'CLAUDE.md'];

const errors = [];
const ids = new Map();

function walk(dir) {
  const out = [];
  if (!existsSync(dir)) return out;
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    if (statSync(full).isDirectory()) out.push(...walk(full));
    else if (entry.endsWith('.md')) out.push(full);
  }
  return out;
}

function frontmatter(text) {
  const match = /^---\r?\n([\s\S]*?)\r?\n---/.exec(text);
  if (!match) return null;
  const fields = {};
  for (const line of match[1].split(/\r?\n/)) {
    const kv = /^([A-Za-z_][\w-]*):\s*(.*)$/.exec(line);
    if (kv) fields[kv[1]] = kv[2].trim();
  }
  return fields;
}

const noteFiles = walk(join(root, 'notes'));
const rootFiles = [
  ...ROOT_DOCS.map((f) => join(root, f)),
  // Skills carry relative links into the vault; a rename must not silently
  // break the procedures that read it.
  ...walk(join(root, '.claude', 'skills')).filter((f) => f.endsWith('SKILL.md')),
].filter((f) => existsSync(f));

for (const file of noteFiles) {
  const rel = relative(root, file).split(sep).join('/');
  const text = readFileSync(file, 'utf8');
  const fm = frontmatter(text);

  if (!fm) {
    errors.push(`${rel}: missing YAML frontmatter`);
    continue;
  }
  for (const key of REQUIRED) {
    if (!fm[key]) errors.push(`${rel}: missing frontmatter field "${key}"`);
  }
  if (fm.updated && !/^\d{4}-\d{2}-\d{2}$/.test(fm.updated)) {
    errors.push(`${rel}: "updated" must be an ISO date, got "${fm.updated}"`);
  }
  if (fm.id) {
    if (ids.has(fm.id)) errors.push(`${rel}: duplicate id "${fm.id}" (also in ${ids.get(fm.id)})`);
    else ids.set(fm.id, rel);
  }
}

// Code spans and fenced blocks are documentation, not live links or queries.
function stripCode(text) {
  return text.replace(/```[\s\S]*?```/g, '').replace(/`[^`\n]*`/g, '');
}

for (const file of [...noteFiles, ...rootFiles]) {
  const rel = relative(root, file).split(sep).join('/');
  const raw = readFileSync(file, 'utf8');
  const text = stripCode(raw);

  if (/\[\[[^\]]+\]\]/.test(text)) {
    errors.push(`${rel}: contains [[wikilinks]] - use relative markdown links (see notes/agent-protocol.md)`);
  }
  if (/```(dataview|base)/.test(raw) && !rel.startsWith('notes/dashboards/')) {
    errors.push(`${rel}: Dataview/Bases block outside notes/dashboards/ - agents cannot read rendered output`);
  }

  for (const [, target] of text.matchAll(/\[[^\]]*\]\(([^)\s]+)\)/g)) {
    if (/^(https?:|mailto:|#)/.test(target)) continue;
    const path = decodeURI(target.split('#')[0]);
    if (!path) continue;
    if (!existsSync(resolve(dirname(file), path))) {
      errors.push(`${rel}: broken link -> ${target}`);
    }
  }
}

const noteCount = noteFiles.length;
if (errors.length) {
  console.error(`vault:check FAILED - ${errors.length} problem(s) across ${noteCount} notes\n`);
  for (const e of errors) console.error(`  ${e}`);
  process.exit(1);
}
console.log(`vault:check OK - ${noteCount} notes, ${ids.size} unique ids, all links resolve`);
"""


AGENT_PROTOCOL_MD = """---
id: protocol
type: reference
status: active
updated: 1970-01-01
---

# Retrieval and write protocol

Tool-neutral. Applies to Claude Code, Codex, Cursor, Gemini, Copilot, and any
future agent. Referenced from [AGENTS.md](../AGENTS.md).

## Retrieval

Answer from the smallest set of files that can actually support the answer.

1. **[MAP.md](../MAP.md)** - always. State, blockers, ownership.
2. **[INDEX.md](../INDEX.md)** - pick targets by cost.
3. **Atomic notes** - open only what the task names.
4. **Costly documents** - only when the notes cannot answer. State in your
   reply that you escalated and why.

Escalate on purpose, not by habit. A question answerable from two notes
(~0.4k tokens) does not need the full development recap and tracker (~8k) to
produce the same sentence.

For transcripts, search - never load:

```bash
rg -n "search term" meetings/*-transcript.*.md
```

Then read only the surrounding range, and cite `file:line`.

## Writing

**Notes are the source of truth. The documents in `meetings/` are views.**

When new information arrives:

1. Create or update the atomic note(s) in `notes/`. Bump `updated:`.
2. Regenerate the affected view documents from the notes.
3. Append an entry to [JOURNAL.md](../JOURNAL.md).
4. Run `npm run vault:check`.

Rules that do not bend:

- Stable ids, never reused, never renumbered.
- One fact per note. If a note needs two `status:` values, it is two notes.
- Never edit a preserved raw transcript.
- Never fabricate owners, dates, decisions, or speaker attribution. Write
  `uncertain:` in frontmatter and say so in the body instead of guessing.
- Later evidence wins, but record the reversal and cite both meeting dates.
- No secrets, credentials, or unnecessary personal data - see
  [docs/publishing.md](../docs/publishing.md).

## Handoff between tools

You may be a different model than the one that wrote the last entry. The
[JOURNAL.md](../JOURNAL.md) entry is the handoff contract. Write it so a cold
agent can resume without re-reading the corpus:

```markdown
## 2026-01-31 - codex

- **Did:** rewrote the payload note after the example arrived.
- **State:** the upstream item is resolved; the build is now unblocked.
- **Next:** build the objects; the sync API is the hard prerequisite.
- **Watch:** list size is 4+4, not 3 - the recap still says 3 in one place.
```

Keep the ten most recent entries in `JOURNAL.md`. Move older ones to
`notes/sessions/YYYY-QN.md`.

## Why the format is what it is

- **Relative Markdown links, not wikilinks** - so links resolve in Obsidian,
  VS Code, GitHub, and every agent CLI. Obsidian's graph view and backlinks
  work with Markdown links; set `Settings -> Files & Links -> Use [[Wikilinks]]`
  to **off**.
- **Plain YAML frontmatter** - parseable by anything, no plugin required.
- **No Dataview/Bases in agent-read files** - those render only inside
  Obsidian. An agent reads the query source, not the result table. Human
  dashboards using them belong in `notes/dashboards/`.
- **English in `notes/`** - one working surface. Translated files are generated
  deliverables, not a second source of truth to keep in sync.
"""


def vault_static_templates() -> dict[str, str]:
    """Infrastructure that every project shares verbatim and no one hand-edits."""
    return {
        "notes/agent-protocol.md": AGENT_PROTOCOL_MD,
        "scripts/vault-check.mjs": VAULT_CHECK_JS,
        "CLAUDE.md": """# CLAUDE.md

The canonical, tool-neutral instructions for this repository live in
`AGENTS.md`. They are imported below - read them as if written here.

@AGENTS.md

## Claude-specific notes

- Project skills live in `.claude/skills/` (mirrored in `.agents/skills/` for
  other agent runtimes).
- Claude's own persistent memory directory is **not** the project memory. It
  holds only pointers into this repository, because Codex and other tools
  cannot see it. Durable project facts belong in [notes/](notes/).
- Prefer `Grep`/`Glob` over `Bash` for search, and never `Read` a file listed
  under "Never read these" in `AGENTS.md`.
""",
        "GEMINI.md": """# GEMINI.md

The canonical, tool-neutral instructions for this repository live in
[AGENTS.md](AGENTS.md). Read that file first and follow it.

Start every task at [MAP.md](MAP.md), route through [INDEX.md](INDEX.md), and
never load the raw transcripts under `meetings/*-transcript.*.md`.
""",
        ".github/copilot-instructions.md": """# Copilot instructions

The canonical, tool-neutral instructions for this repository live in
[AGENTS.md](../AGENTS.md). Read that file first and follow it.

Start every task at [MAP.md](../MAP.md), route through [INDEX.md](../INDEX.md),
and never load the raw transcripts under `meetings/*-transcript.*.md`.
""",
        "meetings/CLAUDE.md": "@AGENTS.md\n",
        "meetings/AGENTS.md": """# Agent instructions - meetings/

Loaded automatically when an agent works in this directory. Supplements the
root [AGENTS.md](../AGENTS.md).

## Do not load the transcripts

`*-transcript.*.md` in this directory are verbatim meeting transcripts, tens of
kilobytes each. Reading one consumes most of a context window and is almost
never necessary. Search instead, then read only the matching range:

```bash
rg -n "search term" meetings/*-transcript.*.md
```

Never modify a preserved transcript.

## The other files here are views, not sources

`DEVELOPMENT-RECAP*.md` and `open-items*.md` are **rendered from**
[../notes/](../notes/). Change the notes, then regenerate these. Do not treat
them as the place a fact lives.

`results/*.md` are per-meeting recaps - stable historical records. Safe to read
one when you need a specific meeting, but check [../INDEX.md](../INDEX.md) for
the cost first.

Translated files are client-facing deliverables. Do not read them for facts;
read the English source.
""",
        # Markdown links, not wikilinks, so the graph stays readable outside Obsidian.
        ".obsidian/app.json": """{
  "useMarkdownLinks": true,
  "newLinkFormat": "relative",
  "alwaysUpdateLinks": true,
  "showUnsupportedFiles": false,
  "attachmentFolderPath": "notes/attachments",
  "userIgnoreFilters": [
    "force-app/",
    "node_modules/",
    ".sf/",
    ".sfdx/",
    ".husky/",
    "site/",
    "config/",
    "manifest/"
  ]
}
""",
        "notes/items/.gitkeep": "",
        "notes/meetings/.gitkeep": "",
        "notes/people/.gitkeep": "",
        "notes/flows/.gitkeep": "",
        "notes/decisions/.gitkeep": "",
        "notes/risks/.gitkeep": "",
        "notes/dashboards/.gitkeep": "",
        "notes/sessions/.gitkeep": "",
    }


def vault_seed_templates(display_name: str) -> dict[str, str]:
    """Files that accumulate project content, so they are written once and then left alone."""
    name = one_line(display_name)
    templates = {
        "AGENTS.md": """# Agent Instructions - {{PROJECT_NAME}}

Canonical instructions for **any** AI coding agent working in this repository
(Claude Code, Codex, Cursor, Gemini, Copilot). Tool-specific files
(`CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`) are thin pointers
to this file. Edit this file, not the pointers.

This is a Salesforce DX project. Most of the value in this repository is
**project knowledge in markdown**, not code. Read it in the right order or you
will burn your context window on documents you did not need.

## Read protocol

1. Start with [MAP.md](MAP.md) - current project state. Always cheap.
2. Route through [INDEX.md](INDEX.md) - one line per note, with read costs.
3. Open only the specific notes in [notes/](notes/) that the task needs.
4. Escalate to the big documents in `meetings/` **only** when the atomic notes
   are genuinely insufficient, and say so when you do.

Full retrieval and write rules: [notes/agent-protocol.md](notes/agent-protocol.md).

## Never read these

| Path pattern                      | Why                                  |
| --------------------------------- | ------------------------------------ |
| `meetings/*-transcript.*.md`      | Raw verbatim transcripts, huge       |
| `force-app/**`                    | Not relevant to knowledge tasks      |
| `node_modules/**`, `.sf/`         | Generated                            |

Use `rg` against transcripts to locate a quote, then cite the line. Never load
one whole.

## Write protocol

Facts live in `notes/` as atomic notes. The large documents in `meetings/`
(`DEVELOPMENT-RECAP*.md`, `open-items*.md`) are **rendered views** for humans
and the client - regenerate them from the notes, do not hand-edit them as the
source of truth.

Precedence, highest first: **`notes/`** → the rendered views in `meetings/` →
[STATUS.md](STATUS.md) and [its Notion mirror](notes/The%20Notion%20mirror%20of%20the%20project%20status.md) →
[site/](site/). Everything below `notes/` is regenerated, never authored.
**Notion is a publish target - never read a fact out of it into a note.**
`STATUS.md` and the mirror are **internal** and name people; `site/` is
**public** and sanitized ([docs/publishing.md](docs/publishing.md)). Text never
moves from the internal surface to the public one.

- One fact, one note, one stable `id`.
- Update the note's `updated:` field whenever you change it.
- Append a session entry to [JOURNAL.md](JOURNAL.md) at the end of any session
  that changed project state, so the next agent - possibly a different model -
  can resume without re-reading everything.
- Never edit a preserved raw transcript.
- Never fabricate owners, dates, decisions, or attribution. Mark uncertainty.

## Link and format rules (portability)

These exist so the same files work in Obsidian, VS Code, GitHub, and every
agent CLI:

- **Relative Markdown links only**. Do **not** use Obsidian `[[wikilinks]]`;
  agents outside Obsidian cannot resolve them, and GitHub renders them as
  literal text.
- **Plain YAML frontmatter** on every note in `notes/`.
- **No Dataview / Bases query blocks in anything an agent reads.** Those render
  only inside Obsidian; an agent sees the query source, not the table. Keep
  them confined to `notes/dashboards/`, which is human-only.
- English is the working language for `notes/`. Translated files are
  client-facing deliverables generated from the English source.

## Frontmatter schema

```yaml
---
id: OI-01 # stable, unique, never reused
type: open-item # open-item | meeting | person | flow | object | decision | risk
status: open # open | in-progress | resolved | stale | superseded
owner: Name # free text; person note name where one exists
raised: 1970-01-01 # ISO date
updated: 1970-01-01 # ISO date, bump on every edit
depends_on: [OI-00] # ids
blocks: [OI-02] # ids
source: meetings/results/<meeting>.md
---
```

## Workflows

Four repeatable procedures live in `.agents/skills/` (mirrored in
`.claude/skills/`). They are plain Markdown - any agent can follow them.

| Task                                 | Procedure                                     |
| ------------------------------------ | --------------------------------------------- |
| A new meeting transcript arrived     | `.agents/skills/drill-meeting/SKILL.md`       |
| Decide what to unblock next          | `.agents/skills/drill-me/SKILL.md`            |
| Has anything new come in?            | `.agents/skills/requirements-check/SKILL.md`  |
| Does the org match the requirements? | `.agents/skills/org-status-check/SKILL.md`    |

Claude Code loads these as skills automatically. Every other tool: read the
file and follow it.

`org-status-check` owns [STATUS.md](STATUS.md) and the Notion mirror when the run
explicitly selects its reconciliation or publishing mode.

## Checks

```bash
npm run vault:check      # frontmatter + link integrity across notes/
npm run prettier:verify  # formatting
```

Run `vault:check` before committing knowledge changes.

## Repository conventions

- Commits and pushes only when the user asks.
- Secrets, client credentials, and personal data never enter `notes/`, the
  recaps, or [site/](site/) - see [docs/publishing.md](docs/publishing.md).
  The repository is private; `site/` is public.
""",
        "MAP.md": """# MAP - {{PROJECT_NAME}}

Entry point for humans and agents. Keep this file under 4 KB. If it grows,
move detail into a note and link it.

Source of record for everything below: [notes/](notes/)

## Where the project stands

Not yet established. Nothing has been ingested. Run the `drill-meeting`
workflow on the first transcript, or the `drill-me` workflow to start from what
is already known, and rewrite this section from the notes it produces.

## The live chain

The dependency chain of whatever is currently in flight goes here, deepest
blocker first, each item linking to its note in `notes/items/`.

## Map of the territory

| Area                | Start here                                         |
| ------------------- | -------------------------------------------------- |
| Everything, indexed | [INDEX.md](INDEX.md)                               |
| How to read/write   | [notes/agent-protocol.md](notes/agent-protocol.md) |
| Open items          | [notes/items/](notes/items/)                       |
| People and roles    | [notes/people/](notes/people/)                     |
| Risks               | [notes/risks/](notes/risks/)                       |
| Session handoffs    | [JOURNAL.md](JOURNAL.md)                           |
| Status, to share    | [STATUS.md](STATUS.md) → [Notion mirror](notes/The%20Notion%20mirror%20of%20the%20project%20status.md) - **internal**, not the public page |
| Scope + provenance  | [docs/project-context.md](docs/project-context.md) |
| Publishing rules    | [docs/publishing.md](docs/publishing.md)           |

## Standing constraints

None recorded yet. Record the things that shape every decision here - who signs
off, what the client will not do, what the trackers do not cover.
""",
        "INDEX.md": """# INDEX - {{PROJECT_NAME}}

The router. One line per readable artifact, with its approximate read cost, so
any agent can budget before opening anything. Start at [MAP.md](MAP.md).

Costs are approximate tokens (~4 characters per token). **Cheap** = load
freely. **Costly** = justify it. **Never** = do not load; grep instead.

## Cheap - load freely

| File                                               | What it answers                          |
| -------------------------------------------------- | ---------------------------------------- |
| [MAP.md](MAP.md)                                   | Current state, what is blocked, who owns |
| [INDEX.md](INDEX.md)                               | This router                              |
| [STATUS.md](STATUS.md)                             | The **shareable** status view - internal, regenerate from `notes/`, [mirrored to Notion](notes/The%20Notion%20mirror%20of%20the%20project%20status.md) |
| [notes/agent-protocol.md](notes/agent-protocol.md) | How to read and write knowledge here     |
| [AGENTS.md](AGENTS.md)                             | Rules for every agent                    |
| any single note in [notes/](notes/)                | One fact each                            |
| [JOURNAL.md](JOURNAL.md)                           | Cross-tool session handoffs              |

Add a row per note as the graph grows, grouped by type, with the note's own
descriptive filename as the link text.

## Querying without reading

Frontmatter is grep-able. Use this instead of loading notes to find candidates:

```bash
rg -l "^status: open"      notes/items/    # every open item
rg -l "^owner: <name>"     notes/          # everything one person owns
rg "^blocks:|^depends_on:" notes/items/    # the dependency graph
```

## Costly - justify before loading

| File                                                           | When it is worth it                   |
| --------------------------------------------------------------- | ------------------------------------- |
| [meetings/DEVELOPMENT-RECAP.md](meetings/DEVELOPMENT-RECAP.md) | Full technical state across all areas |
| [meetings/open-items.md](meetings/open-items.md)               | Every item, including stale/resolved  |
| [docs/project-context.md](docs/project-context.md)             | Provenance, evidence trace, search log |
| [meetings/results/](meetings/results/)                         | A specific meeting in full            |

Translated twins exist for most of the above. They are client-facing
deliverables - do not read them for facts; read the English source.

## Never - grep, do not load

| Pattern                           | Instead                                              |
| --------------------------------- | ---------------------------------------------------- |
| `meetings/*-transcript.*.md`      | `rg "term" meetings/` then read only that line range |
| `force-app/**`, `node_modules/**` | Glob for the specific file                           |
""",
        "JOURNAL.md": """# Journal - {{PROJECT_NAME}}

Append-only session handoffs. Newest first. Any agent, any model, writes here
at the end of a session that changed project state, so the next one can resume
cold. Format and intent: [notes/agent-protocol.md](notes/agent-protocol.md).

Keep the ten most recent entries here; archive older ones to
`notes/sessions/YYYY-QN.md`.

---

## Project scaffolded

- **Did:** created the Salesforce DX project, the meeting workspace, and this
  knowledge vault.
- **State:** nothing ingested yet. [MAP.md](MAP.md) is a stub.
- **Next:** run the `drill-meeting` workflow on the first transcript, then
  rewrite [MAP.md](MAP.md) and [INDEX.md](INDEX.md) from the notes it produces.
- **Watch:** nothing yet.
""",
        "STATUS.md": """# {{PROJECT_NAME}} - Project Status

> **Internal.** Candid about delivery and the client relationship. **Do not give
> the client access to this page** - the client-facing view is the public page
> published from [site/](site/), which is sanitized to different rules
> ([docs/publishing.md](docs/publishing.md)).

**Last regenerated: not yet** - this file is a stub. **Not verified against a
live org**; no `org-status-check` has been run.

Generated from [notes/](notes/), which is the source of record. If this page and
a note disagree, the note wins - regenerate this page rather than editing facts
into it. Agent-facing equivalent: [MAP.md](MAP.md).

Once published, this page is mirrored to Notion, invite-only and refreshed in
the explicit publishing mode of `org-status-check`. Ids and sharing rules:
[the mirror note](notes/The%20Notion%20mirror%20of%20the%20project%20status.md).

---

## At a glance

Rewrite this table from the notes: the three or four things a colleague must
know, one line each, with the bad news first.

## What is built

Nothing verified yet. Run `org-status-check` against the org and rewrite this
section from what it proves - not from `force-app/`, which is only the
repository's claim about the org.

## What is not built

The agreed scope that has no implementation, each row linking to its item note.

## Blocking now, in order

The ranked list of what is actually stopping progress, with an owner on each.

## Timeline and commitments

Dates that were committed to, and by whom.

## Open risks

One row per note in `notes/risks/`, most severe first.

## Who is who

Names and roles on each side, from `notes/people/`.

## Maintaining this page

- Facts live in [notes/](notes/). Change the note, then regenerate this page.
- Regenerate after any `org-status-check`, `requirements-check`, `drill-meeting`
  or `drill-me` run.
- Any agent - Claude Code, Codex, Cursor - reads and edits this file directly;
  it is plain Markdown in the repo, with no tool-specific hosting.
- **This is not the public page.** [site/](site/) is public, unauthenticated and
  sanitized; this file and its Notion mirror are internal, invite-only, and
  deliberately name people. Never copy text from here into `site/`.
- Contains no credentials, no tokens and no personal contact data, and must not
  acquire any - describe a field, never a value.
""",
        "notes/The Notion mirror of the project status.md": """---
id: ref-notion-mirror
type: reference
status: unpublished
updated: scaffolded
---

# The Notion mirror of the project status

[STATUS.md](../STATUS.md) is the source. Notion is a **mirror** - it exists so
colleagues who do not read the repository can see where the project stands,
behind a login the owner approves person by person.

**Never treat the Notion copy as the record.** If the two disagree, the notes
win, then `STATUS.md`, then Notion. An edit typed into Notion is lost at the next
regeneration.

## Not the same thing as the public page

This project has **two** rendered status surfaces, and they must not be confused:

| Surface                              | Audience          | Rules                                                                       |
| ------------------------------------ | ----------------- | --------------------------------------------------------------------------- |
| [site/](../site/) → Cloudflare Pages | Public, no login  | Sanitized - see [docs/publishing.md](../docs/publishing.md)                 |
| Notion, below                        | Internal, invited | Candid - names people, states the slippage                                  |

Text never moves from Notion into `site/`.

## What exists

**Nothing yet - this project has not been published.** Creating it is a one-time
first-run step, done by an agent session that has the Notion connector; the
scaffolder cannot do it, because the page ids only exist once the pages do.

To publish the first time, create three artifacts and record their ids here:

| Artifact                          | Id       | Holds                                  |
| --------------------------------- | -------- | -------------------------------------- |
| Parent page, named for the project | _unset_ | Project frame; auto-lists its children |
| Page **Project Status**           | _unset_ | The mirror of `STATUS.md`              |
| Database **Open Items**           | _unset_ | One row per note in `notes/items/`     |
| Its data source                   | _unset_ | Needed to create rows or views         |

Record the workspace id and name too, so a later session can confirm it is
pointed at the right one before writing.

⚠ Create the parent page first, then move the status page and the database under
it. A create call that passes a `parent` is sometimes refused where a
workspace-level create followed by `notion-move-pages` succeeds.

## The tracker's shape

Properties: `Item` (title), `Ref` (the item id), `Status`
(Open / In progress / Resolved / Stale / Superseded), `Severity`,
`Critical path` (checkbox),
`Owner`, `Org`, `Raised`, `Blocks`, `Depends on`, `Note` (link to the atomic
note on the working branch).

Suggested views: **Board** grouped by status, **Critical path** filtered to the
checkbox, **By owner** grouped by owner.

`Ref` is the join key back to `notes/items/`. **Match on `Ref`, never on the
title** - titles are edited, ids never are.

## Refreshing it

Owned by the explicit publishing mode of
[org-status-check](../.agents/skills/org-status-check/SKILL.md). Update the page
content in place and match tracker rows on `Ref`, so the URLs stay stable and
existing invitations keep working.

**Not every agent can do this.** The Notion connector is a claude.ai-managed
OAuth grant; Codex, Cursor and a Claude session with an expired token all cannot
reach it. That is not a failure - regenerate `STATUS.md`, say plainly that the
mirror is stale, and leave it for a session that has the connector.

## Sharing

Invite-only, at the parent page, which cascades to its children.
**Publish to web must stay off** - it would remove the login gate entirely.

The pages are **internal**. A client-facing version is a separate document and
needs a translated twin - see [AGENTS.md](../AGENTS.md).
""",
    }
    return {path: content.replace("{{PROJECT_NAME}}", name) for path, content in templates.items()}


def ensure_package_script(project_dir: Path) -> bool:
    """Register the vault check in package.json so `npm run vault:check` works out of the box."""
    target = project_dir / "package.json"
    if not target.is_file():
        return False
    try:
        data = json.loads(target.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return False
    scripts = data.setdefault("scripts", {})
    if scripts.get("vault:check"):
        return False
    scripts["vault:check"] = "node scripts/vault-check.mjs"
    target.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8", newline="\n")
    return True


GITIGNORE_BLOCKS = (
    (
        ".wrangler",
        "# Cloudflare Pages / wrangler local cache (contains the account identifier)\n.wrangler/\n",
    ),
    (
        ".obsidian/workspace.json",
        "# Obsidian: the vault config is committed so every machine reads the graph the\n"
        "# same way; only per-machine UI state is ignored.\n"
        ".obsidian/workspace.json\n.obsidian/workspace-mobile.json\n.obsidian/cache\n.trash/\n",
    ),
)


def ensure_gitignore(project_dir: Path) -> bool:
    """Ignore the wrangler cache (it records the Cloudflare account id) and per-machine Obsidian state."""
    target = project_dir / ".gitignore"
    existing = target.read_text(encoding="utf-8") if target.is_file() else ""
    updated = False
    for marker, block in GITIGNORE_BLOCKS:
        if marker in existing:
            continue
        separator = "" if not existing or existing.endswith("\n\n") else ("\n" if existing.endswith("\n") else "\n\n")
        existing = existing + separator + block
        updated = True
    if updated:
        target.write_text(existing, encoding="utf-8", newline="\n")
    return updated


def install_project_workflows(project_dir: Path, display_name: str) -> dict[str, object]:
    if not project_dir.is_dir() or not (project_dir / "sfdx-project.json").is_file():
        raise ValueError(f"Not a Salesforce DX project: {project_dir}")

    asset_root = Path(__file__).resolve().parents[1] / "assets" / "project-skills"
    if not asset_root.is_dir():
        raise RuntimeError(f"Project skill templates are missing: {asset_root}")

    outputs: dict[Path, str] = {}
    for source in sorted(asset_root.rglob("*")):
        if not source.is_file():
            continue
        relative = source.relative_to(asset_root)
        if relative.name == "SKILL.md.tpl":
            relative = relative.with_name("SKILL.md")
        rendered = source.read_text(encoding="utf-8").replace("{{PROJECT_NAME}}", one_line(display_name))
        for surface in (".agents", ".claude"):
            outputs[project_dir / surface / "skills" / relative] = rendered

    for relative, content in meeting_templates(display_name).items():
        outputs[project_dir / relative] = content

    # Vault infrastructure is identical in every project and is safe to keep in sync.
    for relative, content in vault_static_templates().items():
        outputs[project_dir / relative] = content

    # The status page, its publishing note, and the vault hub files are edited per project as real
    # content accumulates. They are seeded once and then left alone, so re-running the installer
    # never fights the agent.
    slug = derive_slug(display_name)
    seeded: dict[Path, str] = {
        project_dir / relative: content for relative, content in site_templates(display_name, slug).items()
    }
    for relative, content in vault_seed_templates(display_name).items():
        seeded[project_dir / relative] = content
    # MAP.md and INDEX.md link to the research trace. main() writes the real one before calling us;
    # a standalone install onto an existing project gets a stub so the links are never dangling.
    seeded[project_dir / "docs" / "project-context.md"] = context_template(display_name, None)

    conflicts = []
    unchanged = []
    for destination, content in outputs.items():
        if destination.exists():
            if not destination.is_file() or destination.read_text(encoding="utf-8") != content:
                conflicts.append(str(destination.relative_to(project_dir)))
            else:
                unchanged.append(str(destination.relative_to(project_dir)))
    if conflicts:
        joined = ", ".join(conflicts)
        raise FileExistsError(f"Refusing to overwrite customized workflow files: {joined}")

    created = []
    preserved = []
    for destination, content in list(outputs.items()) + list(seeded.items()):
        if destination.exists():
            if destination in seeded:
                preserved.append(str(destination.relative_to(project_dir)))
            continue
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(content, encoding="utf-8", newline="\n")
        created.append(str(destination.relative_to(project_dir)))

    return {
        "created": sorted(created),
        "unchanged": sorted(unchanged),
        "preserved": sorted(preserved),
        "gitignore_updated": ensure_gitignore(project_dir),
        "package_script_added": ensure_package_script(project_dir),
        "pages_project": pages_project(slug),
        "pages_url": f"https://{pages_project(slug)}.pages.dev",
    }


def init_git(git: str, project_dir: Path) -> None:
    initialized = run([git, "init", "-b", "main"], cwd=project_dir, check=False)
    if initialized.returncode == 0:
        return
    run([git, "init"], cwd=project_dir)
    run([git, "branch", "-M", "main"], cwd=project_dir)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--name", required=True, help="Human-readable project name")
    parser.add_argument("--parent", default=".", help="Existing parent directory")
    parser.add_argument("--slack-channel", help="Optional Slack channel name or URL")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    display_name = one_line(args.name)
    if not display_name:
        raise ValueError("Project name cannot be blank.")

    slug = derive_slug(display_name)
    parent = Path(args.parent).expanduser().resolve()
    if not parent.is_dir():
        raise ValueError(f"Parent directory does not exist: {parent}")
    project_dir = parent / slug
    if project_dir.exists():
        raise FileExistsError(f"Target already exists; refusing to overwrite: {project_dir}")

    sf = require_command("sf")
    git = require_command("git")
    base_command = select_sf_command(sf)
    run(
        base_command
        + [
            "--name",
            slug,
            "--output-dir",
            str(parent),
            "--template",
            "standard",
            "--manifest",
        ]
    )

    manifest = project_dir / "manifest" / "package.xml"
    config = project_dir / "sfdx-project.json"
    if not manifest.is_file() or not config.is_file():
        raise RuntimeError(f"Salesforce CLI did not create the expected manifest/project files in {project_dir}")

    (project_dir / "README.md").write_text(
        readme(display_name, slug, args.slack_channel), encoding="utf-8", newline="\n"
    )
    docs = project_dir / "docs"
    docs.mkdir(exist_ok=True)
    (docs / "project-context.md").write_text(
        context_template(display_name, args.slack_channel), encoding="utf-8", newline="\n"
    )
    workflows = install_project_workflows(project_dir, display_name)
    init_git(git, project_dir)

    result = {
        "project_name": display_name,
        "slug": slug,
        "project_dir": str(project_dir),
        "manifest": str(manifest),
        "context": str(docs / "project-context.md"),
        "github_url": f"https://github.com/{GITHUB_OWNER}/{slug}",
        "repository_visibility": "private",
        "gmail_subject_tag": gmail_subject_tag(slug),
        "research_status": "pending",
        "project_workflows": workflows,
        "pages_project": pages_project(slug),
        "pages_url": f"https://{pages_project(slug)}.pages.dev",
        "pages_deployed": False,
    }
    print(json.dumps(result, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (FileExistsError, RuntimeError, ValueError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(1)
