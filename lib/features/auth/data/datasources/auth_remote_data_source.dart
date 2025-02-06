import 'package:road_app/cores/__cores.dart';
// import 'package:road_app/features/auth/data/_data.dart';

abstract class AuthRemoteDataSource {
  Future<BaseModel> verifyBvn(RequestParam param);

  Future<BaseModel> bvnResendOtp(RequestParam param);


}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpHelper httpHelper;

  AuthRemoteDataSourceImpl({required this.httpHelper});

  @override
  Future<BaseModel> verifyBvn(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.verifyBvn,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

  @override
  Future<BaseModel> bvnResendOtp(RequestParam param) async {
    final Map<String, dynamic> response = await httpHelper.post(
      url: ApiEndpoints.resendOtp,
      body: param.toMap(),
    );

    return BaseModel.fromMap(response);
  }

}
