---
id: ticket-qr-code-generation
type: reference
status: active
updated: 2026-10-07
source: requirements/pienissimo-requirements.yaml
---

# Ticket QR code generation

This note explains the server-side QR generation used for ticket Assets.
The implementation is entirely Apex: the QR payload is generated when a
`CampaignMember` is inserted, converted into a QR matrix, rendered as a BMP
image, and attached to the matching `Asset` as a Salesforce File. New QR codes
encode the matching `Asset.Id`.

## Source rule

The requirement record says the QR carries the **campaign member ID**, not the
Campaign ID. The relevant entries are:

- `requirements/pienissimo-requirements.yaml`, constant `ASSET_vs_QR`: the
  Asset is the record; the QR is a value inside it and carries the campaign
  member ID.
- `requirements/pienissimo-requirements.yaml`, requirement text around BIG-20:
  "The QR code contains the campaign member ID".
- [The newest design diagram](The%20newest%20design%20diagram.md) records the
  same design detail: the QR code contains the campaign member id.
- [OI-78 Participant data collection](items/OI-78%20Participant%20data%20collection.md)
  and [OI-84 Campaign Member handling for manual check-in](items/OI-84%20Campaign%20Member%20handling%20for%20manual%20check-in.md)
  both state that the QR carries the campaign member id.

The implementation changed on 2026-10-07 by direct user instruction: the QR now
encodes `Asset.Id`, which still identifies one individual ticket. This differs
from the `BIG-20` `to_confirm` wording that says Campaign Member Id; the
requirement register was not silently rewritten.

## Runtime flow

```text
CampaignMember after insert
        |
        v
CampaignMemberQrTrigger
        |
        v
AssetQrService.syncCampaignMembers(...)
        |
        +-- finds matching Asset by ContactId + Campaign__c
        +-- creates ContentVersion with TicketQrImage.generate(...)
        +-- publishes Participant_Document_Request__e per Asset
```

The document PDF that follows is rendered by an internal user, not the site
guest user: see
[Participant document PDFs are rendered by an internal user](flows/Participant%20document%20PDFs%20are%20rendered%20by%20an%20internal%20user.md).

The files involved are:

- `force-app/main/default/triggers/CampaignMemberQrTrigger.trigger`
- `force-app/main/default/classes/AssetQrService.cls`
- `force-app/main/default/classes/TicketQrImage.cls`
- `force-app/main/default/classes/BarcodeGenerator.cls`
- `force-app/main/default/objects/Asset/fields/Campaign__c.field-meta.xml`

The QR payload is the matching `Asset.Id`. No duplicate QR identifier field is
stored on the Asset.

## Asset matching

`AssetQrService.syncCampaignMembers` receives the newly inserted campaign
members. For each member with both `ContactId` and `CampaignId`, it builds a key:

```apex
String.valueOf(campaignMember.ContactId) + ':' + String.valueOf(campaignMember.CampaignId)
```

It queries Assets where:

```soql
ContactId IN :contactIds
AND Campaign__c IN :campaignIds
```

For every matching Asset, it compares:

```apex
Asset.ContactId + ':' + Asset.Campaign__c
```

to the Campaign Member key. When they match, the service:

1. Generates a BMP QR image using `TicketQrImage.generate`.
2. Inserts a `ContentVersion` attached to the Asset through
   `FirstPublishLocationId`.

The inserted file is named like:

```text
Ticket-QR-<AssetId>.bmp
```

## What `BarcodeGenerator.getPattern(payload, 'qr')` does

`TicketQrImage.generate` calls:

```apex
String pattern = BarcodeGenerator.getPattern(payload, 'qr');
```

This does not return an image. It returns the logical QR matrix as text.

The returned string is made of rows separated by newline characters:

```text
111111100101...
100000100010...
101110101111...
```

Each character means:

```text
1 = black QR module
0 = white QR module
```

`TicketQrImage` later converts those modules into actual BMP pixels.

## QR matrix generation

`BarcodeGenerator.getPattern(value, 'qr')` routes to the private
`buildQrPattern(value)` method.

The implementation supports:

```text
QR versions: 1 through 14
Error correction: M
Encoding mode: Byte mode
Mask: pattern 0
```

The generation process is:

1. Convert the payload string to byte values.

   The payload is normally a Salesforce Id, so every character is ASCII. If a
   character is above byte range, the code replaces it with `?`.

2. Select the smallest QR version that fits the data.

   QR grid size is:

   ```apex
   Integer size = 4 * version + 17;
   ```

   Version 1 is 21x21 modules, version 2 is 25x25 modules, and so on.

3. Build the QR data bit stream.

   The code appends:

   - the byte-mode indicator, `0100`
   - the payload length
   - the payload bytes
   - terminator bits
   - zero padding to reach a byte boundary
   - alternating QR pad bytes `236` and `17`

4. Convert every 8 bits into data codewords.

   A codeword is one byte of QR data.

5. Split the codewords into the block structure for the chosen QR version.

   The block structure comes from `QR_EC_BLOCKS`.

6. Generate Reed-Solomon error correction codewords.

   `generateReedSolomon` builds the QR error-correction bytes over GF(256).
   This lets scanners recover the payload if the printed or displayed QR is
   imperfect.

