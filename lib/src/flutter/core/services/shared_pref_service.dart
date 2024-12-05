part of '../index.dart';

abstract class SharedPrefService<T> implements Storage<T> {
  final SharedPreferences _sharedPreferences;
  final String prefix;
  const SharedPrefService._(this._sharedPreferences, this.prefix);

  @override
  Future<void> delete(String key) async {
    await _sharedPreferences.remove("${prefix}_$key");
  }

  @override
  Future<void> write(String key, T value) async {
    key = "${prefix}_$key";
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else {
      throw Exception('Type not supported');
    }
  }
}

class SharedPrefStringService extends SharedPrefService<String> {
  SharedPrefStringService._(super.sharedPreferences, super.prefix) : super._();

  @override
  Future<String?> read(String key) async {
    return _sharedPreferences.getString("${prefix}_$key");
  }

  static SharedPrefStringService? _instance;

  static Future<SharedPrefStringService> getInstance() async {
    if (_instance == null) {
      var pref = await SharedPreferences.getInstance();
      _instance = SharedPrefStringService._(pref, 's');
    }
    return _instance!;
  }
}

class SharedPrefIntService extends SharedPrefService<int> {
  SharedPrefIntService._(super.sharedPreferences, super.prefix) : super._();

  @override
  Future<int?> read(String key) async {
    return _sharedPreferences.getInt("${prefix}_$key");
  }

  static SharedPrefIntService? _instance;

  static Future<SharedPrefIntService> getInstance() async {
    if (_instance == null) {
      var pref = await SharedPreferences.getInstance();
      _instance = SharedPrefIntService._(pref, 'i');
    }
    return _instance!;
  }
}
