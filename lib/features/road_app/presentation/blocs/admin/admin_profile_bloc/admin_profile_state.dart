part of 'admin_profile_bloc.dart';

enum AdminProfileStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == AdminProfileStatus.loading;
  bool get isSuccess => this == AdminProfileStatus.success;
  bool get isFailure => this == AdminProfileStatus.failure;
  bool get isInitial => this == AdminProfileStatus.initial;
}

class AdminProfileState extends Equatable {
  const AdminProfileState({
    this.status = AdminProfileStatus.initial,
    this.failure,
    this.data,
  });

  final AdminProfileStatus status;
  final Failures? failure;
  final AdminProfileEntity? data;

  factory AdminProfileState.initial() => const AdminProfileState();

  AdminProfileState copyWith({
    AdminProfileStatus? status,
    Failures? failure,
    AdminProfileEntity? data,
  }) {
    return AdminProfileState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, failure, data];
}