7. Interleave data codewords and error-correction codewords.

   QR codes store codewords in an interleaved order. The implementation first
   interleaves the data blocks, then interleaves the error-correction blocks.

8. Create the QR matrix.

   The code creates:

   ```apex
   List<List<Integer>> matrix
   List<List<Boolean>> reserved
   ```

   `matrix` stores black or white module values. `reserved` marks modules that
   belong to QR structure and cannot be overwritten by payload bits.

9. Place the fixed QR structures.

   The code places:

   - finder patterns in three corners
   - timing patterns
   - reserved format-information areas
   - the dark module
   - alignment patterns for version 2 and above

10. Place payload bits into free modules.

    The payload bits are written from the bottom-right of the matrix in the
    standard QR zig-zag path, skipping reserved cells.

11. Apply mask pattern 0.

    For every non-reserved module where `(row + col) % 2 == 0`, the bit is
    flipped. Masking avoids visual patterns that can make QR codes harder to
    scan.

12. Write format bits.

    The implementation writes precomputed format bits for error correction
    level M and mask pattern 0:

    ```text
    101010000010010
    ```

13. Serialize the matrix.

    The final matrix is returned as a newline-separated string of `0` and `1`
    characters.

## BMP rendering

`TicketQrImage.generate` turns the logical QR matrix into a BMP `Blob`.

The important rendering constants are:

```apex
Integer scale = 8;
Integer quietModules = 4;
```

That means each QR module becomes an 8x8 pixel square, and the image gets a
4-module white quiet zone on every side. The quiet zone is required so scanners
can distinguish the QR code from surrounding content.

The BMP is a 1-bit image:

- `BM` file signature
- DIB header
- 1 bit per pixel
- two-color palette: white and black
- packed pixel rows

The pixel loop maps every output pixel back to a QR module:

```text
pixel coordinate -> module coordinate -> pattern row/column -> black or white
```

If the module value is `1`, the output bit is black. Otherwise, it remains
white. Pixels in the quiet zone are always white.

The byte list is converted to a hex string and then to a Salesforce `Blob`:

```apex
EncodingUtil.convertFromHex(String.join(hexBytes, ''))
```

That `Blob` becomes the `ContentVersion.VersionData`.

## Result in Salesforce

For every matched Asset, the service creates a file:

```apex
new ContentVersion(
  Title = 'Ticket QR - ' + String.valueOf(assetRecord.Id),
  PathOnClient = 'Ticket-QR-' + String.valueOf(assetRecord.Id) + '.bmp',
  VersionData = TicketQrImage.generate(String.valueOf(assetRecord.Id)),
  FirstPublishLocationId = assetRecord.Id
)
```

The Asset therefore has a Salesforce File containing a QR image of its own Id.
The participant PDF and Asset quick action also generate their QR directly from
`Asset.Id`.

## Lookup endpoint

The repository now includes `TicketQrLookupService`, an Apex REST endpoint for
scanner/check-in clients that need to resolve the QR payload before taking any
event action.

Preferred endpoint:

```text
POST /services/apexrest/ticket-qr
Content-Type: application/json

{
  "qrId": "{AssetId}"
}
```

GET path fallback:

```text
GET /services/apexrest/ticket-qr/{AssetId}
```

Query-parameter fallback:

```text
GET /services/apexrest/ticket-qr?qrId={AssetId}
```

The service validates that the supplied value is an Asset Id, then returns a
stable JSON response containing:

- the Contact name, email, phone and account name
- the Campaign/event name, event date, start time and place
- the matching Asset name, status and product name

The response intentionally does not echo Salesforce record ids, including the
QR payload id.

QR images containing the previous `CampaignMember.Id` payload are not accepted.
They must be regenerated with the Asset payload.

`GET` is read-only. `POST` performs check-in: an `Assegnato` Asset becomes
`Utilizzato` and receives `Data_CheckIn__c`. A repeated scan of an already
`Utilizzato` ticket succeeds without replacing the original timestamp. Other
states return `INVALID_ASSET_STATUS` with HTTP 409.

Every lookup writes an `Integration_Log__c` row with:

- `Flow_Name__c = TicketQrLookupService.lookup`
- `Inbound_Outbound__c = Inbound`
- the REST resource path in `Request_Endpoint__c`
- request headers in `Request_Headers__c`, with `Authorization` redacted
- the serialized response in `Response_Body__c`
- the HTTP status in `Response_State__c`
- `Is_Error__c = true` for invalid ids, missing Assets, or unexpected exceptions

Unexpected exceptions are converted to `UNEXPECTED_ERROR` responses and log the
exception message and stack trace.

## Current boundaries

This implementation generates, stores and resolves ticket QR codes and performs
the Fase 1 Asset check-in update. Campaign date validation and the Fase 2
multi-entry speaking-error rules remain outside this change. The redundant
`Asset.QR_Id__c` field was removed from source and Pienissimo UAT on 2026-10-07.
UAT deployment `0AfMA00000CrxUT0AZ` succeeded, and a Tooling API query verified
that the field is absent. Production is untouched.
