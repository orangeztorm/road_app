import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/__road_app.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_teams_model.dart';

part 'all_teams_event.dart';
part 'all_teams_state.dart';

class AllTeamsBloc extends Bloc<AllTeamsEvent, AllTeamsState> {
  final RoadAppRepository repository;
  AllTeamsBloc({
    required this.repository,
  }) : super(AllTeamsState.initial()) {
    on<FetchAllTeams>(_onFetchAllTeams);
    on<FetchMoreAllTeams>(_onFetchMoreAllTeams);
  }

  void _onFetchAllTeams(
    FetchAllTeams event,
    Emitter<AllTeamsState> emit,
  ) async {
    emit(state.copyWith(status: AllTeamsStatus.loading));
    final result = await repository.allTeams(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: AllTeamsStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: AllTeamsStatus.success,
            teams: data.data.docs,
            hasReachedMax: data.data.page == data.data.totalPages,
          ),
        );
      },
    );
  }

  void _onFetchMoreAllTeams(
    FetchMoreAllTeams event,
    Emitter<AllTeamsState> emit,
  ) async {
    emit(state.copyWith(status: AllTeamsStatus.loadMore));
    final result = await repository.allTeams(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: AllTeamsStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: AllTeamsStatus.success,
            teams: [...state.teams, ...data.data.docs],
            hasReachedMax: data.data.page == data.data.totalPages,
          ),
        );
      },
    );
  }
}
