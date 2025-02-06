import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/auth/presentation/pages/user/notification_page.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signin_screen';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      bg: AppColor.colorF2F4F3,
      body: Column(
        children: [
          const VSpace(20),
          Container(
            height: h(150),
            width: w(150),
            decoration: const BoxDecoration(
              color: AppColor.kcBlack,
              shape: BoxShape.circle,
            ),
          ),
          const VSpace(20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(20)),
            decoration: const BoxDecoration(
              color: AppColor.kcWhite,
            ),
            child: Column(
              children: [
                const TextFieldWidget(hintText: 'Username'),
                const VSpace(),
                const TextFieldWidget(hintText: 'Password'),
                const VSpace(),
                const VSpace(50),
                Button(
                  text: 'SignUp',
                  onTap: () {
                    AppRouter.instance.navigateTo(NotificationPage.routeName);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
