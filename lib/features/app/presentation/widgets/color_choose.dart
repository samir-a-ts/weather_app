import 'package:flutter/material.dart';
import 'package:weather_app/core/constans/constants.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/app/presentation/widgets/color_circle.dart';

class ColorChoose extends StatefulWidget {
  const ColorChoose({Key key}) : super(key: key);

  @override
  _ColorChooseState createState() => _ColorChooseState();
}

class _ColorChooseState extends State<ColorChoose> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          I18n.chooseAppColor,
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: color
                .map(
                  (e) => ColorCircle(color: e),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
