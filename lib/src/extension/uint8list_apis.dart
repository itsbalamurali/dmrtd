// Created by Crt Vavros, copyright © 2022 ZeroPass. All rights reserved.
import 'dart:convert';
import 'dart:typed_data';
import 'package:convert/convert.dart' as conv;

extension Uint8ListEncodeApis on Uint8List {
  String base64() {
    return Base64Codec().encode(this);
  }

  String hex() {
    return conv.hex.encoder.convert(this);
  }
}

extension Uint8ListDecodeApis on Uint8List {
  DateTime toDate() {
    if (length < 4) {
      throw const FormatException('Invalid length for date conversion, expected 4 bytes.');
    }

    int bcdToInt(int byte) => ((byte >> 4) * 10) + (byte & 0x0F);

    // The date is in the format 'CCYYMMDD'
    final year = bcdToInt(this[0]) * 100 + bcdToInt(this[1]);
    final month = bcdToInt(this[2]);
    final day = bcdToInt(this[3]);

    return DateTime(year, month, day);
  }
}