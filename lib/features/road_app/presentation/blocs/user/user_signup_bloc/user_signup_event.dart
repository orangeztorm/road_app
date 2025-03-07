part of 'user_signup_bloc.dart';

sealed class UserSignupEvent extends Equatable {
  const UserSignupEvent();

  @override
  List<Object> get props => [];
}

class UserSignUp extends UserSignupEvent {
  final RequestParam param;

  const UserSignUp(this.param);

  @override
  List<Object> get props => [param];
}
