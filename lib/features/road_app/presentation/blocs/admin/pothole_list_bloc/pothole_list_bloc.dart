import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'pothole_list_event.dart';
part 'pothole_list_state.dart';

class PotholeListBloc extends Bloc<PotholeListEvent, PotholeListState> {
  final RoadAppRepository roadAppRepository;
  PotholeListBloc({
    required this.roadAppRepository,
  }) : super(PotholeListState.initial()) {
    on<GetPotholes>(_onPotholeList);
    on<GetMorePotholes>(_onGetMorePotholes);
  }

  void _onPotholeList(GetPotholes event, Emitter<PotholeListState> emit) async {
    emit(state.copyWith(status: PotholeListStatus.loading));
    final result = await roadAppRepository.potholesList(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: PotholeListStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: PotholeListStatus.success,
          data: data.data.docs,
          hasMore: data.data.page < data.data.totalPages,
        ));
      },
    );
  }

  void _onGetMorePotholes(
      GetMorePotholes event, Emitter<PotholeListState> emit) async {
    emit(state.copyWith(status: PotholeListStatus.loadMore));
    final result = await roadAppRepository.potholesList(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: PotholeListStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: PotholeListStatus.success,
          data: [...state.data!, ...data.data.docs],
          hasMore:false,
        ));
      },
    );
  }
}
