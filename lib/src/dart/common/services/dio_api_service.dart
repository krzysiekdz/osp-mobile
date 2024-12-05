part of '../index.dart';

//api service na bazie Dio
abstract class DioApiService<R extends Response> implements ApiService {
  late final String baseUrl;
  final Map<String, dynamic> _params = {};
  final dio.Dio _dio = dio.Dio();

  DioApiService() {
    baseUrl = createBaseUrl();
  }

  String createBaseUrl();

  @override
  Future<R> get(
      {required String endpoint,
      Map<String, dynamic> params = const {}}) async {
    try {
      final p = Map<String, dynamic>.from(_params);
      p.addAll(params);
      if (kShowDebugInfo) log('dio GET: $endpoint , params: $p');
      final response = await _dio.get(
        '$baseUrl/$endpoint',
        queryParameters: p,
      );
      return mapResponse(response);
    } on dio.DioException catch (e) {
      return mapResponse(e.response);
    }
  }

  @override
  Future<R> post(
      {required String endpoint,
      Map<String, dynamic> params = const {}}) async {
    try {
      final p = Map<String, dynamic>.from(_params);
      p.addAll(params);
      if (kShowDebugInfo) log('dio POST: $endpoint , params: $p');
      final response = await _dio.post(
        '$baseUrl/$endpoint',
        data: p,
      );
      return mapResponse(response);
    } on dio.DioException catch (e) {
      return mapResponse(e.response);
    }
  }

  @override
  Future<R> put(
      {required String endpoint,
      Map<String, dynamic> params = const {}}) async {
    try {
      final p = Map<String, dynamic>.from(_params);
      p.addAll(params);
      if (kShowDebugInfo) log('dio PUT: $endpoint , params: $p');
      final response = await _dio.put(
        '$baseUrl/$endpoint',
        data: p,
      );
      return mapResponse(response);
    } on dio.DioException catch (e) {
      return mapResponse(e.response);
    }
  }

  @override
  Future<R> delete(
      {required String endpoint,
      Map<String, dynamic> params = const {}}) async {
    try {
      final p = Map<String, dynamic>.from(_params);
      p.addAll(params);
      if (kShowDebugInfo) log('dio DELETE: $endpoint , params: $p');
      final response = await _dio.delete(
        '$baseUrl/$endpoint',
        data: p,
      );
      return mapResponse(response);
    } on dio.DioException catch (e) {
      return mapResponse(e.response);
    }
  }

  @override
  void addParam(String key, dynamic value) {
    _params[key] = value;
  }

  @override
  void removeParam(String key) {
    _params.remove(key);
  }

  R mapResponse(dio.Response? response);
}
