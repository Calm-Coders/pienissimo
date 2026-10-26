---
id: meeting-2026-10-08-internal-test
type: meeting
status: resolved
owner: Elena Spini
org: ROMI
raised: 2026-10-08
updated: 2026-10-08
source: Drive 1mahvMnO5mauF4VOgwfbv99DJUeNL1ZN2i6KPYo5dSpI
---

# 2026-10-08 Internal Test

**ROMI-internal working session, 10:00 CEST, ~2h — the whole delivery team and
no client in the room. Six `Concordato`, ten next steps. It reviewed the
marketing form fields against the data model, drove a renewal quote end to end,
and found the root cause of the Mexal order-send failure: the integration
classes were running `with sharing`.**

Present: **Elena Spini · Aurel Mrruku · Rexhina Hysi · Anita Aga.** All four are
ROMI-side. Source: the Gemini notes document, read in full — structured sections
plus all `Dettagli`; the verbatim transcript was read for the opening and the
field-mapping discussion only. The last transcript section is at `01:59:24`.

⚠ The document's title misspells the project as `PIENSSIMO`.

## Concordato

| # | Ruling |
| - | ------ |
| 1 | **Form fields map at Opportunity level**, marked in a distinct colour for the later clean-up |
| 2 | **Italy is the default country for Anticipay responses** |
| 3 | **A shortlist of about twenty products** is used for the campaign tests, and only for them |
| 4 | **The UAT user gets every permission**, integration permissions included, so the tests can run |
| 5 | **The IVA rate code travels from the article to the order line and the quote line** |
| 6 | **Any change to a field used in the quote must trigger a refresh of the PDF**, constraining the user's action |

## Where the form fields land, and why

Elena Spini brought the marketing form review — Matteo Distaso had reopened it
days earlier — against
[the Campi Oggetti workbook](../The%20Campi%20Oggetti%20Flussi%20e%20Utenti%20workbook.md)
as the data model. The question was whether UTM source and the `interessato a`
interest fields belong on Account, Contact or Opportunity.

Aurel Mrruku argued the Account is the core of a lead and that UTM fields are
standard custom fields present in every project. Elena Spini's counter-argument
carried it, and it is a volume argument: the same person submits many forms, the
registry data already exists after the first, so a second submission must create
an **Opportunity** rather than overwrite the Account.

> **Elena Spini:** _"since they have like thousand of this […] form, I think it's
> better having on opportunity level."_

The agreed shape is **a dedicated marketing-forms section on the Opportunity
page**, with the newly added fields coloured differently so the selection can be
cleaned up afterwards. Categoria, sottocategoria, tipologia di attività and the
profiling and privacy consent flags are placed there. The field list is
[OI-115](../items/OI-115%20Tipologia%20Attivita%20values%20and%20its%20move%20to%20the%20quote.md)'s,
still unreconciled against the client's picklist attachment.

## The root cause of the failed order send

Aurel Mrruku identified it live: `OrderMexalIntegrationService` and the rest of
the Mexal integration stack ran **`with sharing`** instead of `without sharing`,
so the executing user had no visibility on the class that sends the order.
Elena Spini had read the same failure as DocuSign missing from order creation;
Aurel Mrruku established it was the Mexal callout and the class's sharing mode.
Recorded as
[OI-223](../items/OI-223%20The%20Mexal%20order%20send%20failed%20because%20the%20integration%20classes%20ran%20with%20sharing.md).

## Surfacing the integration error where it happens

Elena Spini and Aurel Mrruku agreed to show the integration log's exception and
error messages **directly on the order in the UI**, using a background colour to
highlight the error rather than elaborate formatting. That is the ⚠ Aurel Mrruku
raised at the 07/10 UAT, and it was built the same afternoon — see
[OI-214](../items/OI-214%20The%20Mexal%20order%20send%20requires%20an%20agent%20code%20WooCommerce%20orders%20lack.md).

## Raised in testing

- 🔴 **A tranche with no products could be saved** — Aurel Mrruku reported it as
  a critical case, attributing it to a missing control.
  [OI-220](../items/OI-220%20A%20tranche%20with%20no%20products%20was%20reported%20saveable.md).
- 🔴 **The old un-updated Mexal products were still in the system**, forcing
  another clean-up and re-mapping. Aurel Mrruku expressed strong displeasure;
  Elena Spini carried a clean-up request to Fabrizio Paganelli. Adjacent to
  [OI-217](../items/OI-217%20The%20article%20code%20revision%20needs%20direction%20approval.md).
