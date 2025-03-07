import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/repositories/road_app_repository.dart';

part 'add_to_schedule_event.dart';
part 'add_to_schedule_state.dart';

class AddToScheduleBloc extends Bloc<AddToScheduleEvent, AddToScheduleState> {
  final RoadAppRepository roadAppRepository;
  AddToScheduleBloc({
    required this.roadAppRepository,
  }) : super(AddToScheduleState.initial()) {
    on<AddToSchedule>(_onAddToSchedule);
  }

  void _onAddToSchedule(
      AddToSchedule event, Emitter<AddToScheduleState> emit) async {
    try {
      emit(state.copyWith(status: AddToScheduleStatus.loading));
      final result = await roadAppRepository.addToSchedule(event.param);
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: AddToScheduleStatus.failure,
            failure: failure,
          ),
        ),
        (data) => emit(
          state.copyWith(
            status: AddToScheduleStatus.success,
            message: data.message,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          failure: BaseFailures(message: e.toString()),
          status: AddToScheduleStatus.failure,
        ),
      );
    }
  }
}
