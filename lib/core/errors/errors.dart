import 'package:equatable/equatable.dart';

/// Main app exception.
/// Happening in datasources.
abstract class AppException extends Equatable {
  const AppException();

  @override
  List<Object> get props => [];
}

class LocationServiceNotEnabledException extends AppException {}

class LocationPermissionDeniedForeverException extends AppException {}

class LocationPermissionRequestDeniedException extends AppException {}

class NotInCityException extends AppException {}

class CityDoesNotExistsException extends AppException {}

class ForecastNotExist extends AppException {}
