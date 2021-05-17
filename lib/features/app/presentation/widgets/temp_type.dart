import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/domain/entities/settings.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';

class TempTypeWidget extends StatefulWidget {
  @override
  _TempTypeWidgetState createState() => _TempTypeWidgetState();
}

class _TempTypeWidgetState extends State<TempTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          I18n.tempType,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: TempType.values
                .map<Widget>(
                  (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    final cubit = BlocProvider.of<InitCubit>(context);

                    final state = cubit.state as InitLoaded;

                    cubit.update(
                      state,
                      settings:
                      state.settings.copyWith(type: e),
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        e == TempType.celsium ? '°C' : '°F',
                      ),
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        )
      ],
    );
  }
}
