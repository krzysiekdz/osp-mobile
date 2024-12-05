part of '../index.dart';

class ListItemParams {
  final int index;
  final AppSession appState;
  final BuildContext context;
  const ListItemParams(
      {required this.index, required this.appState, required this.context});
}

typedef ListItemBuilder<T> = Widget Function(T item, ListItemParams p);
