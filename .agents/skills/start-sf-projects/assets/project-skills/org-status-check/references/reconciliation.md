# Reconcile the project record

Use only in `reconcile` or `publish` mode. Atomic notes are the volatile source;
trackers, recaps, status pages and external mirrors are rendered views.

1. Update affected atomic notes from verified evidence and bump their update
   date. Add separate notes for new divergent, unrequested or operational-risk
   findings. Preserve superseded diagnoses and explain the failed instrument.
2. Update structured build state without changing requirement text. Record org
   identity, observation time, repository commit, method, drift and limitations.
3. Regenerate only affected hubs, bilingual trackers and recaps. Keep earlier
   decisions intact; a newer build observation supersedes only older build
   claims.
4. Regenerate the internal status file from notes. Do not move names, security
   details, prices, product codes or credentials to a public surface.
5. Append the repository's session journal, run its knowledge-integrity and
   formatting checks, and review the final diff for unrelated churn.

Never commit or push unless the user asks.
