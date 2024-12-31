part of 'index.dart';

class FireDepartment extends TBase with TAddress, TAddress2, TContact {
  const FireDepartment(super._d);

  String get shortName => d?['short_name'] ?? '';
  String get fullName => d?['full_name'] ?? '';
}
