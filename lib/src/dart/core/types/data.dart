part of '../index.dart';

// operacje na źródle pewnego typu danych; T może tez byc typem zlozonym i miec zdefiniowane np create oraz edit , bez list i get
abstract class Repository<T> {
  Future<List<T>> list(
      {int offset = 0,
      int limit = 20,
      Map<String, dynamic> params = const {}}) {
    throw UnimplementedError();
  }

  Future<T> get({dynamic id, Map<String, dynamic> params = const {}}) {
    throw UnimplementedError();
  }

  Future<T> create(T data, {Map<String, dynamic> params = const {}}) {
    throw UnimplementedError();
  }

  //data - obiekt zawiera mapę (jeśli TBase) - tylko pola, ktore rzeczywiscie są edytowane, nie musza to byc wszystkie pola obiektu
  Future<T> update(T data, {Map<String, dynamic> params = const {}}) {
    throw UnimplementedError();
  }

  Future<T> delete({dynamic id, Map<String, dynamic> params = const {}}) {
    throw UnimplementedError();
  }

  T createElement(Map<String, dynamic> data) => throw UnimplementedError();

  T copy(T data) => throw UnimplementedError();
}

class RepositoryException implements Exception {
  final String msg;
  final int code;
  const RepositoryException(this.msg, {this.code = 0});
}

abstract interface class ApiService {
  Future<Response> get(
      {required String endpoint, Map<String, dynamic> params = const {}});
  Future<Response> post(
      {required String endpoint, Map<String, dynamic> params = const {}});
  Future<Response> put(
      {required String endpoint, Map<String, dynamic> params = const {}});
  Future<Response> delete(
      {required String endpoint, Map<String, dynamic> params = const {}});
  void addParam(String key, dynamic value);
  void removeParam(String key);
}

abstract interface class Storage<T> {
  Future<void> write(String key, T value);
  Future<T?> read(String key);
  Future<void> delete(String key);
}
