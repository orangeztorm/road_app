import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/__road_app.dart';

part 'create_team_event.dart';
part 'create_team_state.dart';

class CreateTeamBloc extends Bloc<CreateTeamEvent, CreateTeamState> {
  final RoadAppRepository repository;
  CreateTeamBloc({
    required this.repository,
  }) : super(CreateTeamState.initial()) {
    on<CreateTeam>(_onCreateTeam);
  }

  void _onCreateTeam(
    CreateTeam event,
    Emitter<CreateTeamState> emit,
  ) async {
    emit(state.copyWith(status: CreateTeamStatus.loading));
    final result = await repository.createTeams(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: CreateTeamStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: CreateTeamStatus.success,
            message: data.message,
          ),
        );
      },
    );
  }
}
