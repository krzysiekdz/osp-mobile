part of '../index.dart';

class OspRouteParams<T extends TBase> extends AppRouteParams {
  final Widget? menuBottom;
  final Api1Service? api1service;
  final Widget? floatingActionButton;
  final AppFormParams<T>? formParams;

  const OspRouteParams(
      {this.menuBottom,
      this.api1service,
      this.floatingActionButton,
      this.formParams,
      super.params});
}

class OspRoute extends AppRoute<OspRouteName, OspRouteParams> {
  OspRoute(
      {required super.menuItem, required super.factory, required super.name});
}

@immutable
class OspRouteReturnData {
  final bool doRefresh;
  final dynamic data;
  const OspRouteReturnData({this.doRefresh = false, this.data});
}
