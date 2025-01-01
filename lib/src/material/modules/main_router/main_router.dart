part of 'index.dart';

class MainRouter extends StatefulWidget {
  final List<RouteName> menuBottomConfig;
  final Api1Service api1service;
  const MainRouter(
      {super.key, required this.menuBottomConfig, required this.api1service});

  @override
  State<MainRouter> createState() => _MainRouterState();
}

class _MainRouterState extends State<MainRouter> {
  List<OspRoute> get modules => findRoutes(widget.menuBottomConfig);
  late final PageController _pageController;

  void onItemSelected(int index) {
    _pageController.jumpToPage(index);
    // _pageController.animateToPage(index,
    //     duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // _pageController.addListener(() {
    //   _navKey.currentState!.setIndex(_pageController.page?.round() ?? 0);
    // });
  }

  // final _navKey = GlobalKey<MainRouterNavState>();

  @override
  Widget build(BuildContext context) {
    final m = modules;
    // String? title = m[0].menuItem.label;

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var config = OspRouteParams(api1service: widget.api1service);
          Widget w = m.asMap().containsKey(index)
              ? m[index].factory(config)
              : NotFound(
                  config: config,
                );

          return w;
        },
        itemCount: m.length,
      ),
      bottomNavigationBar: MainRouterNav(
        // key: _navKey,
        modules: m,
        onNavelected: onItemSelected,
      ),
    );
  }
}

typedef IntCallback = void Function(int);

class MainRouterNav extends StatefulWidget {
  const MainRouterNav(
      {super.key, required this.modules, required this.onNavelected});

  final List<OspRoute> modules;
  final IntCallback onNavelected;

  @override
  State<StatefulWidget> createState() => MainRouterNavState();
}

class MainRouterNavState extends State<MainRouterNav> {
  int _selectedIndex = 0;

  void onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onNavelected(index);
  }

  // void setIndex(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        surfaceTintColor: Theme.of(context).cardColor,
        selectedIndex: _selectedIndex,
        onDestinationSelected: onItemSelected,
        destinations: [
          for (var i in widget.modules)
            NavigationDestination(
                icon: Icon(i.menuItem.icon), label: i.menuItem.label)
        ]);
  }
}
