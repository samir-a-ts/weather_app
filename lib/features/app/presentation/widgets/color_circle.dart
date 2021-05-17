import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/app/presentation/cubtis/init_cubit.dart';

class ColorCircle extends StatefulWidget {
  final Color color;

  const ColorCircle({Key key, this.color}) : super(key: key);

  @override
  _ColorCircleState createState() => _ColorCircleState();
}

class _ColorCircleState extends State<ColorCircle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          final cubit = BlocProvider.of<InitCubit>(context);

          final state = cubit.state as InitLoaded;

          cubit.update(
            state,
            settings: state.settings.copyWith(color: widget.color),
          );
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
