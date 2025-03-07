import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/domain/param/assign_team_param.dart';

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
  Future<AssignTeamModel> assignTeam(RequestParam param);
  Future<CavSchedulesListModel> cavSchedules(RequestParam param);

  // user
  Future<BaseModel> listPotholes(RequestParam param);
  Future<NearbyPotholesModel> potholesNearby(RequestParam param);
  Future<UserSignupModel> signup(RequestParam param);
  Future<UserSignInModel> signin(RequestParam param);
  Future<BaseModel> userLogout(RequestParam param);
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
  Future<AssignTeamModel> assignTeam(RequestParam param) async {
    param as AssignTeamParam;
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.assignTeam(param.id),
      // body: param.toMap(),
      body: {},
    );

    return AssignTeamModel.fromJson(response);
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
}
