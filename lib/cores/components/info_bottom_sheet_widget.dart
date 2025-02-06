import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class InfoBottomSheetWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const InfoBottomSheetWidget({
    super.key,
    this.icon = Icons.info,
    this.title = "Info",
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const VSpace(),
        Icon(icon, color: AppColor.kcSoftTextColor, size: sp(40)),
        const VSpace(40),
        TextWidget(
          title,
          fontSize: sp(16),
          fontWeight: FontWeight.w600,
        ),
        TextWidget(
          description,
          fontSize: sp(14),
          fontWeight: FontWeight.w300,
          textColor: AppColor.kcSoftTextColor,
        ),
        const VSpace(40),
        Button(text: "Try Again", onTap: onTap),
        const VSpace(),
      ],
    );
  }
}
