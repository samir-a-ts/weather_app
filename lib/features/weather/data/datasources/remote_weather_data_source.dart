import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/constans/constants.dart';
import 'package:weather_app/core/errors/errors.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';

abstract class RemoteWeatherDataSource {
  /// Loading forecast depending
  /// on location of user. (more concrete,
  /// the city user locating)
  /// Requires nothing.
  /// Returns [Forecast].
  Future<Forecast> loadForecastFromLocation();

  /// Loading forecast depending
  /// on city name we passed.
  /// Requires city name.
  /// Returns [Forecast].
  Future<Forecast> loadForecastFromCityName(String cityName);
}

class RemoteWeatherDataSourceImpl extends RemoteWeatherDataSource {
  final Dio _dio;

  RemoteWeatherDataSourceImpl(this._dio);

  @override
  Future<Forecast> loadForecastFromCityName(String cityName) async {
    /// Making request for geocoding
    /// (getting location by user city name).
    final Response<List> cityRequest = await _dio.get(
      'http://api.openweathermap.org/geo/1.0/direct',
      queryParameters: {
        'q': cityName,
      }..addAll(commonApiQueryParams),
    );

    final cityStatusCode = cityRequest.statusCode;

    /// If status code of request is OK,
    /// then making proccess through!
    if (cityStatusCode >= 200 && cityStatusCode < 300) {
      final data = cityRequest.data.cast<Map<String, dynamic>>();

      /// If there is no city, then throwing
      /// exception.
      if (data.isEmpty) throw CityDoesNotExistsException();

      /// Getting city name.
      final latitude = data[0]['lat'] as double;
      final longtitude = data[0]['lon'] as double;

      final newCityName =
          data[0]['local_names'][I18n.currentLanguage] as String;

      /// Then requesting weather data by location.
      final Response<Map<String, dynamic>> weatherRequest = await _dio.get(
        'https://api.openweathermap.org/data/2.5/onecall',
        queryParameters: {
          'lat': latitude,
          'lon': longtitude,
        }..addAll(commonApiQueryParams),
      );

      final statusCode = weatherRequest.statusCode;

      /// If status code of request is OK,
      /// then making proccess through!
      if (statusCode >= 200 && statusCode < 300) {
        /// Getting big forecast data.
        final data = weatherRequest.data;

        /// And make them from JSON to [Forecast] entity!
        final forecast = Forecast.fromJSON(data, newCityName);

        return forecast;
      } else {
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }

  @override
  Future<Forecast> loadForecastFromLocation() async {
    /// First we request
    /// from phone:
    /// 1. is geolocation enabled
    /// 2. is it allowed by user
    final enabled = await Geolocator.isLocationServiceEnabled();
    final permission = await Geolocator.checkPermission();

    /// If location is not enabled
    /// on phone, we throwing an error.
    if (!enabled) {
      throw LocationServiceNotEnabledException();
    }

    /// If user denied permission on
    /// geolocation forever,
    /// we also throwing error.
    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForeverException();
    }

    /// If user denied permission, but
    /// not forever...
    if (permission == LocationPermission.denied) {
      /// ...we are trying
      /// to access permission
      /// on location.
      final res = await Geolocator.requestPermission();

      /// If our @GOOD_PERSON@ denied anyway,
      /// then, trowing error.
      if (res == LocationPermission.denied ||
          res == LocationPermission.deniedForever) {
        throw LocationPermissionRequestDeniedException();
      }
    }

    /// Lastly, getting location of
    /// user.
    final result = await Geolocator.getCurrentPosition();

    /// Making request for reverse geocoding
    /// (getting city by user location).
    final Response<List> cityRequest = await _dio.get(
      'http://api.openweathermap.org/geo/1.0/reverse',
      queryParameters: {
        'lat': result.latitude,
        'lon': result.longitude,
        'limit': 2,
      }..addAll(commonApiQueryParams),
    );

    final cityStatusCode = cityRequest.statusCode;

    /// If status code of request is OK,
    /// then making proccess through!
    if (cityStatusCode >= 200 && cityStatusCode < 300) {
      final data = cityRequest.data.cast<Map<String, dynamic>>();

      /// If there is no city, then throwing
      /// exception.
      if (data.length == 1) throw NotInCityException();

      /// Getting city name.
      final cityName = data[1]['local_names'][I18n.currentLanguage] as String;

      /// Then requesting weather data by location.
      final Response<Map<String, dynamic>> weatherRequest = await _dio.get(
        'https://api.openweathermap.org/data/2.5/onecall',
        queryParameters: {
          'lat': result.latitude,
          'lon': result.longitude,
        }..addAll(commonApiQueryParams),
      );

      final statusCode = weatherRequest.statusCode;

      /// If status code of request is OK,
      /// then making proccess through!
      if (statusCode >= 200 && statusCode < 300) {
        /// Getting big forecast data.
        final data = weatherRequest.data;

        /// And make them from JSON to [Forecast] entity!
        final forecast = Forecast.fromJSON(data, cityName);

        return forecast;
      } else {
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }
}
