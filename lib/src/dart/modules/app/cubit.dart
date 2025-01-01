part of 'index.dart';

const authUrl = 'v1/system/sessions';

abstract class AppCubit extends Cubit<AppState> {
  final Api1Service apiService;
  late Storage storageService;
  String? _token;
  AppCubit({required this.apiService}) : super(const AppStateInitial());

  Future<Storage> createStorage();

  void init() async {
    emit(const AppStateInitial());
    storageService = await createStorage();
    _token = await storageService.read('token');
    await Future.delayed(const Duration(seconds: 1));
    if (_token == null || _token == '') {
      emit(const AppStateLogin());
    } else {
      var res = await apiService.put(
          endpoint: '$authUrl/$_token', params: {'refresh': 1}) as Api1Response;
      if (res.statusCode == 200) {
        _setMain(res);
      } else if (res.statusCode < 500) {
        await storageService.delete('token');
        emit(AppStateLogin(message: res.message));
      } else {
        await storageService.delete('token');
        emit(const AppStateLogin());
      }
    }
  }

  void login(String email, String password) async {
    emit(const AppStateLogin(isPending: true));
    var res = await apiService.post(endpoint: authUrl, params: {
      'email': email,
      'password': password,
    }) as Api1Response;
    if (res.statusCode == 200) {
      _token = res.data['token'];
      await storageService.write('token', _token);
      _setMain(res);
    } else if (res.statusCode < 500) {
      emit(AppStateLogin(message: res.message));
    } else {
      emit(const AppStateLogin(message: 'Błąd serwera'));
    }
  }

  void logout() async {
    emit(const AppStateInitial());
    await apiService.delete(endpoint: authUrl)
        as Api1Response; //TODO: api zwrocilo blad
    apiService.removeParam('token');
    await storageService.delete('token');
    emit(const AppStateLogin());
  }

  void _setMain(Api1Response res) {
    apiService.addParam('token', _token);
    emit(AppSession(res));
  }

  void replaceMenuConfig(List<RouteName> menuBottomConfig) {
    if (state is AppSession) {
      emit((state as AppSession).copyWith(menuBottomConfig: menuBottomConfig));
    }
  }

  @override
  void onChange(Change<AppState> change) {
    super.onChange(change);
    print(change);
  }
}
