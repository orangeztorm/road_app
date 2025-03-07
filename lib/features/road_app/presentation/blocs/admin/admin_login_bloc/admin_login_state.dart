part of 'admin_login_bloc.dart';

enum AdminLoginStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == AdminLoginStatus.loading;
  bool get isSuccess => this == AdminLoginStatus.success;
  bool get isFailure => this == AdminLoginStatus.failure;
  bool get isInitial => this == AdminLoginStatus.initial;
}

class AdminLoginState extends Equatable {
  const AdminLoginState({
    this.status = AdminLoginStatus.initial,
    this.failure,
    this.message,
  });

  final AdminLoginStatus status;
  final Failures? failure;
  final String? message;

  factory AdminLoginState.initial() => const AdminLoginState();

  AdminLoginState copyWith({
    AdminLoginStatus? status,
    Failures? failure,
    String? message,
  }) {
    return AdminLoginState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        failure,
        message,
      ];
}
