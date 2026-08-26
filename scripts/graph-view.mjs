#!/usr/bin/env node
/**
 * Render the Graphify-SFDX snapshot as a self-contained, offline HTML page.
 *
 * `graphify-out/graph.json` is the only view of the org's metadata that carries
 * relationships, but it is reachable exclusively as text through the MCP tools.
 * This turns it into something you can look at: a force-directed map of the
 * objects, fields, Apex, LWC, validation rules and order-of-execution steps,
 * filterable by node kind and relation.
 *
 * Two deliberate constraints:
 *
 *   - **The Apex `source` text on every node is stripped.** The graph carries
 *     each class's full body, which would triple the page and put source code in
 *     a file that is easy to forward. The page keeps the file path and line
 *     instead, so you can open the real thing.
 *   - **Output goes to `graphify-out/`, which is gitignored.** The page is
 *     generated data, like the graph it renders. Nothing here is committed.
 *
 * Dependency-free, like `vault-check.mjs` — this repository has no bundler and
 * the page must work offline, so the force layout is ~60 lines of plain JS
 * rather than a CDN import that a strict network would block.
 *
 *   node scripts/graph-view.mjs [path/to/graph.json] [-o out.html]
 */

import { readFileSync, writeFileSync, existsSync } from "node:fs";
import { dirname, resolve, relative, join } from "node:path";
import { fileURLToPath } from "node:url";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const argv = process.argv.slice(2);
const outFlag = argv.indexOf("-o");
const outPath =
  outFlag !== -1
    ? resolve(argv[outFlag + 1])
    : join(root, "graphify-out", "graph.html");
const inPath = resolve(
  argv.find((a, i) => !a.startsWith("-") && argv[i - 1] !== "-o") ??
    join(root, "graphify-out", "graph.json")
);

if (!existsSync(inPath)) {
  console.error(
    `graph-view: ${relative(root, inPath)} not found - run 'npm run intelligence:graph' first`
  );
  process.exit(1);
}

const graph = JSON.parse(readFileSync(inPath, "utf8"));

// A class node's `label` is scraped from its doc comment and is often a stray
// word ("used"). The filename is the only reliable name for one.
function displayName(n) {
  if (n.sf_api_name) return n.sf_api_name;
  if (n.sf_code_type === "class" || n.sf_code_type === "trigger") {
    const base = String(n.source_file ?? "")
      .split(/[\\/]/)
      .pop();
    if (base) return base.replace(/\.(cls|trigger)$/i, "");
  }
  return n.label || n.id;
}

const nodes = graph.nodes.map((n) => ({
  id: n.id,
  name: displayName(n),
  kind: n.file_type ?? "other",
  code: n.sf_code_type ?? null,
  obj: n.sf_object ?? n.sf_ooe_sobject ?? null,
  community: n.community ?? null,
  api: n.sf_api_name ?? null,
  fieldType: n.sf_field_type ?? null,
  violation: n.sf_violation_type ?? null,
  step: n.sf_ooe_step ?? null,
  file: n.source_file
    ? relative(root, n.source_file).split("\\").join("/")
    : null
}));

const links = graph.links.map((l) => ({
  s: l.source,
  t: l.target,
  rel: l.relation ?? "related",
  conf: l.confidence ?? null,
  loop: !!l.sf_in_loop,
  loc: l.source_location ?? null
}));

const payload = JSON.stringify({ nodes, links, generated: null }).replace(
  /</g,
  "\\u003c"
);

