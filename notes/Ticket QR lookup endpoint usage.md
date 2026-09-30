---
id: ticket-qr-lookup-endpoint-usage
type: reference
status: active
updated: 2026-09-28
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
