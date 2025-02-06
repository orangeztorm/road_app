import 'package:fpdart/fpdart.dart';
import 'package:road_app/cores/__cores.dart';

abstract class BankMiscRepository {
  Future<Either<Failures, GetNigeriaBankModel>> getNigerianBanks();

  Future<Either<Failures, ResolveBankModel>> resolveBankAccount(
    RequestParam requestParam,
  );

  Future<Either<Failures, ConvertCurrencyEntity>> convertAmount(
    RequestParam requestParam,
  );
}
