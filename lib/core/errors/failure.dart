import 'package:equatable/equatable.dart';

/// Main app failure entity representer.
/// If in repository some error => Failure.
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
}

/// Failure for internet connection.
class ConnectionFailure extends Failure {
  const ConnectionFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}

/// Failure for getting user location.
class LocationFailure extends Failure {
  const LocationFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}

/// Failure of data first entry.
class InitFailure extends Failure {
  const InitFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}

/// Failure of weather data.
class WeatherFailure extends Failure {
  const WeatherFailure(String message) : super(message);

  @override
  List<Object> get props => [message];
}
