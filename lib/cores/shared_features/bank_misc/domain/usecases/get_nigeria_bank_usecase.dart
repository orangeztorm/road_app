import 'package:fpdart/fpdart.dart';

import '../../../../failures/base.dart';
import '../../../../usecase/params.dart';
import '../../../../usecase/usecase_interface.dart';
import '../entities/get_nigeria_bank_entity.dart';
import '../repositories/bank_misc_repository.dart';

class GetNigerianBanksUsecase
    implements UseCaseFuture<Failures, GetNigeriaBankEntity, NoParams> {
  final BankMiscRepository repository;

  const GetNigerianBanksUsecase({required this.repository});

  @override
  Future<Either<Failures, GetNigeriaBankEntity>> call(NoParams params) async {
    return await repository.getNigerianBanks();
  }
}
