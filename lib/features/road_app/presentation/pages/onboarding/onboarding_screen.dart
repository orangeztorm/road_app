// import 'package:road_app/cores/__cores.dart';
// import 'package:road_app/features/auth/presentation/_presentation.dart';
// import 'package:flutter/material.dart';

// class OnboardingScreen extends StatefulWidget {
//   static const routeName = '/onboarding_screen';
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController controller = PageController();
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     controller.addListener(() {
//       setState(() {
//         currentIndex = controller.page?.toInt() ?? 0;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldWidget(
//       useSingleScroll: false,
//       body: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           const VSpace(),
//           ProgressIndicatorWidget(
//             currentIndex: currentIndex,
//           ),
//           const VSpace(60),
//           Expanded(
//             child: PageView.builder(
//               controller: controller,
//               itemCount: OnboardingUi.values.length,
//               itemBuilder: (context, index) => OnboardWidget(
//                 OnboardingUi.values[index],
//               ),
//             ),
//           ),
//           _buildActionButtons(),
//           const VSpace(20),
//         ],
//       ),
//     );
//   }

//   Widget _buildActionButtons() {
//     return Row(
//       children: [
//         Expanded(
//           child: Button(
//             text: 'Sign up',
//             onTap: () {
//               FeaturesX.resetFeature(Features.auth);
//               AppRouter.instance.navigateTo(SignUpBvnScreen.routeName);
//             },
//           ),
//         ),
//         const HSpace(10),
//         Expanded(
//           child: Button(
//             text: 'Log in',
//             onTap: () {
//               AppRouter.instance.navigateTo(LoginPhoneScreen.routeName);
//             },
//             color: AppColor.colorFFE9D9,
//             textColor: AppColor.kcTextColor,
//           ),
//         ),
//       ],
//     );
//   }
// }
