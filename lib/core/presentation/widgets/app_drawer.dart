import 'package:flutter/material.dart';
import 'package:weather_app/core/presentation/widgets/drawer_button.dart';
import 'package:weather_app/features/app/presentation/widgets/color_choose.dart';
import 'package:weather_app/features/app/presentation/widgets/language_set.dart';
import 'package:weather_app/features/app/presentation/widgets/temp_type.dart';

import 'gap.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final padding = MediaQuery.of(context).padding.top;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: size.width * .6,
          height: size.height,
          child: Material(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ColorChoose(),
                const Gap(10),
                const LanguageSet(),
                const Gap(10),
                TempTypeWidget(),
              ],
            ),
          ),
        ),
        Positioned(
          right: -50,
          top: padding + 20,
          child: const SizedBox(
            width: 50,
            height: 50,
            child: DrawerButton(),
          ),
        ),
      ],
    );
  }
}
