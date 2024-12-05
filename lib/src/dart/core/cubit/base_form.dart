part of '../index.dart';

abstract class BaseFormCubit<T> extends Cubit<AppFormState<T>> {
  late final Repository<T> repo;
  final bool fetchOnInit;
  dynamic id;
  Map<String, dynamic>? params;
  //initialObject - dla trybu dodawania
  final List<Future<T>> pendingTasks = [];
  BaseFormCubit(
      {this.fetchOnInit = true,
      AppFormState<T>? initialState,
      this.id,
      this.params})
      : super(initialState ?? AppFormState<T>());

  void init() {
    repo = createRepo();
    if (fetchOnInit && id != null) fetchItem();
  }

  void setId(id) {
    this.id = id;
  }

  void setParams(Map<String, dynamic> params) {
    this.params = params;
  }

  Repository<T> createRepo();

  void fetchItem() async {
    _cancelPendingTasks();
    emit(state.copyWith(isPending: true, clearError: true));
    late Future<T> pendingTask;
    try {
      pendingTask = repo.get(id: id, params: params ?? {});
      pendingTasks.add(pendingTask);
      final T item = await pendingTask;
      if (isClosed) return;
      emit(state.copyWith(item: item, isPending: false));
    } on RepositoryException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isPending: false, err: e, clearItem: true));
    } finally {
      pendingTasks.remove(pendingTask);
    }
  }

  void _cancelPendingTasks() {
    for (var task in pendingTasks) {
      task.ignore();
    }
    pendingTasks.clear();
  }

  @override
  void onChange(Change<AppFormState<T>> change) {
    super.onChange(change);
  }
}

class AppFormState<T> {
  final T? item;
  final bool isPending;
  final RepositoryException? err;
  const AppFormState({
    this.item,
    this.isPending = false,
    this.err,
  });

  AppFormState<T> copyWith(
          {T? item,
          bool? isPending,
          RepositoryException? err,
          bool? clearError,
          bool? clearItem}) =>
      AppFormState<T>(
        item: clearItem == true ? null : (item ?? this.item),
        isPending: isPending ?? this.isPending,
        err: clearError == true ? null : (err ?? this.err),
      );

  bool get isError => err != null ? true : false;
}
