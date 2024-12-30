part of 'index.dart';

class SzkoleniaList extends BaseListWidget {
  const SzkoleniaList({super.key, super.config});

  @override
  State<BaseListWidget> createState() => _SzkoleniaList();
}

class _SzkoleniaList extends StdList<Szkolenie> {
  @override
  Repository<Szkolenie> createRepo() => SzkolenieRepo();

  @override
  Widget renderItem(Szkolenie item) {
    return Column(
      children: [
        Text('${item.numer}'),
        Text('${item.strazak?.firstName} ${item.strazak?.lastName}')
      ],
    );
  }

  @override
  Widget renderTitle() => const Text('Szkolenia');
}
