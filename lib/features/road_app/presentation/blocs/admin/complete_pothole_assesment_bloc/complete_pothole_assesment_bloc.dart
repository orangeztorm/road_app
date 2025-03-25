import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/__road_app.dart';

part 'complete_pothole_assesment_event.dart';
part 'complete_pothole_assesment_state.dart';

class CompletePotholeAssesmentBloc
    extends Bloc<CompletePotholeAssesmentEvent, CompletePotholeAssesmentState> {
  final RoadAppRepository repository;
  CompletePotholeAssesmentBloc({
    required this.repository,
  }) : super(CompletePotholeAssesmentState.initial()) {
    on<CompletePotholeAssesment>(_onCompletePotholeAssesment);
  }

  void _onCompletePotholeAssesment(
    CompletePotholeAssesment event,
    Emitter<CompletePotholeAssesmentState> emit,
  ) async {
    emit(state.copyWith(status: CompletePotholeAssesmentStatus.loading));
    final result = await repository.completePotholeAssesment(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: CompletePotholeAssesmentStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: CompletePotholeAssesmentStatus.success,
            message: data.message,
          ),
        );
      },
    );
  }
}
