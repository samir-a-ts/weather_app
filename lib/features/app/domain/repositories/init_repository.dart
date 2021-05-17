import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failure.dart';
import '../entities/settings.dart';

/// Repository for app initialisation.
/// Getting on app entry data and so on.
abstract class InitRepository {
  /// Method for finding out, is
  /// user entered the app for the
  /// first time.
  /// Requires nothing.
  /// Return [bool].
  Future<Either<Failure, bool>> isUserNew();

  /// Method for loading settings.
  /// Requires nothing.
  /// Return [Settings].
  Future<Either<Failure, Settings>> loadSettings();

  /// Method for saving settings on phone.
  /// Requires [Settings].
  /// Return nothing.
  Future<Either<Failure, void>> saveSettings(Settings settings);
}
