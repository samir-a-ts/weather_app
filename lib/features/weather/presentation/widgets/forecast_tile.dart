import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weather_app/core/constans/constants.dart';
import 'package:weather_app/core/presentation/widgets/gap.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/domain/entities/settings.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';
import '../pages/weather_page.dart';

class ForecastTile extends StatefulWidget {
  final int index;

  const ForecastTile({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _ForecastTileState createState() => _ForecastTileState();
}

class _ForecastTileState extends State<ForecastTile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<InitCubit, InitState>(builder: (context, initState) {
      return BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          final forecast = state.forecasts[widget.index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Slidable(
              actionPane: const SlidableDrawerActionPane(),
              actions: <Widget>[
                IconSlideAction(
                  caption: I18n.delete,
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    BlocProvider.of<WeatherCubit>(context)
                        .deleteCity(widget.index);
                  },
                ),
                IconSlideAction(
                  caption: I18n.refresh,
                  color: Colors.grey.shade900,
                  icon: Icons.refresh,
                  onTap: () {
                    BlocProvider.of<WeatherCubit>(context)
                        .refreshCity(forecast.cityName);
                  },
                ),
              ],
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WeatherPage(
                        index: widget.index,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: size.width,
                  padding: const EdgeInsets.all(12),
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            state.forecasts[widget.index].cityName,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const Gap(7),
                          Text(
                            forecast.current.conditionDetails,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          getTempFromType(
                            initState is InitLoaded
                                ? initState.settings.type
                                : TempType.celsium,
                            forecast.current.temp,
                          ),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
