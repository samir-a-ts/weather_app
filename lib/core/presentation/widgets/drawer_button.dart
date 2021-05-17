import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';

class DrawerButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerButton({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _DrawerButtonState createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: BlocBuilder<InitCubit, InitState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              widget.scaffoldKey.currentState.openDrawer();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color:
                    (state is InitLoaded) ? state.settings.color : Colors.black,
              ),
              child: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
