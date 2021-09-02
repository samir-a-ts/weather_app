import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/presentation/widgets/gap.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';

class LoadLocationCityDialog extends StatefulWidget {
  @override
  _LoadLocationCityDialogState createState() => _LoadLocationCityDialogState();
}

class _LoadLocationCityDialogState extends State<LoadLocationCityDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Text(
              I18n.loadFromLocation,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: -100,
            child: Image.asset(
              'assets/images/icon.png',
              width: 150,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    BlocProvider.of<WeatherCubit>(context)
                        .loadLocationWeather();
                  },
                  child: Text(I18n.ok),
                ),
                const Gap(10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(I18n.no),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
