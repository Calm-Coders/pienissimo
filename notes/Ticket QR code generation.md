---
id: ticket-qr-code-generation
type: reference
status: active
updated: 2026-09-28
source: requirements/pienissimo-requirements.yaml
---

# Ticket QR code generation

This note explains the server-side QR generation used for ticket Assets.
The implementation is entirely Apex: the QR payload is generated when a
`CampaignMember` is inserted, converted into a QR matrix, rendered as a BMP
image, and attached to the matching `Asset` as a Salesforce File.

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

So the current code is aligned on payload identity when it encodes
`CampaignMember.Id`. A QR that encoded only `Campaign.Id` would identify the
event/edition, not the individual participant.

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
        +-- writes Asset.QR_Id__c = CampaignMember.Id
        +-- creates ContentVersion with TicketQrImage.generate(...)
```

The files involved are:

- `force-app/main/default/triggers/CampaignMemberQrTrigger.trigger`
- `force-app/main/default/classes/AssetQrService.cls`
- `force-app/main/default/classes/TicketQrImage.cls`
- `force-app/main/default/classes/BarcodeGenerator.cls`
- `force-app/main/default/objects/Asset/fields/QR_Id__c.field-meta.xml`
- `force-app/main/default/objects/Asset/fields/Campaign__c.field-meta.xml`

The QR payload is the `CampaignMember.Id`. That value is also copied into
`Asset.QR_Id__c`, so the Asset stores the same participant identifier that the
QR image encodes.

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

1. Updates `Asset.QR_Id__c` to the `CampaignMember.Id`.
2. Generates a BMP QR image using `TicketQrImage.generate`.
3. Inserts a `ContentVersion` attached to the Asset through
   `FirstPublishLocationId`.

The inserted file is named like:

```text
Ticket-QR-<CampaignMemberId>.bmp
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
  Title = 'Ticket QR - ' + String.valueOf(memberId),
  PathOnClient = 'Ticket-QR-' + String.valueOf(memberId) + '.bmp',
  VersionData = TicketQrImage.generate(String.valueOf(memberId)),
  FirstPublishLocationId = assetRecord.Id
)
```

The Asset therefore has:

- `QR_Id__c`: the Campaign Member Id as text
- a Salesforce File: the QR image containing the same Campaign Member Id

## Current boundaries

This implementation generates and stores ticket QR codes. It does not implement
an inbound scan endpoint, and no current Apex path writes `Asset.Data_CheckIn__c`
from a QR scan.
