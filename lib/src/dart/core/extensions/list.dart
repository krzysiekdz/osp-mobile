part of '../index.dart';

extension ListExt<E> on List<E> {
  List<T> mapi<T>(T Function(E item, int index) toElement) {
    List<T> result = [];
    var index = 0;
    for (E item in this) {
      result.add(toElement(item, index));
      index++;
    }
    return result;
  }
}
