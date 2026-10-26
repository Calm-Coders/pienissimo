public class TicketQrImage {
  // Salesforce Files can store and preview BMP images. The QR includes a
  // four-module white border so a scanner can detect it reliably.
  public static Blob generate(String payload) {
    String pattern = BarcodeGenerator.getPattern(payload, 'qr');
    if (String.isBlank(pattern)) {
      throw new QrImageException('Cannot encode the Campaign Member ID.');
    }

    List<String> rows = pattern.split('\n');
    Integer scale = 8;
    Integer quietModules = 4;
    Integer width = (rows.size() + quietModules * 2) * scale;
    Integer height = width;
    Integer rowBytes = ((width + 31) / 32) * 4;
    Integer pixelBytes = rowBytes * height;
    Integer headerBytes = 62;
    List<Integer> bytes = new List<Integer>();

    bytes.add(66);
    bytes.add(77);
    append32(bytes, headerBytes + pixelBytes);
    append16(bytes, 0);
    append16(bytes, 0);
    append32(bytes, headerBytes);
    append32(bytes, 40);
    append32(bytes, width);
    append32(bytes, height);
    append16(bytes, 1);
    append16(bytes, 1);
    append32(bytes, 0);
    append32(bytes, pixelBytes);
    append32(bytes, 2835);
    append32(bytes, 2835);
    append32(bytes, 2);
    append32(bytes, 0);
    // Palette: white background, black QR modules.
    bytes.addAll(new List<Integer>{ 255, 255, 255, 0, 0, 0, 0, 0 });

    for (Integer y = height - 1; y >= 0; y--) {
      Integer moduleY = y / scale - quietModules;
      for (Integer xByte = 0; xByte < rowBytes; xByte++) {
        Integer packed = 0;
        for (Integer bit = 0; bit < 8; bit++) {
          Integer moduleX = (xByte * 8 + bit) / scale - quietModules;
          if (
            moduleY >= 0 &&
            moduleY < rows.size() &&
            moduleX >= 0 &&
            moduleX < rows.size() &&
            rows[moduleY].charAt(moduleX) == 49
          ) {
            packed += 128 / (Integer) Math.pow(2, bit);
          }
        }
        bytes.add(packed);
      }
    }

    String hexDigits = '0123456789abcdef';
    List<String> hexBytes = new List<String>();
    for (Integer value : bytes) {
      hexBytes.add(
        hexDigits.substring(value / 16, value / 16 + 1) +
        hexDigits.substring(Math.mod(value, 16), Math.mod(value, 16) + 1)
      );
    }
    return EncodingUtil.convertFromHex(String.join(hexBytes, ''));
  }

  private static void append16(List<Integer> bytes, Integer value) {
    bytes.add(Math.mod(value, 256));
    bytes.add(Math.mod(value / 256, 256));
  }

  private static void append32(List<Integer> bytes, Integer value) {
    append16(bytes, value);
    append16(bytes, value / 65536);
  }

  public class QrImageException extends Exception {
  }
}