- 🔴 **The community quote-acceptance test failed** — _"Non è stato possibile
  completare la richiesta"_. Rexhina Hysi and Aurel Mrruku investigated the error
  logs, the guest user's profile and the signature field's state; **the cause was
  not settled in the session**.
- 🔴 **An order showed the Mexal integration as failed with a completely empty
  response body** (Rexhina Hysi's observation). Aurel Mrruku went to the request
  body and undertook to report by end of day. The new order-creation flow **had
  not been tested** before the session.
- **The due-date and payment-state logic** for `da pagare` (blank or unpaid) was
  worked through for the flows. ⚠ Nothing in the session qualified the paid test
  by due date, so
  [OI-212](../items/OI-212%20A%20Ri.Ba.%20rate%20reads%20as%20paid%20before%20its%20due%20date.md)
  was not addressed.
- **WooCommerce payment-condition mapping** was reviewed (bonifico `12`, rimessa
  diretta) with integration changes needed to track the fields of orders created
  from that platform —
  [OI-204](../items/OI-204%20WooCommerce%20payment%20codes%20need%20a%20mapping%20table%20to%20Mexal.md),
  built the same day.

## Quote surfaces

Elena Spini and Aurel Mrruku reviewed the quote and community fields and
**confirmed the presence of unit of measure, quantity, list price, amount, total
discount, due date and payment method** — the list
[OI-207](../items/OI-207%20The%20quote%20and%20order%20layouts%20omit%20the%20commercial%20fields%20the%20client%20requires.md)
was opened for. ⚠ This is a review in a ROMI-internal session, not the client
verification OI-207 asks for, and the logo was not mentioned.

Also settled or noted:

- **The quote e-mail template is split** — a dynamic opening personalised with
  the quote codes, a static tail carrying the interaction buttons, so text is not
  duplicated.
- **Mobile optimisation for quote acceptance matters** because _"80% of people
  open the emails from mobile devices"_ — raised, no owner, no date.
- **Any edit to a quote-relevant field must regenerate the PDF** —
  [OI-221](../items/OI-221%20The%20quote%20PDF%20does%20not%20regenerate%20when%20the%20quote%20changes.md).

## Of record

- 🟢 **Aurel Mrruku states the development team has completed 95% of the core
  flows**, renewal-without-signature and the QR ticket update included, with
  operational tests the same day. ⚠ A self-assessment stated in an internal
  session, recorded as such.
- 🟢 **Rexhina Hysi added the missing permissions** to the administration user
  during the session. Aurel Mrruku had found full permissions, data-signature and
  integration-management rights absent, although Elena Spini and Rexhina Hysi
  believed the Partial-sandbox authorisations had been replicated correctly.
- ⚠ **Proton Mail is being adopted for credentials and access keys**, with
  per-person keys or passwords for the access shared with Elisa Migliano over the
  weekend. Recorded as a practice; no value is recorded anywhere.
- 🔑 **Post-release support needs an estimate.** Aurel Mrruku argued significant
  support will be needed after go-live because people forget instructions;
  Elena Spini agreed that clients do not read the documentation supplied.
  **Elena Spini owns a weekly-or-monthly support estimate.** Commercial, not a
  requirement, and new to the record.
- **A universal integration user driven by the integration logs** is Aurel
  Mrruku's preferred way to own the responses from external applications; the
  group owes a verification of which user currently receives them.
- **Tranches are created directly on the order**, confirmed to Rexhina Hysi.

## Next steps as recorded

| Owner | Step |
| ----- | ---- |
| Elena Spini | Update the Opportunity fields, new ones in a distinct colour |
| Elena Spini | Prepare the post-launch support estimate, weekly or monthly options |
| Aurel Mrruku | Deactivate the unnecessary products from the supplied code list |
| Aurel Mrruku | Reassign products to the correct campaigns and editions |
| Aurel Mrruku | Carry the IVA code and rate from the product to the order line |
| Aurel Mrruku | Report on the integration flow by end of day |
| Rexhina Hysi | Configure full permissions for the UAT administration user |
| Rexhina Hysi | Show integration exceptions on the order in the UI |
| Rexhina Hysi | Auto-refresh the quote when relevant fields change |
| The group | Verify which user receives the external applications' responses |
