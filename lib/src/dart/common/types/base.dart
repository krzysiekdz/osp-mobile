part of '../index.dart';

class TBase {
  final Map<String, dynamic>? _d;
  const TBase(this._d);

  dynamic get id => _d?['id'] ?? 0;
  set id(dynamic id) => _d?['id'] = id;

  Map<String, dynamic>? get d => _d;

  Map<String, dynamic>? copy() =>
      d?.map<String, dynamic>((i, v) => MapEntry(i, v));

  Map<String, dynamic>? copyWith(Map<String, dynamic> other) =>
      d?.map<String, dynamic>((i, v) =>
          other.containsKey(i) ? MapEntry(i, other[i]) : MapEntry(i, v));

  bool isEmpty() => d?.isEmpty ?? true;
}

class TDict {
  final dynamic value;
  final String text;
  const TDict({this.value = '', this.text = ''});
  TDict.json(Map<String, dynamic>? json)
      : value = json?['value'] ?? '',
        text = json?['text'] ?? '';

  TDict.json2(Map<String, dynamic>? json)
      : value = json?['ident'] ?? '',
        text = json?['nazwa'] ?? '';

  static TDict find(List<TDict> list, dynamic value,
      [String notFoundText = '']) {
    return list.firstWhere((e) => e.value == value,
        orElse: () => TDict(text: notFoundText));
  }

  @override
  String toString() {
    return "TDict($text : $value)";
  }
}

mixin TBase2 on TBase {
  String get nazwa => _d?['nazwa'] ?? '';
  set nazwa(String nazwa) => _d?['nazwa'] = nazwa;

  String get uwagi => _d?['uwagi'] ?? '';
  set uwagi(String uwagi) => _d?['uwagi'] = uwagi;
}

mixin TPerson on TBase {
  String get imie => _d?['imie'] ?? '';
  set imie(String imie) => _d?['imie'] = imie;

  String get drugieImie => _d?['drugie_imie'] ?? '';
  set drugieImie(String imie) => _d?['drugie_imie'] = imie;

  String get nazwisko => _d?['nazwisko'] ?? '';
  set nazwisko(String nazwisko) => _d?['nazwisko'] = nazwisko;
}

mixin TAdres on TBase {
  String get miejscowosc => _d?['miejscowosc'] ?? '';
  set miejscowosc(String miejscowosc) => _d?['miejscowosc'] = miejscowosc;

  String get ulica => _d?['ulica'] ?? '';
  set ulica(String ulica) => _d?['ulica'] = ulica;

  String get nrBudynku => _d?['nr_budynku'] ?? '';
  set nrBudynku(String nrBudynku) => _d?['nr_budynku'] = nrBudynku;

  String get kodPocztowy => _d?['kod_pocztowy'] ?? '';
  set kodPocztowy(String kodPocztowy) => _d?['kod_pocztowy'] = kodPocztowy;

  String get poczta => _d?['poczta'] ?? '';
  set poczta(String poczta) => _d?['poczta'] = poczta;
}

mixin TType on TBase {
  String get type => _d?['type'] ?? '';
  set type(String type) => _d?['type'] = type;
}

mixin TTypeI on TBase {
  int get type => _d?['type'] ?? '';
  set type(int type) => _d?['type'] = type;
}

mixin TStatus on TBase {
  int get status => _d?['status'] ?? '';
  set status(int status) => _d?['status'] = status;
}

mixin TContact on TBase {
  String get email => _d?['email'] ?? '';
  set email(String email) => _d?['email'] = email;

  String get nrTel => _d?['nr_tel'] ?? '';
  set nrTel(String nrTel) => _d?['nr_tel'] = nrTel;

  String get nrTel2 => _d?['nr_tel2'] ?? '';
  set nrTel2(String nrTel2) => _d?['nr_tel2'] = nrTel2;
}

mixin TWymiary on TBase {
  double get wzrost => _d?['wzrost']?.toDouble() ?? 0.0;
  set wzrost(double wzrost) => _d?['wzrost'] = wzrost;

  double get nrButa => _d?['numer_buta']?.toDouble() ?? 0.0;
  set nrButa(double numer_buta) => _d?['numer_buta'] = numer_buta;

  double get obWKlatcePiers =>
      _d?['obwod_w_klatce_piersiowej']?.toDouble() ?? 0.0;
  set obWKlatcePiers(double obwod_w_klatce_piersiowej) =>
      _d?['obwod_w_klatce_piersiowej'] = obwod_w_klatce_piersiowej;

  double get obWPasie => _d?['obwod_w_pasie']?.toDouble() ?? 0.0;
  set obWPasie(double obwod_w_pasie) => _d?['obwod_w_pasie'] = obwod_w_pasie;

  double get obwodGlowy => _d?['obwod_glowy']?.toDouble() ?? 0.0;
  set obwodGlowy(double obwod_glowy) => _d?['obwod_glowy'] = obwod_glowy;

  double get obwodSzyi => _d?['obwod_szyi']?.toDouble() ?? 0.0;
  set obwodSzyi(double obwod_szyi) => _d?['obwod_szyi'] = obwod_szyi;

  String get rozmiarRloni => _d?['rozmiar_dloni'] ?? '';
  set rozmiarRloni(String rozmiar_dloni) =>
      _d?['rozmiar_dloni'] = rozmiar_dloni;
}

mixin TAdres2 on TBase {
  String get wojewodztwo => _d?['wojewodztwo'] ?? '';
  set wojewodztwo(String wojewodztwo) => _d?['wojewodztwo'] = wojewodztwo;

  String get powiat => _d?['powiat'] ?? '';
  set powiat(String powiat) => _d?['powiat'] = powiat;

  String get gmina => _d?['gmina'] ?? '';
  set gmina(String gmina) => _d?['gmina'] = gmina;
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
