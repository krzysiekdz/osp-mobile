part of '../index.dart';

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
  String get name => d?['nazwa'] ?? '';
  set name(String v) => d?['nazwa'] = v;

  String get comments => d?['uwagi'] ?? '';
  set comments(String v) => d?['uwagi'] = v;
}

mixin TPerson on TBase {
  String get firstName => d?['imie'] ?? '';
  set firstName(String v) => d?['imie'] = v;

  String get middleName => d?['drugie_imie'] ?? '';
  set middleName(String v) => d?['drugie_imie'] = v;

  String get lastName => d?['nazwisko'] ?? '';
  set lastName(String v) => d?['nazwisko'] = v;
}

mixin TAddress on TBase {
  String get city => d?['miejscowosc'] ?? '';
  set city(String v) => d?['miejscowosc'] = v;

  String get street => d?['ulica'] ?? '';
  set street(String v) => d?['ulica'] = v;

  String get buildingNo => d?['nr_budynku'] ?? '';
  set buildingNo(String v) => d?['nr_budynku'] = v;

  String get zipCode => d?['kod_pocztowy'] ?? '';
  set zipCode(String v) => d?['kod_pocztowy'] = v;

  String get postOffice => d?['poczta'] ?? '';
  set postOffice(String v) => d?['poczta'] = v;
}

mixin TType on TBase {
  String get type => d?['type'] ?? '';
  set type(String v) => d?['type'] = v;
}

mixin TTypeI on TBase {
  int get type => d?['type'] ?? '';
  set type(int v) => d?['type'] = v;
}

mixin TStatus on TBase {
  int get status => d?['status'] ?? '';
  set status(int v) => d?['status'] = v;
}

mixin TContact on TBase {
  String get email => d?['email'] ?? '';
  set email(String v) => d?['email'] = v;

  String get phoneNo => d?['nr_tel'] ?? '';
  set phoneNo(String v) => d?['nr_tel'] = v;

  String get phoneNo2 => d?['nr_tel2'] ?? '';
  set phoneNo2(String v) => d?['nr_tel2'] = v;
}

mixin TSizes on TBase {
  double get height => d?['wzrost']?.toDouble() ?? 0.0;
  set height(double v) => d?['wzrost'] = v;

  double get shoeNo => d?['numer_buta']?.toDouble() ?? 0.0;
  set shoeNo(double v) => d?['numer_buta'] = v;

  double get chestCircum => d?['obwod_w_klatce_piersiowej']?.toDouble() ?? 0.0;
  set chestCircum(double v) => d?['obwod_w_klatce_piersiowej'] = v;

  double get waistCircum => d?['obwod_w_pasie']?.toDouble() ?? 0.0;
  set waistCircum(double v) => d?['obwod_w_pasie'] = v;

  double get headCircum => d?['obwod_glowy']?.toDouble() ?? 0.0;
  set headCircum(double v) => d?['obwod_glowy'] = v;

  double get neckCircum => d?['obwod_szyi']?.toDouble() ?? 0.0;
  set neckCircum(double v) => d?['obwod_szyi'] = v;

  String get handSize => d?['rozmiar_dloni'] ?? '';
  set handSize(String v) => d?['rozmiar_dloni'] = v;
}

mixin TAddress2 on TBase {
  String get province => d?['wojewodztwo'] ?? '';
  set province(String v) => d?['wojewodztwo'] = v;

  String get district => d?['powiat'] ?? '';
  set district(String v) => d?['powiat'] = v;

  String get commune => d?['gmina'] ?? '';
  set commune(String v) => d?['gmina'] = v;
}

mixin TDate on TBase {
  String get dateStart => d?['date_start'] ?? '';
  set dateStart(String dateStart) => d?['date_start'] = dateStart;

  String get dateEnd => d?['date_end'] ?? '';
  set dateEnd(String dateEnd) => d?['date_end'] = dateEnd;

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
  double get netPrice => d?['cena_n'] ?? 0;
  set netPrice(double v) => d?['cena_n'] = v;

  double get grossPrice => d?['cena_b'] ?? 0;
  set grossPrice(double v) => d?['cena_b'] = v;

  double get vatPrice => d?['cena_v'] ?? 0;
  set vatPrice(double v) => d?['cena_v'] = v;

  double get vatRate => d?['stawka_vat'] ?? 0;
  set vatRate(double v) => d?['stawka_vat'] = v;

  double get netTotal => d?['wartosc_n'] ?? 0;
  set netTotal(double v) => d?['wartosc_n'] = v;

  double get grossTotal => d?['wartosc_b'] ?? 0;
  set grossTotal(double v) => d?['wartosc_b'] = v;

  double get vatTotal => d?['wartosc_v'] ?? 0;
  set vatTotal(double v) => d?['wartosc_v'] = v;

  double get qty => d?['ilosc'] ?? 0;
  set qty(double v) => d?['ilosc'] = v;
}

class Product extends TBase with TPrice, TBase2 {
  const Product(super._d);

  String get unit => d?['jm'] ?? '';
  set unit(String v) => d?['jm'] = v;

  String get symbol => d?['symbol'] ?? '';
  set symbol(String v) => d?['symbol'] = v;
}
