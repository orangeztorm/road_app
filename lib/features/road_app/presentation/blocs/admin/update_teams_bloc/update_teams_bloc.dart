import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'update_teams_event.dart';
part 'update_teams_state.dart';

class UpdateTeamsBloc extends Bloc<UpdateTeamsEvent, UpdateTeamsState> {
  final RoadAppRepository repository;
  UpdateTeamsBloc({
    required this.repository,
  }) : super(UpdateTeamsState.initial()) {
    on<UpdateTeam>(_onUpdateTeam);
  }

  void _onUpdateTeam(
    UpdateTeam event,
    Emitter<UpdateTeamsState> emit,
  ) async {
    emit(state.copyWith(status: UpdateTeamsStatus.loading));
    final result = await repository.updateTeams(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: UpdateTeamsStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: UpdateTeamsStatus.success,
            message: data.message,
          ),
        );
      },
    );
  }
}
