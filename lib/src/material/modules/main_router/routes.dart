part of 'index.dart';

List<OspRoute> appRoutes = [
  OspRoute(
      menuItem: MenuItem(label: 'Pulpit', icon: Icons.dashboard),
      name: RouteName.dashboard,
      factory: (OspRouteParams? config) => Dashboard(
            config: config,
          )),
  OspRoute(
      menuItem: MenuItem(label: 'Strażacy', icon: Icons.group),
      name: RouteName.fireman,
      factory: (OspRouteParams? params) => FiremanList(
            params: params,
          )),
];

List<OspRoute> findRoutes(List<RouteName> names) {
  return [
    for (var m in appRoutes)
      for (var id in names)
        if (m.name == id) m
  ];
}
