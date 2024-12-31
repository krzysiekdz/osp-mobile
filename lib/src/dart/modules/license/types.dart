part of 'index.dart';

class License extends TBase with TType, TBase2, TStatus {
  const License(super._d);

  String get expirationDate => d?['data_waznosci'] ?? '';
  String get code => d?['kod'] ?? '';
}
