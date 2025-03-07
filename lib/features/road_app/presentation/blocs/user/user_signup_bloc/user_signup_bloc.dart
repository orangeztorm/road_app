import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

part 'user_signup_event.dart';
part 'user_signup_state.dart';

class UserSignupBloc extends Bloc<UserSignupEvent, UserSignupState> {
  final RoadAppRepository roadAppRepository;
  UserSignupBloc({
    required this.roadAppRepository,
  }) : super(UserSignupState.initial()) {
    on<UserSignUp>(_onUserSignUp);
  }

  void _onUserSignUp(UserSignUp event, Emitter<UserSignupState> emit) async {
    emit(state.copyWith(status: UserSignupStatus.loading));
    final result = await roadAppRepository.signup(event.param);
    result.fold(
      (failures) {
        emit(state.copyWith(
          status: UserSignupStatus.failure,
          failure: failures,
        ));
      },
      (data) {
        emit(state.copyWith(
          status: UserSignupStatus.success,
          data: data,
        ));
      },
    );
  }
}
