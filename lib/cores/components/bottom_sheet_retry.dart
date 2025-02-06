import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class BottomSheetRetryBottomSheet extends StatelessWidget {
  final String? message;
  final Function()? onRetry;
  final Function()? onClose;
  const BottomSheetRetryBottomSheet({
    super.key,
    this.message,
    this.onRetry,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpace(),
        Icon(Icons.info_outline, color: AppColor.kcSoftTextColor, size: sp(40)),
        const VSpace(40),
        TextWidget(
          message ?? "Something went wrong",
          fontSize: sp(16),
          fontWeight: FontWeight.w600,
        ),
        const VSpace(40),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Button(
                text: "Retry",
                onTap: onRetry,
              ),
            ),
            const HSpace(20),
            Expanded(
              child: Button(
                text: "Close",
                onTap: onClose,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
