import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/presentation/_presentation.dart';
import 'package:road_app/features/road_app/presentation/pages/user/user_login/signup_screen.dart';

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
            // height: 120,
            textAlign: TextAlign.left,
            fontWeight: FontWeight.w700,
          ),
        ),
        usePadding: false,
        useSafeArea: false,
        body: SizedBox(
          height: sh(100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Custom Top Section
              Container(
                color: AppColor.kcPrimaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      padding: EdgeInsets.zero,
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
                        Tab(text: "SIGN IN"),
                        Tab(text: "SIGN UP"),
                      ],
                    ),
                  ],
                ),
              ),
              // List of Cards
              const Expanded(
                child: TabBarView(
                  children: [
                    SignInScreen(),
                    SignUpScreen(),
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
