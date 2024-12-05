part of '../index.dart';

// kazda implementacja repository jest unikalna, bo np. wymaga specyficznych parametrow dla źródła danych
abstract class Api1Repository<T extends TBase> extends Repository<T> {
  late final Api1Service apiService;
  String get endpoint;

  Api1Repository(this.apiService);

  T createElement(Map<String, dynamic> data);

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
}
