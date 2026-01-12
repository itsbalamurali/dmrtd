// Created by Nejc Skerjanc, copyright © 2023 ZeroPass. All rights reserved.


import 'dart:typed_data';
import 'package:dmrtd/extensions.dart';
import 'package:dmrtd/src/lds/asn1_object_identifiers.dart';
import 'package:logging/logging.dart';
import 'ssc.dart';
import 'iso7816/smcipher.dart';
import '../crypto/aes.dart';

class AesSmCipher implements SMCipher {
  static final _log = Logger("AesSmCipher");
  @override
  CipherAlgorithm type = CipherAlgorithm.aes;

  Uint8List ksEnc;
  Uint8List ksMac;
  AESCipher cipher;

  AesSmCipher(this.ksEnc, this.ksMac, {required KeyLength size}):
        cipher = AESCipher(size: size);

  @override
  CipherAlgorithm get cipherAlgorithm => type;

  @override
  Uint8List encrypt(Uint8List data, {SSC? ssc}) {
    _log.debug ("encrypt: data size: ${data.length}, ssc: ${ssc?.toBytes().hex()}");
    _log.sdVerbose("encrypt: data: ${data.hex()}, ksEnc: ${ksEnc.hex()}");
    if (ssc == null) {
      throw Exception("PACE_SMCipher_AES.encrypt: SSC should not be null");
    }

    //IV = E(ksEnc, SCC)
    _log.sdDebug("Encrypting IV with ksEnc: ${ksEnc.hex()}, ssc: ${ssc.toBytes().hex()}");
    Uint8List iv = cipher.encrypt(data: ssc.toBytes(), key: ksEnc, mode: BlockCipherMode.ecb);

    _log.sdVerbose("Encrypted IV: ${iv.hex()}");

    _log.sdDebug("Encrypting data with ksEnc: ${ksEnc.hex()}, iv: ${iv.hex()}");
    Uint8List encrypted = cipher.encrypt(data: data, key: ksEnc,  iv: iv);

    _log.sdVerbose("Encrypted data: ${encrypted.hex()}");
    return encrypted;
  }

  @override
  Uint8List decrypt(Uint8List data, {SSC? ssc}) {
    _log.debug ("decrypt: data size: ${data.length}, ssc: ${ssc?.toBytes().hex()}");
    _log.sdVerbose("decrypt: data: $data, ksEnc: ${ksEnc.hex()}");
    if (ssc == null) {
      throw Exception("PACE_SMCipher_AES.decrypt: SSC should not be null");
    }

    //IV = E(ksEnc, SCC)
    Uint8List iv = cipher.encrypt(data: ssc.toBytes(), key: ksEnc, mode: BlockCipherMode.ecb);
    _log.sdVerbose("IV: ${iv.hex()}");
    Uint8List decrypted =  cipher.decrypt(data: data, key: ksEnc, iv: iv);
    _log.sdVerbose("Decrypted data: ${decrypted.hex()}");
    return decrypted;
  }

  @override
  Uint8List mac(Uint8List data) {
    _log.debug ("mac: data size: ${data.length}");
    _log.sdVerbose("mac: data: ${data.hex()}, ksMac: ${ksMac.hex()}");
    Uint8List cmac =  cipher.calculateCMAC(data: data, key: ksMac);
    _log.sdVerbose("CMAC: ${cmac.hex()}");
    return cmac;
  }
}