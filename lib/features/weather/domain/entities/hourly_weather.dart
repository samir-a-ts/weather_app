import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_helper.dart';

/// Entity for representing weather forecast
/// for concrete hour.
class HourlyWeather extends Equatable {
  /// Date of the weather forecast.
  final DateTime date;

  /// Temperature of the weather.
  final double temp;

  /// What temperature is really feeling like.
  final double feelsLikeTemp;

  /// Humidity of the
  /// day in percentage.
  final int humidity;

  /// Pressure of atmosphere.
  final int pressure;

  /// Percentage of sky
  /// cloud covering.
  final int clouds;

  /// Wind speed in m/s.
  final double windSpeed;

  /// Condition of the weather.
  final WeatherCondition weatherCondition;

  /// Weather condition details.
  final String conditionDetails;

  const HourlyWeather(
      {this.date,
      this.weatherCondition,
      this.conditionDetails,
      this.temp,
      this.feelsLikeTemp,
      this.pressure,
      this.humidity,
      this.clouds,
      this.windSpeed});

  factory HourlyWeather.fromJSON(Map<String, dynamic> json) {
    final weatherCondition = json['weather'][0];

    return HourlyWeather(
      clouds: json['clouds'] as int,
      feelsLikeTemp: (json['feels_like'] as num).toDouble(),
      temp: (json['temp'] as num).toDouble(),
      humidity: json['humidity'] as int,
      date: DateTime.now(),
      pressure: json['pressure'] as int,
      windSpeed: (json['wind_speed'] as num).toDouble(),
      weatherCondition: fromJSONString(weatherCondition['main'] as String),
      conditionDetails: weatherCondition['description'] as String,
    );
  }

  factory HourlyWeather.fromAppJSON(Map<String, dynamic> json) {
    return HourlyWeather(
      clouds: json['clouds'] as int,
      feelsLikeTemp: json['feels_like'] as double,
      temp: json['temp'] as double,
      humidity: json['humidity'] as int,
      pressure: json['pressure'] as int,
      date: DateTime.fromMicrosecondsSinceEpoch(json['dt'] as int),
      windSpeed: json['wind_speed'] as double,
      weatherCondition: fromJSONString(json['weather_cond'] as String),
      conditionDetails: json['cond_details'] as String,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'clouds': clouds,
      'feels_like': feelsLikeTemp,
      'temp': temp,
      'humidity': humidity,
      'wind_speed': windSpeed,
      'weather_cond': weatherCondition.toJSONString(),
      'cond_details': conditionDetails,
      'dt': date.microsecondsSinceEpoch,
      'pressure': pressure,
    };
  }

  @override
  List<Object> get props => [
        temp,
        feelsLikeTemp,
        humidity,
        clouds,
        windSpeed,
        weatherCondition,
        pressure,
        conditionDetails,
      ];
}
