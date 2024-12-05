part of '../index.dart';

class Response {
  final int statusCode;
  final String statusMsg;
  final dynamic d;
  Response(this.d, {required this.statusCode, this.statusMsg = ''});

  bool get isOk => (statusCode >= 200) && (statusCode < 300);
}
