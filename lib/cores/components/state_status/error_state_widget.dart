import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

// import 'package:lottie/lottie.dart';

class ErrorStateWidget extends StatelessWidget {
  static const String routeName = '/errorStateWidget';

  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onTap;

  const ErrorStateWidget({
    super.key,
    this.title = "Failure",
    this.message = "Something went wrong, Please try again",
    this.buttonText = "Retry",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const VSpace(20),
        TextWidget(
          title,
          fontSize: sp(20),
          fontWeight: FontWeight.w400,
        ),
        const VSpace(5),
        // Lottie.asset(
        //   "assets/lottie/state_status/error.json",
        //   height: h(150),
        //   width: w(150),
        //   repeat: false,
        //   fit: BoxFit.fill,
        // ),
        const VSpace(20),
        SizedBox(
          width: sw(75),
          child: TextWidget(
            message,
            fontSize: sp(15),
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ),
        const VSpace(25),
        Button(text: buttonText, onTap: onTap ?? AppRouter.instance.goBack),
        const VSpace(),
      ],
    );
  }
}
