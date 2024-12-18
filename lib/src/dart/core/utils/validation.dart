part of '../index.dart';

typedef AppTextFormValidator = String? Function(String? value);

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Podaj email';
  }
  final result = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  return result ? null : 'Niepoprawny email';
}

AppTextFormValidator notEmpty([String msg = 'Pole nie może być puste']) {
  return (String? v) {
    if (v == null || v.isEmpty) {
      return msg;
    }
    return null;
  };
}
