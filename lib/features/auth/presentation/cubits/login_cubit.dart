// import 'package:beam/cores/__cores.dart';
// import 'package:beam/features/__features.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';

// class LoginCubit extends Cubit<LoginFormzState> {
//   final UserBloc userBloc;
//   final UserProfileManager userProfileManager;
//   LoginCubit({
//     required this.userBloc,
//     required this.userProfileManager,
//   }) : super(LoginFormzState.initial());

//   // fuction call

//   void loginUser(
//     LoginBloc loginBloc, {
//     bool useBiometrics = false,
//     String? hasdhedPin,
//   }) {
//     emit(state.copyWith(
//       isBiometricEnabled: useBiometrics,
//     ));
//     loginBloc.add(Login(state));
//   }

//   void onPinChanged(String pin) {
//     emit(
//       state.copyWith(
//         pin: RequiredLength.dirty(
//           value: pin,
//           minLength: 6,
//         ),
//       ),
//     );
//   }

//   void onPhoneChanged(String phone) {
//     emit(
//       state.copyWith(
//         phoneNo: RequiredLength.dirty(
//           value: phone,
//           minLength: 11,
//         ),
//       ),
//     );
//   }

//   void navigateToDashBoard() {
//     userProfileManager.clearUserProfile();
//     Future.delayed(const Duration(seconds: 1), () {
//       AppRouter.instance.clearRouteAndPush(DashboardPage.routeName);
//       userBloc.add(const GetUser());
//     });
//     reset();
//   }

//   void navigateToLoginOnError() {
//     userProfileManager.clearUserProfile();
//     AppRouter.instance.clearRouteAndPush(LoginPhoneScreen.routeName);
//     Toast.showError("An error occured");
//   }

//   void navigateToPinScreen() {
//     state.copyWith(pin: const RequiredLength.pure(minLength: 6));
//     AppRouter.instance.navigateTo(LoginPinScreen.routeName);
//   }

//   void reset() {
//     emit(LoginFormzState.initial());
//   }
// }

// class LoginFormzState extends RequestParam with FormzMixin {
//   final RequiredLength phoneNo;
//   final RequiredLength pin;
//   final bool? isBiometricEnabled;

//   const LoginFormzState({
//     this.pin = const RequiredLength.pure(
//       minLength: 6,
//       value: '123456',
//     ),
//     this.phoneNo = const RequiredLength.pure(
//       minLength: 11,
//     ),
//     this.isBiometricEnabled = false,
//   });

//   factory LoginFormzState.initial() => const LoginFormzState();

//   @override
//   List<Object?> get props => [
//         phoneNo,
//         pin,
//         isBiometricEnabled,
//       ];

//   LoginFormzState copyWith({
//     RequiredLength? pin,
//     RequiredLength? phoneNo,
//     bool? isBiometricEnabled,
//   }) {
//     return LoginFormzState(
//       pin: pin ?? this.pin,
//       phoneNo: phoneNo ?? this.phoneNo,
//       isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
//     );
//   }

//   @override
//   List<FormzInput> get inputs => [
//         pin,
//         phoneNo,
//       ];

//   @override
//   Map<String, dynamic> toMap() {
//     return {
//       "password": pin.value,
//       "phoneNumber": phoneNo.value,
//       // if (isBiometricEnabled == true) "isBiometricPassword": isBiometricEnabled,
//     };
//   }
// }
