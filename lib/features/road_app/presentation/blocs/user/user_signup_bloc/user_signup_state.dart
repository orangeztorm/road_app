part of 'user_signup_bloc.dart';

enum UserSignupStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == UserSignupStatus.initial;
  bool get isLoading => this == UserSignupStatus.loading;
  bool get isSuccess => this == UserSignupStatus.success;
  bool get isFailure => this == UserSignupStatus.failure;
}

class UserSignupState extends Equatable {
  const UserSignupState({
    this.status = UserSignupStatus.initial,
    this.data,
    this.failure,
  });

  final UserSignupStatus status;
  final dynamic data;
  final Failures? failure;

  factory UserSignupState.initial() {
    return const UserSignupState();
  }

  UserSignupState copyWith({
    UserSignupStatus? status,
    dynamic data,
    Failures? failure,
  }) {
    return UserSignupState(
      status: status ?? this.status,
      data: data ?? this.data,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
        failure,
      ];
}
