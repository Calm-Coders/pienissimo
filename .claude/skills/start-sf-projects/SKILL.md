---
name: start-sf-projects
description: Create or upgrade a Salesforce DX project with a manifest, README, source-backed Gmail and optional Slack context, a Pienissimo-style bilingual meeting workspace, project-local drill-meeting and drill-me skills for multiple agents, a sanitized public delivery-status page on Cloudflare Pages, Git initialization, and private publication under the Calm-Coders GitHub organization. Use when the user asks to start, bootstrap, scaffold, reshape, upgrade, initialize, or publish a Salesforce or SF project.
---

# Start SF Projects

Create a researched Salesforce DX project in the current folder and publish it to `Calm-Coders` on GitHub. Include the reusable meeting-intelligence structure proven in Pienissimo, without copying Pienissimo-specific people, dates, decisions, transcripts, or metadata.

## Inputs

Before writing files, obtain the inputs required by the task:

1. For a new project, ask: "What is the project name? If it has a Slack channel, include its name or URL; otherwise say none."
2. For an upgrade, use the supplied Salesforce project path or the current directory when it contains `sfdx-project.json`. Infer the display name from the README or project configuration; ask only when the target or name is ambiguous. Preserve existing research statuses and do not repeat Gmail or Slack discovery unless it is missing, pending, or requested.
3. If the user already supplied an input, do not ask for it again.
4. Derive the Gmail subject tag `[ROMI-<UPPERCASE-PROJECT-SLUG>]` from the project slug unless the user supplies a different tag. For example, `Life365` becomes `[ROMI-LIFE365]`.
5. Treat `https://github.com/Calm-Coders` as the GitHub organization owner. Derive a lowercase hyphenated folder and repository slug from the project name.
6. Default a new GitHub repository to private. Ask only when the user requests a different visibility, the derived slug collides, or an existing folder/repository would be affected.

Do not create a throwaway example when the project name is missing.

## Capability check

Use the agent's native connected tools first, then authenticated CLIs, then an authenticated browser session. Detect capabilities instead of assuming vendor-specific tool names.

Require:

- Salesforce CLI (`sf`) and Git for scaffolding.
- Authenticated Gmail access for the first-run research.
- Authenticated Slack access only when a Slack channel exists.
- Permission to create repositories in the `Calm-Coders` GitHub organization and a way to push Git content.
- Cloudflare access with the `pages (write)` scope, for the public status page. Its absence leaves the page pending rather than blocking the project.

Never use public web search as a substitute for Gmail or Slack. If required access is unavailable, explain what connection is missing. Local scaffolding may proceed, but leave the research status pending and do not publish until the required first-run research is complete.

## First-run research

Run this phase when `docs/project-context.md` is absent or marks Gmail or the provided Slack channel as pending.

### Gmail

Always run separate all-mail searches for:

- the exact project name, derived slug, and obvious spacing/hyphen variants;
- the exact derived subject tag, such as `subject:"[ROMI-LIFE365]"`;
- the tokenized fallback without brackets, such as `subject:ROMI-LIFE365`, because Gmail can normalize punctuation.

Union the results, deduplicate by stable message or thread ID, paginate until exhausted, and review relevant thread context rather than only snippets. Expand to distinctive aliases only when results show a useful alias. Record every query separately, including zero-result queries and the connected mailbox identity.

Capture:

- decisions and their rationale;
- requirements, scope, and constraints;
- owners, stakeholders, commitments, deadlines, and unresolved questions;
- links or stable message/thread identifiers when the platform exposes them;
- the exact queries used and the time of the search, including a clear "no relevant results" result when applicable.

### Slack

If the user says there is no channel, record `not applicable`. If a channel is supplied, resolve the exact channel, inspect relevant channel history and threads, and search within that channel for the project name and discovered aliases. Include useful pins, bookmarks, or canvases when the connected capability exposes them.

Do not silently search a similarly named channel. Ask when multiple channels match.

### Trace safely

Summarize findings in `docs/project-context.md` under these sections:

- Executive summary
- Requirements and scope
- Decisions
- People and ownership
- Dates and milestones
- Open questions
- Evidence trace
- Search log

For each evidence row, record source, date, author, subject or channel/thread location, a concise finding, and a stable reference. Paraphrase by default. Do not commit raw mailbox/channel exports, access tokens, credentials, customer secrets, unnecessary personal data, or large verbatim excerpts. Mark conflicting claims rather than choosing one without evidence.

## Scaffold the Salesforce project

Resolve the skill directory from this `SKILL.md`; do not assume where the skill is installed. Run:

```text
python <skill-directory>/scripts/create_sf_project.py --name <project-name> --parent <current-directory> [--slack-channel <channel-or-url>]
```

The script must create `<current-directory>/<derived-slug>` with:

