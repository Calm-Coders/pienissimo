# Publish status surfaces

Use only after reconciliation and only in `publish` mode. Read the repository's
publishing rules and Notion-mirror note first.

- Treat Notion as a publish target, never a source. Confirm workspace identity
  and use stored page/data-source ids; never search by title.
- Fetch before writing, update the existing status page in place, make the
  smallest replacement, and re-fetch to verify the stored result.
- Match tracker rows on stable reference id, never title. Do not delete history.
- If the connector is unavailable or the workspace differs, stop the mirror
  stage. The regenerated local status file remains the deliverable.
- Keep internal status/Notion and public-site audiences separate. Re-derive any
  public page from sanitized source facts; never copy internal prose into it.
- Publishing files does not deploy them. Deploy only when separately requested.
