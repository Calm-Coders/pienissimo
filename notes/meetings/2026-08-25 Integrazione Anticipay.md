---
id: MTG-2026-08-25-anticipay
type: meeting
status: resolved
owner: Elena Spini
org: both
raised: 2026-08-25
updated: 2026-08-25
source: Drive - "[ROMI-PIENISSIMO] - Integrazione Anticipay - 2026/08/25 10:00 CEST - Appunti di Gemini", doc 17eH8QPVs5BCRZUJqVLtC-md5KK3Xq7KNJHONDeFrAQY
---

# 2026-08-25 Integrazione Anticipay

**Client-facing session, 25 August 2026, 10:00 CEST.** Gemini notes, transcript
and a recording exist. It is the technical call
[OI-73](../items/OI-73%20VAT%20validation%20moves%20into%20Salesforce.md) has been
waiting for since 6 August, and the second of the post-Ferragosto restart
meetings.

**Present:** Elena Spini, Aurel Mrruku, Andrea Di Cicco (ROMI); **Andrea
Parmeggiani** (`andrea.p@pienissimo.pro`, Pienissimo Software), Fabrizio
Paganelli, Elisa Migliano (`amministrazione@`). Sabatino Rinaldi invited,
optional.

## The decision that changes the design

🔴 **Salesforce will not call Anticipay. It will call an API exposed by
Pienissimo Software, which acts as middleware.**

Andrea Parmeggiani raised it: repeated Anticipay calls cost money, and Pienissimo
already holds the data. He proposed that Salesforce query an API of theirs
instead of Anticipay directly, with Pienissimo storing the results to avoid
duplicate lookups. Aurel Mrruku supported it on a second ground — it insulates
Salesforce from any future change to Anticipay's own endpoints. The group agreed.

Written up as
[OI-94](../items/OI-94%20Anticipay%20is%20called%20through%20the%20Pienissimo%20middleware.md).

## Also agreed

- **Trigger confirmed:** the check fires **automatically at the first order
  inserted for each Account**, i.e. when a quote becomes an order for a new
  account. This is what the design file already drew; the meeting confirmed it
  out loud rather than changing it.
- **Authentication:** a **token placed directly in the HTTP request header**.
  Andrea Parmeggiani described it as deliberately simple.
- **Error protocol:** the middleware returns **specific error codes — `404` for a
  VAT number not found, `500` for generic errors — together with their
  descriptive messages**. Those codes and messages are **passed through to
  Salesforce, stored there for three months**, and used to raise internal
  notifications. Pienissimo's current practice is a message to an internal
  company chat; Aurel Mrruku asked for the same information to reach Salesforce
  so a history exists for verification. The frequent real cases named were
  non-existent VAT numbers and VAT numbers too recent for Anticipay to have
  picked up.
- **Payload is trimmed, not forwarded whole.** Anticipay's full response carries
  far more than is wanted. Only the necessary fields come across — see
  [OI-95](../items/OI-95%20Which%20Anticipay%20fields%20land%20in%20Salesforce.md).
- **The returned value overwrites Salesforce** where the two disagree on the VAT
  number. Aurel Mrruku's ruling, unopposed.
- **A dedicated test environment will be created** for the integration.

## Timing

Andrea Parmeggiani committed to supplying **an example of the API call structure
by the end of the following week** (so on or before **Fri 4 September**). Elena
Spini booked a follow-up regardless — **`[ROMI-PIENISSIMO] - Follow-up
Integrazione Anticipay`, Tuesday 1 September 2026, 10:00–11:00 CEST** — on the
agreement that it can be cancelled if the material arrives by mail first and
raises no questions. Invitation sent 25 Aug 13:17 UTC to Aurel Mrruku,
`amministrazione@`, Andrea Parmeggiani and Fabrizio Paganelli, cc Sabatino
Rinaldi.

## ⚠ One Gemini action item is wrong, and was corrected the same afternoon

The auto-generated next steps assign _"Creare ambiente test: configurare un
ambiente di test dedicato per l'integrazione del middleware"_ to **Aurel
Mrruku**. That is not what was agreed.

Elena Spini put the list to Aurel Mrruku on Slack at **15:03 CEST**. He replied:
_"l ambiente di test nostro esiste già"_ … _"e uat"_ … **_"serve un loro ambiente
di test dove noi dobbiamo puntare"_**. Elena Spini accepted the correction —
_"ok mi torna e mi sembrava di aver capito così, Gemini no bravo infatti"_.

So the action belongs to **Pienissimo Software**: they must stand up a test
environment for ROMI to point at. ROMI's own test environment is the existing
UAT org. The transcript detail agrees — Andrea Parmeggiani said _"verrà creato
appositamente un ambiente di test"_, i.e. by his side.

**The client-facing calendar invitation carries the uncorrected wording.** It was
sent at 13:17 UTC, before the 15:03 correction, and its next-step block still
reads as though the test environment is ROMI's to create. Nobody has re-sent it.

## Other business, recorded but not project design

- **Mexal review prepared.** Fabrizio Paganelli and Elena Spini used the opening
  minutes to set up the next day's Mexal session — anagrafica articoli, and
  **three fields available on Mexal** that Fabrizio Paganelli says he has
  examined personally. That is the 26 August client review.
- **Diagram legibility.** The flow PNGs Elena Spini mailed on 20 August could not
  be read on screen; Elisa Migliano reported Marco Montesi had to print them
  across four sheets. Worth knowing before the next diagram goes out as an image.
- **Calendar invitations were not reaching Elisa Migliano**, because Elena Spini
  invites the `amministrazione@` address rather than her personal one. Resolved
  by keeping the `amministrazione@` convention and letting recipients forward to
  their own calendars. Elena Spini added Elisa Migliano and Fabrizio Paganelli to
  the **WooCommerce** invitation during the call.
- **Payment chasing** (solleciti, incassi) took the last few minutes. Pienissimo
  administration business, no ROMI deliverable.

## Actions

| Owner | Action | Due |
| ----- | ------ | --- |
| Andrea Parmeggiani | Send an example of the middleware API structure, including the `404` / `500` error codes and their messages | end of week commencing 31 Aug |
| Andrea Parmeggiani | Send an example of **all** fields Anticipay returns, so the useful ones can be picked | — |
| Andrea Parmeggiani / Pienissimo Software | Stand up the test environment ROMI points at | before build |
| Fabrizio Paganelli, Elisa Migliano | Decide which of those fields are worth holding in Salesforce | — |
| Elena Spini, Andrea Parmeggiani | Recap phone call the same afternoon, after 14:30 | 25 Aug |
| Fabrizio Paganelli, Elisa Migliano | Download the customer list and send payment reminders | — (Pienissimo-internal) |
