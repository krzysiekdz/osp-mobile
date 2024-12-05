part of '../index.dart';

class OspRouteParams extends AppRouteParams {
  final Widget? menuBottom;
  final Api1Service? api1service;
  final Widget? floatingActionButton;

  const OspRouteParams(
      {this.menuBottom,
      this.api1service,
      this.floatingActionButton,
      super.params});
}

class OspRoute extends AppRoute<OspRouteName, OspRouteParams> {
  OspRoute(
      {required super.menuItem, required super.factory, required super.name});
}
