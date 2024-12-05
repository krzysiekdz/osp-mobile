part of '../index.dart';

extension StreamExtension<T> on Stream<T> {
  Stream<T> debounceTime(Duration duration) {
    return transform(DebounceTimeTransformer<T>(duration).build());
  }
}

class DebounceTimeTransformer<T> {
  final Duration duration;
  Timer? _timer;

  DebounceTimeTransformer(this.duration);

  StreamTransformer<T, T> build() {
    return StreamTransformer<T, T>.fromHandlers(handleData: (data, sink) {
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
      _timer = Timer(duration, () => sink.add(data));
    });
  }
}
