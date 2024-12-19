part of '../index.dart';

class AppRegistry extends InheritedWidget {
  AppRegistry({super.key, required super.child});

  final Map<dynamic, dynamic> registry = {};

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static AppRegistry? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppRegistry>();
  }

  static AppRegistry of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No AppRegistry found in context');
    return result!;
  }
}
