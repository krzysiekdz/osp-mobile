part of '../index.dart';

// kazda implementacja repository jest unikalna, bo np. wymaga specyficznych parametrow dla źródła danych
abstract class Api1Repository<T extends TBase> extends Repository<T> {
  late final Api1Service apiService;
  String get endpoint;

  Api1Repository(this.apiService);

  @override
  T copy(T data) {
    return createElement(data.copy() ?? {});
  }

  @override
  Future<T> get({id, Map<String, dynamic> params = const {}}) async {
    Api1Response res = await apiService.get(
        endpoint: '$endpoint/$id', params: params) as Api1Response;
    if (res.isOk) {
      return createElement(res.data);
    }
    throw RepositoryException(res.message, code: res.statusCode);
  }

  @override
  Future<List<T>> list(
      {int offset = 0,
      int limit = 20,
      Map<String, dynamic> params = const {}}) async {
    final p = Map<String, dynamic>.from(params);
    p['offset'] = offset;
    p['limit'] = limit;
    Api1Response res =
        await apiService.get(endpoint: endpoint, params: p) as Api1Response;
    if (res.isOk) {
      List<T> data = [];
      for (var e in res.dataArray) {
        data.add(createElement(e));
      }
      return data;
    }
    throw RepositoryException(res.message, code: res.statusCode);
  }

  @override
  Future<T> update(T data, {Map<String, dynamic> params = const {}}) async {
    final p = Map<String, dynamic>.from(data.d ?? {});
    p.addAll(params);
    final id = p['id'] ?? 0;
    if (id == 0) {
      throw const RepositoryException("Nie przekazano ID", code: 400);
    }
    p.remove('id');

    Api1Response res = await apiService.put(
        endpoint: '$endpoint/$id', params: p) as Api1Response;
    if (res.isOk) {
      return createElement(res.data);
    }
    throw RepositoryException(res.message, code: res.statusCode);
  }

  @override
  Future<T> create(T data, {Map<String, dynamic> params = const {}}) async {
    final p = Map<String, dynamic>.from(data.d ?? {});
    p.addAll(params);

    Api1Response res =
        await apiService.post(endpoint: endpoint, params: p) as Api1Response;
    if (res.isOk) {
      return createElement(res.data);
    }
    throw RepositoryException(res.message, code: res.statusCode);
  }
}
