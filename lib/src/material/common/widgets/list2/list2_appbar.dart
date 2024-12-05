part of '../../index.dart';

class MatList2AppBar<T, C extends BaseListCubit<T>> extends StatefulWidget {
  const MatList2AppBar({
    super.key,
    required this.title,
    required this.state,
    this.filterTabs = const [],
    this.appBarHeight = 140,
  });

  final ListState<T> state;
  final String title;
  final List<FilterTab> filterTabs;
  final double appBarHeight;

  @override
  State<StatefulWidget> createState() => MatList2AppBarState<T, C>();
}

class MatList2AppBarState<T, C extends BaseListCubit<T>>
    extends State<MatList2AppBar<T, C>> {
  void onSearchText(String text) {
    context.read<C>().search(text);
  }

  void onTabFiltersChange(Map<String, dynamic> filters) {
    context.read<C>().replaceFilters(filters);
    // print("filters ${filters.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      titleSpacing: gap,
      expandedHeight: widget.appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.none,
          background: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildSearch(context),
              buildTabBar(context),
            ],
          )),
    );
  }

  Widget buildSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: gap, vertical: 8),
      child: SearchField(
        text: widget.state.searchText ?? '',
        onSearchText: onSearchText,
      ),
    );
  }

  Widget buildTabBar(BuildContext context) {
    return widget.filterTabs.isNotEmpty
        ? MatList2FilterTabs(
            onFiltersChange: onTabFiltersChange,
            filterTabs: widget.filterTabs,
            filters: widget.state.params)
        : Container(height: 0);
  }
}
