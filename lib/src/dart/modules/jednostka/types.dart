part of 'index.dart';

class Jednostka extends TBase with TAddress, TAddress2, TContact {
  const Jednostka(super._d);

  String get shortName => d?['short_name'] ?? '';
  String get fullName => d?['full_name'] ?? '';
}
