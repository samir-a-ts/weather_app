import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    BlocProvider.of<InitCubit>(context).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<InitCubit, InitState>(
        listener: (context, state) {
          if (state is InitLoaded) {
            if (I18n.currentLocale.languageCode != state.settings.locale) {
              I18n.load(Locale(state.settings.locale));
            }

            Future.delayed(
              const Duration(seconds: 3),
              () {
                Navigator.of(context).pushReplacementNamed('/weather-list');
              },
            );
          }
        },
        child: Center(
          child: Image.asset(
            'assets/images/icon.png',
            width: size.width * .7,
          ),
        ),
      ),
    );
  }
}
