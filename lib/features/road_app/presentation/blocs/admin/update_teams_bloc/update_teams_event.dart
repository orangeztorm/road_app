part of 'update_teams_bloc.dart';

sealed class UpdateTeamsEvent extends Equatable {
  const UpdateTeamsEvent();

  @override
  List<Object> get props => [];
}

class UpdateTeam extends UpdateTeamsEvent {
  final RequestParam param;
  const UpdateTeam(this.param);

  @override
  List<Object> get props => [param];
}
