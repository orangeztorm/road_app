import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../base_request_body/base_request_body.dart';
import '../../../domain/entities/resolved_bank_account_entity.dart';
import '../../../domain/usecases/resolve_bank_usecase.dart';

part 'resolve_bank_account_event.dart';
part 'resolve_bank_account_state.dart';

class ResolveBankAccountBloc
    extends Bloc<ResolveBankAccountEvent, ResolveBankAccountState> {
  final ResolveBankUsecase resolveBankUsecase;

  ResolveBankAccountBloc({required this.resolveBankUsecase})
      : super(ResolveBankAccountInitial()) {
    on<ResolveBankAccountEvent>((event, emit) async {
      emit(ResolveBankAccountLoading());

      final result = await resolveBankUsecase(event.requestParam);

      result.fold(
        (failure) => emit(ResolveBankAccountError(failure.message)),
        (data) => emit(ResolveBankAccountSuccess(data)),
      );
    });
  }
}
