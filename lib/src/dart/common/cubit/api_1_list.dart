part of '../index.dart';

abstract class Api1ListCubit<T> extends BaseListCubit<T> {
  Api1Service apiService;
  Api1ListCubit(this.apiService, {super.initialState, super.fetchOnInit});
}

// class Api1ListState<T> extends ListState<T> {}
