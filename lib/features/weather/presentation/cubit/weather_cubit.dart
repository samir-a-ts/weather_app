import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/errors/failure.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepoistory;

  WeatherCubit(this._weatherRepoistory) : super(const WeatherState([]));

  Future<void> refreshCity(String cityName) async {
    emit(state.toLoading());

    final result = await _weatherRepoistory.loadForecastFromCityName(cityName);

    final newState = result.fold(
      (failure) => state.toFailure(failure),
      (forecast) {
        final f = List.of(state.forecasts);

        for (int i = 0; i < f.length; i++) {
          if (f[i].cityName == cityName) {
            f[i] = forecast;
            break;
          }
        }

        return state.copyWith(
          forecast: f,
        );
      },
    );

    emit(newState);
  }

  Future<void> deleteCity(int index) async {
    final forecasts = List.of(state.forecasts);

    forecasts.removeAt(index);

    emit(state.copyWith(forecast: forecasts));
  }

  Future<Forecast> loadLocationWeather() async {
    emit(state.toLoading());

    final result = await _weatherRepoistory.loadForecastFromLocation();

    Forecast forecasts;

    final newState = result.fold(
      (failure) => state.toFailure(failure),
      (forecast) {
        forecasts = forecast;

        return state.copyWith(
          forecast: List.of(state.forecasts)..insert(0, forecast),
        );
      },
    );

    emit(newState);

    return forecasts;
  }

  Future<void> load() async {
    emit(state.toLoading());

    final result = await _weatherRepoistory.loadSavedForecast();

    final newState = result.fold(
      (failure) => state.toFailure(failure),
      (forecasts) => state.copyWith(
        forecast: List.of(forecasts)..insertAll(0, state.forecasts),
      ),
    );

    emit(newState);
  }

  Future<void> loadCity(String city) async {
    for (int i = 0; i < state.forecasts.length; i++) {
      if (state.forecasts[i].cityName == city) return;
    }

    emit(state.toLoading());

    final result = await _weatherRepoistory.loadForecastFromCityName(city);

    final newState = result.fold(
      (failure) => state.toFailure(failure),
      (forecasts) {
        final list = List.of(state.forecasts)..insert(0, forecasts);

        return state.copyWith(forecast: list);
      },
    );

    emit(newState);
  }

  Future<void> saveForecasts() async {
    await _weatherRepoistory.saveForecast(state.forecasts);
  }
}
