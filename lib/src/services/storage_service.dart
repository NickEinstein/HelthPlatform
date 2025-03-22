import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  String getString(String key, {String defaultValue = ''});

  Future<void> setString(String key, String value);

  int getInt(String key, {int defaultValue = 0});

  Future<void> setInt(String key, int value);

  bool getBool(String key, {bool defaultValue = false});

  Future<void> setBool(String key, bool value);

  double getDouble(String key, {double defaultValue = 0.0});

  Future<void> setDouble(String key, double value);

  Future<void> remove(String key);

  Future<void> clear();
}

class StorageServiceImpl extends StorageService {
  late SharedPreferences _preferences;

  StorageServiceImpl._internal();

  factory StorageServiceImpl() {
    return _instance;
  }

  static final StorageServiceImpl _instance = StorageServiceImpl._internal();

  Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  String getString(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  @override
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  @override
  double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }

  @override
  Future<void> setDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await _preferences.clear();
  }
}

class SharedPreferencesService {
  SharedPreferences? _prefs;

  SharedPreferencesService._();

  static final SharedPreferencesService instance = SharedPreferencesService._();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  String? getString(String key) {
    return _prefs?.getString(key);
  }

  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs?.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs?.getDouble(key);
  }

  Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
