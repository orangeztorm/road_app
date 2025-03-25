import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/__road_app.dart';

part 'nearby_pothole_event.dart';
part 'nearby_pothole_state.dart';

class NearbyPotholeBloc extends Bloc<NearbyPotholeEvent, NearbyPotholeState> {
  final RoadAppRepository roadAppRepository;
  NearbyPotholeBloc({
    required this.roadAppRepository,
  }) : super(NearbyPotholeState.initial()) {
    on<FetchNearbyPotholes>(_onFetchNearbyPotholes);
    on<FetchMoreNearbyPotholes>(_onFetchMoreNearbyPotholes);
  }

  void _onFetchNearbyPotholes(
      FetchNearbyPotholes event, Emitter<NearbyPotholeState> emit) async {
    emit(state.copyWith(status: NearbyPotholeStatus.loading));
    final result = await roadAppRepository.potholesNearby(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: NearbyPotholeStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: NearbyPotholeStatus.success,
          potholes: data.data,
        ));
      },
    );
  }

  void _onFetchMoreNearbyPotholes(
      FetchMoreNearbyPotholes event, Emitter<NearbyPotholeState> emit) async {
    emit(state.copyWith(status: NearbyPotholeStatus.loadMore));
    final result = await roadAppRepository.potholesNearby(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: NearbyPotholeStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: NearbyPotholeStatus.success,
          potholes: [...state.potholes, ...data.data],
        ));
      },
    );
  }
}
