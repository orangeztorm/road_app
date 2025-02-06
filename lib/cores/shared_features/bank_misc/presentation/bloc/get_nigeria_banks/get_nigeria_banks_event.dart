part of 'get_nigeria_banks_bloc.dart';

abstract class NigeriaBanksEvent extends Equatable {
  const NigeriaBanksEvent();

  @override
  List<Object> get props => [];
}

class GetNigeriaBanksEvent extends NigeriaBanksEvent {}

class SearchNigeriaBanksEvent extends NigeriaBanksEvent {
  final String query;

  const SearchNigeriaBanksEvent(this.query);
}
