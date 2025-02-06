import 'package:road_app/cores/__cores.dart';
import 'package:flutter/material.dart';

class PercentageCounterWidget extends StatelessWidget {
  final int height, percent, radius;
  final Color backgroundColor, progressColor;

  const PercentageCounterWidget({
    super.key,
    this.height = 8,
    this.percent = 10,
    this.radius = 20,
    this.backgroundColor = AppColor.kcWhite,
    this.progressColor = AppColor.kcPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the width based on the available space
        double progressWidth = (constraints.maxWidth * (percent / 100))
            .clamp(0, constraints.maxWidth);

        return Container(
          height: h(height.toDouble()),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(sr(radius.toDouble())),
          ),
          child: Stack(
            children: [
              Container(
                height: h(height.toDouble()),
                width: progressWidth,
                decoration: BoxDecoration(
                  color: progressColor,
                  borderRadius: BorderRadius.circular(sr(radius.toDouble())),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
