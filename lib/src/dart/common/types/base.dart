part of '../index.dart';

class TBase {
  final Map<String, dynamic>? _d;
  const TBase(this._d);

  dynamic get id => _d?['id'];
  set id(dynamic id) => _d?['id'] = id;

  Map<String, dynamic>? get d => _d;

  Map<String, dynamic>? copy() =>
      d?.map<String, dynamic>((i, v) => MapEntry(i, v));

  Map<String, dynamic>? copyWith(Map<String, dynamic> other) =>
      d?.map<String, dynamic>((i, v) =>
          other.containsKey(i) ? MapEntry(i, other[i]) : MapEntry(i, v));

  void merge(TBase other) {
    _d?.addAll(other.d ?? {});
  }

  bool isEmpty() => d?.isEmpty ?? true;
}

class DictPair {
  final dynamic key;
  final dynamic value;
  const DictPair({this.key = '', this.value = ''});
  DictPair.json(Map<String, dynamic>? json)
      : key = json?['value'] ?? '',
        value = json?['text'] ?? '';

  DictPair.json2(Map<String, dynamic>? json)
      : key = json?['ident'] ?? '',
        value = json?['nazwa'] ?? '';

  static DictPair find(List<DictPair> list, dynamic key,
      [String notFoundText = '']) {
    return list.firstWhere((e) => e.key == key,
        orElse: () => DictPair(value: notFoundText));
  }

  @override
  String toString() {
    return "DictPair($key => $value)";
  }
}

mixin TBase2 on TBase {
  String get name => _d?['nazwa'] ?? '';
  set name(String v) => _d?['nazwa'] = v;

  String get comments => _d?['uwagi'] ?? '';
  set comments(String v) => _d?['uwagi'] = v;
}

mixin TPerson on TBase {
  String get firstName => _d?['imie'] ?? '';
  set firstName(String v) => _d?['imie'] = v;

  String get middleName => _d?['drugie_imie'] ?? '';
  set middleName(String v) => _d?['drugie_imie'] = v;

  String get lastName => _d?['nazwisko'] ?? '';
  set lastName(String v) => _d?['nazwisko'] = v;
}

mixin TAddress on TBase {
  String get city => _d?['miejscowosc'] ?? '';
  set city(String v) => _d?['miejscowosc'] = v;

  String get street => _d?['ulica'] ?? '';
  set street(String v) => _d?['ulica'] = v;

  String get buildingNo => _d?['nr_budynku'] ?? '';
  set buildingNo(String v) => _d?['nr_budynku'] = v;

  String get zipCode => _d?['kod_pocztowy'] ?? '';
  set zipCode(String v) => _d?['kod_pocztowy'] = v;

  String get postOffice => _d?['poczta'] ?? '';
  set postOffice(String v) => _d?['poczta'] = v;
}

mixin TType on TBase {
  String get type => _d?['type'] ?? '';
  set type(String v) => _d?['type'] = v;
}

mixin TTypeI on TBase {
  int get type => _d?['type'] ?? '';
  set type(int v) => _d?['type'] = v;
}

mixin TStatus on TBase {
  int get status => _d?['status'] ?? '';
  set status(int v) => _d?['status'] = v;
}

mixin TContact on TBase {
  String get email => _d?['email'] ?? '';
  set email(String v) => _d?['email'] = v;

  String get phoneNo => _d?['nr_tel'] ?? '';
  set phoneNo(String v) => _d?['nr_tel'] = v;

  String get phoneNo2 => _d?['nr_tel2'] ?? '';
  set phoneNo2(String v) => _d?['nr_tel2'] = v;
}

mixin TSizes on TBase {
  double get height => _d?['wzrost']?.toDouble() ?? 0.0;
  set height(double v) => _d?['wzrost'] = v;

  double get shoeNo => _d?['numer_buta']?.toDouble() ?? 0.0;
  set shoeNo(double v) => _d?['numer_buta'] = v;

  double get chestCircum => _d?['obwod_w_klatce_piersiowej']?.toDouble() ?? 0.0;
  set chestCircum(double v) => _d?['obwod_w_klatce_piersiowej'] = v;

  double get waistCircum => _d?['obwod_w_pasie']?.toDouble() ?? 0.0;
  set waistCircum(double v) => _d?['obwod_w_pasie'] = v;

  double get headCircum => _d?['obwod_glowy']?.toDouble() ?? 0.0;
  set headCircum(double v) => _d?['obwod_glowy'] = v;

  double get neckCircum => _d?['obwod_szyi']?.toDouble() ?? 0.0;
  set neckCircum(double v) => _d?['obwod_szyi'] = v;

  String get handSize => _d?['rozmiar_dloni'] ?? '';
  set handSize(String v) => _d?['rozmiar_dloni'] = v;
}

mixin TAddress2 on TBase {
  String get province => _d?['wojewodztwo'] ?? '';
  set province(String v) => _d?['wojewodztwo'] = v;

  String get district => _d?['powiat'] ?? '';
  set district(String v) => _d?['powiat'] = v;

  String get commune => _d?['gmina'] ?? '';
  set commune(String v) => _d?['gmina'] = v;
}

mixin TDate on TBase {
  String get dateStart => _d?['date_start'] ?? '';
  set dateStart(String dateStart) => _d?['date_start'] = dateStart;

  String get dateEnd => _d?['date_end'] ?? '';
  set dateEnd(String dateEnd) => _d?['date_end'] = dateEnd;

  //read/write as date
  DateTime get dateStartAsDate => DateTime.parse(dateStart);
  DateTime get dateEndAsDate => DateTime.parse(dateEnd);
  set dateStartAsDate(DateTime dt) => dateStart = dt.toString();
  set dateEndAsDate(DateTime dt) => dateEnd = dt.toString();
}

mixin TImageUrl on TBase {
  String get imgUrl {
    final imgUrl = d?['img_url'] ?? '';
    if (appMode == AppMode.dev) {
      return imgUrl.replaceAll('https', 'http');
    }
    return imgUrl;
  }
}

mixin TPrice on TBase {
  double get netPrice => _d?['cena_n'] ?? 0;
  set netPrice(double v) => _d?['cena_n'] = v;

  double get grossPrice => _d?['cena_b'] ?? 0;
  set grossPrice(double v) => _d?['cena_b'] = v;

  double get vatPrice => _d?['cena_v'] ?? 0;
  set vatPrice(double v) => _d?['cena_v'] = v;

  double get vatRate => _d?['stawka_vat'] ?? 0;
  set vatRate(double v) => _d?['stawka_vat'] = v;

  double get netTotal => _d?['wartosc_n'] ?? 0;
  set netTotal(double v) => _d?['wartosc_n'] = v;

  double get grossTotal => _d?['wartosc_b'] ?? 0;
  set grossTotal(double v) => _d?['wartosc_b'] = v;

  double get vatTotal => _d?['wartosc_v'] ?? 0;
  set vatTotal(double v) => _d?['wartosc_v'] = v;

  double get qty => _d?['ilosc'] ?? 0;
  set qty(double v) => _d?['ilosc'] = v;
}

class Product extends TBase with TPrice, TBase2 {
  const Product(super._d);

  String get unit => _d?['jm'] ?? '';
  set unit(String v) => _d?['jm'] = v;

  String get symbol => _d?['symbol'] ?? '';
  set symbol(String v) => _d?['symbol'] = v;
}
