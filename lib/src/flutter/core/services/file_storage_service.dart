part of '../index.dart';

//zapisanie za pomoca file storage obiektow danych; jako mapy? spr jakie obiekty pobieram z api
//aplikacja przy ponownym uruchomieniu wysyla token i sprawdza czy jest nadal zalogowana
//po stronie api zrobic odswiezenie tokenu?
//jesli jest zalogowany, to pobieram dane z file storage i mam je zapisane w jakims local storage
//gdzie mam szybki dostep; sa tylko do odczytu
class FileStorageService implements Storage<String> {
  @override
  Future<void> delete(String key) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<String?> read(String key) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> write(String key, String value) {
    // TODO: implement write
    throw UnimplementedError();
  }
}
