import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class Loader extends StatelessWidget {
  final double topPadding;

  const Loader({super.key, this.topPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: CircularProgressIndicator(
        color: Theme.of(context).brightness == Brightness.dark
            ? null
            : AppColor.kcPrimaryColor,
      ),
    );
  }
}
