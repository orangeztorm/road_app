// import 'package:beam/cores/__cores.dart';
// import 'package:beam/features/auth/domain/_domain.dart';
// import 'package:beam/features/auth/presentation/_presentation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';

// class CreateAccountCubit extends Cubit<CreateAccountFormzState> {
//   CreateAccountCubit() : super(CreateAccountFormzState.initial());

//   // fuction call
//   void verifyBvn(
//     CreateAccountVerifyBvnBloc createAccountVerifyBvnBloc,
//   ) {
//     emit(state.copyWith(step: SignUpSteps.bvn));
//     createAccountVerifyBvnBloc.add(CreateAccountVerifyBvn(state));
//   }

//   void verifyOtp(CreateAccountVerifyBvnOtpBloc createAccountVerifyOtpBloc) {
//     emit(state.copyWith(step: SignUpSteps.verifyOtp));
//     createAccountVerifyOtpBloc.add(CreateAccountVerifyBvnOtp(state));
//   }

//   void resendOtp(CreateAccountSendOtpBloc createAccountSendOtpBloc) {
//     emit(state.copyWith(step: SignUpSteps.resendOtp));
//     createAccountSendOtpBloc.add(CreateAccountSendOtp(state));
//   }

//   void createAccount(CreateAccountBloc createAccountBloc) {
//     emit(state.copyWith(step: SignUpSteps.create));
//     createAccountBloc.add(CreateAccount(state));
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

//   void onStepChanged(SignUpSteps step) {
//     emit(state.copyWith(step: step));
//   }

//   void onConfirmPinChanged(String? confirmPin) {
//     emit(state.copyWith(
//         confirmPin:
//             RequiredLength.dirty(value: confirmPin ?? '', minLength: 4)));
//   }

//   // void onOccupationChanged(MapEntry<String, String>? occupation) {
//   //   emit(state.copyWith(occupation: occupation));
//   // }

//   // void onMonthlyIncomeRangeChanged(
//   //     MapEntry<String, String>? monthlyIncomeRange) {
//   //   emit(state.copyWith(monthlyIncomeRange: monthlyIncomeRange));
//   // }

//   void onOccupationChanged(Map<String, dynamic>? occupation) {
//     emit(state.copyWith(occupation: occupation));
//   }

//   void onMonthlyIncomeRangeChanged(Map<String, dynamic>? monthlyIncomeRange) {
//     emit(state.copyWith(monthlyIncomeRange: monthlyIncomeRange));
//   }

//   void onHustleChanged(String? hustle) {
//     emit(state.copyWith(hustle: Required.dirty(hustle ?? '')));
//   }

//   void onPhoneChanged(String phone) {
//     emit(state.copyWith(phone: Required.dirty(phone)));
//   }

//   void onEmailChanged(String email) {
//     emit(state.copyWith(email: Email.dirty(email)));
//   }

//   void onCreateAccountEntityChanged(CreateAccountEntity? createAccountEntity) {
//     emit(state.copyWith(
//       createAccountEntity: createAccountEntity,
//     ));
//   }

//   void navigateToOtpScreen(BvnEntitiy? bvnEntitiy) {
//     emit(state.copyWith(
//         phone: Required.dirty(bvnEntitiy?.data.phoneNo ?? AppStrings.na)));
//     emit(state.copyWith(otp: const RequiredLength.pure(minLength: 6)));
//     AppRouter.instance.navigateTo(SignUpVerifyBvnScreen.routeName);
//   }

//   void navigateToBvnDetailsScreen(VerifyOtpEntity? data) {
//     emit(state.copyWith(bvnData: data?.data, useCurrentBvnData: true));
//     AppRouter.instance.navigateTo(SignUpVerifyDetailsScreen.routeName);
//   }

//   void navigateToBvnScreen() {
//     emit(state.copyWith(bvn: const RequiredLength.pure(minLength: 11)));
//     AppRouter.instance.goBack();
//     AppRouter.instance.goBack();
//     AppRouter.instance.goBack();
//   }

//   void navigateToPinScreen() {
//     emit(state.copyWith(pin: const RequiredLength.pure(minLength: 4)));
//     AppRouter.instance.navigateTo(SignUpCreatePin.routeName);
//   }

//   void navigateToConfirmPinScreen() {
//     emit(state.copyWith(confirmPin: const RequiredLength.pure(minLength: 4)));
//     AppRouter.instance.navigateTo(SignUpConfirmPinScreen.routeName);
//   }

//   void navigateToTellMeAboutYourselfScreen() {
//     emit(
//       state.copyWith(
//         occupation: null,
//         monthlyIncomeRange: null,
//         useCurrentMoreData: true,
//         hustle: const Required.pure(),
//         email: const Email.pure(),
//       ),
//     );
//     AppRouter.instance.navigateTo(MoreAboutYouScreen.routeName);
//   }

//   void navigateToCreateAccountSuccessful(
//       CreateAccountEntity? createAccountEntity) {
//     onCreateAccountEntityChanged(createAccountEntity);
//     AppRouter.instance.navigateTo(WelcomeScreen.routeName);
//   }

