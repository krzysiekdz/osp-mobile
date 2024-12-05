part of 'index.dart';

class Szkolenie {
  int? id;
  Strazak? strazak;
  String? numer;
  String? type;

  Szkolenie({this.id, this.strazak, this.numer, this.type});
}

class SzkolenieRepo extends Repository<Szkolenie> {
  @override
  Future<Szkolenie> get({id, Map<String, dynamic> params = const {}}) async {
    return Szkolenie(
        id: id,
        numer: 'SZKOLENIE/2024/05/$id',
        strazak:
            Strazak({'id': id, 'imie': 'Jan$id', 'nazwisko': 'Kowalski$id'}));
  }

  @override
  Future<List<Szkolenie>> list(
      {int offset = 0,
      int limit = 20,
      Map<String, dynamic> params = const {}}) async {
    return [
      for (var i = offset; i < limit + offset; i++)
        Szkolenie(
            id: i,
            numer: 'SZKOLENIE/2024/05/0$i',
            strazak:
                Strazak({'id': i, 'imie': 'Jan$i', 'nazwisko': 'Kowalski$i'}))
    ];
  }
}
