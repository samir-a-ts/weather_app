import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/presentation/widgets/gap.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/domain/entities/settings.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';
import 'package:weather_app/features/weather/domain/entities/forecast.dart';
import 'package:weather_app/features/weather/domain/entities/weather_helper.dart';

class WeatherPanel extends StatefulWidget {
  final Forecast forecast;

  const WeatherPanel({Key key, this.forecast}) : super(key: key);

  @override
  _WeatherPanelState createState() => _WeatherPanelState();
}

class _WeatherPanelState extends State<WeatherPanel> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final days = widget.forecast.hourly.take(24).toList();

    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 320,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, -1),
                blurRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              const Gap(7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    days.length,
                    (index) {
                      final e = days[index];

                      final date = e.date.add(Duration(hours: index));

                      return SizedBox(
                        height: 100,
                        width: size.width / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              validateTime(date),
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              getTempFromType(
                                state is InitLoaded
                                    ? state.settings.type
                                    : TempType.celsium,
                                e.temp,
                              ),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Icon(
                              getIconFromWeatherCondition(e),
                              color: state is InitLoaded
                                  ? state.settings.color
                                  : Colors.black,
                              size: 27,
                            ),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              const Gap(7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.opacity,
                        color: state is InitLoaded
                            ? state.settings.color
                            : Colors.black,
                        size: 40,
                      ),
                      Text(
                        '${widget.forecast.current.humidity}%',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        I18n.humidity,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.waves,
                        size: 40,
                        color: state is InitLoaded
                            ? state.settings.color
                            : Colors.black,
                      ),
                      Text(
                        '${widget.forecast.current.windSpeed} ${I18n.metrePerSecond}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        I18n.windSpeed,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.speed,
                        size: 40,
                        color: state is InitLoaded
                            ? state.settings.color
                            : Colors.black,
                      ),
                      Text(
                        '${widget.forecast.current.pressure}',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        I18n.pressure,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.thermostat_sharp,
                        size: 40,
                        color: state is InitLoaded
                            ? state.settings.color
                            : Colors.black,
                      ),
                      Text(
                        getTempFromType(
                          state is InitLoaded
                              ? state.settings.type
                              : TempType.celsium,
                          widget.forecast.current.feelsLikeTemp,
                        ),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        I18n.feelsLike,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
