part of '../index.dart';

abstract class BaseFormCubit<T extends TBase> extends Cubit<AppFormState<T>> {
  late final Repository<T> repo;
  final AppFormParams<T> formParams;
  Map<String, dynamic>? params;
  final List<Future<T>> _pendingTasks = [];
  final formChanges = StreamController<_FormChanges<T>>();
  final formChangesDelay = 200;
  bool _inited = false;
  BaseFormCubit(
      {AppFormState<T>? initialState, required this.formParams, this.params})
      : super(initialState ?? AppFormState<T>(phase: AppFormPhase.data));

  //callable only once
  void init() {
    if (_inited) return;
    _inited = true;
    repo = createRepo();
    formChanges.stream
        .debounceTime(Duration(milliseconds: formChangesDelay))
        .listen((fc) => updateFormNow(fc.current, fc.buffer));
    if (fetchOnInit) {
      fetch();
    } else if (formParams.item != null) {
      _setItem(formParams.item!);
    } else {
      _setItem(repo.createElement({}));
    }
  }

  // nie musi byc tylko dla 'update', bo dla 'create' mozna pobierac w ten sposob domyslny obiekt z repo, np dla id=0
  // teoretycznie mozna tez przekazac item i wtedy nalezy zrobic merge na przekazanym item oraz obiekcie pobranym z repo
  bool get fetchOnInit => (formParams.id != null);

  //dodatkowe parametry do repo
  void setParams(Map<String, dynamic> params) {
    this.params = params;
  }

  Repository<T> createRepo();

  T createBuffer() => repo.createElement({});

  T copyItem(T item) => repo.copy(item);

  void _setItem(T item) {
    emit(state.copyWith(
        initial: item,
        current: copyItem(item),
        buffer: createBuffer(),
        phase: AppFormPhase.data));
  }

  void fetch() async {
    _cancelPendingTasks();
    emit(state.copyWith(phase: AppFormPhase.fetch, clearError: true));
    late Future<T> pendingTask;
    try {
      pendingTask = repo.get(id: formParams.id, params: params ?? {});
      _pendingTasks.add(pendingTask);
      final T item = await pendingTask;
      if (isClosed) return;
      if (formParams.item != null) {
        final item2 = copyItem(formParams.item!);
        item2.merge(item);
        _setItem(item2);
      } else {
        _setItem(item);
      }
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

    //jesli nie wykonujemy operacji na repo - zwracamy sukces
    if (!formParams.doRepoAction) return true;

    _cancelPendingTasks();
    emit(state.copyWith(phase: AppFormPhase.dataSave, clearError: true));
    late Future<T> pendingTask;
    try {
      if (formParams.formType == AppFormType.update) {
        final id = state.initial!.id ?? formParams.id;
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
