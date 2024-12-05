part of '../index.dart';

//to taki service sluzacy do operowania na liscie - posiada aktualny stan listy - wystarczy przekazac go warstwie prezentacji
//repository sluzy do pobrania listy, ale zapisanie stanu listy, strony, parametrow wyszukiwania itp - od tego jest ten service (cubit)
//cubit przechowuje aktualny stan listy oraz posiada operacje ktore zmieniaja ten stan
abstract class BaseListCubit<T> extends Cubit<ListState<T>> {
  late Repository<T> repo;
  bool fetchOnInit;
  final searchStreamCtrl = StreamController<String>();
  final int searchDebounceTime;
  final String? searchKey;
  final List<Future> pendingTasks = [];

  BaseListCubit(
      {this.fetchOnInit = true,
      this.searchDebounceTime = 500,
      this.searchKey = 'search',
      ListState<T>? initialState})
      : super(initialState ?? ListState<T>());

  void init() {
    repo = createRepo();
    searchStreamCtrl.stream
        .skip(1)
        .distinct()
        .debounceTime(Duration(milliseconds: searchDebounceTime))
        .listen((text) => searchImmediate(text));
    if (fetchOnInit) fetchInitialData();
  }

  Repository<T> createRepo();

  void fetchInitialData() async {
    _cancelPendingTasks();
    emit(state.copyWith(
        isPending: true, clearError: true, offset: 0, data: const []));
    late Future pendingTask;
    try {
      pendingTask = repo.list(offset: 0, limit: state.limit, params: params);
      pendingTasks.add(pendingTask);
      final data = await pendingTask;
      if (isClosed) return;
      emit(state.copyWith(
          data: data,
          isPending: false,
          isAllFetched: data.length < state.limit));
    } on RepositoryException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isPending: false, err: e, data: const []));
    } finally {
      pendingTasks.remove(pendingTask);
    }
  }

  void fetchNextData() async {
    if (state.isAllFetched || state.isPending) return;
    emit(state.copyWith(isPending: true, clearError: true));
    late Future pendingTask;
    try {
      pendingTask = repo.list(
          offset: state.offset + state.limit,
          limit: state.limit,
          params: params);
      pendingTasks.add(pendingTask);
      final data = await pendingTask;
      if (isClosed) return;
      emit(state.copyWith(
          data: state.data..addAll(data),
          isPending: false,
          offset: state.offset + state.limit,
          isAllFetched: data.length < state.limit));
    } on RepositoryException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isPending: false, err: e));
    } finally {
      pendingTasks.remove(pendingTask);
    }
  }

  void setFilter(String key, dynamic value) {
    emit(state.copyWith(params: {...state.params, key: value}));
  }

  void removeFilter(String key) {
    emit(state.copyWith(params: {...state.params}..remove(key)));
  }

  void updateFilters(Map<String, dynamic> filters) {
    emit(state.copyWith(params: {...state.params}..addAll(filters)));
    refresh();
  }

  void replaceFilters(Map<String, dynamic> filters) {
    emit(state.copyWith(params: filters));
    refresh();
  }

  void search(String text) {
    searchStreamCtrl.add(text);
  }

  void refresh() async {
    return fetchInitialData();
  }

  void searchImmediate(String text) {
    emit(state.copyWith(searchText: text));
    fetchInitialData();
  }

  Map<String, dynamic> get params {
    final p = Map<String, dynamic>.from(state.params);
    if (searchKey != null) {
      p[searchKey!] = state.searchText ?? '';
    }
    return p;
  }

  void _cancelPendingTasks() {
    for (var task in pendingTasks) {
      task.ignore();
    }
    pendingTasks.clear();
  }

  @override
  void onChange(Change<ListState<T>> change) {
    super.onChange(change);
    // print(change);
  }
}

class ListState<T> {
  final List<T> data;
  final int offset;
  final int limit;
  final String? searchText;
  final bool isPending;
  final bool isAllFetched;
  final Map<String, dynamic> params;
  final RepositoryException? err;

  const ListState({
    this.data = const [],
    this.isPending = false,
    this.offset = 0,
    this.limit = 30,
    this.searchText,
    this.isAllFetched = false,
    this.params = const {},
    this.err,
  });

  ListState<T> copyWith(
          {List<T>? data,
          bool? isPending,
          String? searchText,
          int? offset,
          int? limit,
          bool? isAllFetched,
          Map<String, dynamic>? params,
          RepositoryException? err,
          bool? clearError}) =>
      ListState<T>(
        data: data ?? this.data,
        isPending: isPending ?? this.isPending,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        searchText: searchText ?? this.searchText,
        params: params ?? this.params,
        isAllFetched: isAllFetched ?? this.isAllFetched,
        err: clearError == true ? null : (err ?? this.err),
      );

  bool get isError => err != null ? true : false;

  bool get isEmpty => data.isEmpty;

  int get dataCount => data.length;
}
