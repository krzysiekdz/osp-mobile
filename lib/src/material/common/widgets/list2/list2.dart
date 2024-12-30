part of '../../index.dart';

typedef MatList2SliverBuilder<T> = Widget Function(ListState<T> state);

typedef AppWithMapCallback = void Function(Map<String, dynamic>? params);

abstract class MatCubitableList2<T, C extends BaseListCubit<T>>
    extends StatefulWidget {
  const MatCubitableList2({super.key, this.params});

  final OspRouteParams? params;
  String get title => '';

  C createCubit();

  Widget renderItem(T item, ListItemParams p);

  List<FilterTab> get filterTabs => const [];

  double get appBarHeight => 140;

  bool get keepAlive => true;

  bool get hasFAB => true;

  Widget createAppBarSliver(ListState<T> state) => MatList2AppBar<T, C>(
      state: state,
      title: title,
      filterTabs: filterTabs,
      appBarHeight: appBarHeight);

  Widget createListSliver(ListState<T> state) {
    return MatCubitableList2Items<T, C>(state: state, renderItem: renderItem);
  }

  Widget? createFAB(AppWithMapCallback callback) {
    if (!hasFAB) return null;
    final Map<String, dynamic> params = {'type': 1};
    return FloatingActionButton(
      onPressed: () {
        callback(params);
      },
      child: const Icon(Icons.add),
    );
  }

  Widget buildFormTypeCreate(
          BuildContext context, Map<String, dynamic>? params) =>
      const Placeholder();

  @override
  State<StatefulWidget> createState() => _MatCubitableList2State<T, C>();
}

class _MatCubitableList2State<T, C extends BaseListCubit<T>>
    extends State<MatCubitableList2<T, C>>
    with AutomaticKeepAliveClientMixin<MatCubitableList2<T, C>> {
  final scrollController = ScrollController();

  C get cubit => _blocContextKey.currentContext!.read<C>();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // context.read<C>().fetchNextData(); //tak nie mozna, bo C nie jest zdefiniowane w kontekscie
        cubit.fetchNextData();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _callFormCreate(Map<String, dynamic>? params) {
    Timer(const Duration(milliseconds: 50), () async {
      final OspRouteReturnData? retData = await Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  widget.buildFormTypeCreate(context, params)));
      if (context.mounted && retData != null && retData.doRefresh) {
        refresh();
      }
    });
  }

  Future<void> refresh() async => cubit.refresh();

  final GlobalKey<State<BlocBuilder<C, ListState<T>>>> _blocContextKey =
      GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<C>(
      create: (_) => widget.createCubit()..init(),
      child: BlocBuilder<C, ListState<T>>(
        key: _blocContextKey,
        builder: (context, state) => Scaffold(
          body: RefreshIndicator(
            onRefresh: refresh,
            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                widget.createAppBarSliver(state),
                widget.createListSliver(state),
              ],
            ),
          ),
          bottomNavigationBar: widget.params?.menuBottom,
          floatingActionButton: widget.params?.floatingActionButton ??
              widget.createFAB(_callFormCreate),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
