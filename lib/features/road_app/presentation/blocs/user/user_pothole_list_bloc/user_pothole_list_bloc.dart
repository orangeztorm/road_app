import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'user_pothole_list_event.dart';
part 'user_pothole_list_state.dart';

class UserPotholeListBloc
    extends Bloc<UserPotholeListEvent, UserPotholeListState> {
  final RoadAppRepository roadAppRepository;
  UserPotholeListBloc({
    required this.roadAppRepository,
  }) : super(UserPotholeListState.initial()) {
    on<FetchUserPotholes>(_onFetchUserPotholes);
    on<FetchMoreUserPotholes>(_onFetchMoreUserPotholes);
  }

  void _onFetchUserPotholes(
      FetchUserPotholes event, Emitter<UserPotholeListState> emit) async {
    emit(state.copyWith(status: UserPotholeListStatus.loading));
    final result = await roadAppRepository.listPotholes(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: UserPotholeListStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: UserPotholeListStatus.success,
          potholes: data.data.docs,
        ));
      },
    );
  }

  void _onFetchMoreUserPotholes(
      FetchMoreUserPotholes event, Emitter<UserPotholeListState> emit) async {
    emit(state.copyWith(status: UserPotholeListStatus.loadMore));
    final result = await roadAppRepository.listPotholes(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: UserPotholeListStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: UserPotholeListStatus.success,
          potholes: [...state.potholes, ...data.data.docs],
        ));
      },
    );
  }
}
