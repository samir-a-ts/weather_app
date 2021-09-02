import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/errors/errors.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

abstract class LocalWeatherDataSource {
  /// Loads saved forecasts on device.
  /// Requires nothing.
  /// Returns [list<Forecast>].s
  Future<List<Forecast>> loadSavedForecast();

  /// Saves list of forecasts.
  /// Requires index of saving and the forecast.
  /// Returns nothing.
  Future<void> saveForecast(List<Forecast> forecast);
}

class LocalWeatherDataSourceImpl extends LocalWeatherDataSource {
  final SharedPreferences _sharedPreferences;

  LocalWeatherDataSourceImpl(this._sharedPreferences);

  @override
  Future<void> saveForecast(List<Forecast> forecast) async {
    /// Migrate forecast from entity
    /// to JSON, then stringifined JSON,
    /// and then saving it locally.
    final list = forecast
        .map<String>(
          (e) => jsonEncode(e.toJSON()),
        )
        .toList();

    await _sharedPreferences.setStringList(StorageKeys.weatherKey, list);
  }

  @override
  Future<List<Forecast>> loadSavedForecast() async {
    /// Reading serialised JSON, migrating
    /// it to Map and then representing it
    /// in [Forecast] entity.
    final list = _sharedPreferences.getStringList(StorageKeys.weatherKey);

    if (list == null) throw ForecastNotExist();

    final forecasts = list.map<Forecast>((e) {
      final json = jsonDecode(e) as Map<String, dynamic>;

      final forecast = Forecast.fromAppJSON(json);

      return forecast;
    }).toList();

    return forecasts;
  }
}
