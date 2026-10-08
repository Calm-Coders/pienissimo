---
id: ticket-qr-lookup-endpoint-usage
type: reference
status: active
updated: 2026-10-08
source: force-app/main/default/classes/TicketQrLookupService.cls
---

# Ticket QR lookup endpoint usage

`TicketQrLookupService` resolves an `Asset.Id` QR payload into Asset, Contact
and Campaign data. Campaign Member identifiers are not accepted.

## Authentication in a Salesforce sandbox

Exchange a freshly signed JWT assertion for an access token. Send the fields as
`application/x-www-form-urlencoded`, not as JSON.

```http
POST https://test.salesforce.com/services/oauth2/token
Content-Type: application/x-www-form-urlencoded

grant_type=urn%3Aietf%3Aparams%3Aoauth%3Agrant-type%3Ajwt-bearer&assertion=<SIGNED_JWT_ASSERTION>
```

Equivalent cURL request:

```bash
curl --request POST \
  --url https://test.salesforce.com/services/oauth2/token \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer" \
  --data-urlencode "assertion=<SIGNED_JWT_ASSERTION>"
```

The token response supplies `access_token` and `instance_url`. Use that
`instance_url` for the Apex REST request rather than hard-coding an org host.
Never save the signed assertion or access token in this repository.

## Check-in request

Use `POST` to return the ticket information and check in the Asset.

```http
POST /services/apexrest/ticket-qr
Authorization: Bearer <access_token>
Content-Type: application/json
```

```json
{
  "qrId": "02iMA00000A624fYAB"
}
```

On the first valid check-in, the service changes `Asset.Status` from
`Assegnato` to `Utilizzato` and writes `Asset.Data_CheckIn__c`. A repeated scan
returns success without replacing the original check-in timestamp.

Complete cURL request after obtaining the token:

```bash
curl --request POST \
  --url "<INSTANCE_URL>/services/apexrest/ticket-qr" \
  --header "Authorization: Bearer <ACCESS_TOKEN>" \
  --header "Content-Type: application/json" \
  --data '{"qrId":"02iMA00000A624fYAB"}'
```

## Read-only GET lookup

`GET` returns the same information without changing the Asset.

Path style:

```http
GET /services/apexrest/ticket-qr/02iMA0000012345YAA
Authorization: Bearer <access_token>
```

Query-string style:

```http
GET /services/apexrest/ticket-qr?qrId=02iMA0000012345YAA
Authorization: Bearer <access_token>
```

Do not add an extra slash after `apexrest`; use:

```text
/services/apexrest/ticket-qr
```

not:

```text
/services/apexrest//ticket-qr
```

## Success response shape

The response intentionally does not echo Salesforce record ids.

```json
{
  "success": true,
  "message": "Ticket checked in successfully.",
  "errorCode": null,
  "contact": {
    "name": "Mario Rossi",
    "email": "mario.rossi@example.com",
    "phone": "+390612345678",
    "accountName": "Rossi Srl"
  },
  "campaign": {
    "name": "Sold Out 2027 Edizione",
    "eventDate": "2027-01-15",
    "startTime": "09:30:00.000Z",
    "place": "Milano",
    "startDate": "2027-01-15",
    "endDate": "2027-01-15"
  },
  "asset": {
    "name": "Ticket-0001",
    "status": "Utilizzato",
    "productName": "Ticket Mastery",
    "checkInDate": "2026-10-07T10:30:00.000Z"
  }
}
```

## Verified UAT example - 2026-10-07

The user reported a successful sandbox `POST` for Asset
`02iMA00000A624fYAB`. Personal contact data is redacted here by repository
policy.

```json
{
  "success": true,
  "message": "Ticket checked in successfully.",
  "errorCode": null,
  "contact": {
    "phone": "<redacted>",
    "name": "<redacted>",
    "email": "<redacted>",
    "accountName": "<redacted>"
  },
  "campaign": {
    "startTime": "09:00:00.000Z",
    "startDate": null,
    "place": null,
    "name": "Test Edizione Accademy 2026",
    "eventDate": "2026-09-16",
    "endDate": null
  },
  "asset": {
    "status": "Utilizzato",
    "productName": "ACADEMY",
    "name": "ACADEMY #2",
    "checkInDate": "2026-10-07T08:54:56.140Z"
  }
}
```

