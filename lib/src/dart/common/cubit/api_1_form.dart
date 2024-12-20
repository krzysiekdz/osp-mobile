part of '../index.dart';

abstract class Api1FormCubit<T extends TBase> extends BaseFormCubit<T> {
  Api1Service apiService;
  Api1FormCubit(this.apiService,
      {super.initialState, required super.formParams, super.params});
}
