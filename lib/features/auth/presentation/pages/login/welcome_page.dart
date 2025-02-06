import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/auth/presentation/_presentation.dart';
import 'package:road_app/features/auth/presentation/pages/user/user_login/signup_screen.dart';

class WelcomePage extends StatelessWidget {
  static const String routeName = '/welcome_page';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: ScaffoldWidget(
        appBar: AppBar(
          centerTitle: false,
          title: const TextWidget(
            'Welcome',
            fontSize: 22,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w700,
          ),
        ),
        usePadding: false,
        useSafeArea: false,
        body: SizedBox(
          height: sh(80),
          child: Column(
            children: [
              // Custom Top Section
              Container(
                color: AppColor.kcPrimaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      labelColor: AppColor.kcBlack, // Change to desired color
                      labelStyle: GoogleFonts.karla(
                        fontSize: sp(15),
                        fontWeight: FontWeight.w600,
                        color: AppColor
                            .kcWhite, // You can remove this as labelColor already applies the color
                      ),
                      unselectedLabelColor: AppColor
                          .kcSoftTextColor, // Unselected tabs' text color
                      unselectedLabelStyle: GoogleFonts.poppins(
                        fontSize: sp(15),
                        fontWeight: FontWeight.w400,
                      ),
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.black,
                      indicatorWeight: h(2),
                      tabs: const [
                        Tab(text: "SIGN UP"),
                        Tab(text: "SIGN IN"),
                      ],
                    ),
                  ],
                ),
              ),
              // List of Cards
              const Expanded(
                child: TabBarView(
                  children: [
                    SignUpScreen(),
                    SignInScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
