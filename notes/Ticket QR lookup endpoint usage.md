---
id: ticket-qr-lookup-endpoint-usage
type: reference
status: active
updated: 2026-10-07
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

## Logging

Every request creates an `Integration_Log__c` row. The service stores endpoint,
headers with `Authorization` redacted, request body, response status, response
body and error details when applicable.
