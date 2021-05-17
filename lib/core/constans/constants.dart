import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/presentation/pages/splash_page.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_list_page.dart';

export 'theme.dart';
export 'validators.dart';

/// API key for getting weather data from:
/// https://openweathermap.org/
const _openWeatherApiKey = '1539a383d823965800c50ec8b158a02f';

/// Common query parameters for
/// weather data calling from API.
/// Contains data type, language and
/// api key.
final commonApiQueryParams = {
  'units': 'metric',
  'lang': I18n.currentLanguage,
  'appid': _openWeatherApiKey,
};

/// Class that contains
/// keys for data writing locally
/// on device.
class StorageKeys {
  static const initKey = 'INIT_KEY';
  static const weatherKey = 'WEATHER_KEY';
  static const settingsKey = 'SETTINGS_KEY';
}

/// App routes.

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => SplashPage(),
  '/weather-list': (context) => WeatherListPage(),
};

/// For app logging.
/// (States, events, failures
/// for debugging, etc...)
final logger = Logger(
  printer: PrettyPrinter(),
);
