import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class WarningStateWidget extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onTap;
  final Widget? buttons;

  const WarningStateWidget({
    super.key,
    this.title = "Warning",
    this.message = "Operation was successful",
    this.buttonText = "Done",
    this.onTap,
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const VSpace(),
        ImageWidget(
          imageTypes: ImageTypes.svg,
          imageUrl: "assets/images/warning_check.svg",
          width: w(72),
          height: h(72),
        ),
        const VSpace(),
        TextWidget.bold(title, fontSize: kfsVeryLarge),
        const VSpace(5),
        SizedBox(
          width: w(333),
          child: TextWidget(message, textAlign: TextAlign.center),
        ),
        const VSpace(32),
        buttons ?? defaultButtonWidget(),
        const VSpace(),
      ],
    );
  }

  Row defaultButtonWidget() {
    return Row(children: [
      Expanded(
        child: Button.withBorderLine(
          borderColor: AppColor.kcPrimaryColor,
          textColor: AppColor.kcPrimaryColor,
          color: Colors.transparent,
          text: "Cancel",
          onTap: AppRouter.instance.goBack,
        ),
      ),
      const HSpace(10),
      Expanded(child: Button(text: buttonText, onTap: onTap))
    ]);
  }
}
