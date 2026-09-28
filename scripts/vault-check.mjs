#!/usr/bin/env node
/**
 * Vault integrity check - tool-neutral, dependency-free.
 *
 * Enforces the rules in notes/Retrieval and write protocol.md so the knowledge
 * graph stays readable by any agent (Claude, Codex, Cursor, Gemini) and by
 * GitHub:
 *   - every note carries id / type / status / updated frontmatter
 *   - ids are unique, and item ids match the tracker numbering (OI-NN)
 *   - the filename is the note's H1 title
 *   - relative markdown links resolve to real files
 *   - no [[wikilinks]] (unresolvable outside Obsidian)
 *   - no Dataview/Bases blocks outside notes/dashboards/ (render-only)
 *   - note filenames stay ASCII (Windows paths + markdown link targets)
 *
 * It also traces notes against requirements/pienissimo-requirements.yaml in both
 * directions - a note's `requirement:` and a requirement's `tracked_by:` must
 * agree - so a signed requirement can always be walked back to the meeting that
 * produced it. Those findings are WARNINGS, not errors: the backlog predates the
 * check and the nightly routine commits only when this script exits 0.
 */

import { readdirSync, readFileSync, statSync, existsSync } from 'node:fs';
import { join, dirname, resolve, relative, sep, basename } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const REQUIRED = ['id', 'type', 'status', 'updated'];
const ROOT_DOCS = ['MAP.md', 'INDEX.md', 'AGENTS.md', 'JOURNAL.md', 'CLAUDE.md', 'GEMINI.md'];

const errors = [];
const warnings = [];
const ids = new Map();
const noteRequirements = []; // { noteId, rel, req }

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
  const duplicates = [];
  for (const line of match[1].split(/\r?\n/)) {
    const kv = /^([A-Za-z_][\w-]*):\s*(.*)$/.exec(line);
    if (!kv) continue;
    // A repeated key silently wins or loses depending on the parser - catch it.
    if (Object.prototype.hasOwnProperty.call(fields, kv[1])) duplicates.push(kv[1]);
    fields[kv[1]] = kv[2].trim();
  }
  Object.defineProperty(fields, '__duplicates', { value: duplicates, enumerable: false });
  return fields;
}

const noteFiles = walk(join(root, 'notes'));
const rootFiles = [
  ...ROOT_DOCS.map((f) => join(root, f)),
  join(root, '.github', 'copilot-instructions.md'),
  // Skills carry relative links into the vault; a rename must not silently
  // break the procedures that read it.
  ...walk(join(root, '.claude', 'skills')).filter((f) => f.endsWith('SKILL.md')),
  ...walk(join(root, '.agents', 'skills')).filter((f) => f.endsWith('SKILL.md')),
].filter((f) => existsSync(f));

