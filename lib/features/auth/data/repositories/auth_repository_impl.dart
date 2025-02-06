import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/auth/data/_data.dart';
import 'package:road_app/features/auth/domain/_domain.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  // @override
  // Future<Either<Failures, BvnEntitiy>> verifyBvn(RequestParam param) {
  //   final action = remoteDataSource.verifyBvn(param);

  //   final repoTryCatchHelper = RepoTryCatchHelper<BvnModel>();
  //   return repoTryCatchHelper.tryAction(() => action);
  // }

  // @override
  // Future<Either<Failures, BaseEntity>> bvnResendOtp(RequestParam param) {
  //   final action = remoteDataSource.bvnResendOtp(param);

  //   final repoTryCatchHelper = RepoTryCatchHelper<BaseModel>();
  //   return repoTryCatchHelper.tryAction(() => action);
  // }

  
}
