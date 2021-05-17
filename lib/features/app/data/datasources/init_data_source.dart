import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constans/constants.dart';
import '../../domain/entities/settings.dart';

abstract class InitDataSource {
  /// Method for finding out, is
  /// user entered the app for the
  /// first time.
  Future<bool> isUserNew();

  /// Method for loading settings.
  /// Requires nothing.
  /// Return [Settings].
  Future<Settings> loadSettings();

  /// Method for saving settings on phone.
  /// Requires [Settings].
  /// Return nothing.
  Future<void> saveSettings(Settings settings);
}

class InitDataSourceImpl extends InitDataSource {
  final SharedPreferences _sharedPreferences;

  InitDataSourceImpl(this._sharedPreferences);

  @override
  Future<bool> isUserNew() async {
    /// Reads first entry data.
    final result = _sharedPreferences.getBool(StorageKeys.initKey);

    /// If there is no value,
    /// writing data and returning false.
    if (result == null) {
      await _sharedPreferences.setBool(StorageKeys.initKey, true);

      return false;
    }

    /// Or-else returning true.
    return true;
  }

  @override
  Future<Settings> loadSettings() async {
    /// Reads first entry data.
    final result = _sharedPreferences.getString(StorageKeys.settingsKey);

    /// If there is no value,
    /// writing data and returning false.
    if (result == null) {
      final initial = Settings.initial();

      _sharedPreferences.setString(
          StorageKeys.settingsKey, jsonEncode(initial.toJSON()));

      return initial;
    }

    final settings =
        Settings.fromJSON(jsonDecode(result) as Map<String, dynamic>);

    /// Or-else returning true.
    return settings;
  }

  @override
  Future<void> saveSettings(Settings settings) async {
    await _sharedPreferences.setString(
        StorageKeys.settingsKey, jsonEncode(settings.toJSON()));
  }
}
