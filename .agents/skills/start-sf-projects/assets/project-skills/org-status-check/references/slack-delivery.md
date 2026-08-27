# Slack result delivery

Result delivery is **disabled by default**. Enable it in a project-specific copy
only after the intended recipient explicitly asks for recurring delivery.

When enabled, record the exact Slack workspace id, user id, verification date
and authorization scope here. Resolve the user with an exact Slack user search;
never rely on a display name alone. Send only by DM to that user id, never to a
project channel or similarly named account.

Send after the org-status run, selected reconciliation/publication mode and
validations finish. Include the same substantive result delivered in chat:
scope, evidence basis, all three verdict counts, every non-matching finding,
limitations, actions and explicit non-actions. Split messages at 4,500
characters and thread continuations rather than dropping findings.

Never include secrets, credentials, endpoints, customer records, catalogue
values, product codes or local filesystem paths. Return the Slack message link
in chat. Do not retry an ambiguous send failure because that can create a
duplicate; report the delivery failure without failing the completed org check.
