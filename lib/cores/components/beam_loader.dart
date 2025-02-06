import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class BeamLoader extends StatelessWidget {
  final num height;
  final num width;
  final Color? color;
  final Widget? widget;
  const BeamLoader({
    super.key,
    this.height = 21,
    this.width = 21,
    this.color,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h(height.toDouble()),
      width: w(width.toDouble()),
      child: RotatingImage(
        child: Icon(Icons.autorenew, color: color ?? AppColor.kcPrimaryColor),
      ),
    );
  }
}