- a standard Salesforce DX layout;
- `manifest/package.xml`;
- a project-specific `README.md`;
- `docs/project-context.md`;
- the derived Gmail subject tag in the README and research log;
- `.agents/skills/` copies of `drill-meeting`, `drill-me`, `requirements-check` and `org-status-check` for open-standard agent discovery;
- matching `.claude/skills/` copies for Claude Code;
- `STATUS.md`, the internal shareable status view, and `notes/The Notion mirror of the project status.md`, which holds the ids of its Notion mirror once it is published;
- bilingual `meetings/open-items*` and `meetings/DEVELOPMENT-RECAP*` starter files;
- empty `meetings/results/` and `meetings/proposals/` workspaces;
- `site/index.html`, `site/_headers` and `site/robots.txt` for the public status page, plus `docs/publishing.md`;
- a Git repository on branch `main`.

Use the current Salesforce command `sf template generate project --manifest`; the helper automatically falls back for older CLIs. If the target directory exists, stop instead of merging or overwriting it.

Fill the generated context file with the research results and update its Gmail/Slack status and timestamp. Update the README only when the derived repository URL or research status differs from its generated value.

## Project-local meeting intelligence

Install generalized project skills, not the customer-specific Pienissimo versions:

- `drill-meeting` must preserve raw transcripts, extract facts into atomic notes under `notes/`, then regenerate the bilingual recaps, open-item trackers and development recaps from those notes, reconcile proposals, and report decisions, actions, risks, reversals, and TBDs.
- `drill-me` must load `MAP.md`, select candidates by grepping note frontmatter rather than reading the large documents, rank the current blockers, ask the user concrete adaptive questions, then write decisions back into the notes and regenerate both languages without renumbering historical tracker rows.
- `requirements-check` sweeps email, chat and Drive for anything new since the last watermark, drills any new meeting through `drill-meeting`, and writes a trace note that becomes the next run's watermark. It is read-only on every external source.
- `org-status-check` compares expected requirements, committed source and the live Salesforce org on separate compliance, drift and operability axes. Reporting is the default; reconciling notes and publishing `STATUS.md` or Notion are explicit modes. It is read-only against the org and supports opt-in Slack DM delivery to a verified recipient.

Keep `.agents/skills/` and `.claude/skills/` semantically identical. Do not add Pienissimo names, known people, archive gaps, deadlines, prior decisions, or meeting history to another project.

## The two status surfaces

A scaffolded project has **two** rendered status views with deliberately opposite rules. Do not let them bleed into each other:

- **`site/`** - public, unauthenticated, sanitized to `docs/publishing.md`. No names, no endpoints, no credentials.
- **`STATUS.md` and its Notion mirror** - internal and invite-only. They name people and state the slippage plainly, which is the point of them.

`STATUS.md` is scaffolded as a stub with section headings and no facts; `org-status-check` fills it. The **Notion mirror is not scaffolded** - the page ids only exist once the pages do, and the script has no Notion connector. `notes/The Notion mirror of the project status.md` ships with an empty id table and the first-run procedure. Publishing is a one-time step for an agent session that has the connector, and a project that never takes that step still works: `STATUS.md` stands alone.

## Tool-neutral knowledge vault

`install_project_workflows` also lays down an Obsidian-compatible vault that any LLM can read, so the project
is not tied to one agent tool and so routine questions cost a fraction of the context they otherwise would.

Written every run, kept in sync (`outputs`):

- `AGENTS.md` is the canonical agent contract; `CLAUDE.md` (an `@AGENTS.md` import), `GEMINI.md`, and
  `.github/copilot-instructions.md` are thin pointers to it. Edit the canonical file, never the pointers.
- `notes/agent-protocol.md`, the retrieval and write rules, plus the empty `notes/` subdirectories.
- `meetings/AGENTS.md` and `meetings/CLAUDE.md`, a nested guard so agents working in that directory learn
  not to load the transcripts.
- `scripts/vault-check.mjs` and a `vault:check` entry in `package.json`.
- `.obsidian/app.json`, configured for **relative Markdown links, not wikilinks**.

Seeded once, then left alone (`seeded`): `MAP.md`, `INDEX.md`, `JOURNAL.md`, `STATUS.md`,
`notes/The Notion mirror of the project status.md`, and `docs/project-context.md`. These accumulate real project content — the
mirror note accumulates the Notion ids — so re-running the installer must never overwrite them.

Rules that keep the vault portable across tools — enforce them in anything you generate:

- Relative Markdown links only. Obsidian `[[wikilinks]]` do not resolve in Codex, GitHub, or VS Code.
- Plain YAML frontmatter with `id`, `type`, `status`, `updated`. Ids are stable and never reused.
- No Dataview or Bases query blocks in any file an agent reads; they render only inside Obsidian.
- Notes are the source of truth. Everything in `meetings/` is a rendered view, regenerated from them, so
  the two language versions cannot drift.

Run `npm run vault:check` after generating; it fails on missing frontmatter, duplicate ids, broken links,
wikilinks, and stray Dataview blocks.

## Publish the sanitized status page

Every project gets a public delivery-status page served from `site/`, so that people and AI agents
without repository credentials can read the current state. The repository itself stays private. Run
this phase on creation and again on every upgrade.

The scaffold seeds `site/index.html`, `site/_headers`, `site/robots.txt` and `docs/publishing.md`, and
derives a Cloudflare Pages project name of the form `<slug>-status-<suffix>`. Those four files are
seeded once and never overwritten by a later run, so the status you write into them survives upgrades.

