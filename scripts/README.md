# Scripts

Run each one with an explicit `--target-org` (`"Pienissimo UAT"` or
`"Pienissimo Prod"`). Anonymous Apex runs as the authenticated user.

## Nightly Mexal syncs

The schedulers are deployed with the classes but **not scheduled by the
deploy**: after a fresh deploy to an org, run
`schedule-mexal-nightly-syncs.apex` once.

| Script                                                                               | What it does                                                                                                                                                          |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [apex/schedule-mexal-nightly-syncs.apex](apex/schedule-mexal-nightly-syncs.apex)     | Schedules articles 01:00, customers 02:00, invoices and scadenzario 03:30. Re-runnable: aborts and reschedules jobs of the same name. Run as a user on `Europe/Rome`. |
| [apex/unschedule-mexal-nightly-syncs.apex](apex/unschedule-mexal-nightly-syncs.apex) | Removes those three jobs only.                                                                                                                                        |
| [apex/run-mexal-article-sync-now.apex](apex/run-mexal-article-sync-now.apex)         | One article sync now, without waiting for the night.                                                                                                                  |
| [apex/run-mexal-customer-sync-now.apex](apex/run-mexal-customer-sync-now.apex)       | One customer sync now.                                                                                                                                                |
| [apex/run-mexal-invoice-sync-now.apex](apex/run-mexal-invoice-sync-now.apex)         | One invoice → lines → scadenzario sync now. Run the customer sync first if new customers may be involved.                                                             |

```bash
sf apex run --target-org "Pienissimo UAT" --file scripts/apex/schedule-mexal-nightly-syncs.apex
```

## Checks

`sf data query --file` does not accept comments, so the `.soql` files are bare
queries. All times come back in UTC.

| Query                                                                          | What it shows                                                                                      |
| ------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------- |
| [soql/scheduled-apex-jobs.soql](soql/scheduled-apex-jobs.soql)                 | Every scheduled job in the org, next run first.                                                    |
| [soql/recent-async-apex-jobs.soql](soql/recent-async-apex-jobs.soql)           | Batch, queueable and scheduled runs in the last two days: whether a job started at all.            |
| [soql/mexal-sync-logs-last-2-days.soql](soql/mexal-sync-logs-last-2-days.soql) | `Integration_Log__c` rows of the three syncs. One per step per night; `Is_Error__c` = step failed. |

```bash
sf data query --target-org "Pienissimo UAT" --file scripts/soql/mexal-sync-logs-last-2-days.soql
```
