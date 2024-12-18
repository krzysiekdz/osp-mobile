part of '../index.dart';

abstract class BaseFormCubit<T extends TBase> extends Cubit<AppFormState<T>> {
  late final Repository<T> repo;
  final bool fetchOnInit;
  dynamic id;
  Map<String, dynamic>? params;
  final List<Future<T>> _pendingTasks = [];
  final formChanges = StreamController<_FormChanges<T>>();
  final formChangesDelay = 200;
  BaseFormCubit(
      {this.fetchOnInit = true,
      AppFormState<T>? initialState,
      this.id,
      this.params})
      : super(initialState ??
            AppFormState<T>(
                phase: (fetchOnInit && id != null)
                    ? AppFormPhase.fetch
                    : AppFormPhase.data));

  void init() {
    repo = createRepo();
    formChanges.stream
        .debounceTime(Duration(milliseconds: formChangesDelay))
        .listen((fc) => updateFormNow(fc.current, fc.buffer));
    if (fetchOnInit && id != null) fetch();
  }

  void setId(id) {
    this.id = id;
  }

  void setParams(Map<String, dynamic> params) {
    this.params = params;
  }

  Repository<T> createRepo();

  T createBuffer() => repo.createElement({});

  void fetch() async {
    _cancelPendingTasks();
    emit(state.copyWith(phase: AppFormPhase.fetch, clearError: true));
    late Future<T> pendingTask;
    try {
      pendingTask = repo.get(id: id, params: params ?? {});
      _pendingTasks.add(pendingTask);
      final T item = await pendingTask;
      if (isClosed) return;
      emit(state.copyWith(
          initial: item,
          current: repo.copy(item),
          buffer: createBuffer(),
          phase: AppFormPhase.data));
    } on RepositoryException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        phase: AppFormPhase.fetchError,
        err: e,
      ));
    } finally {
      _pendingTasks.remove(pendingTask);
    }
  }

  void _cancelPendingTasks() {
    for (var task in _pendingTasks) {
      task.ignore();
    }
    _pendingTasks.clear();
  }

  @override
  void onChange(Change<AppFormState<T>> change) {
    super.onChange(change);
  }

  Future<bool> save() async {
    if (state.buffer == null || state.initial == null) return false;
    _cancelPendingTasks();
    emit(state.copyWith(phase: AppFormPhase.dataSave, clearError: true));
    late Future<T> pendingTask;
    try {
      final id = state.initial!.id;
      if (id != 0) {
        pendingTask = repo.update(state.buffer!, params: {'id': id});
      } else {
        pendingTask = repo.create(state.buffer!);
      }
      _pendingTasks.add(pendingTask);
      await pendingTask;
      if (isClosed) return true;
      emit(state.copyWith(phase: AppFormPhase.dataSaveSuccess));
      return true;
    } on RepositoryException catch (e) {
      if (!isClosed) {
        emit(state.copyWith(
          phase: AppFormPhase.dataSaveError,
          err: e,
        ));
      }
      return false;
    } finally {
      if (!isClosed) {
        _pendingTasks.remove(pendingTask);
      }
    }
  }

  void updateForm(T current, T buffer) {
    formChanges.add(_FormChanges(current, buffer));
  }

  void updateFormNow(T current, T buffer) {
    emit(state.copyWith(current: current, buffer: buffer));
    // print(state);
  }
}

enum AppFormPhase {
  fetch,
  fetchError,
  data,
  dataSave,
  dataSaveError,
  dataSaveSuccess,
}

class AppFormState<T extends TBase> {
  final T? initial; //initial object
  final T? current; //current object
  final T? buffer; //data ready to save (only changes)
  final AppFormPhase phase;
  final RepositoryException? err;
  const AppFormState({
    this.current,
    this.initial,
    this.buffer,
    this.phase = AppFormPhase.data,
    this.err,
  });

  AppFormState<T> copyWith({
    T? initial,
    T? current,
    T? buffer,
    AppFormPhase? phase,
    RepositoryException? err,
    bool? clearError,
  }) =>
      AppFormState<T>(
        initial: initial ?? this.initial,
        current: current ?? this.current,
        buffer: buffer ?? this.buffer,
        phase: phase ?? this.phase,
        err: clearError == true ? null : (err ?? this.err),
      );

  bool get isError => err != null ? true : false;

  bool get isDirty => !(buffer?.isEmpty() ?? true);

  @override
  String toString() {
    return "buffer: ${buffer?.d.toString() ?? ''}";
  }
}

class _FormChanges<T> {
  final T current;
  final T buffer;
  const _FormChanges(this.current, this.buffer);
}
