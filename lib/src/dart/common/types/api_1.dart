part of '../index.dart';

class Api1Response extends Response {
  Api1Response(super.d, {required super.statusCode, super.statusMsg = ''});

  int get count => d?['count'] ?? 0;

  String get message => d?['messages']?[0] ?? statusMsg;

  List<String> get messages => d?['messages'] ?? [];

  Map<String, dynamic> get extra => d?['extra'] ?? {};

  Map<String, dynamic> get data => d?['data'] ?? {};

  List<dynamic> get dataArray => d?['data'] ?? [];

  Map<String, dynamic> get temp => d?['temp'] ?? {};

  dynamic get dict => d?['temp']?['dict'] ?? {};
}
