import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_helper.dart';

/// Entity for representing weather forecast
/// for hole day.
class DailyWeather extends Equatable {
  /// Date of the weather forecast.
  final DateTime date;

  /// Pressure of atmosphere.
  final int pressure;

  /// Temperature of the weather.
  final DayTemperature temp;

  /// What temperature is really feeling like.
  final DayTemperature feelsLikeTemp;

  /// Humidity of the
  /// day in percentage.
  final int humidity;

  /// Percentage of sky
  /// cloud covering.
  final int clouds;

  /// Wind speed in m/s.
  final double windSpeed;

  /// Condition of the weather.
  final WeatherCondition weatherCondition;

  /// Weather condition details.
  final String conditionDetails;

  const DailyWeather(
      {this.date,
      this.weatherCondition,
      this.conditionDetails,
      this.pressure,
      this.temp,
      this.feelsLikeTemp,
      this.humidity,
      this.clouds,
      this.windSpeed});

  factory DailyWeather.fromJSON(Map<String, dynamic> json) {
    final weatherCondition = json['weather'][0];

    return DailyWeather(

      clouds: json['clouds'] as int,
      date: DateTime.now(),
      pressure: json['pressure'] as int,
      feelsLikeTemp:
          DayTemperature.fromJSON(json['feels_like'] as Map<String, dynamic>),
      temp: DayTemperature.fromJSON(json['temp'] as Map<String, dynamic>),
      humidity: json['humidity'] as int,
      windSpeed: (json['wind_speed'] as num).toDouble(),
      weatherCondition: fromJSONString(weatherCondition['main'] as String),
      conditionDetails: weatherCondition['description'] as String,
    );
  }

  factory DailyWeather.fromAppJSON(Map<String, dynamic> json) {
    return DailyWeather(
      clouds: json['clouds'] as int,
      date: DateTime.fromMicrosecondsSinceEpoch(json['dt'] as int),
      feelsLikeTemp:
          DayTemperature.fromJSON(json['feels_like'] as Map<String, dynamic>),
      temp: DayTemperature.fromJSON(json['temp'] as Map<String, dynamic>),
      humidity: json['humidity'] as int,
      pressure: json['pressure'] as int,
      windSpeed: json['wind_speed'] as double,
      weatherCondition: fromJSONString(json['weather_cond'] as String),
      conditionDetails: json['cond_details'] as String,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'clouds': clouds,
      'feels_like': feelsLikeTemp.toJSON(),
      'temp': temp.toJSON(),
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
        conditionDetails,
        date,
        pressure,
      ];
}
