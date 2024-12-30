part of 'index.dart';

abstract class AppState {
  const AppState();
}

class AppStateInitial extends AppState {
  final String error;
  const AppStateInitial({this.error = ''});
}

class AppStateLogin extends AppState {
  final String message;
  final bool isPending;
  const AppStateLogin({this.message = '', this.isPending = false});
}

class AppStateRegister extends AppState {}

class AppSession extends AppState {
  final Session session;
  final User user;
  final License license;
  final List<OspRouteName> menuBottomConfig;
  final List<DictPair> strazacy;
  final List<DictPair> strazakStopien;
  final List<DictPair> zarzad;
  final List<DictPair> komisja;
  final List<DictPair> wyksztalcenie;

  AppSession(Api1Response res)
      : session = Session(res.data),
        user = User(res.temp['user']),
        menuBottomConfig = cMenuBottomConfig,
        strazacy = [],
        strazakStopien = [],
        zarzad = [],
        komisja = [],
        wyksztalcenie = [],
        license = License(res.temp['licenses']?[0]) {
    for (var s in res.temp['strazacy']) {
      strazacy.add(DictPair.json(s));
    }
    for (var s in res.dict['strazak_stopien']) {
      strazakStopien.add(DictPair.json2(s));
    }
    for (var v in res.dict['zarzad']) {
      zarzad.add(DictPair.json2(v));
    }
    for (var v in res.dict['komisja']) {
      komisja.add(DictPair.json2(v));
    }
    for (var v in res.dict['wyksztalcenie']) {
      wyksztalcenie.add(DictPair.json2(v));
    }
  }

  AppSession._({
    required this.session,
    required this.user,
    required this.license,
    required this.strazacy,
    required this.zarzad,
    required this.wyksztalcenie,
    required this.komisja,
    required this.strazakStopien,
    required this.menuBottomConfig,
  });

  AppSession copyWith({
    Session? session,
    User? user,
    License? license,
    List<OspRouteName>? menuBottomConfig,
    List<DictPair>? strazacy,
    List<DictPair>? strazakStopien,
  }) {
    return AppSession._(
      session: session ?? this.session,
      user: user ?? this.user,
      license: license ?? this.license,
      zarzad: zarzad,
      komisja: komisja,
      wyksztalcenie: wyksztalcenie,
      strazacy: strazacy ?? this.strazacy,
      strazakStopien: strazakStopien ?? this.strazakStopien,
      menuBottomConfig: menuBottomConfig ?? this.menuBottomConfig,
    );
  }
}
