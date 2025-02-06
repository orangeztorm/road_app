// import 'package:beam/app/__app.dart';
// import 'package:beam/cores/__cores.dart';
// import 'package:beam/features/__features.dart';
// import 'package:beam/features/auth/presentation/_presentation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPhoneScreen extends StatelessWidget {
//   static const routeName = '/login_phone';

//   const LoginPhoneScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const LoginPageBackgroundWidget(
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           VSpace(40),
//           Expanded(
//             child: _PhoneNumberForm(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PhoneNumberForm extends StatefulWidget {
//   const _PhoneNumberForm();

//   @override
//   State<_PhoneNumberForm> createState() => _PhoneNumberFormState();
// }

// class _PhoneNumberFormState extends State<_PhoneNumberForm> {
//   final LoginCubit loginCubit = getIt<LoginCubit>();
//   final _phoneController = TextEditingController();
//   final AuthLocalStorageDataSource authLocalStorageDataSource = getIt();

//   @override
//   void initState() {
//     super.initState();
//     checkIfDataIsSaved();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           BlocBuilder<LoginCubit, LoginFormzState>(
//             bloc: loginCubit,
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   TextFieldWidget(
//                     hintText: AppStrings.phoneHint,
//                     title: AppStrings.phoneNumber,
//                     onChanged: loginCubit.onPhoneChanged,
//                     controller: _phoneController,
//                     maxlength: 11,
//                     titleBold: true,
//                   ),
//                   const VSpace(30),
//                   _buildButton(state),
//                 ],
//               );
//             },
//           ),
//           const VSpace(15),
//           TwoSpanTextWidget(
//             AppStrings.dontHaveABeamAccount,
//             AppStrings.registerHere,
//             fontWeight: FontWeight.w300,
//             fontWeight2: FontWeight.w300,
//             textColor2: AppColor.kcPrimaryColor,
//             onTapText2: () => AppRouter.instance.navigateTo(
//               SignUpBvnScreen.routeName,
//             ),
//           ),
//           const VSpace(40),
//         ],
//       ),
//     );
//   }

//   void checkIfDataIsSaved() async {
//     final data = await authLocalStorageDataSource.getSavedLoginData();
//     _phoneController.text = data?.phone ?? '';
//     loginCubit.onPhoneChanged(_phoneController.text);
//   }

//   Widget _buildButton(
//     LoginFormzState formzState,
//   ) {
//     return Button(
//       active: formzState.phoneNo.isValid,
//       text: AppStrings.proceed,
//       onTap: () => loginCubit.navigateToPinScreen(),
//     );
//   }
// }
