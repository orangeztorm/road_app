import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/auth/presentation/pages/user/notification_page.dart';

class SignInScreen extends StatelessWidget {
  static const String routeName = '/signin_screen';
  const SignInScreen({super.key});

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
                Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (value) {},
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                        const HSpace(),
                        const TextWidget.bold('Remember me'),
                      ],
                    ),
                    const Spacer(),
                    const TextWidget.bold('Forgot Password?'),
                  ],
                ),
                const VSpace(50),
                Button(
                  text: 'Login',
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