### Fill the page from the trackers

Rebuild `site/index.html` from `meetings/open-items.md` and `meetings/DEVELOPMENT-RECAP.md`. Count the
items rather than estimating them, and make the status tiles reconcile to the tracker totals. Report
source coverage — how many meetings are ingested against how many are known to exist but unreachable —
rather than presenting partial coverage as complete.

### Sanitize before publishing

`site/` is a public folder inside a private repository. It may carry delivery status, phase, item
counts, milestone dates and roles. It must never carry:

- individual names — use roles such as "client IT reference" or "technical lead";
- email addresses, phone numbers, or any other contact detail;
- meeting transcripts, quotes, or characterisations of individuals and their behaviour;
- commercial terms, pricing, licence counts or contract friction;
- credentials, tokens, endpoint URLs, authentication schemes;
- any description of a security weakness, which on a public page is an invitation.

Then run the leak check from the project root, extending the pattern in `docs/publishing.md` with the
surnames of everyone named in `docs/project-context.md`:

```text
grep -rnEi "token|jwt|password|secret|api[_-]?key|<surnames>" site/
```

Output means stop and fix. Never publish a page you have not leak-checked in the same session you
deploy it.

### Confirm, then deploy

The page names the client and states whether delivery is on track. Before the **first** publication of
a project, tell the user the URL will be public and unauthenticated, and ask whether the client may be
named or a codename should be used. Do not re-ask on later deploys of the same project.

Deploy by direct upload, which keeps Cloudflare out of the private repository entirely:

```text
npx wrangler pages project create <pages-project> --production-branch=main
npx wrangler pages deploy site --project-name=<pages-project> --branch=main
```

If `wrangler` is not authenticated, run `npx wrangler login` once; the account needs the
`pages (write)` scope. If Cloudflare access is unavailable, leave the page unpublished, record it as
pending, and continue — an unpublished page never blocks the rest of the project.

Verify the deployment before reporting it: fetch the live URL, confirm HTTP 200, and confirm the
`x-robots-tag` header arrives. A brand-new project can return 522 for a minute or two while it
propagates; re-check rather than reporting a failure. Then write the resulting URL into the README.

## Upgrade an existing Salesforce project

When the user asks to reshape an existing project with this structure, run:

```text
python <skill-directory>/scripts/install_project_workflows.py --project-dir <salesforce-project-directory> --name <project-name>
```

The installer is idempotent for untouched generated files and refuses to overwrite customized workflow files. Review conflicts and merge them deliberately rather than forcing replacement. The `site/` files and `docs/publishing.md` are seeded only when absent and are never reported as conflicts, so an upgrade preserves a status page already in use.

After installation, add a concise `Project intelligence` section to the existing README that links the two skills, bilingual trackers, meeting results, and proposals, and a `Public status page` section carrying the live URL and the redeploy command. Preserve all existing README content.

Then run the status-page phase below: refresh the page from the trackers, leak-check it, and deploy.

## Verify before publishing

From the new project directory:

1. Confirm `sfdx-project.json`, `manifest/package.xml`, `README.md`, `docs/project-context.md`, both project-skill surfaces, both bilingual tracker pairs, both meeting workspace directories, and `site/` with `docs/publishing.md` exist.
2. Confirm the manifest is well-formed XML and its API version agrees with `sourceApiVersion` in `sfdx-project.json` unless the CLI intentionally generated otherwise.
3. Review `git status` and every file that will be committed.
4. Scan staged content for credentials, tokens, private keys, connection strings, and raw Gmail or Slack exports. Remove sensitive content rather than merely adding it to `.gitignore` after staging.
5. Run the `site/` leak check and confirm it is clean. The status page is published to a public URL; a private repository does not protect it.
6. Do not retrieve from, deploy to, or otherwise mutate a Salesforce org as part of project creation.

## Publish to GitHub

Target `Calm-Coders/<derived-slug>`.

1. Check whether the repository already exists. If it does, stop and ask whether to use it or choose a new slug; never force-push or replace it.
2. Create a private repository under `Calm-Coders` with the project display name as its description. Do not auto-initialize the remote.
3. Set `origin` to `https://github.com/Calm-Coders/<derived-slug>.git`.
4. Stage the reviewed files, commit with `chore: initialize Salesforce project`, and push `main`.
5. If repository creation succeeds but the push fails, report the partial state and reuse that repository on retry instead of creating another one.

Use a connected GitHub capability when it can create the repository; otherwise use an authenticated GitHub CLI or browser/API workflow available to the agent. Never make the repository public unless the user explicitly requests it.

## Completion report

Report the local project path, GitHub repository URL and visibility, manifest path, installed project-local skills, meeting workspace paths, Gmail and Slack research status, evidence counts, the public status-page URL with its verified HTTP status, and any pending access or ambiguity. State plainly that the status page is public while the repository is private, and name what was excluded from it. Do not claim completion until the repository contains the pushed `main` branch and all required first-run research is complete or the user explicitly waives an unavailable source.
