part of '../index.dart';

//api glowne; jest po to, aby pobrac z providera service dla api glownego i przekazac okreslonemu cubitowi;
//moze istniec kilka api service wiec trzeba wskazac ktore, ale bez wskazania konkretnej implementacji
abstract interface class Api1Service implements ApiService {}

// wykorzystanie dio api service jako serwisu do głównego api
class DioApi1Service extends DioApiService<Api1Response>
    implements Api1Service {
  @override
  String createBaseUrl() => AppConfigService.getConfig().url;

  @override
  Api1Response mapResponse(dio.Response? response) {
    final statusCode = response?.statusCode ?? 500;
    if (statusCode < 500) {
      return Api1Response(
        response?.data,
        statusCode: statusCode,
        statusMsg: response?.statusMessage ?? 'Nieznany błąd',
      );
    } else {
      return Api1Response(
        null,
        statusCode: statusCode,
        statusMsg: 'Błąd serwera',
      );
    }
  }
}

//moglbym tez w inny sposob zaimplementowac Api1Service
