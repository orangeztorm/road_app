import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../usecase/params.dart';
import '../../../domain/entities/get_nigeria_bank_entity.dart';
import '../../../domain/usecases/get_nigeria_bank_usecase.dart';

part 'get_nigeria_banks_event.dart';
part 'get_nigeria_banks_state.dart';

class GetNigeriaBanksBloc
    extends Bloc<NigeriaBanksEvent, GetNigeriaBanksState> {
  final GetNigerianBanksUsecase getNigerianBanksUsecase;
  List<NigeriaBankEntity> banks = [];

  GetNigeriaBanksBloc({
    required this.getNigerianBanksUsecase,
  }) : super(GetNigeriaBanksInitial()) {
    on<GetNigeriaBanksEvent>((event, emit) async {
      emit(GetNigeriaBanksLoading());

      final result = await getNigerianBanksUsecase(const NoParams());

      result.fold(
        (failure) => emit(GetNigeriaBanksError(failure.message)),
        (data) {
          banks = data.banks;
          emit(GetNigeriaBanksSuccess(data));
        },
      );
    });

    on<SearchNigeriaBanksEvent>((event, emit) {
      final String query = event.query.toLowerCase();
      List<NigeriaBankEntity> searchData = [];
      emit(GetNigeriaBanksLoading());

      if (event.query.isEmpty) {
        searchData = banks;
      } else {
        searchData = banks
            .where((bank) => bank.bankName.toLowerCase().startsWith(query))
            .toList();
      }

      emit(SearchNigeriaBanksLoaded(searchData));
    });
  }
}
