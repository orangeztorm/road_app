import 'package:road_app/cores/__cores.dart';
import 'package:flutter/material.dart';
import 'package:road_app/features/auth/presentation/_presentation.dart';
import 'package:road_app/features/auth/presentation/pages/authority/authority_login_page.dart';

class LoginPage extends StatelessWidget {
  static const String routeName = '/login_page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VSpace(80),
          const TextWidget.bold(
            'Welcome!',
            fontSize: 18,
          ),
          const VSpace(),
          const TextWidget.bold(
            'RoadGuard',
            fontSize: 22,
          ),
          const Spacer(),
          const TextWidget.bold(
            'Smart Vehicle-based\nAv System',
            fontSize: 18,
            textAlign: TextAlign.center,
          ),
          const VSpace(30),
          Button(
            text: 'User Login',
            onTap: navigateToLogin,
          ),
          const VSpace(15),
          Button(
            text: 'Authorithy Login',
            onTap: navigateToAuthorityLogin,
          ),
          const VSpace(20),
        ],
      ),
    );
  }

  void navigateToLogin() {
    AppRouter.instance.navigateTo(WelcomePage.routeName);
  }

  void navigateToAuthorityLogin() {
    AppRouter.instance.navigateTo(AuthorityLoginPage.routeName);
  }
}
