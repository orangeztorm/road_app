import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'user_signin_event.dart';
part 'user_signin_state.dart';

class UserSigninBloc extends Bloc<UserSigninEvent, UserSigninState> {
  final RoadAppRepository roadAppRepository;
  UserSigninBloc({
    required this.roadAppRepository,
  }) : super(UserSigninState.initial()) {
    on<UserSignIn>(_onUserSignIn);
  }

  void _onUserSignIn(UserSignIn event, Emitter<UserSigninState> emit) async {
    emit(state.copyWith(status: UserSigninStatus.loading));
    final result = await roadAppRepository.signin(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: UserSigninStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        SessionManager.instance.setToken(data.data.accessToken);
        emit(state.copyWith(
          status: UserSigninStatus.success,
          message: data.message,
        ));
      },
    );
  }
}
