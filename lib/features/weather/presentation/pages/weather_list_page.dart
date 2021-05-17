import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/presentation/widgets/gap.dart';
import 'package:weather_app/core/presentation/widgets/app_drawer.dart';
import 'package:weather_app/core/presentation/widgets/drawer_button.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/widgets/app_info_dialog.dart';
import 'package:weather_app/core/presentation/widgets/snack_bar.dart';
import '../widgets/forecast_tile.dart';

class WeatherListPage extends StatefulWidget {
  @override
  _WeatherListPageState createState() => _WeatherListPageState();
}

class _WeatherListPageState extends State<WeatherListPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _showFirstAppOpeningDialog());
  }

  void _showFirstAppOpeningDialog() {
    final state = BlocProvider.of<InitCubit>(context).state as InitLoaded;

    if (!state.result) {
      showDialog(
        context: context,
        builder: (context) => AppInfoDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is FailureWeatherState) {
          final failure = state.failure;

          _scaffoldKey.currentState.showSnackBar(
            getErrorSnackbar(failure.message),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: const AppDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DrawerButton(
                      scaffoldKey: _scaffoldKey,
                    ),
                  ),
                  const Gap(25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _cityController,
                    ),
                  ),
                  const Gap(10),
                  if (state is LoadingWeatherState)
                    const Align(
                      child: CircularProgressIndicator(),
                    )
                  else
                    Align(
                      child: RaisedButton(
                        onPressed: () {
                          if (_cityController.text.isNotEmpty) {
                            BlocProvider.of<WeatherCubit>(context)
                                .loadCity(_cityController.text);

                            _cityController.value = TextEditingValue.empty;
                          }
                        },
                        child: Text(I18n.addCity),
                      ),
                    ),
                  const Gap(10),
                  Column(
                    children: List.generate(
                      state.forecasts.length,
                      (index) => ForecastTile(index: index),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
