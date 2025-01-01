part of '../index.dart';

class TBase {
  final Map<String, dynamic>? _d;
  const TBase(this._d);

  dynamic get id => _d?['id'];
  set id(dynamic id) => _d?['id'] = id;

  Map<String, dynamic>? get d => _d;

  Map<String, dynamic>? copy() =>
      d?.map<String, dynamic>((i, v) => MapEntry(i, v));

  Map<String, dynamic>? copyWith(Map<String, dynamic> other) =>
      d?.map<String, dynamic>((i, v) =>
          other.containsKey(i) ? MapEntry(i, other[i]) : MapEntry(i, v));

  void merge(TBase other) {
    _d?.addAll(other.d ?? {});
  }

  bool isEmpty() => d?.isEmpty ?? true;
}
