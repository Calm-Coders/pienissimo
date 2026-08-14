# Journal - Pienissimo

Append-only session handoffs. Newest first. Any agent, any model, writes here
at the end of a session that changed project state, so the next one can resume
cold. Format and intent:
[notes/Retrieval and write protocol.md](notes/Retrieval%20and%20write%20protocol.md).

Keep the ten most recent entries here; archive older ones to
`notes/sessions/YYYY-QN.md`.

---

## 2026-08-14 — claude — requirements check, watermark 2026-08-07

- **Did:** swept Gmail, Slack, Drive and Fathom from the 2026-08-07 watermark.
  Six material findings, all folded into notes and both tracker languages.
- **State:** **Mexal field mapping answered** by Mirko Merendi on 11/08 —
  agent filter `610`, computed availability, causale FE, a **two-step N+1
  invoice retrieval** that is also the only source of the `numero riga d'ordine`
  [OI-75](notes/items/OI-75%20Ticket%20availability%20rule.md) needs, `501.AUTO`
  client creation, order serie 1 prod / 10 test. **Anticipay = ex CreditSafe**,
  one company — [OI-73](notes/items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md)
  is no longer uncertain. **Coupons excluded from phase 1**, closing one of
  [OI-49](notes/items/OI-49%20WooCommerce%20checkout-link%20flow.md)'s two open
  decisions. Four meetings dated: **19, 20, 25, 27 August**.
- **Next:** the 20/08 asset meeting is scope discovery, not review — Elisa says
  there are things never discussed. Read the two attachments before the 27/08
  build call: `Integrazioni pienissimo.xlsx` and the Mexal mapping workbook.
  Chase Fabrizio on **listino 1 vs listino 2**.
- **Watch:** three things. **(1)** A **sixth asset state, `rinuncia al
  servizio`**, exists in Elena's client-facing doc and in no version of
  [OI-74](notes/items/OI-74%20Asset%20state%20machine.md) — do not configure the
  picklist without it. **(2)** `PIENISSIMO - Project Status.docx` numbers its
  open points **1–15 under its own scheme**; never conflate with the tracker's
  `#NN`. **(3)** [OI-88](notes/items/OI-88%20Zoho%20import%20template%20owed%20to%20Pienissimo.md)
  is new and is the **only migration item ROMI owns** — it had no row anywhere.
- **Note:** the trace note now carries `external_watermark:`, and the earlier
  same-day repository trace is marked `superseded` and links forward, so the
  next run cannot mistake a repo read for a sweep.

---

## 2026-08-14 — claude — knowledge structure installed

- **Did:** replicated the Life365 knowledge architecture onto this repository.
  Added the routing layer ([MAP.md](MAP.md), [INDEX.md](INDEX.md),
  [AGENTS.md](AGENTS.md) with `CLAUDE.md` / `GEMINI.md` /
  `.github/copilot-instructions.md` as pointers, this journal), the
  [notes/](notes/) vault with its
  [protocol](notes/Retrieval%20and%20write%20protocol.md),
  `npm run vault:check`, committed Obsidian config, the four project skills in
  both `.agents/skills/` and `.claude/skills/`, and
  [docs/publishing.md](docs/publishing.md) + [site/](site/).
- **State:** the first wave of notes is written — every live open item, the
  people, the risks, what is actually built, and the three core flows.
  **Resolved tracker rows were deliberately not split**; they stay in
  `meetings/open-items.md` under `## Resolved`, which remains the archive.
- **Two findings came out of the migration, neither of them in any tracker.**
  **(1)** The repository is roughly a week ahead of the 2026-08-03 org check:
  `OrderBigliettoTrigger`, `Solo_Bundle__c`, both WooCommerce fields,
  `OrderItem.Data_Scadenza__c`, `Opportunity.Tipo_Opportunita__c` and an
  standard integration scaffolding were all committed 04–07 August by the
  Calm-Coders developers working for ROMI — Anita Aga, Sara Aga and Rexhina —
  and the trackers were never updated to match. (The scaffolding itself is
  house pattern and correctly has no requirement; everything else on that list
  does.) **(2)** The Biglietto DocuSign/PDF
  Apex stack that the org check found Active in UAT is **not in `force-app/`
  at all** — six classes live only in the org.
- **Next:** re-run the org check against UAT to date the divergence properly
  (the 2026-08-03 snapshot is now stale in both directions), and decide whether
  `Tranche__c` or the participant flow goes first when the team returns ~24–26
  August.
- **Watch:** item ids in `notes/items/` are the tracker's own numbers
  (`#64` → `OI-64`) because those numbers are cited in `REQUIREMENTS.md` and in
  the published artifacts. Never renumber them. Note filenames are ASCII with
  spaces — Italian domain words are fine, accents are transliterated.