//   void reset() {
//     emit(CreateAccountFormzState.initial());
//   }
// }

// class CreateAccountFormzState extends RequestParam with FormzMixin {
//   final RequiredLength bvn;
//   final RequiredLength otp;
//   final Required phone;
//   final VerifyOtpDetails? bvnData;
//   final Email email;
//   final RequiredLength pin;
//   final RequiredLength confirmPin;
//   // final MapEntry<String, String>? occupation;
//   // final MapEntry<String, String>? monthlyIncomeRange;
//   final Map<String, dynamic>? occupation;
//   final Map<String, dynamic>? monthlyIncomeRange;
//   final Required hustle;
//   final SignUpSteps step;
//   final CreateAccountEntity? createAccountEntity;

//   const CreateAccountFormzState({
//     this.bvn = const RequiredLength.pure(minLength: 11),
//     this.otp = const RequiredLength.pure(minLength: 6),
//     this.bvnData,
//     this.pin = const RequiredLength.pure(minLength: 4),
//     this.confirmPin = const RequiredLength.pure(minLength: 4),
//     this.occupation,
//     this.monthlyIncomeRange,
//     this.hustle = const Required.pure(),
//     this.step = SignUpSteps.bvn,
//     this.phone = const Required.pure(),
//     this.createAccountEntity,
//     this.email = const Email.pure(),
//   });

//   factory CreateAccountFormzState.initial() => const CreateAccountFormzState();

//   bool get confirmPinIsValid =>
//       confirmPin.isValid && confirmPin.value == pin.value;

//   bool get moreAboutYourselfScreenValid =>
//       hustle.isValid &&
//       occupation != null &&
//       monthlyIncomeRange != null &&
//       email.isValid;

//   @override
//   List<Object?> get props => [
//         bvn,
//         otp,
//         bvnData,
//         pin,
//         confirmPin,
//         occupation,
//         monthlyIncomeRange,
//         hustle,
//         step,
//         phone,
//         createAccountEntity,
//         email,
//       ];

//   CreateAccountFormzState copyWith({
//     RequiredLength? bvn,
//     RequiredLength? otp,
//     VerifyOtpDetails? bvnData,
//     RequiredLength? pin,
//     RequiredLength? confirmPin,
//     // MapEntry<String, String>? occupation,
//     // MapEntry<String, String>? monthlyIncomeRange,
//     Map<String, dynamic>? occupation,
//     Map<String, dynamic>? monthlyIncomeRange,
//     Required? hustle,
//     bool useCurrentBvnData = true, // Default to true, retain the current value
//     bool useCurrentMoreData =
//         false, // Default to true, retain the current value
//     SignUpSteps? step,
//     Required? phone,
//     CreateAccountEntity? createAccountEntity,
//     Email? email,
//   }) {
//     return CreateAccountFormzState(
//       bvn: bvn ?? this.bvn,
//       otp: otp ?? this.otp,
//       bvnData: useCurrentBvnData ? (bvnData ?? this.bvnData) : null,
//       pin: pin ?? this.pin,
//       confirmPin: confirmPin ?? this.confirmPin,
//       occupation:
//           useCurrentMoreData ? occupation : (occupation ?? this.occupation),
//       monthlyIncomeRange: useCurrentMoreData
//           ? monthlyIncomeRange
//           : (monthlyIncomeRange ?? this.monthlyIncomeRange),
//       // occupation:
//       //     useCurrentMoreData ? occupation : (occupation ?? this.occupation),
//       // monthlyIncomeRange: useCurrentMoreData
//       //     ? monthlyIncomeRange
//       //     : (monthlyIncomeRange ?? this.monthlyIncomeRange),
//       hustle: hustle ?? this.hustle,
//       step: step ?? this.step,
//       phone: phone ?? this.phone,
//       createAccountEntity: createAccountEntity ?? this.createAccountEntity,
//       email: email ?? this.email,
//     );
//   }

//   @override
//   List<FormzInput> get inputs => [
//         bvn,
//         otp,
//         pin,
//         confirmPin,
//         hustle,
//         phone,
//         email,
//       ];

//   @override
//   Map<String, dynamic> toMap() {
//     switch (step) {
//       case SignUpSteps.bvn:
//         return {
//           "bvn": bvn.value,
//         };
//       case SignUpSteps.resendOtp:
//         return {
//           "phoneNo": phone.value,
//         };
//       case SignUpSteps.verifyOtp:
//         return {
//           "phoneNo": phone.value,
//           "otp": otp.value,
//         };
//       case SignUpSteps.createAccount:
//         return {
//           "phoneNo": phone.value,
//         };
//       case SignUpSteps.create:
//         return {
//           "phoneNo": phone.value,
//           "password": pin.value,
//           "occupationId": occupation?.keys.first,
//           "monthlyIncomeRangeId": monthlyIncomeRange?.keys.first,
//           "hasSideHustle": hustle.value == 'Yes' ? true : false,
//           "email": email.value,
//         };
//     }
//   }
// }
