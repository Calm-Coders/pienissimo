---
id: DEC-2026-10-05-event-link-collection-status
type: decision
status: active
owner: null
org: ROMI
raised: 2026-10-05
updated: 2026-10-05
depends_on: [OI-75, OI-78, OI-81, OI-126]
source: User instruction to Codex on 2026-10-05
---

# Decision - Event Link collection status follows campaign tickets

`Event_Invitation__c.Status__c` (`Stato Raccolta`) is an automatically
maintained aggregate for the invitation's exact Order-Campaign pair. It is not
the URL preparation state, the Asset lifecycle state, or proof that Marketing
Cloud sent a ticket.

The four states are:

| Value       | Meaning                                                                                                                                                                                                               |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Pending`   | The pair has no Assets, or at least one Asset is still `Ordinato` and none is currently `Disponibile`.                                                                                                                |
| `Ready`     | At least one Asset is `Disponibile`. Other `Ordinato` Assets do not block collection of tickets already available.                                                                                                    |
| `Completed` | The pair has Assets, none is `Disponibile` or `Ordinato`, and the tickets reached collection-terminal states other than an all-ticket `Rinuncia`, such as `Assegnato`, `Utilizzato`, `Non utilizzato` or `Annullato`. |
| `Cancelled` | Every Asset in the exact Order-Campaign pair is `Rinuncia`, or the whole invitation was explicitly cancelled. Automatic recalculation preserves it and the public controller rejects its token.                       |

Partial submission remains `Ready` while any ticket in the pair is still
`Disponibile`. If every currently actionable ticket is concluded but another
is still `Ordinato`, the invitation returns to `Pending`; when that ticket
becomes `Disponibile`, it can reopen to `Ready`. Adding, deleting, moving, or
changing the status of an Asset recalculates both the old and new pair.
The public `Rinuncia` action applies to all tickets in that same pair, so its
aggregate result is `Cancelled`, not `Completed`.

Recipient, send date, token and URL preparation do not determine `Stato
Raccolta`. They remain separate prerequisites for sending or opening the
participant journey. The legacy `Ready_Requires_Preparation` validation rule is
inactive because it incorrectly coupled those concerns to the Asset aggregate.

`Send_After__c` is derived from the linked Campaign's
`Data_Invio_Biglietto__c`. Campaign date changes refresh linked invitations.
An invocable recalculation action and an hourly schedulable entry point can
repair existing aggregate values without requiring an Asset edit. The hourly
job can be scheduled after deployment with
`EventInvitationService.scheduleHourly()`.

Implemented locally on 5 October 2026 in `EventInvitationService`,
`EventInvitationAssetTrigger`, and `EventInvitationCampaignTrigger`. The same
day, the logic was corrected so `Disponibile` alone makes the pair `Ready`;
preparation fields no longer keep it `Pending`. Earlier UAT check-only deploy
`0AfMA00000CquAT0AZ` validated the pre-correction implementation. The corrected
metadata compiled in final UAT dry-run `0AfMA00000Cqx6j0AB`. A test dry-run
`0AfMA00000Cqwll0AB` passed 27 of 28 existing tests; the sole failure is the
now-obsolete `TicketingTest.invitationTokenIsRegeneratedAndLinksRefreshed`
assertion that a `Disponibile` invitation is `Pending`. No Apex test code was
added. The all-ticket `Rinuncia` mapping was then corrected locally to
`Cancelled`. Final UAT compilation dry-run `0AfMA00000Cqx9y0AB` succeeded. Test
dry-run `0AfMA00000CqyCT0AZ` again passed 27 of 28 existing tests, with only the
same obsolete `Pending` assertion failing.
