part of 'index.dart';

class License extends TBase with TType, TBase2, TStatus {
  const License(super._d);

  String get dataWaznosci => d?['data_waznosci'] ?? '';
  String get kod => d?['kod'] ?? '';
}
