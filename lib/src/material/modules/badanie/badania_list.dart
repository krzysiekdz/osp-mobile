part of 'index.dart';

class BadaniaList extends BaseListWidget {
  const BadaniaList({super.key, super.config});

  @override
  State<BaseListWidget> createState() => _BadaniaList();
}

class _BadaniaList extends StdList<Badanie> {
  @override
  Repository<Badanie> createRepo() => BadanieRepo();

  @override
  Widget renderItem(Badanie item) {
    return Column(
      children: [
        Text('${item.numer}'),
        Text('${item.strazak?.imie} ${item.strazak?.nazwisko}')
      ],
    );
  }

  @override
  Widget renderTitle() => const Text('Badania');
}
