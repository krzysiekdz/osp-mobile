part of 'index.dart';

class Strazak extends TBase with TPerson, TAddress, TContact, TSizes {
  const Strazak(super._d);

  String get imgUrl {
    final imgUrl = d?['img_url'] ?? '';
    if (appMode == AppMode.dev) {
      return imgUrl.replaceAll('https', 'http');
    }
    return imgUrl;
  }

  String get stopien => d?['stopien'] ?? '';

  int get rodzaj => d?['rodzaj'] ?? -1;

  bool get inActions => d?['in_actions'] ?? false;

  bool get czyJot => d?['czy_jot'] ?? false;

  bool get czyOpiekunMdp => d?['czy_opiekun_mdp'] ?? false;

  bool get czyKomisja => d?['komisja'] != null ? true : false;

  bool get czyZarzad => d?['zarzad'] != null ? true : false;

  String get nrLegitymacji => d?['numer_legitymacji'] ?? '';

  String get dataWstapienia => d?['data_wstapienia'] ?? '';

  String get zarzad => d?['zarzad'] ?? '';

  String get komisja => d?['komisja'] ?? '';

  String get pesel => d?['pesel'] ?? '';

  String get dataUr => d?['data_urodzenia'] ?? '';

  String get miejsceUr => d?['miejsce_urodzenia'] ?? '';

  String get imieOjca => d?['imie_ojca'] ?? '';

  String get miejscePracy => d?['miejsce_pracy'] ?? '';

  String get wyksztalcenie => d?['wyksztalcenie'] ?? '';

  String get zawod => d?['zawod'] ?? '';

  static List<DictPair> rodzaje() {
    return const [
      DictPair(value: 'Zwyczajny', key: 1),
      DictPair(value: 'Wspierający', key: 2),
      DictPair(value: 'Honorowy', key: 3),
      DictPair(value: 'MDP', key: 4),
    ];
  }
}

class StrazakRepo extends Api1Repository<Strazak> {
  StrazakRepo(super.apiService);

  @override
  String get endpoint => 'v1/mod-strazak/strazacy';

  @override
  Strazak createElement(Map<String, dynamic> data) => Strazak(data);
}

class StrazakListCubit extends Api1ListCubit<Strazak> {
  StrazakListCubit(super.apiService);

  @override
  Repository<Strazak> createRepo() => StrazakRepo(apiService);
}

class StrazakFormCubit extends Api1FormCubit<Strazak> {
  StrazakFormCubit(super.apiService, {required super.formParams, super.params});

  @override
  Repository<Strazak> createRepo() => StrazakRepo(apiService);
}
