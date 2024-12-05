part of '../index.dart';

/*
  standardowy, konfigurowalny widok listy
*/
abstract class StdList<T> extends BaseList<T> {
  //-------- methods to implement

  Widget renderItem(T item);

  Widget renderTitle();

  //-------------------

  late StdAppBar appBar;

  StdList() {
    appBar = StdAppBar(stdList: this);
  }

  Widget loader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget list() {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: data.mapi((item, i) => Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(bottom: 4),
              // color: i % 2 == 0 ? Colors.amber[100] : Colors.amber[600],
              child: renderItem(item),
            )));
  }

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar.build(context),
      body: SafeArea(child: isPending ? loader() : list()),
      bottomNavigationBar: (widget.config as OspRouteParams).menuBottom,
    );
  }
}

class StdAppBar<T> {
  final StdList<T> stdList;
  bool isSearchMode = false;

  StdAppBar({required this.stdList});

  Widget popupMenu() {
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
      title: stdList.renderTitle(),
      actions: [
        IconButton(
            onPressed: () {
              setSearchMode(true);
            },
            icon: const Icon(Icons.search)),
        popupMenu(),
      ],
    );
  }

  AppBar appBarSearch() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          setSearchMode(false);
        },
      ),
      title: TextField(),
    );
  }

  void setSearchMode(bool mode) {
    isSearchMode = mode;
    stdList.rebuild();
  }

  AppBar build(BuildContext context) {
    return isSearchMode ? appBarSearch() : appBarNormal();
  }
}
