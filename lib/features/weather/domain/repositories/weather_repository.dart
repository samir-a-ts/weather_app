import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

/// Repository for managing weather data in
/// local (savings and some shit)
abstract class WeatherRepository {
  /// Loads saved forecasts on device.
  /// Requires nothing.
  /// Returns [list<Forecast>].s
  Future<Either<Failure, List<Forecast>>> loadSavedForecast();

  /// Saves list of forecasts.
  /// Requires index of saving and the forecast.
  /// Returns nothing.
  Future<Either<Failure, void>> saveForecast(List<Forecast> forecast);

  /// Loading forecast depending
  /// on location of user. (more concrete,
  /// the city user locating)
  /// Requires nothing.
  /// Returns [Forecast].
  Future<Either<Failure, Forecast>> loadForecastFromLocation();

  /// Loading forecast depending
  /// on city name we passed.
  /// Requires city name.
  /// Returns [Forecast].
  Future<Either<Failure, Forecast>> loadForecastFromCityName(String cityName);
}
