part of 'all_teams_bloc.dart';

sealed class AllTeamsEvent extends Equatable {
  const AllTeamsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllTeams extends AllTeamsEvent {
  final RequestParam param;
  const FetchAllTeams(this.param);

  @override
  List<Object> get props => [param];
}

class FetchMoreAllTeams extends AllTeamsEvent {
  final RequestParam param;
  const FetchMoreAllTeams(this.param);

  @override
  List<Object> get props => [param];
}
