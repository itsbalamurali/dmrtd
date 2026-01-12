// Created by Crt Vavros, copyright © 2022 ZeroPass. All rights reserved.
import 'dart:typed_data';
import 'package:dmrtd/src/lds/asn1_object_identifiers.dart';

import '../ssc.dart';

abstract class SMCipher {
  late CipherAlgorithm type;

  /// Returns cipher algorithm.
  CipherAlgorithm get cipherAlgorithm => type;

  /// Encrypts [data] to be used in Secure Messaging.
  /// [data] must be padded (if needed) before calling this function.
  /// [ssc] is used as IV for encryption.
  Uint8List encrypt(final Uint8List data, {SSC? ssc});

  /// Decrypts [edata] from Secure Messaging.
  /// [edata] must be unpadded after calling this function.
  /// [ssc] is used as IV for encryption.
  Uint8List decrypt(final Uint8List edata, {SSC? ssc});

  /// Calculates MAC of [data].
  /// [data] must be padded (if needed) before calling this function.
  Uint8List mac(final Uint8List data);
}