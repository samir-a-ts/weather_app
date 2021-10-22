import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/presentation/widgets/app_drawer.dart';
import 'package:weather_app/core/presentation/widgets/drawer_button.dart';
import 'package:weather_app/core/presentation/widgets/gap.dart';
import 'package:weather_app/core/presentation/widgets/snack_bar.dart';
import 'package:weather_app/features/app/domain/entities/settings.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';
import 'package:weather_app/features/weather/domain/entities/weather_helper.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';

import '../widgets/weather_panel.dart';

class WeatherPage extends StatefulWidget {
  final int index;

  const WeatherPage({Key key, this.index}) : super(key: key);

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _messangerState = GlobalKey<ScaffoldState>();

  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return BlocListener<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is FailureWeatherState) {
          _scaffoldKey.currentState.showSnackBar(
            getErrorSnackbar(state.failure.message),
          );
        }
      },
      child: BlocBuilder<InitCubit, InitState>(builder: (context, snapshot) {
        return BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            final forecast = state.forecasts[widget.index];

            return Scaffold(
              key: _messangerState,
              drawer: const AppDrawer(),
              body: ScaffoldMessenger(
                key: _scaffoldKey,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          getImageFromWeatherCondition(forecast.current),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SlidingUpPanel(
                      controller: _panelController,
                      minHeight: 0,
                      maxHeight: 320,
                      body: SizedBox(
                        width: query.size.width,
                        height: query.size.height - query.padding.top,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 0,
                              top: 20,
                              child: DrawerButton(
                                scaffoldKey: _messangerState,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 90.0),
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.phone_android,
                                        color: snapshot is InitLoaded
                                            ? snapshot.settings.color
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    const Gap(10),
                                    if (BlocProvider.of<WeatherCubit>(context)
                                        .state is LoadingWeatherState)
                                      const CircularProgressIndicator()
                                    else
                                      IconButton(
                                        icon: Icon(
                                          Icons.refresh,
                                          color: snapshot is InitLoaded
                                              ? snapshot.settings.color
                                              : Colors.black,
                                        ),
                                        onPressed: () async {
                                          BlocProvider.of<WeatherCubit>(context)
                                              .refreshCity(forecast.cityName);
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              right: 25,
                              child: SizedBox(
                                width: query.size.width * .7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      forecast.cityName,
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                      textAlign: TextAlign.end,
                                    ),
                                    const Gap(7),
                                    Text(
                                      getTempFromType(
                                        snapshot is InitLoaded
                                            ? snapshot.settings.type
                                            : TempType.celsium,
                                        forecast.current.temp,
                                      ),
                                      textAlign: TextAlign.end,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          .copyWith(
                                            fontSize: 65,
                                          ),
                                    ),
                                    const Gap(7),
                                    Text(
                                      forecast.current.conditionDetails,
                                      textAlign: TextAlign.end,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 50,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_upward,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _panelController.open();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      panel: WeatherPanel(
                        forecast: forecast,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
