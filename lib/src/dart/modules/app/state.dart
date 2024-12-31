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
  final List<DictPair> firemen;
  final List<DictPair> firemanRank;
  final List<DictPair> boardOf;
  final List<DictPair> committee;
  final List<DictPair> education;

  AppSession(Api1Response res)
      : session = Session(res.data),
        user = User(res.temp['user']),
        menuBottomConfig = cMenuBottomConfig,
        firemen = [],
        firemanRank = [],
        boardOf = [],
        committee = [],
        education = [],
        license = License(res.temp['licenses']?[0]) {
    for (var s in res.temp['strazacy']) {
      firemen.add(DictPair.json(s));
    }
    for (var s in res.dict['strazak_stopien']) {
      firemanRank.add(DictPair.json2(s));
    }
    for (var v in res.dict['zarzad']) {
      boardOf.add(DictPair.json2(v));
    }
    for (var v in res.dict['komisja']) {
      committee.add(DictPair.json2(v));
    }
    for (var v in res.dict['wyksztalcenie']) {
      education.add(DictPair.json2(v));
    }
  }

  AppSession._({
    required this.session,
    required this.user,
    required this.license,
    required this.firemen,
    required this.boardOf,
    required this.education,
    required this.committee,
    required this.firemanRank,
    required this.menuBottomConfig,
  });

  AppSession copyWith({
    Session? session,
    User? user,
    License? license,
    List<OspRouteName>? menuBottomConfig,
    List<DictPair>? firemen,
    List<DictPair>? firemanRank,
  }) {
    return AppSession._(
      session: session ?? this.session,
      user: user ?? this.user,
      license: license ?? this.license,
      boardOf: boardOf,
      committee: committee,
      education: education,
      firemen: firemen ?? this.firemen,
      firemanRank: firemanRank ?? this.firemanRank,
      menuBottomConfig: menuBottomConfig ?? this.menuBottomConfig,
    );
  }
}
