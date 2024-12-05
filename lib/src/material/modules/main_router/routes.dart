part of 'index.dart';

List<OspRoute> appRoutes = [
  OspRoute(
      menuItem: MenuItem(label: 'Pulpit', icon: Icons.dashboard),
      name: OspRouteName.dashboard,
      factory: (OspRouteParams? config) => Dashboard(
            config: config,
          )),
  OspRoute(
      menuItem: MenuItem(label: 'Strażacy', icon: Icons.group),
      name: OspRouteName.strazacy,
      factory: (OspRouteParams? params) => StrazacyList(
            params: params,
          )),
  OspRoute(
      menuItem: MenuItem(label: 'Badania', icon: Icons.add_business),
      name: OspRouteName.badania,
      factory: (OspRouteParams? config) => BadaniaList(
            config: config,
          )),
  OspRoute(
      menuItem: MenuItem(label: 'Szkolenia', icon: Icons.abc_outlined),
      name: OspRouteName.szkolenia,
      factory: (OspRouteParams? config) => SzkoleniaList(
            config: config,
          )),
];

List<OspRoute> findRoutes(List<OspRouteName> names) {
  return [
    for (var m in appRoutes)
      for (var id in names)
        if (m.name == id) m
  ];
}
