import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'admin_profile_event.dart';
part 'admin_profile_state.dart';

class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  final RoadAppRepository roadAppRepository;
  AdminProfileBloc({
    required this.roadAppRepository,
  }) : super(AdminProfileState.initial()) {
    on<GetAdminProfile>(_onGetAdminProfile);
  }

  void _onGetAdminProfile(
      GetAdminProfile event, Emitter<AdminProfileState> emit) async {
    emit(state.copyWith(status: AdminProfileStatus.loading));
    final result = await roadAppRepository.adminProfile(const NoParams());
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: AdminProfileStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: AdminProfileStatus.success,
          data: data,
        ));
      },
    );
  }
}
