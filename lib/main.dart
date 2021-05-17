import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/core/constans/constants.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/injection_container.dart';

import './injection_container.dart' as di;
import 'core/state_observer.dart';
import 'core/translations/i18n.dart';

/// Main function. Runs app, but
/// firstly initialises dependecies and
/// some logging.
Future<void> main() async {
  /// Adds possibility to
  /// get all dependicies before
  /// `runApp` called.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialised all third pard
  /// dependicies.
  await di.initialise();

  /// Setups bloc observer.
  /// (logger)
  Bloc.observer = SimpleBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<InitCubit>(
          create: (context) => sl<InitCubit>(),
        ),
        BlocProvider<WeatherCubit>(
          create: (context) => sl<WeatherCubit>()..load(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// When user closing app, all forecasts
    /// is saving immidisatly.
    if (state == AppLifecycleState.inactive) {
      BlocProvider.of<WeatherCubit>(context).saveForecasts();

      final init = BlocProvider.of<InitCubit>(context);

      init.update(init.state as InitLoaded);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Weather App',
          theme: kTheme.copyWith(
            primaryColor:
                (state is InitLoaded) ? state.settings.color : Colors.black,
          ),
          localizationsDelegates: const [
            I18nDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: I18nDelegate.supportedLocals,
          routes: routes,
          initialRoute: '/splash',
        );
      },
    );
  }
}
