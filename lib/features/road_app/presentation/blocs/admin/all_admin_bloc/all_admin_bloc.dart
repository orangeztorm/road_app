import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_admin_model.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'all_admin_event.dart';
part 'all_admin_state.dart';

class AllAdminBloc extends Bloc<AllAdminEvent, AllAdminState> {
  final RoadAppRepository repository;
  AllAdminBloc({
    required this.repository,
  }) : super(AllAdminState.initial()) {
    on<FetchAllAdmins>(_onFetchAllAdmins);
    on<FetchMoreAllAdmins>(_onFetchMoreAllAdmins);
  }

  void _onFetchAllAdmins(
    FetchAllAdmins event,
    Emitter<AllAdminState> emit,
  ) async {
    emit(state.copyWith(status: AllAdminStatus.loading));
    final result = await repository.allAdmins(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: AllAdminStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: AllAdminStatus.success,
            admins: data.data.docs,
            hasReachedMax: data.data.page == data.data.totalPages,
          ),
        );
      },
    );
  }

  void _onFetchMoreAllAdmins(
    FetchMoreAllAdmins event,
    Emitter<AllAdminState> emit,
  ) async {
    emit(state.copyWith(status: AllAdminStatus.loadMore));
    final result = await repository.allAdmins(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: AllAdminStatus.failure,
          failures: failures,
        ));
      },
      (data) {
        emit(
          state.copyWith(
            status: AllAdminStatus.success,
            admins: [...state.admins, ...data.data.docs],
            hasReachedMax: data.data.page == data.data.totalPages,
          ),
        );
      },
    );
  }
}
