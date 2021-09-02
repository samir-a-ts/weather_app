import 'package:weather_app/features/app/domain/entities/settings.dart';

String getTempFromType(TempType type, double value) {
  if (type == TempType.farring) {
    return '${((value * (9 / 5)) + 32).toStringAsFixed(1)}°F';
  }

  return '${value.toStringAsFixed(1)}°C';
}

/// For time validation.
String validateTime(DateTime time) {
  return '${time.hour.toString().length == 1 ? '0${time.hour}' : time.hour}:00';
}
