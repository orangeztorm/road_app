import 'package:road_app/app/__app.dart';
import 'package:road_app/features/road_app/__road_app.dart';
void setUpRoadAppLocator() {
  // Data Sources
  getIt.registerLazySingleton<RoadAppRemoteDataSource>(
    () => RoadAppRemoteDataSourceImpl(
      httpHelper: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<RoadAppRepository>(
    () => RoadAppRepositoryImpl(
      remoteDataSource: getIt(),
    ),
  );

  // api manager
  getIt.registerLazySingleton<UserProfileManager>(
    () => UserProfileManager(),
  );

  getIt.registerLazySingleton<AdminProfileManager>(
    () => AdminProfileManager(),
  );

  // blocs
  getIt.registerLazySingleton<AdminLoginBloc>(
    () => AdminLoginBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<PotholeListBloc>(
    () => PotholeListBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<CavSchedulesBloc>(
    () => CavSchedulesBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<AdminProfileBloc>(
    () => AdminProfileBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<NearbyPotholeBloc>(
    () => NearbyPotholeBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<UserPotholeListBloc>(
    () => UserPotholeListBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<UserSigninBloc>(
    () => UserSigninBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<UserSignupBloc>(
    () => UserSignupBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<DetectPotholeBloc>(
    () => DetectPotholeBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<AssignTeamBloc>(
    () => AssignTeamBloc(
      roadAppRepository: getIt(),
    ),
  );

  getIt.registerLazySingleton<AddToScheduleBloc>(
    () => AddToScheduleBloc(
      roadAppRepository: getIt(),
    ),
  );

  // cubits
  getIt.registerLazySingleton<AdminLoginCubit>(
    () => AdminLoginCubit(),
  );

  getIt.registerLazySingleton<PotholeListCubit>(
    () => PotholeListCubit(),
  );

  getIt.registerLazySingleton<CavScheduleCubit>(
    () => CavScheduleCubit(),
  );

  getIt.registerLazySingleton<NearbyPotholeCubit>(
    () => NearbyPotholeCubit(),
  );

  getIt.registerLazySingleton<UserPotholeListCubit>(
    () => UserPotholeListCubit(),
  );

  getIt.registerLazySingleton<UserSignInCubit>(
    () => UserSignInCubit(),
  );

  getIt.registerLazySingleton<UserSignUpCubit>(
    () => UserSignUpCubit(),
  );

  getIt.registerLazySingleton<DetectPotholeCubit>(
    () => DetectPotholeCubit(),
  );
}
