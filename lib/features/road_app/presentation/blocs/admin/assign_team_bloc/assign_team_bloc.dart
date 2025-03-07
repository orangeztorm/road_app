import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

part 'assign_team_event.dart';
part 'assign_team_state.dart';

class AssignTeamBloc extends Bloc<AssignTeamEvent, AssignTeamState> {
  final RoadAppRepository roadAppRepository;
  AssignTeamBloc({
    required this.roadAppRepository,
  }) : super(AssignTeamState.initial()) {
    on<AssignTeam>(_onAssignTeam);
  }

  void _onAssignTeam(AssignTeam event, Emitter<AssignTeamState> emit) async {
    try {
      emit(state.copyWith(status: AssignTeamStatus.loading));
      final result = await roadAppRepository.assignTeam(event.param);
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: AssignTeamStatus.failure,
            failure: failure,
          ),
        ),
        (data) => emit(
          state.copyWith(
            status: AssignTeamStatus.success,
            message: data.message,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          failure: BaseFailures(message: e.toString()),
          status: AssignTeamStatus.failure,
        ),
      );
    }
  }
}
