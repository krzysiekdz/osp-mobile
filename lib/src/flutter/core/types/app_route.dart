part of '../index.dart';

class MenuItem {
  String label;
  IconData icon;
  IconData? iconSelected;

  MenuItem({required this.label, required this.icon, this.iconSelected});
}

typedef AppRouteFactory<P extends AppRouteParams> = Widget Function(P? params);

abstract class AppRouteParams {
  final Map<String, dynamic>? params;
  const AppRouteParams({this.params});
}

abstract class AppRoute<T, P extends AppRouteParams> {
  MenuItem menuItem;
  AppRouteFactory<P> factory;
  T name;

  AppRoute({required this.menuItem, required this.factory, required this.name});
}
