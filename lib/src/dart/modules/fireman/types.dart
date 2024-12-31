part of 'index.dart';

class Fireman extends TBase
    with TPerson, TAddress, TContact, TSizes, TImageUrl {
  const Fireman(super._d);

  String get rank => d?['stopien'] ?? '';
  set rank(String v) => d?['stopien'] = v;

  int get type => d?['rodzaj'] ?? -1;
  set type(int v) => d?['rodzaj'] = v;

  bool get inActions => d?['in_actions'] ?? false;

  bool get isJOT => d?['czy_jot'] ?? false;

  bool get isMDPSupervisor => d?['czy_opiekun_mdp'] ?? false;

  bool get isAuditCommittee => d?['komisja'] != null ? true : false;

  bool get isBoardMember => d?['zarzad'] != null ? true : false;

  String get idNo => d?['numer_legitymacji'] ?? '';

  String get joinDate => d?['data_wstapienia'] ?? '';

  String get boardRole => d?['zarzad'] ?? '';

  String get committee => d?['komisja'] ?? '';

  String get peselNo => d?['pesel'] ?? '';

  String get birthDate => d?['data_urodzenia'] ?? '';

  String get placeOfBirth => d?['miejsce_urodzenia'] ?? '';

  String get fatherName => d?['imie_ojca'] ?? '';

  String get workplace => d?['miejsce_pracy'] ?? '';

  String get education => d?['wyksztalcenie'] ?? '';

  String get profession => d?['zawod'] ?? '';

  static List<DictPair> types() {
    return const [
      DictPair(value: 'Zwyczajny', key: 1),
      DictPair(value: 'Wspierający', key: 2),
      DictPair(value: 'Honorowy', key: 3),
      DictPair(value: 'MDP', key: 4),
    ];
  }
}

class FiremanRepo extends Api1Repository<Fireman> {
  FiremanRepo(super.apiService);

  @override
  String get endpoint => 'v1/mod-strazak/strazacy';

  @override
  Fireman createElement(Map<String, dynamic> data) => Fireman(data);
}

class FiremanListCubit extends Api1ListCubit<Fireman> {
  FiremanListCubit(super.apiService);

  @override
  Repository<Fireman> createRepo() => FiremanRepo(apiService);
}

class FiremanFormCubit extends Api1FormCubit<Fireman> {
  FiremanFormCubit(super.apiService, {required super.formParams, super.params});

  @override
  Repository<Fireman> createRepo() => FiremanRepo(apiService);
}
