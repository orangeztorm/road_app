part of 'update_teams_bloc.dart';

enum UpdateTeamsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == UpdateTeamsStatus.initial;
  bool get isLoading => this == UpdateTeamsStatus.loading;
  bool get isSuccess => this == UpdateTeamsStatus.success;
  bool get isFailure => this == UpdateTeamsStatus.failure;
}

class UpdateTeamsState extends Equatable {
  const UpdateTeamsState({
    this.status = UpdateTeamsStatus.initial,
    this.failures,
    this.message,
  });

  final UpdateTeamsStatus status;
  final Failures? failures;
  final String? message;

  factory UpdateTeamsState.initial() => const UpdateTeamsState();

  UpdateTeamsState copyWith({
    UpdateTeamsStatus? status,
    Failures? failures,
    String? message,
  }) {
    return UpdateTeamsState(
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
