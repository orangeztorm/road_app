part of 'create_admin_bloc.dart';

enum CreateAdminStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == CreateAdminStatus.initial;
  bool get isLoading => this == CreateAdminStatus.loading;
  bool get isSuccess => this == CreateAdminStatus.success;
  bool get isFailure => this == CreateAdminStatus.failure;
}

class CreateAdminState extends Equatable {
  const CreateAdminState({
    this.status = CreateAdminStatus.initial,
    this.failures,
    this.message,
  });

  final CreateAdminStatus status;
  final Failures? failures;
  final String? message;

  factory CreateAdminState.initial() => const CreateAdminState();

  CreateAdminState copyWith({
    CreateAdminStatus? status,
    Failures? failures,
    String? message,
  }) {
    return CreateAdminState(
      status: status ?? this.status,
      failures: failures,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        failures,
        message,
      ];
}
