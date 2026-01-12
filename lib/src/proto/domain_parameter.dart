//  Created by Nejc Skerjanc, copyright © 2023 ZeroPass. All rights reserved.

enum DomainParameterType {
  none,
  gfp,
  ecp,
}

class DomainParameter{
  final int _id;
  final String _name;
  final int _size;
  final DomainParameterType _type;
  final bool _isSupported; //is supported by this library (is in pointycastle)

  DomainParameter({required int id,
    required String name,
    required int size,
    required DomainParameterType type,
    required bool isSupported}):
        _id = id,
        _name = name,
        _size = size,
        _type = type,
        _isSupported = isSupported;

  int get id => _id;

  @override
  String toString() => "DomainParameter(id: $_id, name: $_name, size: $_size, type: $_type, isSupported: $_isSupported)";

  String get name => _name;

  int get size => _size;

  DomainParameterType get type => _type;

  bool get isSupported => _isSupported;

  @override
  bool operator == (Object other) {
    if (other is! DomainParameter) {
      return false;
    }
    return _id == other.id;
  }

  @override
  int get hashCode => _id.hashCode;
}
// Specified in section 9.5.1 of ICAO 9303 p11
Map<int, DomainParameter> icaoDomainParameters = {
  0   : DomainParameter(id: 0,   name: "1024-bit MODP Group with 160-bit Prime Order Subgroup",   size: 1024, type: DomainParameterType.gfp, isSupported: false ),
  1   : DomainParameter(id: 1,   name: "2048-bit MODP Group with 224-bit Prime Order Subgroup",   size: 2048, type: DomainParameterType.gfp, isSupported: false ),
  2   : DomainParameter(id: 2,   name: "2048-bit MODP Group with 256-bit Prime Order Subgroup",   size: 2048, type: DomainParameterType.gfp, isSupported: false ),
  8   : DomainParameter(id: 8,   name: "NIST P-192 (secp192r1)",                                  size: 192,  type: DomainParameterType.ecp, isSupported: false ),
  9   : DomainParameter(id: 9,   name: "BrainpoolP192r1",                                         size: 192,  type: DomainParameterType.ecp, isSupported: false ),
  10  : DomainParameter(id: 10,  name: "NIST P-224 (secp224r1)",                                  size: 224,  type: DomainParameterType.ecp, isSupported: false ),
  11  : DomainParameter(id: 11,  name: "BrainpoolP224r1",                                         size: 224,  type: DomainParameterType.ecp, isSupported: false ),
  12  : DomainParameter(id: 12,  name: "NIST P-256 (secp256r1)",                                  size: 256,  type: DomainParameterType.ecp, isSupported: true  ),
  13  : DomainParameter(id: 13,  name: "BrainpoolP256r1",                                         size: 256,  type: DomainParameterType.ecp, isSupported: false ),
  14  : DomainParameter(id: 14,  name: "BrainpoolP320r1",                                         size: 320,  type: DomainParameterType.ecp, isSupported: false ),
  15  : DomainParameter(id: 15,  name: "NIST P-384 (secp384r1)",                                  size: 384,  type: DomainParameterType.ecp, isSupported: false ),
  16  : DomainParameter(id: 16,  name: "BrainpoolP384r1",                                         size: 384,  type: DomainParameterType.ecp, isSupported: false ),
  17  : DomainParameter(id: 17,  name: "BrainpoolP512r1",                                         size: 512,  type: DomainParameterType.ecp, isSupported: false ),
  18  : DomainParameter(id: 18,  name: "NIST P-521 (secp521r1)",                                  size: 521,  type: DomainParameterType.ecp, isSupported: false )
};