import 'package:road_app/cores/__cores.dart';
import 'package:fpdart/fpdart.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_admin_model.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_teams_model.dart';
import 'package:road_app/features/road_app/data/responses/admin/report_model.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

abstract class RoadAppRepository {
  Future<Either<Failures, AdminLoginEntity>> adminLogin(RequestParam param);
  Future<Either<Failures, BaseEntity>> adminLogout(NoParams param);
  Future<Either<Failures, AdminProfileEntity>> adminProfile(NoParams param);
  Future<Either<Failures, PotholeDetectEntity>> potholesDetect(
      RequestParam param);
  Future<Either<Failures, PotholeListEntity>> potholesList(RequestParam param);
  // Future<Either<Failures, BaseModel>> updatePotholes(RequestParam param);
  Future<Either<Failures, BaseModel>> assignTeam(RequestParam param);
  // Future<Either<Failures, BaseModel>> assignMaintainanceTeam(
  //     RequestParam param);
  // Future<Either<Failures, BaseModel>> getPotholeSummary(RequestParam param);
  Future<Either<Failures, CavSchedulesListEntity>> cavSchedules(
      RequestParam param);
  Future<Either<Failures, BaseEntity>> addToSchedule(RequestParam param);

  // user
  Future<Either<Failures, BaseModel>> listPotholes(RequestParam param);
  Future<Either<Failures, NearbyPotholesEntity>> potholesNearby(
      RequestParam param);
  Future<Either<Failures, UserSignupEntity>> signup(RequestParam param);
  Future<Either<Failures, UserSignInEntity>> signin(RequestParam param);

  //Teams
  Future<Either<Failures, AllTeamsModel>> allTeams(RequestParam param);
  Future<Either<Failures, ReportModel>> adminReport(RequestParam param);
  Future<Either<Failures, AllAdminModel>> allAdmins(RequestParam param);
  Future<Either<Failures, BaseEntity>> createAdmin(RequestParam param);
  Future<Either<Failures, BaseEntity>> createTeams(RequestParam param);
  Future<Either<Failures, BaseEntity>> updateTeams(RequestParam param);
  Future<Either<Failures, BaseEntity>> completePotholeAssesment(
      RequestParam param);
}
