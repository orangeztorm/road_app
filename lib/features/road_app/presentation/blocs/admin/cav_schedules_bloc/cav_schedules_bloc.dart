import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'cav_schedules_event.dart';
part 'cav_schedules_state.dart';

class CavSchedulesBloc extends Bloc<CavSchedulesEvent, CavSchedulesState> {
  final RoadAppRepository roadAppRepository;
  CavSchedulesBloc({
    required this.roadAppRepository,
  }) : super(CavSchedulesState.initial()) {
    on<GetCavSchedules>(_onGetCavSchedules);
    on<GetMoreCavSchedules>(_onGetMoreCavSchedules);
  }

  void _onGetCavSchedules(
      GetCavSchedules event, Emitter<CavSchedulesState> emit) async {
    emit(state.copyWith(status: CavSchedulesStatus.loading));
    final result = await roadAppRepository.cavSchedules(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: CavSchedulesStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: CavSchedulesStatus.success,
          data: data.data,
          hasNext: data.currentPage < data.totalPages,
        ));
      },
    );
  }

  void _onGetMoreCavSchedules(
      GetMoreCavSchedules event, Emitter<CavSchedulesState> emit) async {
    emit(state.copyWith(status: CavSchedulesStatus.loadMore));
    final result = await roadAppRepository.cavSchedules(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: CavSchedulesStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: CavSchedulesStatus.success,
          data: [...state.data!, ...data.data],
          hasNext: data.currentPage < data.totalPages,
        ));
      },
    );
  }
}
