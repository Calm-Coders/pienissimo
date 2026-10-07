---
id: ticket-qr-lookup-endpoint-usage
type: reference
status: active
updated: 2026-10-07
source: force-app/main/default/classes/TicketQrLookupService.cls
---

# Ticket QR lookup endpoint usage

`TicketQrLookupService` resolves a ticket QR payload into Contact, Campaign and
Asset data. The QR payload is the `CampaignMember.Id`.

## Preferred request

Use `POST` when sending the QR value in the request body.

```http
POST /services/apexrest/ticket-qr
Authorization: Bearer <access_token>
Content-Type: application/json
```

```json
{
  "qrId": "00vMA000007IqnJYAS"
}
```

If this request is sent as `GET`, Salesforce calls the `@HttpGet` method and
the body is ignored. That produces `INVALID_QR_ID` unless the id is also present
in the URL.

## GET fallbacks

Path style:

```http
GET /services/apexrest/ticket-qr/00vMA000007IqnJYAS
Authorization: Bearer <access_token>
```

Query-string style:

```http
GET /services/apexrest/ticket-qr?qrId=00vMA000007IqnJYAS
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
  "message": null,
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
    "status": "Assegnato",
    "productName": "Ticket Mastery"
  }
}
```

## Common errors

`INVALID_QR_ID` means the service did not receive a valid Campaign Member Id.
The most common cause is sending a JSON body while the Postman method is still
`GET`.

`CAMPAIGN_MEMBER_NOT_FOUND` means the id has the right Salesforce shape, but no
Campaign Member with that id exists in the org.

`TICKET_ASSET_NOT_FOUND` means the Campaign Member exists, but no matching Asset
was found through `Asset.QR_Id__c` or through the Contact + Campaign fallback.

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
