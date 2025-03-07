// import 'package:road_app/app/__app.dart';
// import 'package:road_app/cores/__cores.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   static const String routeName = '/splash_screen';
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthLocalStorageDataSource _authLocalStorageDataSource =
//       getIt<AuthLocalStorageDataSource>();

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(
//       const Duration(seconds: 3),
//       checkFirstTimeLogin,
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   void checkFirstTimeLogin() async {
//     final isNotFirstTime =
//         await _authLocalStorageDataSource.isNotFirstTimeUsingApp();
//     if (isNotFirstTime == true) {
//       navigatetoLogin();
//     } else {
//       // AppRouter.instance.clearRouteAndPush(OnboardingScreen.routeName);
//     }
//   }

//   void navigatetoLogin() {
//     // AppRouter.instance.clearRouteAndPush(LoginPage.routeName);
//     AppRouter.instance.clearRouteAndPush(LoginPhoneScreen.routeName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldWidget(
//       bg: AppColor.kcWhite,
//       useSingleScroll: false,
//       body: const Center(
//         child: ImageWidget(
//           imageTypes: ImageTypes.asset,
//           imageUrl: Images.logo,
//           // imageTypes: ImageTypes.svg,
//           // imageUrl: Assets.appIcon,
//         ),
//       ),
//     );
//   }
// }
