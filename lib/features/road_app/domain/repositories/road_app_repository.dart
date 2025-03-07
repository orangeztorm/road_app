import 'package:road_app/cores/__cores.dart';
import 'package:fpdart/fpdart.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

abstract class RoadAppRepository {
  Future<Either<Failures, AdminLoginEntity>> adminLogin(RequestParam param);
  Future<Either<Failures, BaseModel>> adminLogout(NoParams param);
  Future<Either<Failures, AdminProfileEntity>> adminProfile(NoParams param);
  Future<Either<Failures, PotholeDetectEntity>> potholesDetect(
      RequestParam param);
  Future<Either<Failures, PotholeListEntity>> potholesList(RequestParam param);
  // Future<Either<Failures, BaseModel>> updatePotholes(RequestParam param);
  Future<Either<Failures, AssignTeamEntity>> assignTeam(RequestParam param);
  // Future<Either<Failures, BaseModel>> assignMaintainanceTeam(
  //     RequestParam param);
  // Future<Either<Failures, BaseModel>> getPotholeSummary(RequestParam param);
  Future<Either<Failures, CavSchedulesListEntity>> cavSchedules(
      RequestParam param);
  Future<Either<Failures, BaseModel>> addToSchedule(RequestParam param);

  // user
  Future<Either<Failures, BaseModel>> listPotholes(RequestParam param);
  Future<Either<Failures, NearbyPotholesEntity>> potholesNearby(
      RequestParam param);
  Future<Either<Failures, UserSignupEntity>> signup(RequestParam param);
  Future<Either<Failures, UserSignInEntity>> signin(RequestParam param);
}
