part of '../../index.dart';

class MatListAppBar<T, C extends BaseListCubit<T>> extends StatefulWidget
    implements PreferredSizeWidget {
  final ListState<T> state;
  final String title;
  final bool isSearchMode;

  const MatListAppBar(
      {super.key,
      required this.state,
      this.title = '',
      this.isSearchMode = false});

  @override
  State<StatefulWidget> createState() => MatListAppBarState<T, C>();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MatListAppBarState<T, C extends BaseListCubit<T>>
    extends State<MatListAppBar<T, C>> {
  bool isSearchMode = false;
  late final TextEditingController searchCtrl;

  @override
  void initState() {
    super.initState();
    isSearchMode = widget.isSearchMode;
    searchCtrl = TextEditingController(text: widget.state.searchText ?? '');
    searchCtrl.addListener(() {
      onSearchText();
    });
  }

  @override
  void didUpdateWidget(covariant MatListAppBar<T, C> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // isSearchMode = widget.isSearchMode; //jeśli bym robił update, to za kazda zmiana app bar wroci do stanu poczatkowego
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void onSearchText() {
    context.read<C>().search(searchCtrl.text);
  }

  Widget popupSettings() {
    return PopupMenuButton(
        tooltip: 'Opcje',
        icon: const Icon(Icons.settings),
        itemBuilder: (context) {
          return ['Odśwież', 'Dodaj']
              .map((String item) => PopupMenuItem(
                      child: ListTile(
                    leading: const Icon(Icons.remove_red_eye),
                    title: Text(item),
                  )))
              .toList();
        });
  }

  AppBar appBarNormal() {
    return AppBar(
      title: Text(widget.title),
      bottom: appBarSearch(),
      actions: [
        IconButton(
            onPressed: () {
              setSearchMode(true);
            },
            icon: const Icon(Icons.search)),
        popupSettings(),
      ],
    );
  }

  AppBar appBarSearch() {
    return AppBar(
      title: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        height: 40,
        child: TextField(
          controller: searchCtrl,
        ),
      ),
    );
  }

  void setSearchMode(bool mode) {
    setState(() {
      isSearchMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSearchMode ? appBarSearch() : appBarNormal();
  }
}
