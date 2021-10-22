import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/errors.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/core/utils/network_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/local_weather_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/remote_weather_data_source.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepoistoryImpl extends WeatherRepository {
  final LocalWeatherDataSource _localWeatherDataSource;
  final RemoteWeatherDataSource _remoteWeatherDataSource;
  final NetworkDataSource _networkDataSource;

  WeatherRepoistoryImpl(this._localWeatherDataSource,
      this._remoteWeatherDataSource, this._networkDataSource);

  @override
  Future<Either<Failure, List<Forecast>>> loadSavedForecast() async {
    try {
      final result = await _localWeatherDataSource.loadSavedForecast();

      return Right(result);
    } on ForecastNotExist {
      return const Right([]);
    } catch (e) {
      return Left(WeatherFailure(I18n.savedForecastFailure));
    }
  }

  @override
  Future<Either<Failure, void>> saveForecast(List<Forecast> forecast) async {
    try {
      final result = await _localWeatherDataSource.saveForecast(forecast);

      return Right(result);
    } catch (e) {
      return Left(WeatherFailure(I18n.saveForecastFailure));
    }
  }

  @override
  Future<Either<Failure, Forecast>> loadForecastFromCityName(
      String cityName) async {
    try {
      if (await _networkDataSource.checkInternetConnection()) {
        final result =
            await _remoteWeatherDataSource.loadForecastFromCityName(cityName);

        return Right(result);
      } else {
        return Left(ConnectionFailure(I18n.noInternetConnection));
      }
    } on CityDoesNotExistsException {
      return Left(WeatherFailure(I18n.cityDoesNotExists));
    } catch (e) {
      return Left(WeatherFailure(I18n.cannotLoadCityForecast));
    }
  }

  @override
  Future<Either<Failure, Forecast>> loadForecastFromLocation() async {
    try {
      if (await _networkDataSource.checkInternetConnection()) {
        final result =
            await _remoteWeatherDataSource.loadForecastFromLocation();

        return Right(result);
      } else {
        return Left(ConnectionFailure(I18n.noInternetConnection));
      }
    } on LocationServiceNotEnabledException {
      return Left(WeatherFailure(I18n.notInTheCity));
    } on LocationPermissionDeniedForeverException {
      return Left(LocationFailure(I18n.locationPermissionDeniedForever));
    } on LocationPermissionRequestDeniedException {
      return Left(LocationFailure(I18n.locationPermissionDenied));
    } catch (e) {
      return Left(WeatherFailure(I18n.cannotLoadCityForecast));
    }
  }
}
