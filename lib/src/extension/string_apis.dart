// Created by Crt Vavros, copyright © 2022 ZeroPass. All rights reserved.
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';
import 'package:convert/convert.dart';

extension StringDecodeApis on String {
  Uint8List parseBase64() {
    return base64.decode(this);
  }

  Uint8List parseHex() {
    return hex.decoder.convert(this);
  }
}

extension StringYYMMDDateApi on String {
  DateTime parseDateYYMMDD({bool futureDate = false}) {
    final compact = replaceAll(RegExp(r'[^0-9]'), '');
    if (compact.length < 6) {
      throw const FormatException('Invalid length of compact date string');
    }

    var y = int.parse(compact.substring(0, 2)) + 2000;
    final m = int.parse(compact.substring(2, 4));
    final d = int.parse(compact.substring(4, 6));

    final now = DateTime.now();
    var maxYear = now.year;
    var maxMonth = now.month;

    if (futureDate) {
      final future = DateTime(now.year + 20, now.month + 5);
      maxYear = future.year;
      maxMonth = future.month;
    }

    if (y > maxYear || (y == maxYear && maxMonth < m)) {
      y -= 100;
    }

    return DateTime(y, m, d);
  }

  DateTime parseDate({bool futureDate = false}) {
    final raw = trim();
    if (raw.isEmpty) {
      throw const FormatException('Empty date string');
    }

    final cleaned = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length == 6) {
      return cleaned.parseDateYYMMDD(futureDate: futureDate);
    }

    if (cleaned.length == 8) {
      final year = int.parse(cleaned.substring(0, 4));
      final month = int.parse(cleaned.substring(4, 6));
      final day = int.parse(cleaned.substring(6, 8));
      return DateTime(year, month, day);
    }

    return DateTime.parse(raw);
  }
}