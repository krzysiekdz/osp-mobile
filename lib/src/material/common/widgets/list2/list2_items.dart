part of '../../index.dart';

class MatCubitableList2Items<T, C extends BaseListCubit<T>>
    extends StatefulWidget {
  final ListState<T> state;
  final ListItemBuilder<T> renderItem;
  const MatCubitableList2Items(
      {super.key, required this.state, required this.renderItem});

  @override
  State<StatefulWidget> createState() => MatCubitableList2ItemsState<T, C>();
}

class MatCubitableList2ItemsState<T, C extends BaseListCubit<T>>
    extends State<MatCubitableList2Items<T, C>> {
  late final AppSession appState;
  ListState<T> get state => widget.state;

  @override
  void initState() {
    super.initState();
    appState = context.read<OspAppCubit>().state as AppSession;
  }

  @override
  Widget build(BuildContext context) {
    return state.isEmpty && state.isPending
        ? buildCenterLoaderSliver()
        : buildListOrErr();
  }

  Widget buildCenterLoaderSliver() {
    return SliverFillRemaining(
      child: buildCenterLoader(),
    );
  }

  Widget buildCenterLoader() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 64),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildListOrErr() {
    return state.isEmpty && state.isError
        ? buildCenterErrorSliver()
        : state.isEmpty
            ? buildEmptyListSliver()
            : buildListSliver();
  }

  Widget buildCenterErrorSliver() {
    return SliverFillRemaining(
      child: buildCenterError(),
    );
  }

  Widget buildCenterError() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.err!.msg,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<C>().fetchInitialData();
                },
                child: const Text('Ponów'))
          ],
        ),
      ),
    );
  }

  Widget buildEmptyListSliver() {
    return SliverFillRemaining(
      child: buildEmptyList(),
    );
  }

  Widget buildEmptyList() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 64),
      child: const Center(
        child: Text(
          'Brak danych',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }

  //tutaj lista na pewno nie jest empty
  Widget buildListSliver() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, i) {
        if (state.isPending && i == state.dataCount) {
          return buildOnListLoader();
        } else if (state.isError && i == state.dataCount) {
          return buildOnListErr();
        }
        return widget.renderItem(widget.state.data[i],
            ListItemParams(index: i, appState: appState, context: context));
      },
      childCount: state.dataCount + (state.isPending || state.isError ? 1 : 0),
    ));
  }

  Widget buildOnListLoader() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: const Center(child: CircularProgressIndicator()));
  }

  Widget buildOnListErr() {
    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            state.err!.msg,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