const html = `<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Salesforce metadata graph</title>
    <style>
      :root {
        --bg: #fbfbfa; --fg: #1c1c1a; --muted: #6b6b66; --line: #e3e3df;
        --card: #ffffff; --shadow: rgba(0, 0, 0, 0.06);
        --k-sobject: #2f6f4f; --k-field: #4a72b8; --k-code: #8a4fbf;
        --k-concept: #8a6413; --k-lwc: #b8543a; --k-rule: #9b3226;
        --k-other: #6b6b66; --edge: #c9c9c4; --violation: #9b3226;
      }
      @media (prefers-color-scheme: dark) {
        :root {
          --bg: #16161a; --fg: #ececea; --muted: #9a9a95; --line: #2c2c31;
          --card: #1e1e23; --shadow: rgba(0, 0, 0, 0.4);
          --k-sobject: #7fc0a0; --k-field: #8fb4ec; --k-code: #c39bea;
          --k-concept: #d9b168; --k-lwc: #e8967a; --k-rule: #e08b7f;
          --k-other: #9a9a95; --edge: #3a3a41; --violation: #e08b7f;
        }
      }
      * { box-sizing: border-box; }
      html, body { height: 100%; }
      body {
        margin: 0; background: var(--bg); color: var(--fg);
        font: 14px/1.5 ui-sans-serif, system-ui, -apple-system, "Segoe UI", sans-serif;
        display: grid; grid-template-rows: auto 1fr; height: 100vh; overflow: hidden;
      }
      header {
        border-bottom: 1px solid var(--line); padding: 0.7rem 1rem;
        display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;
      }
      h1 { font-size: 0.95rem; margin: 0; font-weight: 650; letter-spacing: -0.01em; }
      .count { color: var(--muted); font-size: 0.8rem; }
      input[type="search"] {
        background: var(--card); color: var(--fg); border: 1px solid var(--line);
        border-radius: 0.4rem; padding: 0.3rem 0.55rem; font: inherit; font-size: 0.85rem; min-width: 14rem;
      }
      .chips { display: flex; gap: 0.3rem; flex-wrap: wrap; }
      .chip {
        font-size: 0.75rem; padding: 0.15rem 0.5rem; border-radius: 0.35rem;
        border: 1px solid var(--line); background: var(--card); cursor: pointer;
        user-select: none; white-space: nowrap; color: var(--muted);
      }
      .chip.on { color: var(--fg); border-color: currentColor; font-weight: 600; }
      .chip .dot { display: inline-block; width: 0.55em; height: 0.55em; border-radius: 50%; margin-right: 0.35em; vertical-align: baseline; }
      main { display: grid; grid-template-columns: 1fr 20rem; min-height: 0; }
      #canvas { width: 100%; height: 100%; display: block; cursor: grab; }
      #canvas.drag { cursor: grabbing; }
      aside {
        border-left: 1px solid var(--line); padding: 1rem; overflow-y: auto;
        background: var(--card); font-size: 0.85rem;
      }
      aside h2 { font-size: 0.72rem; text-transform: uppercase; letter-spacing: 0.09em; color: var(--muted); margin: 0 0 0.5rem; }
      aside h3 { font-size: 1rem; margin: 0 0 0.15rem; word-break: break-word; }
      aside dl { display: grid; grid-template-columns: auto 1fr; gap: 0.2rem 0.6rem; margin: 0.8rem 0; }
      aside dt { color: var(--muted); font-size: 0.78rem; }
      aside dd { margin: 0; word-break: break-word; font-size: 0.8rem; }
      aside code { font-size: 0.78rem; word-break: break-all; }
      .nbr { display: block; width: 100%; text-align: left; background: none; border: 0; border-bottom: 1px solid var(--line); padding: 0.35rem 0; color: var(--fg); font: inherit; font-size: 0.8rem; cursor: pointer; }
      .nbr:hover { color: var(--k-field); }
      .nbr .rel { color: var(--muted); font-size: 0.72rem; }
      .hint { color: var(--muted); font-size: 0.8rem; }
      text { pointer-events: none; user-select: none; }
    </style>
  </head>
  <body>
    <header>
      <h1>Salesforce metadata graph</h1>
      <span class="count" id="count"></span>
      <input type="search" id="q" placeholder="Search name, object, file..." />
      <div class="chips" id="kinds"></div>
      <div class="chips" id="rels"></div>
    </header>
    <main>
      <svg id="canvas"></svg>
      <aside id="panel"><p class="hint">Click a node to inspect it. Drag the background to pan, scroll to zoom, drag a node to pin it.</p></aside>
    </main>
    <script id="data" type="application/json">${payload}</script>
    <script>
      var DATA = JSON.parse(document.getElementById('data').textContent);
      var KIND_COLOR = {
        sobject: 'var(--k-sobject)', field: 'var(--k-field)', code: 'var(--k-code)',
        concept: 'var(--k-concept)', lwc_component: 'var(--k-lwc)',
        validation_rule: 'var(--k-rule)', record_type: 'var(--k-rule)',
        permission_set: 'var(--k-rule)', other: 'var(--k-other)'
      };
      var svg = document.getElementById('canvas');
      var panel = document.getElementById('panel');
      var NS = 'http://www.w3.org/2000/svg';

      var byId = {};
      DATA.nodes.forEach(function (n) { byId[n.id] = n; n.deg = 0; });
      DATA.links = DATA.links.filter(function (l) { return byId[l.s] && byId[l.t]; });
      DATA.links.forEach(function (l) { byId[l.s].deg++; byId[l.t].deg++; });

      var kinds = {}, rels = {};
      DATA.nodes.forEach(function (n) { kinds[n.kind] = (kinds[n.kind] || 0) + 1; });
      DATA.links.forEach(function (l) { rels[l.rel] = (rels[l.rel] || 0) + 1; });
      var kindOn = {}, relOn = {};
      Object.keys(kinds).forEach(function (k) { kindOn[k] = true; });
      Object.keys(rels).forEach(function (r) { relOn[r] = true; });

      function chip(container, label, count, color, get, set) {
        var b = document.createElement('button');
        b.className = 'chip on';
        b.innerHTML = (color ? '<span class="dot" style="background:' + color + '"></span>' : '') +
          label + ' <span style="opacity:.6">' + count + '</span>';
        b.onclick = function () { set(!get()); b.className = 'chip' + (get() ? ' on' : ''); apply(); };
        container.appendChild(b);
      }
      Object.keys(kinds).sort(function (a, b) { return kinds[b] - kinds[a]; }).forEach(function (k) {
        chip(document.getElementById('kinds'), k.replace(/_/g, ' '), kinds[k], KIND_COLOR[k] || KIND_COLOR.other,
          function () { return kindOn[k]; }, function (v) { kindOn[k] = v; });
      });
      Object.keys(rels).sort(function (a, b) { return rels[b] - rels[a]; }).forEach(function (r) {
        chip(document.getElementById('rels'), r.replace(/_/g, ' '), rels[r], null,
          function () { return relOn[r]; }, function (v) { relOn[r] = v; });
      });

      // Deterministic start positions - a seeded ring, so the same graph opens
      // the same way twice instead of reshuffling on every reload.
      var seed = 7;
      function rnd() { seed = (seed * 1103515245 + 12345) % 2147483648; return seed / 2147483648; }
      DATA.nodes.forEach(function (n, i) {
        var a = (i / DATA.nodes.length) * Math.PI * 2;
        n.x = Math.cos(a) * 300 + (rnd() - 0.5) * 60;
        n.y = Math.sin(a) * 300 + (rnd() - 0.5) * 60;
        n.vx = 0; n.vy = 0;
      });

      var view = { x: 0, y: 0, k: 1 };
      var g = document.createElementNS(NS, 'g');
      var gLinks = document.createElementNS(NS, 'g');
      var gNodes = document.createElementNS(NS, 'g');
      g.appendChild(gLinks); g.appendChild(gNodes); svg.appendChild(g);

      var selected = null, query = '';
      var shownNodes = [], shownLinks = [], els = {};

      function radius(n) { return 4 + Math.min(9, Math.sqrt(n.deg) * 2.2); }

      function apply() {
        shownLinks = DATA.links.filter(function (l) {
          return relOn[l.rel] && kindOn[byId[l.s].kind] && kindOn[byId[l.t].kind];
        });
        var keep = {};
        shownLinks.forEach(function (l) { keep[l.s] = 1; keep[l.t] = 1; });
        shownNodes = DATA.nodes.filter(function (n) { return kindOn[n.kind] && (keep[n.id] || n.deg === 0); });
        draw();
        document.getElementById('count').textContent =
          shownNodes.length + ' of ' + DATA.nodes.length + ' nodes - ' +
          shownLinks.length + ' of ' + DATA.links.length + ' edges';
        alpha = 0.9;
        if (!running) tick();
      }

      function esc(s) {
        return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
      }

      function matches(n) {
        if (!query) return true;
        var hay = (n.name + ' ' + (n.obj || '') + ' ' + (n.file || '') + ' ' + n.id).toLowerCase();
        return hay.indexOf(query) !== -1;
      }

      function draw() {
        gLinks.textContent = ''; gNodes.textContent = ''; els = {};
        shownLinks.forEach(function (l) {
          var line = document.createElementNS(NS, 'line');
          line.setAttribute('stroke', l.rel === 'governor_violation' || l.loop ? 'var(--violation)' : 'var(--edge)');
          line.setAttribute('stroke-width', l.rel === 'governor_violation' ? 2 : 1);
          if (l.conf === 'INFERRED') line.setAttribute('stroke-dasharray', '3 3');
          l._el = line; gLinks.appendChild(line);
        });
        shownNodes.forEach(function (n) {
          var grp = document.createElementNS(NS, 'g');
          var c = document.createElementNS(NS, 'circle');
          c.setAttribute('r', radius(n));
          c.setAttribute('fill', KIND_COLOR[n.kind] || KIND_COLOR.other);
          c.setAttribute('stroke', n.violation ? 'var(--violation)' : 'var(--bg)');
          c.setAttribute('stroke-width', n.violation ? 2.5 : 1.5);
          c.style.cursor = 'pointer';
          grp.appendChild(c);
          if (n.deg >= 3 || n.kind === 'sobject' || n.code === 'class' || n.code === 'trigger') {
            var t = document.createElementNS(NS, 'text');
            t.textContent = n.name.length > 28 ? n.name.slice(0, 27) + '\\u2026' : n.name;
            t.setAttribute('font-size', '9');
            t.setAttribute('fill', 'currentColor');
            t.setAttribute('text-anchor', 'middle');
            t.setAttribute('dy', -radius(n) - 4);
            grp.appendChild(t);
          }
          grp.onclick = function (e) { e.stopPropagation(); select(n); };
          grp.onmousedown = function (e) { e.stopPropagation(); startDragNode(e, n); };
          n._el = grp; els[n.id] = grp; gNodes.appendChild(grp);
        });
        paint();
      }

      function paint() {
        var near = {};
        if (selected) {
          near[selected.id] = 1;
          DATA.links.forEach(function (l) {
            if (l.s === selected.id) near[l.t] = 1;
            if (l.t === selected.id) near[l.s] = 1;
          });
        }
        shownNodes.forEach(function (n) {
          var dim = (query && !matches(n)) || (selected && !near[n.id]);
          n._el.setAttribute('opacity', dim ? 0.15 : 1);
        });
        shownLinks.forEach(function (l) {
          var hot = selected && (l.s === selected.id || l.t === selected.id);
          var dim = selected ? !hot : query ? !(matches(byId[l.s]) || matches(byId[l.t])) : false;
          l._el.setAttribute('opacity', dim ? 0.08 : selected ? 0.9 : 0.45);
        });
      }

      function select(n) {
        selected = n;
        var rows = '';
        function row(k, v) { if (v) rows += '<dt>' + k + '</dt><dd>' + v + '</dd>'; }
        row('kind', esc(n.kind).replace(/_/g, ' '));
        row('code type', n.code ? esc(n.code) : null);
        row('object', n.obj ? esc(n.obj) : null);
        row('api name', n.api ? '<code>' + esc(n.api) + '</code>' : null);
        row('field type', n.fieldType ? esc(n.fieldType) : null);
        row('OOE step', n.step ? esc(n.step) : null);
        row('community', n.community);
        row('degree', n.deg);
        row('violation', n.violation ? '<strong style="color:var(--violation)">' + esc(n.violation) + '</strong>' : null);
        row('file', n.file ? '<code>' + esc(n.file) + '</code>' : null);
        row('id', '<code>' + esc(n.id) + '</code>');
        var nb = '';
        DATA.links.forEach(function (l) {
          var other = l.s === n.id ? byId[l.t] : l.t === n.id ? byId[l.s] : null;
          if (!other) return;
          var dir = l.s === n.id ? '\\u2192' : '\\u2190';
          nb += '<button class="nbr" data-id="' + esc(other.id) + '">' + dir + ' ' + esc(other.name) +
            '<span class="rel"> &middot; ' + esc(l.rel).replace(/_/g, ' ') +
            (l.conf === 'INFERRED' ? ' (inferred)' : '') + (l.loc ? ' &middot; ' + l.loc : '') + '</span></button>';
        });
        panel.innerHTML = '<h2>Selected</h2><h3>' + esc(n.name) + '</h3><dl>' + rows + '</dl>' +
          '<h2>Connections (' + n.deg + ')</h2>' + (nb || '<p class="hint">None.</p>');
        Array.prototype.forEach.call(panel.querySelectorAll('.nbr'), function (b) {
          b.onclick = function () { var t = byId[b.getAttribute('data-id')]; if (t && t._el) select(t); };
        });
        paint();
      }

      svg.onclick = function () {
        selected = null;
        panel.innerHTML = '<p class="hint">Click a node to inspect it. Drag the background to pan, scroll to zoom, drag a node to pin it.</p>';
        paint();
      };
      document.getElementById('q').oninput = function (e) { query = e.target.value.trim().toLowerCase(); paint(); };

      // Force layout: repulsion is O(n^2), which at this size is a few tens of
      // thousands of pairs per frame - cheaper than any quadtree would be.
      var alpha = 1, running = false;
      function tick() {
        if (alpha < 0.005) { running = false; return; }
        running = true;
        alpha *= 0.985;
        var n = shownNodes.length;
        for (var i = 0; i < n; i++) {
          var a = shownNodes[i];
          for (var j = i + 1; j < n; j++) {
            var b = shownNodes[j];
            var dx = b.x - a.x, dy = b.y - a.y;
            var d2 = dx * dx + dy * dy || 0.01;
            if (d2 > 90000) continue;
            var f = 900 / d2;
            var d = Math.sqrt(d2);
            var ux = (dx / d) * f, uy = (dy / d) * f;
            if (!a.fixed) { a.vx -= ux; a.vy -= uy; }
            if (!b.fixed) { b.vx += ux; b.vy += uy; }
          }
        }
        shownLinks.forEach(function (l) {
          var a = byId[l.s], b = byId[l.t];
          var dx = b.x - a.x, dy = b.y - a.y;
          var d = Math.sqrt(dx * dx + dy * dy) || 0.01;
          var f = (d - 70) * 0.035;
          var ux = (dx / d) * f, uy = (dy / d) * f;
          if (!a.fixed) { a.vx += ux; a.vy += uy; }
          if (!b.fixed) { b.vx -= ux; b.vy -= uy; }
        });
        shownNodes.forEach(function (p) {
          if (p.fixed) return;
          p.vx -= p.x * 0.0022; p.vy -= p.y * 0.0022;
          p.vx *= 0.82; p.vy *= 0.82;
          p.x += p.vx * alpha * 3; p.y += p.vy * alpha * 3;
        });
        render();
        requestAnimationFrame(tick);
      }

      function render() {
        shownLinks.forEach(function (l) {
          var a = byId[l.s], b = byId[l.t];
          l._el.setAttribute('x1', a.x); l._el.setAttribute('y1', a.y);
          l._el.setAttribute('x2', b.x); l._el.setAttribute('y2', b.y);
        });
        shownNodes.forEach(function (p) {
          p._el.setAttribute('transform', 'translate(' + p.x + ',' + p.y + ')');
        });
        g.setAttribute('transform', 'translate(' + view.x + ',' + view.y + ') scale(' + view.k + ')');
      }

      function resize() {
        var r = svg.getBoundingClientRect();
        svg.setAttribute('viewBox', -r.width / 2 + ' ' + -r.height / 2 + ' ' + r.width + ' ' + r.height);
      }
      window.onresize = resize; resize();

      var pan = null;
      svg.addEventListener('mousedown', function (e) { pan = { x: e.clientX, y: e.clientY, vx: view.x, vy: view.y }; svg.classList.add('drag'); });
      window.addEventListener('mouseup', function () { pan = null; dragging = null; svg.classList.remove('drag'); });
      window.addEventListener('mousemove', function (e) {
        if (dragging) {
          var r = svg.getBoundingClientRect();
          dragging.x = (e.clientX - r.left - r.width / 2 - view.x) / view.k;
          dragging.y = (e.clientY - r.top - r.height / 2 - view.y) / view.k;
          dragging.vx = 0; dragging.vy = 0; render(); return;
        }
        if (!pan) return;
        view.x = pan.vx + (e.clientX - pan.x); view.y = pan.vy + (e.clientY - pan.y); render();
      });
      svg.addEventListener('wheel', function (e) {
        e.preventDefault();
        var f = e.deltaY < 0 ? 1.12 : 1 / 1.12;
        view.k = Math.max(0.15, Math.min(6, view.k * f)); render();
      }, { passive: false });

      var dragging = null;
      function startDragNode(e, n) { dragging = n; n.fixed = true; svg.classList.add('drag'); }

      apply();
    </script>
  </body>
</html>
`;

writeFileSync(outPath, html, "utf8");
const kb = Math.round(Buffer.byteLength(html) / 1024);
console.log(
  `graph-view: ${nodes.length} nodes, ${links.length} edges -> ${relative(root, outPath).split("\\").join("/")} (${kb} KB)`
);
