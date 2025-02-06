import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// return a percentage of the screen height in respect to the  value given
double sh(double value) => (value / 100).sh;

/// return a percentage of the screen width in respect to the  value given
double sw(double value) => (value / 100).sw;

/// Calculates the sp (Scalable Pixel) depending on the device's screen size
double sp(double value) => value.sp;

double h(double value) => value.h;

double w(double value) => value.w;

double sr(double value) => value.r;

@Deprecated('Use the const VSpace widget instead.')
SizedBox verticalSpace([double value = 10]) => SizedBox(height: value.sp);

@Deprecated('Use the const HSpace widget instead.')
SizedBox horizontalSpace([double value = 10]) => SizedBox(width: value.sp);

class VSpace extends StatelessWidget {
  final double size;
  final SizeUnit unit;

  // Using a positional argument with a default value for size
  const VSpace([this.size = 10, this.unit = SizeUnit.pixel, Key? key])
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double adjustedSize = unit == SizeUnit.pixel ? size.h : size.sh;
    return SizedBox(height: adjustedSize);
  }
}

class HSpace extends StatelessWidget {
  final double size;
  final SizeUnit unit;

  // Using a positional argument with a default value for size
  const HSpace([this.size = 10, this.unit = SizeUnit.pixel, Key? key])
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double adjustedSize = unit == SizeUnit.pixel ? size.w : size.sw;
    return SizedBox(width: adjustedSize);
  }
}

enum SizeUnit {
  pixel,
  percent,
}
