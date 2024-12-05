part of '../index.dart';

abstract class BaseListWidget extends StatefulWidget {
  final AppRouteParams? config;
  const BaseListWidget({super.key, this.config});
}

/*
  klasa uniwersalna do operowania na listach: fetch, search, filter itp
  nie definiuje konkretnego UI - metoda build() ma byc zdefiniowana poprzez klasę dziedziczącą
*/
abstract class BaseList<T> extends State<BaseListWidget> {
  List<T> data = [];
  late Repository<T> repo;
  bool isPending = true;
  bool fetchOnInit = true;

  @override
  initState() {
    super.initState();
    repo = createRepo();
    if (fetchOnInit) fetchData();
  }

  Repository<T> createRepo();

  setPending(bool pending) {
    setState(() {
      isPending = pending;
    });
  }

  fetchData() async {
    setPending(true);
    // await Future.delayed(const Duration(seconds: 2));
    data = await repo.list();
    if (!mounted) return;
    setPending(false);
  }
}
