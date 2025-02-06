import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:road_app/cores/__cores.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  const LoadingIndicatorWidget({
    super.key,
    this.strokeWidth,
    @Deprecated('Do not use `value`') this.value,
    this.topPadding = 0.0,
    this.bottomPadding = 0.0,
    this.color,
  });

  final double? strokeWidth;
  final double? value;
  final double topPadding;
  final double bottomPadding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
        child: CircularProgressIndicator.adaptive(
          // color: Colors.grey[200],
          backgroundColor: color ?? Colors.grey,
          strokeWidth: strokeWidth ?? 2.0,
          // value: value,
        ),
      ),
    );
  }
}

class LoadingListIndicator extends StatelessWidget {
  final Widget child;
  final double topPadding;
  final int length;

  const LoadingListIndicator({
    super.key,
    required this.child,
    this.topPadding = 12,
    this.length = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: h(topPadding)),
        itemCount: length,
        itemBuilder: (context, index) => child,
      ),
    ).animate().fade();
  }
}

class LoadingSingleWidgetIndicator extends StatelessWidget {
  final Widget child;
  final double topPadding;
  final int length;

  const LoadingSingleWidgetIndicator({
    super.key,
    required this.child,
    this.topPadding = 12,
    this.length = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: child).animate().fade();
  }
}
