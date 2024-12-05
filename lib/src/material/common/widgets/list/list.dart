part of '../../index.dart';

abstract class MatCubitableList<T, C extends BaseListCubit<T>>
    extends StatelessWidget {
  const MatCubitableList({super.key, this.config});

  final OspRouteParams? config;
  String get title => '';
  bool get isSearchMode => false;

  C createCubit();

  Widget renderItem(T item, ListItemParams p);
  // ListItemBuilder<T> get renderItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createCubit()..init(),
      child: BlocBuilder<C, ListState<T>>(
        builder: (context, state) => Scaffold(
          appBar: createAppBar(state),
          body: createList(state),
          bottomNavigationBar: config?.menuBottom,
        ),
      ),
    );
  }

  PreferredSizeWidget createAppBar(ListState<T> state) => MatListAppBar<T, C>(
      state: state, title: title, isSearchMode: isSearchMode);

  Widget createList(ListState<T> state) {
    return MatCubitableListItems<T, C>(state: state, renderItem: renderItem);
  }
}
