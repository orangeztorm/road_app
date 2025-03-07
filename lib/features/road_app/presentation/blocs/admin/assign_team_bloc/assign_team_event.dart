part of 'assign_team_bloc.dart';

sealed class AssignTeamEvent extends Equatable {
  const AssignTeamEvent();

  @override
  List<Object> get props => [];
}

class AssignTeam extends AssignTeamEvent {
  final RequestParam param;

  const AssignTeam(this.param);

  @override
  List<Object> get props => [param];
}
