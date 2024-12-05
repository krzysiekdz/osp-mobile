part of 'index.dart';

class Badanie {
  int? id;
  Strazak? strazak;
  String? numer;
  String? type;

  Badanie({this.id, this.strazak, this.numer, this.type});
}

class BadanieRepo extends Repository<Badanie> {
  @override
  Future<Badanie> get({id, Map<String, dynamic> params = const {}}) async {
    return Badanie(
        id: id,
        numer: 'BADANIE/2024/05/$id',
        strazak: const Strazak({'imie': 'Jan', 'nazwisko': 'Kowalski'}));
  }

  @override
  Future<List<Badanie>> list(
      {int offset = 0,
      int limit = 20,
      Map<String, dynamic> params = const {}}) async {
    return [
      for (var i = offset; i < limit + offset; i++)
        Badanie(
            id: i,
            numer: 'BADANIE/2024/05/0$i',
            strazak: Strazak({'imie': 'Jan$i', 'nazwisko': 'Kowalski$i'}))
    ];
  }
}
