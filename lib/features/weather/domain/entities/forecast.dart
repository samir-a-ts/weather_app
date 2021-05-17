import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/daily_weather.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_weather.dart';

/// Forecast that we are getting from
/// OneCall OpenWeather API.
class Forecast extends Equatable {
  /// The name of the city we
  /// are getting forecast from.
  final String cityName;

  /// Current weather.
  final HourlyWeather current;

  /// Hourly weather forecast for 3 days.
  final List<HourlyWeather> hourly;

  /// Daily forecast for week.
  final List<DailyWeather> daily;

  const Forecast({
    this.current,
    this.hourly,
    this.daily,
    this.cityName,
  });

  Map<String, dynamic> toJSON() {
    return {
      'current': current.toJSON(),
      'hourly': hourly
          .map<Map<String, dynamic>>(
            (e) => e.toJSON(),
          )
          .toList(),
      'daily': daily
          .map<Map<String, dynamic>>(
            (e) => e.toJSON(),
          )
          .toList(),
      'city_name': cityName,
    };
  }

  factory Forecast.fromJSON(Map<String, dynamic> json, String cityName) {
    return Forecast(
      cityName: cityName,
      current: HourlyWeather.fromJSON(json['current'] as Map<String, dynamic>),
      hourly: (json['hourly'] as List)
          .cast<Map<String, dynamic>>()
          .map<HourlyWeather>(
            (e) => HourlyWeather.fromJSON(e),
          )
          .toList(),
      daily: (json['daily'] as List)
          .cast<Map<String, dynamic>>()
          .map<DailyWeather>(
            (e) => DailyWeather.fromJSON(e),
          )
          .toList(),
    );
  }

  factory Forecast.fromAppJSON(Map<String, dynamic> json) {
    return Forecast(
      current:
          HourlyWeather.fromAppJSON(json['current'] as Map<String, dynamic>),
      hourly: (json['hourly'] as List)
          .cast<Map<String, dynamic>>()
          .map<HourlyWeather>(
            (e) => HourlyWeather.fromAppJSON(e),
          )
          .toList(),
      daily: (json['daily'] as List)
          .cast<Map<String, dynamic>>()
          .map<DailyWeather>(
            (e) => DailyWeather.fromAppJSON(e),
          )
          .toList(),
      cityName: json['city_name'] as String,
    );
  }

  @override
  List<Object> get props => [
        current,
        hourly,
        daily,
        cityName,
      ];
}
