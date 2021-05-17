import 'package:flutter/cupertino.dart';

class Gap extends StatelessWidget {
  final double gap;

  const Gap(this.gap, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gap,
      height: gap,
    );
  }
}
