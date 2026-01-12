//  Created by Nejc Skerjanc, copyright © 2023 ZeroPass. All rights reserved.

import 'dart:typed_data';
import '../lds/asn1_object_identifiers.dart';

abstract class AccessKey{
  // described in ICAO 9303 p11 - 4.4.4.1 MSE:Set AT - Reference of a public key / secret key
  abstract int paceRefKeyTag; //MRZ or CAN tag;


  Uint8List kpi(CipherAlgorithm cipherAlgorithm, KeyLength keyLength);

  /// Very sensitive data. Do not use in production!
  @override
  String toString();
}
