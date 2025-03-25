part of 'create_team_bloc.dart';

sealed class CreateTeamEvent extends Equatable {
  const CreateTeamEvent();

  @override
  List<Object> get props => [];
}

class CreateTeam extends CreateTeamEvent {
  final RequestParam param;
  const CreateTeam(this.param);

  @override
  List<Object> get props => [param];
}
