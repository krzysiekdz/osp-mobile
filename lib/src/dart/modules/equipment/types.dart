part of 'index.dart';

class Equipment extends Product with TImageUrl {
  const Equipment(super._d);

  String get inventoryNo => d?['nr_inwent'] ?? '';
  set inventoryNo(String v) => d?['nr_inwent'] = v;

  int get type => d?['typ_srodka'] ?? 0;
  set type(int v) => d?['typ_srodka'] = v;

  int get owner => d?['wlasciciel'] ?? 0;
  set owner(int v) => d?['wlasciciel'] = v;

  String get introductionDate => d?['data_wpr'] ?? '';
  set introductionDate(String v) => d?['data_wpr'] = v;

  String get deletionDate => d?['data_wykr'] ?? '';
  set deletionDate(String v) => d?['data_wykr'] = v;

  String get productionDate => d?['data_produkcji'] ?? '';
  set productionDate(String v) => d?['data_produkcji'] = v;

  String get expirationDate => d?['data_przydatnosci'] ?? '';
  set expirationDate(String v) => d?['data_przydatnosci'] = v;

  // static List<DictPair> types() {
  //   return const [
  //     DictPair(value: 'Środek trwały', key: 1),
  //     DictPair(value: 'Środek nietrwały', key: 2),
  //     DictPair(value: 'Środek materiałowy', key: 3),
  //     DictPair(value: 'Wyposażenie osobiste', key: 4),
  //   ];
  // }

  static Map<int, String> types() {
    return const {
      1: 'Środek trwały',
      2: 'Środek nietrwały',
      3: 'Środek materiałowy',
      4: 'Wyposażenie osobiste'
    };
  }

  // static List<DictPair> owners() {
  //   return const [
  //     DictPair(value: 'OSP', key: 1),
  //     DictPair(value: 'Gmina', key: 2),
  //   ];
  // }

  static Map<int, String> owners() {
    return const {
      1: 'OSP',
      2: 'Gmina',
    };
  }
}

class EquipmentRepo extends Api1Repository<Equipment> {
  EquipmentRepo(super.apiService);

  @override
  String get endpoint => 'v1/mod-inwentarz/sprzet';

  @override
  Equipment createElement(Map<String, dynamic> data) => Equipment(data);
}

class EquipmentListCubit extends Api1ListCubit<Equipment> {
  EquipmentListCubit(super.apiService);

  @override
  Repository<Equipment> createRepo() => EquipmentRepo(apiService);
}

class EquipmentFormCubit extends Api1FormCubit<Equipment> {
  EquipmentFormCubit(super.apiService,
      {required super.formParams, super.params});

  @override
  Repository<Equipment> createRepo() => EquipmentRepo(apiService);
}
