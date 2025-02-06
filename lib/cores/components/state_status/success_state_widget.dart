import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

// import 'package:lottie/lottie.dart';

class SuccessStateWidget extends StatelessWidget {
  static const String routeName = '/successStateWidget';

  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onTap;

  const SuccessStateWidget({
    super.key,
    this.title = "Success",
    this.message = "Operation was successful",
    this.buttonText = "Done",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const VSpace(),
        Container(
          padding: EdgeInsets.all(sp(10)),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffD1FADF),
          ),
          child: ImageWidget(
            imageTypes: ImageTypes.svg,
            imageUrl: "assets/images/wallet/sucess_check_mark.svg",
            width: w(38),
            height: h(38),
          ),
        ),
        const VSpace(),
        TextWidget.bold(title, fontSize: kfsVeryLarge),
        const VSpace(5),
        SizedBox(
          width: w(333),
          child: TextWidget(message, textAlign: TextAlign.center),
        ),
        const VSpace(32),
        Button(
            text: buttonText,
            onTap: onTap ??
                () {
                  // AppRouter.instance.clearRouteAndPush(DashboardPage.routeName);
                }),
        const VSpace(),
      ],
    );
  }
}
