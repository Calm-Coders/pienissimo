# Slack result delivery

This project has standing user authorization to send every completed
`org-status-check` result to the one verified Slack destination below.

## Verified destination

| Setting          | Value                                                                                  |
| ---------------- | -------------------------------------------------------------------------------------- |
| Workspace        | `Romi` — `T8MJ1KWJ2`                                                                   |
| Project group DM | `Pienissimo devs` — `C0BQD34LLF4` — Aurel Mrruku, Rexhina Hysi, Sara Aga and Anita Aga |
| Verified         | Group DM on 2026-08-26 by exact name and membership                                    |

Use Slack's send-message action once, with `channel_id: C0BQD34LLF4` for the
existing `Pienissimo devs` group DM. Do not search again during ordinary runs,
create a channel or group, or substitute another conversation. If the
destination is unreachable, report the failure in chat instead of guessing a
replacement.

**Do not send a personal DM.** Aurel asked on 2026-08-31 for the personal-DM
copy to stop; he is a member of the group DM and receives the result there. A
second copy is duplication, not redundancy. Send to the group DM only, even
when a run is started from his own session.

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

After sending, return the Slack message link (and any thread links) in chat. Do
not retry an ambiguous send failure because that can duplicate a message. A
run-specific instruction from Aurel not to send overrides this standing
preference for that run only.
