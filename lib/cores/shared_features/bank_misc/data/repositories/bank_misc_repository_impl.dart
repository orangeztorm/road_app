import 'package:fpdart/fpdart.dart';
import 'package:road_app/cores/__cores.dart';

class BankMiscRepositoryImpl extends BankMiscRepository {
  final BankMiscRemoteDataSource remoteDataSource;

  BankMiscRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, GetNigeriaBankModel>> getNigerianBanks() async {
    final action = remoteDataSource.getNigerianBanks();

    final repoTryCatchHelper = RepoTryCatchHelper<GetNigeriaBankModel>();
    return await repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, ResolveBankModel>> resolveBankAccount(
    RequestParam requestParam,
  ) async {
    final action = remoteDataSource.resolveBankAccount(requestParam);

    final repoTryCatchHelper = RepoTryCatchHelper<ResolveBankModel>();
    return await repoTryCatchHelper.tryAction(() => action);
  }

  @override
  Future<Either<Failures, ConvertCurrencyEntity>> convertAmount(
      RequestParam requestParam) async {
    final action = remoteDataSource.convertAmount(requestParam);

    final repoTryCatchHelper = RepoTryCatchHelper<ConvertCurrencyData>();
    return await repoTryCatchHelper.tryAction(() => action);
  }
}
