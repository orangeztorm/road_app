import 'package:flutter/material.dart';

import '../../cores/components/custom_text_widget.dart';
import '../constants/color.dart';

class RetryButtonWidget extends StatelessWidget {
  const RetryButtonWidget({
    super.key,
    this.callback,
    this.textColor,
  });

  final void Function()? callback;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback!.call(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.kcGrey400),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: TextWidget.light('Retry', textColor: textColor),
      ),
    );
  }
}
