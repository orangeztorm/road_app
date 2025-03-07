part of 'user_signin_bloc.dart';

enum UserSigninStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == UserSigninStatus.initial;
  bool get isLoading => this == UserSigninStatus.loading;
  bool get isSuccess => this == UserSigninStatus.success;
  bool get isFailure => this == UserSigninStatus.failure;
}

class UserSigninState extends Equatable {
  const UserSigninState({
    this.status = UserSigninStatus.initial,
    this.message,
    this.failure,
  });

  final UserSigninStatus status;
  final String? message;
  final Failures? failure;

  factory UserSigninState.initial() {
    return const UserSigninState();
  }

  UserSigninState copyWith({
    UserSigninStatus? status,
    String? message,
    Failures? failure,
  }) {
    return UserSigninState(
      status: status ?? this.status,
      message: message ?? this.message,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [status, message, failure];
}
