part of '../../index.dart';

class MatCubitableListItems<T, C extends BaseListCubit<T>>
    extends StatefulWidget {
  final ListState<T> state;
  final ListItemBuilder<T> renderItem;
  const MatCubitableListItems(
      {super.key, required this.state, required this.renderItem});

  @override
  State<StatefulWidget> createState() => MatCubitableListItemsState<T, C>();
}

class MatCubitableListItemsState<T, C extends BaseListCubit<T>>
    extends State<MatCubitableListItems<T, C>> {
  final scrollController = ScrollController();
  late final AppSession appState;
  late ListState<T> state;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<C>().fetchNextData();
      }
    });
    appState = context.read<OspAppCubit>().state as AppSession;
    state = widget.state;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MatCubitableListItems<T, C> oldWidget) {
    super.didUpdateWidget(oldWidget);
    state = widget.state;
  }

  @override
  Widget build(BuildContext context) {
    return state.isEmpty && state.isPending
        ? buildCenterLoader()
        : buildListOrErr();
  }

  Widget buildCenterLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildListOrErr() {
    return state.isEmpty && state.isError
        ? buildCenterError()
        : state.isEmpty
            ? buildEmptyList()
            : buildList();
  }

  Widget buildCenterError() {
    return Center(
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
    );
  }

  Widget buildEmptyList() {
    return const Center(
      child: Text('Brak danych'),
    );
  }

  //tutaj lista na pewno nie jest empty
  Widget buildList() {
    return ListView.builder(
        controller: scrollController,
        itemCount: state.dataCount + (state.isPending || state.isError ? 1 : 0),
        itemBuilder: (context, i) {
          if (state.isPending && i == state.dataCount) {
            return buildOnListLoader();
          } else if (state.isError && i == state.dataCount) {
            return buildOnListErr();
          }
          return widget.renderItem(widget.state.data[i],
              ListItemParams(index: i, appState: appState, context: context));
        });
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
