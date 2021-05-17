import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/utils/network_data_source.dart';
import 'package:weather_app/features/app/data/datasources/init_data_source.dart';
import 'package:weather_app/features/app/data/repositories/init_repository_impl.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';
import 'package:weather_app/features/weather/data/datasources/local_weather_data_source.dart';
import 'package:weather_app/features/weather/data/datasources/remote_weather_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';

final sl = GetIt.instance;

/// Function that initialises
/// app third part or own
/// dependecies for app
/// working.
Future<void> initialise() async {
  /// Third part

  /// Check internet connection

  sl.registerSingleton(Connectivity());

  /// API calling

  sl.registerSingleton(Dio());

  /// User location.
  sl.registerSingleton(Geolocator());

  /// Local user data saving
  sl.registerSingleton(await SharedPreferences.getInstance());

  /// Local dependecies
  sl.registerSingleton(NetworkDataSourceImpl(sl<Connectivity>()));

  sl.registerSingleton(RemoteWeatherDataSourceImpl(sl<Dio>()));
  sl.registerSingleton(LocalWeatherDataSourceImpl(sl<SharedPreferences>()));

  sl.registerSingleton(InitDataSourceImpl(sl<SharedPreferences>()));

  sl.registerSingleton(WeatherRepoistoryImpl(sl<LocalWeatherDataSourceImpl>(),
      sl<RemoteWeatherDataSourceImpl>(), sl<NetworkDataSourceImpl>()));

  sl.registerSingleton(InitRepositoryImpl(sl<InitDataSourceImpl>()));

  sl.registerSingleton(WeatherCubit(sl<WeatherRepoistoryImpl>()));
  sl.registerSingleton(InitCubit(sl<InitRepositoryImpl>()));
}
