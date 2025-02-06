// import 'dart:io';

// import 'package:beam/app/locator.dart';
// import 'package:beam/app/notification_manager.dart';
// import 'package:beam/cores/__cores.dart';
// import 'package:beam/features/auth/domain/_domain.dart';
// import 'package:beam/features/auth/presentation/cubits/_cubits.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'login_event.dart';
// part 'login_state.dart';

// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthRepository authRepository;
//   LoginBloc({
//     required this.authRepository,
//   }) : super(LoginState.initial()) {
//     on<Login>(_onLogin);
//   }

//   Future<void> _onLogin(Login event, Emitter<LoginState> emit) async {
//     SessionManager.instance.clearToken();

//     final data = event.param as LoginFormzState;

//     emit(state.copyWith(status: LoginStatus.loading));

//     final AuthLocalStorageDataSource authLocalStorageDataSource = getIt();
//     final toggle = await authLocalStorageDataSource.checkBiometricToggleState();
//     final loginData = await authLocalStorageDataSource.getSavedLoginData();
//     final phone = loginData?.phone;

//     final result = await authRepository.login(event.param);
//     SessionManager.instance.clearToken();
//     result.fold(
//       (l) {
//         emit(state.copyWith(status: LoginStatus.failure, failures: l));
//       },
//       (r) async {
//         authLocalStorageDataSource.clearLoginData();
//         emit(state.copyWith(status: LoginStatus.success, entity: r));
//         SessionManager.instance.setToken(r.data.tokens?.accessToken ?? '');
//         SessionManager.instance
//             .setRefreshToken(r.data.tokens?.refreshToken ?? '');
//         // _getNotificationToken(authRepository);
//         // if (phone != data.phoneNo.value) {
//         await Future.delayed(const Duration(milliseconds: 800));

//         await authLocalStorageDataSource.saveLoginData(
//           hashedPin: '',
//           phone: data.phoneNo.value,
//           pin: data.pin.value,
//           toggleBiometrics: phone == data.phoneNo.value && toggle,
//         );
//         _getNotificationToken(authRepository);
//       },
//     );
//   }

//   void _getNotificationToken(
//     AuthRepository authRepo,
//   ) async {
//     late String token;
//     // ignore: unused_local_variable
//     late String? token2;
//     if (Platform.isAndroid) {
//       token2 = await FirebaseMessaging.instance.getToken();
//       token = await NotificationManager.firebaseMessaging.getToken() ??
//           AppStrings.na;
//     } else if (Platform.isIOS) {
//       token = await NotificationManager.firebaseMessaging.getAPNSToken() ??
//           AppStrings.na;
//       token2 = await FirebaseMessaging.instance.getAPNSToken();
//     }
//     // print('apns ${await FirebaseMessaging.instance.getAPNSToken()}');
//     // print('token ${await FirebaseMessaging.instance.getToken()}');
//     _saveToken(authRepo, token);
//   }

//   void _saveToken(AuthRepository authRepo, String token) async {
//     authRepository.saveToken(SaveTokenParam(token));
//   }
// }
