import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/translations/i18n.dart';
import 'package:weather_app/features/weather/presentation/widgets/load_location_city.dart';

class AppInfoDialog extends StatefulWidget {
  @override
  _AppInfoDialogState createState() => _AppInfoDialogState();
}

class _AppInfoDialogState extends State<AppInfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            child: SingleChildScrollView(
              child: Text(
                I18n.appDescription,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
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
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  builder: (context) => LoadLocationCityDialog(),
                );
              },
              child: Text(I18n.ok),
            ),
          ),
        ],
      ),
    );
  }
}
