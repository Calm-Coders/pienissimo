# Slack result delivery

This project has standing user authorization to send every completed
`org-status-check` result to both verified Slack destinations below.

## Verified destinations

| Setting          | Value                                                                                               |
| ---------------- | --------------------------------------------------------------------------------------------------- |
| Workspace        | `Romi` — `T8MJ1KWJ2`                                                                                |
| Personal DM      | Aurel Mrruku — `U0A3Y0N8YG3`                                                                        |
| Project group DM | `Pienissimo devs` — `C0BQD34LLF4` — Aurel Mrruku, Rexhina Hysi, Sara Aga and Anita Aga              |
| Verified         | Personal DM on 2026-08-26 by exact user lookup; group DM on 2026-08-26 by exact name and membership |

Use Slack's send-message action twice: once with `channel_id: U0A3Y0N8YG3`,
which opens or reuses Aurel's personal DM, and once with
`channel_id: C0BQD34LLF4` for the existing `Pienissimo devs` group DM. Send the
same substantive report independently to both destinations. Do not search
again during ordinary runs, create a channel or group, or substitute another
conversation. If one destination is unreachable, deliver to the other and
report the partial failure in chat instead of guessing a replacement.

## Message content

Send the same substantive result delivered in chat, reformatted for Slack:

- observation time, scope, output mode and live-org versus repository-only
  basis;
- counts for compliance, deployment drift and operability;
- every non-matching finding, most severe first, with requirement ids,
  consequence and `verified`/`inferred` status;
- evidence limitations or degraded indexes;
- reconciliation or publication performed, and explicit non-actions;
- links only when they are already pushed and accessible to the recipient.

Never include credentials, access tokens, endpoints, catalogue values,
article-code values, customer records or local filesystem paths. Keep each
message below 4,500 characters. If the complete result is longer, send the
summary first and put numbered continuation messages in its thread; do not omit
findings merely to fit one message.

After sending, return both Slack message links in chat. Do not retry an
ambiguous send failure because that can duplicate a message. A run-specific
instruction from Aurel not to send overrides this standing preference for that
run only.
