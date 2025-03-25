import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/__road_app.dart';

part 'create_admin_event.dart';
part 'create_admin_state.dart';

class CreateAdminBloc extends Bloc<CreateAdminEvent, CreateAdminState> {
  final RoadAppRepository repository;
  CreateAdminBloc({
    required this.repository,
  }) : super(CreateAdminState.initial()) {
    on<CreateAdmin>(_onCreateAdmin);
  }

  void _onCreateAdmin(
    CreateAdmin event,
    Emitter<CreateAdminState> emit,
  ) async {
    emit(state.copyWith(status: CreateAdminStatus.loading));
    final result = await repository.createAdmin(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: CreateAdminStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: CreateAdminStatus.success,
            message: data.message,
          ),
        );
      },
    );
  }
}