## Common errors

`INVALID_QR_ID` means the service did not receive a valid Asset Id. A JSON body
is read only by `POST`; put the value in the URL for `GET`.

`TICKET_ASSET_NOT_FOUND` means no matching Asset was found.

`INVALID_ASSET_STATUS` means a `POST` tried to check in an Asset whose status is
neither `Assegnato` nor the already-completed `Utilizzato`. The response still
includes the resolved Asset, Contact and Campaign information.

## Italian response messages - source update 2026-10-08

All user-facing `message` values are now Italian in source. The stable
`errorCode` values and HTTP status codes are unchanged. The successful UAT
response above is retained as evidence of the response returned before this
source change. This update is not yet deployed.

## Logging

Every request creates an `Integration_Log__c` row. The service stores endpoint,
headers with `Authorization` redacted, request body, response status, response
body and error details when applicable.

## Update 2026-10-07 — the delivered UAT contract, and the QR payload changed

Rexhina Hysi sent Aurel Mrruku the authentication and API details for the UAT /
Partial Sandbox environment on **2026-10-07 at 12:35:28Z** (subject
_"Pienissimo – UAT QR Code Ticket API"_).

🔑 **The QR payload is now the Salesforce Asset id, not the `CampaignMember.Id`
this note described above.** The delivered contract states: _"The QR contains the
Salesforce Asset ID."_ The error set changes with it — `INVALID_QR_ID`,
`TICKET_ASSET_NOT_FOUND`, `UNEXPECTED_ERROR` — and
**`CAMPAIGN_MEMBER_NOT_FOUND` is gone.** The sections above this update describe
the superseded CampaignMember contract and are kept for the record.

### Check-in behaviour as delivered

`POST <INSTANCE_URL>/services/apexrest/ticket-qr` with a bearer token and a JSON
body carrying `qrId`. When the Asset is in status `Assegnato` the endpoint:

- changes the status to `Utilizzato`,
- sets `Data_CheckIn__c`,
- returns the related Asset, Contact, Campaign and Product information.

**Repeated scans are accepted and do not replace the original check-in
timestamp.**

### Access a dedicated integration user needs

The user used for validation reached `TicketQrLookupService` through the System
Administrator profile — that is the validation path, not the intended one. The
stated requirement for a dedicated integration user is:

- Apex class access to `TicketQrLookupService`
- read on `Asset`, `Contact`, `Campaign`, `Product`
- edit on `Asset.Status` and `Asset.Data_CheckIn__c`
- create on `Integration_Log__c`

### Authentication

JWT bearer flow (`urn:ietf:params:oauth:grant-type:jwt-bearer`) against the
sandbox token endpoint, `application/x-www-form-urlencoded`.

⚠ **The mail body contains a live signed JWT assertion and the integration
username.** Neither is reproduced here, by rule. That the credential was
circulated by mail on 2026-10-07 is recorded so it can be rotated and moved into
configuration; the values stay in the mailbox.

### Build state

The matching code change is **Rexhina Hysi's `b08c9a8`** (07/10 14:36,
_"fix endpoint to update asset to utilizato"_) — it rewrites
`TicketQrLookupService.cls` and `AssetQrService.cls`, **deletes
`Asset.QR_Id__c`**, and updates this note and two others on its own branch.
⚠ **It is on `Devmain_EndpointWorktoUpdateAsset` and not in `DevMain`**, so the
contract above is delivered by mail and demonstrated, but the merged branch still
carries the CampaignMember shape. The two will agree when the branch merges.

⚠ The 5-day check-in window recorded on 06/10 — QR check-in writes `utilizzato`
within 5 days of the event date — is **not** mentioned in the delivered contract.
Unreconciled.
