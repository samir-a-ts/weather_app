import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/features/app/data/repositories/init_repository_impl.dart';
import 'package:weather_app/features/app/domain/entities/settings.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  final InitRepositoryImpl _initRepositoryImpl;

  InitCubit(this._initRepositoryImpl) : super(InitInitial());

  Future<void> init() async {
    final result = await _initRepositoryImpl.isUserNew();

    final settings = await _initRepositoryImpl.loadSettings();

    final newState = result.fold(
      (failure) => InitLoaded(
        result: false,
        settings: Settings.initial(),
      ),
      (result) => settings.fold(
        (failure) => InitLoaded(
          result: result,
          settings: Settings.initial(),
        ),
        (settings) => InitLoaded(
          result: result,
          settings: settings,
        ),
      ),
    );

    emit(newState);
  }

  Future<void> update(InitLoaded prevState, {Settings settings}) async {
    emit(prevState.copyWith(settings: settings));

    final result =
        await _initRepositoryImpl.saveSettings(settings ?? prevState.settings);

    final newState = result.fold(
      (failure) => prevState,
      (result) => state,
    );

    emit(newState);
  }
}
