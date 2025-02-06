// import 'package:road_app/app/__app.dart';
// import 'package:road_app/features/auth/__auth.dart';

// void setUpAuthLocator() {
//   // data sources
//   getIt.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(
//       httpHelper: getIt(),
//     ),
//   );

//   // repositories
//   getIt.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(
//       remoteDataSource: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(() => UserProfileManager());

//   // blocs

//   getIt.registerFactory(
//     () => CreateAccountBloc(
//       authRepository: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => CreateAccountSendOtpBloc(
//       authRepository: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => CreateAccountVerifyBvnOtpBloc(
//       authRepository: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => CreateAccountVerifyBvnBloc(
//       authRepository: getIt(),
//     ),
//   );

//   // forgot password

//   getIt.registerLazySingleton(
//     () => ForgotPasswordResendOtpBloc(
//       authRepository: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => ForgotPasswordVerifyBvnBloc(
//       authRepository: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => ForgotPasswordVerifyOtpBloc(
//       authRepository: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => ForgetPasswordRestPasswordBloc(
//       authRepository: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => UserBloc(
//       authRepository: getIt(),
//       userProfileManager: getIt(),
//     ),
//   );

//   getIt.registerLazySingleton(
//     () => LoginBloc(
//       authRepository: getIt(),
//     ),
//   );

//   // Cubit

//   getIt.registerSingleton(
//     CreateAccountCubit(),
//   );

//   getIt.registerSingleton(
//     ForgotPasswordCubit(),
//   );

//   getIt.registerSingleton(
//     LoginCubit(
//       userBloc: getIt(),
//       userProfileManager: getIt(),
//     ),
//   );
// }

// void resetAuthFeature() {
//   // setUpAuthLocator(); // Reinitialize auth dependencies
// }
