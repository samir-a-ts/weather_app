import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/features/app/data/datasources/init_data_source.dart';
import 'package:weather_app/features/app/domain/entities/settings.dart';
import 'package:weather_app/features/app/domain/repositories/init_repository.dart';

class InitRepositoryImpl extends InitRepository {
  final InitDataSource _initDataSource;

  InitRepositoryImpl(this._initDataSource);

  @override
  Future<Either<Failure, bool>> isUserNew() async {
    try {
      final result = await _initDataSource.isUserNew();

      return Right(result);
    } catch (e) {
      return const Left(
        InitFailure(''),

        /// If it failed,
        /// well, not so much
        /// left to do smth
        /// with it.
      );
    }
  }

  @override
  Future<Either<Failure, Settings>> loadSettings() async {
    try {
      final result = await _initDataSource.loadSettings();

      return Right(result);
    } catch (e) {
      return const Left(
        InitFailure(''),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(Settings settings) async {
    try {
      final result = await _initDataSource.saveSettings(settings);

      return Right(result);
    } catch (e) {
      return const Left(
        InitFailure(''),
      );
    }
  }
}
