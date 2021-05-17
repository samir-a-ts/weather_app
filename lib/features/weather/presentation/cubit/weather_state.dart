part of 'weather_cubit.dart';

class WeatherState extends Equatable {
  final List<Forecast> forecasts;

  const WeatherState(this.forecasts);

  @override
  List<Object> get props => [forecasts];

  LoadingWeatherState toLoading() {
    return LoadingWeatherState(forecasts);
  }

  FailureWeatherState toFailure(Failure failure) {
    return FailureWeatherState(failure, forecasts);
  }

  WeatherState copyWith({List<Forecast> forecast}) {
    return WeatherState(forecast ?? forecasts);
  }
}

class LoadingWeatherState extends WeatherState {
  const LoadingWeatherState(List<Forecast> forecasts) : super(forecasts);

  @override
  List<Object> get props => [forecasts];
}

class FailureWeatherState extends WeatherState {
  final Failure failure;

  const FailureWeatherState(this.failure, List<Forecast> forecasts)
      : super(forecasts);

  @override
  List<Object> get props => [forecasts];
}
