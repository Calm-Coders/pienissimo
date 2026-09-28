---
id: risk-anticipay-fields-unbuilt
type: risk
status: resolved
severity: high
owner: Aurel Mrruku
org: ROMI
raised: 2026-09-02
updated: 2026-09-04
depends_on: [OI-95, OI-107]
blocks: [OI-73, go-live]
requirement: [INT-18]
source: org-status-check against Pienissimo UAT, 2026-09-02 08:05-08:14Z
evidence: Tooling FieldDefinition on Account, Pienissimo UAT
---

# Risk - the Anticipay field build has not started

**[OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md) was
resolved on 1 September specifically so this build could start. On 2 September
the org shows it has not.**

`Account` carries **three** custom fields:

- `Lead_Email__c`
- `Nome_Locale__c`
- `Partita_IVA__c`

None of them is PEC. None is one of the five legal-representative fields. There
is no free-text field for the representative's address. Proven absent by Tooling
`FieldDefinition`, which is not filtered by field-level security — so this is
not [the false negative that caught the 25 August run](../How%20to%20read%20the%20org%20schema%20without%20a%20false%20negative.md).

## Why this is the sharpest date on the project

**Fase 1 development ends 10 September** — ROMI's own project plan, not the
6 October go-live. That is **eight days**, and the eleven fields are only the
data-model half of the work. The rest of the Anticipay leg is also unstarted and
some of it is blocked:

| Piece                                          | State on 2026-09-02                                                                                                                                 |
| ---------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| The eleven `Account` fields                    | **not built**                                                                                                                                       |
| `Integration_Configuration__c` endpoint row    | **zero rows**, and zero object permissions — see [the scaffolding](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md) |
| Path-parameter support in `API_Callout_Engine` | **not built** — the engine cannot pass `:piva` at all, see [the contract](../The%20Anticipay%20middleware%20API%20contract.md)                      |
| Error-path handling                            | **defective** — see [OI-107](../items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)           |
| Error response bodies from Pienissimo Software | **still owed**, the last technical blocker                                                                                                          |

So "the VAT build can start" — the closing line of the 1 September minute — is
true and has not been acted on.

## What is not blocked

**The eleven fields are buildable today.** They need no endpoint, no token and
no answer from Andrea Parmeggiani: the field list was settled in the room on
1 September and is written down. The blocked pieces are the callout and the
error path, not the schema.

That matters because it means the schema work can proceed in parallel with the
outstanding client answer instead of queuing behind it.

## Two things to decide while building, not after

- **`data_di_dascita_legale_rappresentante` is misspelled in the wire format**
  ([OI-105](../items/OI-105%20The%20Anticipay%20date%20of%20birth%20field%20name%20is%20misspelled.md)).
  The Salesforce field name does not have to inherit the typo, but the mapping
  has to know about it. Decide the spelling once, here, rather than twice.
- **Six of the eleven fields identify a private individual**
  ([OI-108](../items/OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md)),
  and the 1 September room took all five legal-representative fields without the
  personal-data question being raised. Building them makes that concrete. It is
  still worth asking before, not after.

## The ask

**Start the eleven fields.** If they are not going to land before 10 September,
that is a Fase 1 scope decision and belongs to Elena Spini, not to a build
queue — say so explicitly rather than letting the date arrive.

## ✅ 2026-09-04 — resolved. The fields exist, and this risk was stale when written

**`Account` carries ten custom fields, and the
[OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md)
build is among them.** Read from `force-app/main/default/objects/Account/fields/`
on 4 September:

| Field                                       | The OI-95 decision it implements                |
| ------------------------------------------- | ----------------------------------------------- |
| `PEC__c`                                    | PEC as a new custom field                       |
| `Nome_Legale_Rappresentante__c`             | the five legal-representative fields, on Account |
| `Codice_Fiscale_Legale_Rappresentante__c`   | — as Elisa Migliano insisted, not on a Contact  |
| `Data_Nascita_Legale_Rappresentante__c`     |                                                 |
| `Luogo_Nascita_Legale_Rappresentante__c`    |                                                 |
| `Indirizzo_Legale_Rappresentante__c`        | the representative's address as **one** field   |
| `Anticipay_Consolidato__c`                  | new — gates the automatic lookup, see below     |
| `Partita_IVA__c`, `Lead_Email__c`, `Nome_Locale__c` | the three that already existed          |

⚠ **This risk was already false when it was written.** The fields landed in
commit `9b38d1a` on **2026-09-02**; the org check that raised this risk ran the
same morning at **08:05–08:14Z**, hours earlier. The finding was correct at the
moment it was taken and stale by the end of that day, and **the 02/09 and 03/09
sweeps both carried it forward unchecked**. `MAP.md` repeated it twice.

**The lesson is the method one**, and it is the same lesson the 3 September run
drew about pull requests: an org check is a photograph, and a photograph of an
active branch goes out of date within hours. A `git diff` against the previous
watermark would have caught this in one command on 2 September.

## What the same commit built beyond the schema

- **`AnticipayAccountService`** (+80 lines) and
  **`AnticipayAccountRefreshQueueable`** — the callout and its async wrapper.
- **`AnticipayOrderAutomation`** — on order insert, for an account with **no
  previous order** and `Anticipay_Consolidato__c != true`, enqueue a refresh.
  This is the _"Salesforce pushes the account before the order"_ leg of the
  ownership model settled at
  [Data Model Parte 1](../meetings/2026-09-03%20Data%20Model%20Parte%201.md).
- **Two `Aggiorna_Anticipay` quick actions** (Account and Order) with an
  `anticipayAccountRefreshAction` LWC — the manual re-check button
  [OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md)
  asked for.
- **`AnticipayErrorNotificationService`** and the
  `Anticipay_Error_Notification` email template — the agreed failure mail,
  **addressed to the wrong recipient**
  ([OI-119](../items/OI-119%20The%20Anticipay%20error%20notification%20goes%20to%20a%20hardcoded%20ROMI%20address.md)).
- The three error-path defects in `API_Callout_Engine` fixed
  ([OI-107](../items/OI-107%20The%20Anticipay%20error%20path%20does%20not%20reach%20the%20integration%20log%20intact.md)).

## What is still not built

The table in this note listed five pieces. Two survive:

- 🔴 **`Integration_Configuration__c` still holds zero rows** in source control,
  so the integration still has no configured endpoint or principal
  ([the scaffolding](../objects/The%20integration%20scaffolding%20has%20never%20been%20configured.md)).
- 🔴 **The error response bodies are still owed** by Andrea Parmeggiani.

⚠ **Path-parameter support was listed as missing and has not been re-verified by
this sweep.** `AnticipayAccountService` grew by 80 lines in the same commit and
`API_Callout_Engine` now takes a `pathParams` argument, so it has probably been
addressed — **but that was not read closely enough to assert.** Confirm it before
relying on it.

⚠ **None of this has been verified against the org.** Everything above is the
repository. The next `org-status-check` should confirm the fields are deployed
and, separately, whether the org still carries only the three.
