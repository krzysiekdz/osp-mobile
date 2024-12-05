part of 'index.dart';

class OspAppCubit extends AppCubit {
  OspAppCubit({required super.apiService});

  @override
  Future<Storage> createStorage() async {
    return await SharedPrefStringService.getInstance();
  }
}
