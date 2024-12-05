part of '../../index.dart';

typedef OnFiltersChange = void Function(Map<String, dynamic> filters);

class FilterTab {
  const FilterTab({required this.tab, this.key = '', this.value});

  final Tab tab;
  final String key;
  final dynamic value;
}

class MatList2FilterTabs extends StatefulWidget {
  const MatList2FilterTabs(
      {super.key,
      required this.onFiltersChange,
      required this.filterTabs,
      required this.filters});
  final OnFiltersChange onFiltersChange;
  final List<FilterTab> filterTabs;
  final Map<String, dynamic> filters;

  @override
  State<StatefulWidget> createState() => MatList2FilterTabsState();
}

class MatList2FilterTabsState extends State<MatList2FilterTabs>
    with SingleTickerProviderStateMixin {
  late final TabController? filterTabCtrl;
  int _index = 0;
  FilterTab get currentFilterTab => widget.filterTabs[_index];

  @override
  void initState() {
    super.initState();
    if (widget.filterTabs.isNotEmpty) {
      filterTabCtrl =
          TabController(length: widget.filterTabs.length, vsync: this);
      filterTabCtrl!.addListener(() {
        onFiltersChange();
      });
    } else {
      filterTabCtrl = null;
    }
  }

  @override
  void dispose() {
    filterTabCtrl?.dispose();
    super.dispose();
  }

  void onFiltersChange() {
    if (filterTabCtrl!.index == _index) return;
    String prevKey = currentFilterTab.key;
    _index = filterTabCtrl!.index;

    final filters = {
      ...widget.filters,
    }..remove(prevKey);
    if (currentFilterTab.key.isNotEmpty) {
      filters[currentFilterTab.key] = currentFilterTab.value;
    }
    widget.onFiltersChange(filters);
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: filterTabCtrl,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        tabs: widget.filterTabs.map((e) => e.tab).toList());
  }
}
