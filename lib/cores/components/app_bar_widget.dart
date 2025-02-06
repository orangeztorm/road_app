import 'package:road_app/cores/__cores.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget(
    this.title, {
    super.key,
    this.showBackButton = true,
    this.centerText = true,
    this.trilling,
    this.topPadding = 25,
    this.leftPadding = 32,
    this.leading,
    this.height = kToolbarHeight,
  });

  final String title;
  final bool showBackButton;
  final bool centerText;
  final double topPadding, leftPadding, height;
  final Widget? trilling, leading;

  @override
  Size get preferredSize =>
      Size.fromHeight(height); // Set the height of the AppBar

  @override
  Widget build(BuildContext context) {
    if (centerText == false) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextWidget(title, fontSize: sp(18), fontWeight: FontWeight.w700),
          trilling ?? SizedBox(height: sp(20), width: sp(50)),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (showBackButton)
          Container(
            transform: Matrix4.translationValues(-20, 0, 0),
            padding: EdgeInsets.only(left: w(leftPadding), top: h(topPadding)),
            child: Center(child: leading ?? const BeamBackButton()),
          )
        else
          SizedBox(height: sp(20), width: sp(40)),
        TextWidget(title, fontSize: sp(18), fontWeight: FontWeight.w700),
        trilling ?? SizedBox(height: sp(20), width: sp(50)),
      ],
    );
  }
}
