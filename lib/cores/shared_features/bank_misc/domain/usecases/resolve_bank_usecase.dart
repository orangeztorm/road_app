import 'package:fpdart/fpdart.dart';

import '../../../../base_request_body/base_request_body.dart';
import '../../../../failures/base.dart';
import '../../../../usecase/usecase_interface.dart';
import '../entities/resolved_bank_account_entity.dart';
import '../repositories/bank_misc_repository.dart';

class ResolveBankUsecase
    implements UseCaseFuture<Failures, ResolveBankEntity, RequestParam> {
  final BankMiscRepository repository;

  const ResolveBankUsecase({required this.repository});

  @override
  Future<Either<Failures, ResolveBankEntity>> call(
    RequestParam params,
  ) async {
    return await repository.resolveBankAccount(params);
  }
}
