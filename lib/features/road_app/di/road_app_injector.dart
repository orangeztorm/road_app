import 'package:road_app/app/__app.dart';
import 'package:road_app/features/road_app/__road_app.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/admin_report_bloc/admin_report_bloc.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/all_admin_bloc/all_admin_bloc.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/all_teams_bloc/all_teams_bloc.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/complete_pothole_assesment_bloc/complete_pothole_assesment_bloc.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/create_admin_bloc/create_admin_bloc.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/create_team_bloc/create_team_bloc.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/all_admin_list_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/all_teams_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/assign_team_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/create_admin_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/create_teams_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/get_all_report_cubit.dart';

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

  getIt.registerLazySingleton<AllAdminBloc>(
    () => AllAdminBloc(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<AllTeamsBloc>(
    () => AllTeamsBloc(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<CompletePotholeAssesmentBloc>(
    () => CompletePotholeAssesmentBloc(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<CreateAdminBloc>(
    () => CreateAdminBloc(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<CreateTeamBloc>(
    () => CreateTeamBloc(
      repository: getIt(),
    ),
  );

  getIt.registerLazySingleton<AdminReportBloc>(
    () => AdminReportBloc(
      roadAppRepository: getIt(),
    ),
  );

  // cubits
  getIt.registerLazySingleton<GetAllReportsCubit>(
    () => GetAllReportsCubit(),
  );

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

  getIt.registerLazySingleton<AllAdminsListCubit>(
    () => AllAdminsListCubit(),
  );

  getIt.registerLazySingleton<AllTeamsListCubit>(
    () => AllTeamsListCubit(),
  );

  getIt.registerLazySingleton<CreateTeamsCubit>(
    () => CreateTeamsCubit(),
  );

  getIt.registerLazySingleton<CreateAdminCubit>(
    () => CreateAdminCubit(),
  );

  getIt.registerLazySingleton<AssignTeamCubit>(
    () => AssignTeamCubit(),
  );
}
