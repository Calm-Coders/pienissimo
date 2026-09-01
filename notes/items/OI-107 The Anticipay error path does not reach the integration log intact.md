---
id: OI-107
type: open-item
status: open
owner: Aurel Mrruku
with: Andrea Parmeggiani
org: both
raised: 2026-09-01
updated: 2026-09-01
depends_on: [OI-94]
blocks: [OI-73]
requirement: INT-18
source: notes/The Anticipay middleware API contract.md
---

# OI-107 - The Anticipay error path does not reach the integration log intact

⚠ **Corrected 2026-09-01, same day.** This item was first written as _"the error
response body is undocumented, so the three-month error store cannot be built"_.
**That was wrong, and the correction matters.** The store is
[`Integration_Log__c`](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md)
— ROMI's standard callout audit trail, already committed, already the right
shape. It does not need designing and it does not wait on Pienissimo.

The real problem is narrower, more concrete, and **entirely in ROMI's own code**.

## What already works

`API_Callout_Engine` writes an `Integration_Log__c` row for every callout, and
the fields the 25 August agreement asked for are already populated:

| Agreed 25 August               | Where it lands                                                | Status   |
| ------------------------------ | ------------------------------------------------------------- | -------- |
| the error **code**             | `Response_State__c` — `String.valueOf(res.getStatusCode())`   | 🟢 works |
| the descriptive **message**    | `Response_Body__c` — the raw body, `LongTextArea(131072)`     | 🟢 works |
| a **history** for verification | one row per callout, `Request_Body__c` and endpoint alongside | 🟢 works |

🟢 **So the shape of the error body does not block storage.** Whatever
Pienissimo returns, the raw bytes land in `Response_Body__c`. The question
_"which key carries the message"_ matters for **reading** the log later, not for
writing it, and it is no longer urgent.

🟢 **The bearer token is not logged.** `setHeaders` only ever sets
`Content-Type`; `Request_Headers__c` exists on the object but the engine never
populates it. One less exposure than
[OI-106](OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md)
might have implied.

## 🔴 What is actually broken

### 1. `Is_Error__c` is never set for an HTTP error

Read the success path: after `new Http().send(req)` the engine sets
`Response_State__c` and `Response_Body__c` and **never touches `Is_Error__c`**.
The flag is set in exactly two places — when the `Integration_Configuration__c`
record is missing, and in the `catch` block for an Apex exception.

**A `404`, `401` or `500` from the middleware is a perfectly successful HTTP
send.** No exception is thrown. So the row is written with `Is_Error__c = false`.

Consequences, both of which hit the agreed design directly:

- **The error rows cannot be filtered.** A list view, report or scheduled job
  keyed on `Is_Error__c` returns nothing for the case this integration exists to
  handle.
- 🔴 **The internal notification agreed on 25 August will never fire.** Aurel
  Mrruku asked for the stored record to raise a notification so a history exists
  for verification. Built the obvious way — on `Is_Error__c` — it is silent for
  every VAT number Anticipay cannot find.

This is generic scaffolding behaviour, so **it is not an Anticipay bug**: it
affects Mexal and any other outbound callout equally. Fixing it here fixes it
everywhere, which is an argument for doing it properly rather than working
around it in one flow.

### 2. A non-matching error body loses the status code entirely

`deserializeResponse` runs **unconditionally, before any status check**:

```
result.payload = deserializeResponse(config, respJson);   // line 83
```

It does `JSON.deserialize(respJson, Response_Wrapper_Class__c)` — the wrapper
built for the **`200`** shape, `{ success, status, info }`. If the error body has
a different shape, the deserialize **throws**, and control jumps to the `catch`.

🔴 **The `catch` block builds a brand-new `Integration_Log__c` from scratch and
does not carry `Response_State__c` across.** It sets `Flow_Name__c`,
`Inbound_Outbound__c`, `Request_Body__c`, `Is_Error__c`, `Response_Body__c`,
`Exception_Message__c` and `Exception_StackTrace__c` — **no status code**.

So on a `404` whose body does not match the wrapper, the log records **an Apex
deserialization exception with no HTTP status**, instead of _"404, VAT number not
found"_. That is precisely the outcome the 25 August agreement was written to
prevent, and it is silent — the row exists, it just says the wrong thing.

**This is why the error body's shape still matters**, and it is a much more
specific reason than the one this item first gave. Two ways out, and they are not
exclusive:

1. **Ask Andrea Parmeggiani for one example of each error response** — a small
   ask that lets the wrapper be written to accept both shapes. Still worth having.
2. **Check the status code before deserializing**, and carry `Response_State__c`
   into the `catch`. This is the durable fix and it does not wait on anyone.

### 3. Nothing purges the log after three months

The retention agreed on 25 August is **a policy with no implementation**. The
standard scaffolding ships no purge job, and `Integration_Log__c` has no
retention field. Somebody has to write a scheduled delete, or the three months
becomes "forever" — which is the opposite failure from the one anyone worried
about, and it interacts with
[OI-108](OI-108%20The%20Anticipay%20payload%20carries%20personal%20data%20of%20the%20legale%20rappresentante.md):
🔴 **a successful lookup logs the full response body**, so the legal
representative's codice fiscale, date of birth and home address sit in
`Response_Body__c` **regardless of which fields OI-95 chooses to map onto the
Account.** Deciding not to store a field does not stop the log storing it.

### 4. `400` and `401` are new codes and they mean something different

Neither was part of the 25 August protocol. `404` and `500` describe the company
being looked up; **`400` and `401` describe a defect in ROMI's own call**. Once
`Is_Error__c` is fixed, all four raise the same notification unless the
notification reads `Response_State__c` and routes on it. A rotated token
([OI-106](OI-106%20One%20static%20bearer%20token%20serves%20both%20Anticipay%20environments.md))
would otherwise present as a run of unknown companies.

⚠ And under `env=test` the `404` bucket **already** carries two meanings — see
[the contract](../The%20Anticipay%20middleware%20API%20contract.md).

## The ask

**Aurel Mrruku owns most of this now**, which is a change from how the item was
first written:

1. **Set `Is_Error__c` from the status code** on the success path. One line, and
   it unblocks the agreed notification for every integration, not just this one.
2. **Status-check before deserializing**, and carry `Response_State__c` into the
   `catch` so a malformed error body cannot erase the code.
3. **Route the notification on `Response_State__c`**, so `401` does not read as
   `404`.
4. **Write the three-month purge**, and decide what it means for the personal
   data in `Response_Body__c` (OI-108).

**Andrea Parmeggiani** still owes **one example of each error response** — no
longer to unblock the store, but so the response wrapper can be written to accept
the error shape without throwing. Small ask, still worth making.

⚠ **Do not raise items 1–4 as defects in the standard scaffolding's design.**
Per [the convention](../Integration%20Configuration%20is%20standard%20ROMI%20scaffolding.md),
`Integration_Configuration__c`, `Integration_Log__c` and `API_Callout_Engine` are
house components asked for on every project. What is being flagged is that
**this integration's agreed error protocol needs behaviour the house engine does
not currently have** — which is a project decision about whether to extend the
engine or handle it in the Anticipay flow.

🔴 **See also the harder blocker**: the engine cannot pass a **path parameter**
at all, and Anticipay needs two (`:env` and `:piva`). That is recorded in
[the contract](../The%20Anticipay%20middleware%20API%20contract.md) under "Where it
lands in the org" and is a bigger question than anything on this item.
