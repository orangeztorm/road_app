import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/data/_data.dart';
import 'package:road_app/features/road_app/data/responses/user/nearby_potholes_model.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';
import 'package:fpdart/fpdart.dart';
import 'package:road_app/features/road_app/domain/entities/user/nearby_pothole_entity.dart';

class RoadAppRepositoryImpl extends RoadAppRepository {
  final RoadAppRemoteDataSource remoteDataSource;

  RoadAppRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, AdminLoginEntity>> adminLogin(
      RequestParam param) async {
    final action = remoteDataSource.adminLogin(param);

    final repoTryCatchHelper = RepoTryCatchHelper<AdminLoginModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, BaseModel>> adminLogout(NoParams param) async {
    final action = remoteDataSource.adminLogout(param);

    final repoTryCatchHelper = RepoTryCatchHelper<BaseModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, AdminProfileEntity>> adminProfile(
      NoParams param) async {
    final action = remoteDataSource.adminProfile(param);

    final repoTryCatchHelper = RepoTryCatchHelper<AdminProfileModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, PotholeDetectEntity>> potholesDetect(
      RequestParam param) async {
    final action = remoteDataSource.potholesDetect(param);

    final repoTryCatchHelper = RepoTryCatchHelper<PotholeDetectModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, PotholeListEntity>> potholesList(
      RequestParam param) async {
    final action = remoteDataSource.potholesList(param);

    final repoTryCatchHelper = RepoTryCatchHelper<PotholeListModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  // @override
  // Future<Either<Failures, BaseModel>> updatePotholes(RequestParam param) async {
  //   final action = remoteDataSource.updatePotholes(param);

  //   final repoTryCatchHelper = RepoTryCatchHelper<BaseModel>();
  //   return repoTryCatchHelper.tryAction(() => action);
  // }

  @override
  Future<Either<Failures, AssignTeamEntity>> assignTeam(
      RequestParam param) async {
    final action = remoteDataSource.assignTeam(param);

    final repoTryCatchHelper = RepoTryCatchHelper<AssignTeamModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  // @override
  // Future<Either<Failures, BaseModel>> assignMaintainanceTeam(
  //     RequestParam param) async {
  //   final action = remoteDataSource.assignMaintainanceTeam(param);

  //   final repoTryCatchHelper = RepoTryCatchHelper<BaseModel>();
  //   return repoTryCatchHelper.tryAction(() => action);
  // }

  // @override
  // Future<Either<Failures, BaseModel>> getPotholeSummary(
  //     RequestParam param) async {
  //   final action = remoteDataSource.getPotholeSummary(param);

  //   final repoTryCatchHelper = RepoTryCatchHelper<BaseModel>();
  //   return repoTryCatchHelper.tryAction(() => action);
  // }

  @override
  Future<Either<Failures, CavSchedulesListEntity>> cavSchedules(
      RequestParam param) async {
    final action = remoteDataSource.cavSchedules(param);

    final repoTryCatchHelper = RepoTryCatchHelper<CavSchedulesListModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, BaseModel>> addToSchedule(RequestParam param) async {
    final action = remoteDataSource.addToSchedule(param);

    final repoTryCatchHelper = RepoTryCatchHelper<BaseModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, BaseModel>> listPotholes(RequestParam param) async {
    final action = remoteDataSource.listPotholes(param);

    final repoTryCatchHelper = RepoTryCatchHelper<BaseModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, NearbyPotholesEntity>> potholesNearby(
      RequestParam param) async {
    final action = remoteDataSource.potholesNearby(param);

    final repoTryCatchHelper = RepoTryCatchHelper<NearbyPotholesModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, UserSignupEntity>> signup(RequestParam param) async {
    final action = remoteDataSource.signup(param);

    final repoTryCatchHelper = RepoTryCatchHelper<UserSignupModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, UserSignInEntity>> signin(RequestParam param) async {
    final action = remoteDataSource.signin(param);

    final repoTryCatchHelper = RepoTryCatchHelper<UserSignInModel>();
    return repoTryCatchHelper.tryAction(() => action);
  }
}
