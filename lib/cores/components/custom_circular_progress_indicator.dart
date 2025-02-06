import 'package:flutter/cupertino.dart';

import '../utils/__utils.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    super.key,
    this.color,
    this.backGroundColor,
    this.value,
    this.useTopPadding = false,
  });

  final Color? color;
  final Color? backGroundColor;
  final double? value;
  final bool useTopPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: useTopPadding ? sp(10) : 0),
      child: const CupertinoActivityIndicator(radius: 10, animating: true),
    );
  }
}
