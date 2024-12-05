part of '../index.dart';

abstract class Api1FormCubit<T> extends BaseFormCubit<T> {
  Api1Service apiService;
  Api1FormCubit(this.apiService,
      {super.initialState, super.fetchOnInit, super.id, super.params});
}
