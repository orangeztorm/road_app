part of 'get_nigeria_banks_bloc.dart';

abstract class GetNigeriaBanksState extends Equatable {
  const GetNigeriaBanksState();

  @override
  List<Object> get props => [];
}

class GetNigeriaBanksInitial extends GetNigeriaBanksState {}

class GetNigeriaBanksLoading extends GetNigeriaBanksState {}

class GetNigeriaBanksError extends GetNigeriaBanksState {
  final String message;

  const GetNigeriaBanksError(this.message);
}

class GetNigeriaBanksSuccess extends GetNigeriaBanksState {
  final GetNigeriaBankEntity getNigeriaBankEntity;

  const GetNigeriaBanksSuccess(this.getNigeriaBankEntity);
}

class SearchNigeriaBanksLoaded extends GetNigeriaBanksState {
  final List<NigeriaBankEntity> searchData;

  const SearchNigeriaBanksLoaded(this.searchData);

  @override
  List<Object> get props => [searchData];
}
