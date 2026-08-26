# Reconcile the project record

Use this sequence only when the selected output is `reconcile` or `publish`.
The notes are the volatile source of truth; trackers, recaps, `STATUS.md`, Notion
and `site/` are rendered surfaces.

## 1. Write atomic findings

- Update each affected note from verified evidence and bump `updated:`.
- Add one atomic note for each new **Divergent**, **Unrequested** or operational
  risk finding. Never combine facts that need different statuses.
- Preserve the old diagnosis when evidence reverses it: state what was wrong,
  why the instrument failed, and what supersedes it.
- Do not move a requirement or design decision because the implementation
  differs. Record the divergence.
- Keep coverage items and the production-deploy risk current, but do not write
  or offer Apex tests.

## 2. Update structured build state

Update only the `build_state` block in
`requirements/pienissimo-requirements.yaml`; do not alter requirement text from
an org observation. Record:

- observation date, org alias/id, repository commit and method;
- built, not-built, divergent, regression and drift entries;
- requirement refs that actually exist in the register;
- any instrument limitation or method correction.

Run `npm run org-status:validate:strict`. Unknown requirement refs are not
cosmetic: fix them or remove them before claiming the build state is auditable.

## 3. Regenerate human views

1. Update `MAP.md` and `INDEX.md` only where the state or routing changed.
2. Regenerate affected rows of `meetings/open-items.md` and `.it.md` from the
   notes.
3. Append the next numbered build-state section to
   `meetings/DEVELOPMENT-RECAP.md` and `.it.md` in the same session. Never rewrite
   an earlier section.
4. Extend each recap's precedence line so it names every section, including the
   new one.
5. Say that the section records build state only: it supersedes earlier claims
   about what exists, not earlier decisions about what was agreed.

The Italian twins are client-facing and must land in the same session as the
English views.

## 4. Regenerate internal status

Regenerate `STATUS.md` from the corrected notes. Refresh:

- date and basis line, naming the live org alias when reached;
- “What is built” and “What is not built”;
- register-coverage counts;
- ranked blockers and risks.

Do not carry a hardcoded “newest org check” date in instructions. Derive it from
the current evidence. No catalogue prices, article-code values or credentials
may appear even on internal surfaces. Format the touched file with Prettier.

If a flow note or the register's `state_machines` changed, refresh the Flows
page source while preserving its visual conventions: dark-green trigger,
thick-green first held status, grey terminal, red dashed/dotted unminuted edge.
Never promote an unminuted transition to a solid edge.

## 5. Handoff and validate

- Append a `JOURNAL.md` entry with org identity, commit, method, findings,
  written files, deliberate non-actions and next step.
- Run `npm run org-status:validate:strict`.
- Run `npm run vault:check`.
- Run targeted Prettier verification on touched Markdown/YAML/JSON.
- Review `git diff --name-only` and `git diff --stat`. Stop if files outside the
  selected output mode changed or if a renderer rewrote unrelated sections.

Never commit or push unless the user asks.
