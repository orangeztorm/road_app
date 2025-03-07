import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

part 'admin_login_event.dart';
part 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  final RoadAppRepository roadAppRepository;
  AdminLoginBloc({
    required this.roadAppRepository,
  }) : super(AdminLoginState.initial()) {
    on<AdminLogin>(_onAdminLogin);
  }

  void _onAdminLogin(AdminLogin event, Emitter<AdminLoginState> emit) async {
    emit(state.copyWith(status: AdminLoginStatus.loading));
    final result = await roadAppRepository.adminLogin(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: AdminLoginStatus.failure,
          failure: failures,
          message: failures.message,
        ));
      },
      (data) {
        SessionManager.instance.setToken(data.data?.accessToken ?? '');
        emit(state.copyWith(
          status: AdminLoginStatus.success,
          message: data.message,
        ));
      },
    );
  }
}
