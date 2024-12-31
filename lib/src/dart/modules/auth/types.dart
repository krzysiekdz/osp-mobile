part of 'index.dart';

class Session extends TBase {
  const Session(super._d);

  String get token => d?['token'] ?? '';

  bool get isActiveLic => d?['is_active_license'] ?? false;
}

class User extends TBase with TTypeI, TStatus, TPerson, TContact {
  const User(super._d);

  bool get showFireDepRegistration => d?['czy_rejestracja_jednostki'] ?? false;
}
