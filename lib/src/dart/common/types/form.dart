part of '../index.dart';

enum AppFormType { create, update }

class AppFormParams<T extends TBase> {
  final dynamic id;
  final T? item;
  final bool doRepoAction;
  final AppFormType formType;
  const AppFormParams(
      {this.id,
      this.item,
      this.doRepoAction = true,
      this.formType = AppFormType.update});
}
