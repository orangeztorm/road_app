import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/__road_app.dart';

part 'detect_pothole_event.dart';
part 'detect_pothole_state.dart';

class DetectPotholeBloc extends Bloc<DetectPotholeEvent, DetectPotholeState> {
  final RoadAppRepository roadAppRepository;
  DetectPotholeBloc({
    required this.roadAppRepository,
  }) : super(DetectPotholeState.initial()) {
    on<DetectPothole>(_onDetectPothole);
  }

  void _onDetectPothole(
      DetectPothole event, Emitter<DetectPotholeState> emit) async {
    try {
      emit(state.copyWith(status: DetectPotholeStatus.loading));
      final result = await roadAppRepository.potholesDetect(event.param);
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: DetectPotholeStatus.failure,
            failure: failure,
          ),
        ),
        (data) => emit(
          state.copyWith(
            status: DetectPotholeStatus.success,
            data: data,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          failure: BaseFailures(message: e.toString()),
          status: DetectPotholeStatus.failure,
        ),
      );
    }
  }
}
