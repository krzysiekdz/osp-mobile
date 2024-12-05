part of '../index.dart';

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Podaj email';
  }
  final result = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  return result ? null : 'Niepoprawny email';
}
