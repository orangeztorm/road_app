// import 'package:beam/cores/__cores.dart';
// import 'package:beam/features/auth/domain/_domain.dart';
// import 'package:beam/features/auth/presentation/_presentation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';

// class ForgotPasswordCubit extends Cubit<ForgotPasswordFormzState> {
//   ForgotPasswordCubit() : super(ForgotPasswordFormzState.initial());

//   // fuction call
//   void verifyBvn(
//     ForgotPasswordVerifyBvnBloc forgotPasswordVerifyBvnBloc,
//   ) {
//     emit(state.copyWith(step: ForgotPasswordSteps.bvn));
//     forgotPasswordVerifyBvnBloc.add(ForgotPasswordVerifyBvn(state));
//   }

//   void verifyOtp(ForgotPasswordVerifyOtpBloc forgotPasswordVerifyOtpBloc) {
//     emit(state.copyWith(step: ForgotPasswordSteps.verifyOtp));
//     forgotPasswordVerifyOtpBloc.add(ForgotPasswordVerifyOtp(state));
//   }

//   void resendOtp(ForgotPasswordResendOtpBloc forgotPasswordSendOtpBloc) {
//     emit(state.copyWith(step: ForgotPasswordSteps.resendOtp));
//     forgotPasswordSendOtpBloc.add(ForgotPasswordResendOtp(state));
//   }

//   void resetForgotPassword(
//       ForgetPasswordRestPasswordBloc forgetPasswordRestPasswordBloc) {
//     emit(state.copyWith(step: ForgotPasswordSteps.resetPassword));
//     forgetPasswordRestPasswordBloc.add(ForgetPasswordRestPassword(state));
//   }

//   void onBvnChanged(String bvn) {
//     emit(state.copyWith(bvn: RequiredLength.dirty(value: bvn, minLength: 11)));
//   }

//   void onOtpChanged(String? otp) {
//     emit(state.copyWith(
//         otp: RequiredLength.dirty(value: otp ?? '', minLength: 6)));
//   }

//   void onPinChanged(String? pin) {
//     emit(state.copyWith(
//         pin: RequiredLength.dirty(value: pin ?? '', minLength: 4)));
//   }

//   void onStepChanged(ForgotPasswordSteps step) {
//     emit(state.copyWith(step: step));
//   }

//   void onConfirmPinChanged(String? confirmPin) {
//     emit(state.copyWith(
//         confirmPin:
//             RequiredLength.dirty(value: confirmPin ?? '', minLength: 6)));
//   }

//   void onPhoneChanged(String phone) {
//     emit(state.copyWith(phone: Required.dirty(phone)));
//   }

//   void navigateToOtpScreen(BvnEntitiy? bvnEntitiy) {
//     emit(state.copyWith(otp: const RequiredLength.pure(minLength: 6)));
//     emit(state.copyWith(
//       phone: Required.dirty(bvnEntitiy?.data.phoneNo ?? AppStrings.na),
//     ));
//     AppRouter.instance.navigateTo(ResetpasswordOtpScreen.routeName);
//   }

//   void navigateToPinScreen() {
//     emit(state.copyWith(pin: const RequiredLength.pure(minLength: 6)));
//     AppRouter.instance.navigateTo(ResetPasswordPinScreen.routeName);
//   }

//   void navigateToConfirmPinScreen() {
//     emit(state.copyWith(confirmPin: const RequiredLength.pure(minLength: 4)));
//     AppRouter.instance.navigateTo(ResetpasswordConfirmPinScreen.routeName);
//   }

//   void navigateToForgotPasswordSuccessful(String hashPin) {
//     AppRouter.instance.navigateTo(BiometricsPage.routeName, arguments: hashPin);
//   }

//   void reset() {
//     emit(ForgotPasswordFormzState.initial());
//   }
// }

// class ForgotPasswordFormzState extends RequestParam with FormzMixin {
//   final RequiredLength bvn;
//   final RequiredLength otp;
//   final Required phone;
//   final RequiredLength pin;
//   final RequiredLength confirmPin;
//   final ForgotPasswordSteps step;

//   const ForgotPasswordFormzState({
//     this.bvn = const RequiredLength.pure(minLength: 11),
//     this.otp = const RequiredLength.pure(minLength: 6),
//     this.pin = const RequiredLength.pure(minLength: 6),
//     this.confirmPin = const RequiredLength.pure(minLength: 6),
//     this.step = ForgotPasswordSteps.bvn,
//     this.phone = const Required.pure(),
//   });

//   factory ForgotPasswordFormzState.initial() =>
//       const ForgotPasswordFormzState();

//   ForgotPasswordFormzState copyWith({
//     RequiredLength? bvn,
//     RequiredLength? otp,
//     RequiredLength? pin,
//     RequiredLength? confirmPin,
//     ForgotPasswordSteps? step,
//     Required? phone,
//   }) {
//     return ForgotPasswordFormzState(
//       bvn: bvn ?? this.bvn,
//       otp: otp ?? this.otp,
//       pin: pin ?? this.pin,
//       confirmPin: confirmPin ?? this.confirmPin,
//       step: step ?? this.step,
//       phone: phone ?? this.phone,
//     );
//   }

//   @override
//   List<FormzInput> get inputs => [
//         bvn,
//         otp,
//         pin,
//         confirmPin,
//         phone,
//       ];

//   @override
//   List<Object?> get props => [
//         bvn,
//         otp,
//         pin,
//         confirmPin,
//         step,
//         phone,
//       ];

//   bool get isConfimPinValid => pin.value == confirmPin.value;

//   @override
//   Map<String, dynamic> toMap() {
//     switch (step) {
//       case ForgotPasswordSteps.bvn:
//         return {
//           "bvn": bvn.value,
//         };
//       case ForgotPasswordSteps.resendOtp:
//         return {
//           "phoneNo": phone.value,
//         };
//       case ForgotPasswordSteps.verifyOtp:
//         return {
//           "phoneNo": phone.value,
//           "otp": otp.value,
//         };
//       case ForgotPasswordSteps.resetPassword:
//         return {
//           "phoneNo": phone.value,
//           "pin": pin.value,
//         };
//     }
//   }
// }
