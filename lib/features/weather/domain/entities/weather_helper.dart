import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/entities/hourly_weather.dart';

/// Enum that representing
/// weather condition.
enum WeatherCondition { thunderstorm, drizzle, rain, snow, clear, clouds }

IconData getIconFromWeatherCondition(HourlyWeather weather) {
  final condition = weather.weatherCondition;

  switch (condition) {
    case WeatherCondition.thunderstorm:
      return Icons.bolt;
    case WeatherCondition.drizzle:
      return Icons.umbrella;
    case WeatherCondition.rain:
      return Icons.umbrella;
    case WeatherCondition.snow:
      return Icons.ac_unit;
    case WeatherCondition.clear:
      return Icons.circle;
    case WeatherCondition.clouds:
      return Icons.cloud;
  }

  return Icons.circle;
}

String getImageFromWeatherCondition(HourlyWeather weather) {
  final condition = weather.weatherCondition;

  String output = 'assets/images/';

  switch (condition) {
    case WeatherCondition.thunderstorm:
      output += 'thunder.png';
      break;
    case WeatherCondition.drizzle:
      output += 'rain.png';
      break;
    case WeatherCondition.rain:
      output += 'rain.png';
      break;
    case WeatherCondition.snow:
      output += 'snow.png';
      break;
    case WeatherCondition.clear:
      output += 'clear.png';
      break;
    case WeatherCondition.clouds:
      if (weather.clouds > 50) {
        output += 'cloudy.png';
      } else {
        output += 'less_cloudy.png';
      }
      break;
  }

  return output;
}

extension WeatherCondExt on WeatherCondition {
  String toJSONString() {
    switch (this) {
      case WeatherCondition.thunderstorm:
        return 'Thunderstorm';
      case WeatherCondition.drizzle:
        return 'Drizzle';
      case WeatherCondition.rain:
        return 'Rain';
      case WeatherCondition.snow:
        return 'Snow';
      case WeatherCondition.clear:
        return 'Clear';
      case WeatherCondition.clouds:
        return 'Clouds';
    }

    return 'Clear';
  }
}

WeatherCondition fromJSONString(String value) {
  switch (value) {
    case 'Thunderstorm':
      return WeatherCondition.thunderstorm;
    case 'Drizzle':
      return WeatherCondition.drizzle;
    case 'Rain':
      return WeatherCondition.rain;
    case 'Snow':
      return WeatherCondition.snow;
    case 'Clear':
      return WeatherCondition.clear;
    case 'Clouds':
      return WeatherCondition.clouds;
  }

  return WeatherCondition.clear;
}

/// Class representing temperature
/// values of day.
class DayTemperature extends Equatable {
  /// Temperature by hole day.
  final double day;

  /// Temperature by night.
  final double night;

  /// Temperature by evening.
  final double evening;

  /// Temperature by morning.
  final double morning;

  const DayTemperature({
    this.day,
    this.night,
    this.evening,
    this.morning,
  });

  factory DayTemperature.fromJSON(Map<String, dynamic> json) {
    return DayTemperature(
      day: (json['day'] as num).toDouble(),
      night: (json['night'] as num).toDouble(),
      evening: (json['eve'] as num).toDouble(),
      morning: (json['morn'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'day': day,
      'night': night,
      'eve': evening,
      'morn': morning,
    };
  }

  @override
  List<Object> get props => [day, night, evening, morning];
}
