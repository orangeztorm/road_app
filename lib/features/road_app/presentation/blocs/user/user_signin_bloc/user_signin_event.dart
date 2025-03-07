part of 'user_signin_bloc.dart';

sealed class UserSigninEvent extends Equatable {
  const UserSigninEvent();

  @override
  List<Object> get props => [];
}

class UserSignIn extends UserSigninEvent {
  final RequestParam param;

  const UserSignIn(this.param);

  @override
  List<Object> get props => [param];
}
