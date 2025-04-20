import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_admin_model.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_teams_model.dart';
import 'package:road_app/features/road_app/data/responses/admin/report_model.dart';
import 'package:road_app/features/road_app/domain/param/complete_pothole_param.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/assign_team_cubit.dart';

abstract class RoadAppRemoteDataSource {
  //admin login
  Future<AdminLoginModel> adminLogin(RequestParam param);
  Future<BaseModel> adminLogout(NoParams param);
  Future<BaseModel> changePassword(RequestParam param);
  Future<AdminProfileModel> adminProfile(NoParams param);
  Future<PotholeDetectModel> potholesDetect(RequestParam param);
  Future<PotholeListModel> potholesList(RequestParam param);
  Future<BaseModel> addToSchedule(RequestParam param);
  Future<BaseModel> completeSchedule(RequestParam param);
  Future<BaseModel> assignTeam(RequestParam param);
  Future<CavSchedulesListModel> cavSchedules(RequestParam param);
  Future<ReportModel> adminReport(RequestParam param);

  // user
  Future<BaseModel> listPotholes(RequestParam param);
  Future<NearbyPotholesModel> potholesNearby(RequestParam param);
  Future<UserSignupModel> signup(RequestParam param);
  Future<UserSignInModel> signin(RequestParam param);
  Future<BaseModel> userLogout(RequestParam param);

  //Teams
  Future<AllTeamsModel> allTeams(RequestParam param);
  Future<AllAdminModel> allAdmins(RequestParam param);
  Future<BaseModel> createAdmin(RequestParam param);
  Future<BaseModel> createTeams(RequestParam param);
  Future<BaseModel> updateTeams(RequestParam param);
  Future<BaseModel> completePotholeAssesment(RequestParam param);
}

class RoadAppRemoteDataSourceImpl implements RoadAppRemoteDataSource {
  final HttpHelper httpHelper;

  RoadAppRemoteDataSourceImpl({required this.httpHelper});

  @override
  Future<AdminLoginModel> adminLogin(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.adminLogin,
      body: param.toMap(),
    );

    return AdminLoginModel.fromJson(response);
  }

  @override
  Future<BaseModel> adminLogout(NoParams param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.adminLogout,
      body: {},
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<BaseModel> changePassword(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.adminChangePassword,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<AdminProfileModel> adminProfile(NoParams param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.adminProfile,
    );

    return AdminProfileModel.fromJson(response);
  }

  @override
  Future<PotholeDetectModel> potholesDetect(RequestParam param) async {
    param as DetectPotholeFormzState;
    final Map<String, dynamic> response =
        await httpHelper.postMultipartWithFields2(
      url: ApiEndpoints.potholesDetect,
      address: param.address ?? '',
      imageFile: param.image!,
      latitude: param.lat?.toDouble() ?? 0.0,
      longitude: param.lng?.toDouble() ?? 0.0,
    );

    return PotholeDetectModel.fromJson(response);
  }

  @override
  Future<PotholeListModel> potholesList(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.potholesList,
    );

    return PotholeListModel.fromJson(response);
  }

  // @override
  // Future<BaseModel> updatePotholes(RequestParam param) async {
  //   final Map<String, dynamic> response = await httpHelper.post(
  //     url: ApiEndpoints.signIn,
  //     body: param.toMap(),
  //   );

  //   return BaseModel.fromMap(response);
  // }

  @override
  Future<BaseModel> assignTeam(RequestParam param) async {
    param as AssignTeamFormzState;
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.assignTeam(param.potholdId.value),
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  // @override
  // Future<BaseModel> assignMaintainanceTeam(RequestParam param) async {
  //   final Map<String, dynamic> response = await httpHelper.post(
  //     url: ApiEndpoints.signIn,
  //     body: param.toMap(),
  //   );

  //   return BaseModel.fromMap(response);
  // }

  // @override
  // Future<BaseModel> getPotholeSummary(RequestParam param) async {
  //   final Map<String, dynamic> response = await httpHelper.get(
  //     ApiEndpoints.signIn,
  //   );

  //   return BaseModel.fromMap(response);
  // }

  @override
  Future<CavSchedulesListModel> cavSchedules(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.cavSchedules,
      query: param.toMap(),
    );

    return CavSchedulesListModel.fromJson(response);
  }

  @override
  Future<BaseModel> listPotholes(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.signIn,
      query: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<NearbyPotholesModel> potholesNearby(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.nearbyPotholes,
      query: param.toMap(),
    );

    return NearbyPotholesModel.fromJson(response);
  }

  @override
  Future<UserSignupModel> signup(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.userSignup,
      body: param.toMap(),
    );

    return UserSignupModel.fromJson(response);
  }

  @override
  Future<UserSignInModel> signin(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.userSignin,
      body: param.toMap(),
    );

    return UserSignInModel.fromJson(response);
  }

  @override
  Future<BaseModel> userLogout(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.signIn,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<BaseModel> addToSchedule(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.addToSchedule,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<BaseModel> completeSchedule(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.completePothole(''),
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<AllTeamsModel> allTeams(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.allTeams,
    );

    return AllTeamsModel.fromJson(response);
  }

  @override
  Future<AllAdminModel> allAdmins(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.allAdmins,
    );

    return AllAdminModel.fromJson(response);
  }

  @override
  Future<BaseModel> createAdmin(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.createAdmin,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<BaseModel> createTeams(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.createTeams,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<BaseModel> updateTeams(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.put(
      url: ApiEndpoints.updateTeams,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<BaseModel> completePotholeAssesment(RequestParam param) async {
    param as CompletePotholeParam;
    final Map<String, dynamic> response = await httpHelper.put(
      url: ApiEndpoints.completePothole(param.id),
      body: {},
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<ReportModel> adminReport(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.get(
      ApiEndpoints.report,
      query: param.toMap(),
    );

    return ReportModel.fromJson(response);
  }
}