for (const file of noteFiles) {
  const rel = relative(root, file).split(sep).join('/');
  const name = basename(file, '.md');
  const text = readFileSync(file, 'utf8');
  const fm = frontmatter(text);

  // eslint-disable-next-line no-control-regex
  if (/[^\x00-\x7F]/.test(name)) {
    errors.push(`${rel}: non-ASCII character in filename - transliterate it`);
  }
  if (/[(){}[\]'"*?<>|:\\]/.test(name)) {
    errors.push(`${rel}: filename contains a character banned by the protocol`);
  }

  // The filename IS the title: "OI-64 The suite is broken" <- "# OI-64 - The suite is broken"
  const h1 = /^#\s+(.+)$/m.exec(text.replace(/^---\r?\n[\s\S]*?\r?\n---/, ''));
  if (!h1) {
    errors.push(`${rel}: no H1 title`);
  } else {
    const flattened = h1[1]
      .replace(/[–—]/g, '-')
      .replace(/\s+/g, ' ')
      .trim();
    const expected = name.replace(/\s+/g, ' ').trim();
    if (flattened.replace(/\s*-\s*/g, ' ') !== expected.replace(/\s*-\s*/g, ' ')) {
      errors.push(`${rel}: filename does not match H1 "${h1[1]}"`);
    }
  }

  if (!fm) {
    errors.push(`${rel}: missing YAML frontmatter`);
    continue;
  }
  for (const key of REQUIRED) {
    if (!fm[key]) errors.push(`${rel}: missing frontmatter field "${key}"`);
  }
  for (const key of fm.__duplicates) {
    errors.push(`${rel}: duplicate frontmatter key "${key}"`);
  }
  if (fm.updated && !/^\d{4}-\d{2}-\d{2}$/.test(fm.updated)) {
    errors.push(`${rel}: "updated" must be an ISO date, got "${fm.updated}"`);
  }
  if (rel.startsWith('notes/items/') && fm.id && !/^OI-\d+$/.test(fm.id)) {
    errors.push(`${rel}: item id must be OI-NN matching the tracker row, got "${fm.id}"`);
  }
  if (fm.id) {
    if (ids.has(fm.id)) errors.push(`${rel}: duplicate id "${fm.id}" (also in ${ids.get(fm.id)})`);
    else ids.set(fm.id, rel);
  }
  if (fm.requirement && fm.id) {
    for (const req of fm.requirement.replace(/[[\]]/g, '').split(',')) {
      const trimmed = req.trim();
      if (trimmed) noteRequirements.push({ noteId: fm.id, rel, req: trimmed });
    }
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
    errors.push(`${rel}: contains [[wikilinks]] - use relative markdown links`);
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

// --- Requirement trace: notes <-> requirements/pienissimo-requirements.yaml ---
// Deliberately regex-based, to keep this script dependency-free like the rest of
// it. Requirement ids are scanned across the whole file - most live under
// `requirements:`, but OUT-01..03 sit in `scope:` and REG-01/02 in
// `build_state:`, and a note may legitimately cite any of them. DGM-1/DGM-2 in
// `sources:` are the draw.io diagrams, not requirements.
const registry = join(root, 'requirements', 'pienissimo-requirements.yaml');
if (existsSync(registry)) {
  const yaml = readFileSync(registry, 'utf8');

  const requirementIds = new Set();
  const trackedBy = new Map(); // requirement id -> Set of note ids
  // Each entry is a flow mapping; slice from one `id:` to just before the next.
  const marks = [...yaml.matchAll(/^\s*-?\s*id:\s*((?:DM|[A-Z]{3})-\d+)/gm)].filter(
    (m) => !m[1].startsWith('DGM-')
  );
  marks.forEach((mark, i) => {
    const reqId = mark[1];
    requirementIds.add(reqId);
    const chunk = yaml.slice(mark.index, i + 1 < marks.length ? marks[i + 1].index : undefined);
    const tracked = /tracked_by:\s*\[([^\]]*)\]/.exec(chunk);
    const set = trackedBy.get(reqId) || new Set();
    if (tracked) {
      for (const n of tracked[1].split(',').map((s) => s.trim()).filter(Boolean)) set.add(n);
    }
    trackedBy.set(reqId, set);
  });

  if (requirementIds.size === 0) {
    warnings.push('requirements registry: no requirement ids parsed - has the file structure changed?');
  }

  let untraced = 0;
  for (const { noteId, rel, req } of noteRequirements) {
    if (!requirementIds.has(req)) {
      warnings.push(`${rel}: cites requirement "${req}", which is not defined in the registry`);
    } else if (trackedBy.get(req).size === 0) {
      // Not yet backfilled. Counted, not shouted about, one line per note is noise.
      untraced++;
    } else if (!trackedBy.get(req).has(noteId)) {
      warnings.push(`${rel}: cites "${req}", but ${req} does not list ${noteId} in tracked_by`);
    }
  }
  if (untraced) {
    warnings.push(
      `${untraced} note(s) cite a requirement that does not name them back - run the trace backfill`
    );
  }

  for (const [reqId, notes] of trackedBy) {
    for (const noteId of notes) {
      if (!ids.has(noteId)) {
        warnings.push(`requirements registry: ${reqId} tracked_by "${noteId}", which is not a note id`);
      } else if (!noteRequirements.some((n) => n.noteId === noteId && n.req === reqId)) {
        warnings.push(`requirements registry: ${reqId} lists ${noteId}, but that note does not cite ${reqId}`);
      }
    }
  }

  const traced = [...trackedBy.values()].filter((s) => s.size > 0).length;
  if (!errors.length) {
    console.log(
      `requirement trace: ${traced}/${requirementIds.size} requirements reachable from a note`
    );
  }
}

const noteCount = noteFiles.length;
if (warnings.length) {
  console.warn(`\nvault:check - ${warnings.length} trace warning(s), not blocking:\n`);
  for (const w of warnings) console.warn(`  ! ${w}`);
  console.warn('');
}
if (errors.length) {
  console.error(`vault:check FAILED - ${errors.length} problem(s) across ${noteCount} notes\n`);
  for (const e of errors) console.error(`  ${e}`);
  process.exit(1);
}
console.log(`vault:check OK - ${noteCount} notes, ${ids.size} unique ids, all links resolve`);
