part of 'assign_team_bloc.dart';

enum AssignTeamStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == AssignTeamStatus.loading;
  bool get isSuccess => this == AssignTeamStatus.success;
  bool get isFailure => this == AssignTeamStatus.failure;
  bool get isInitial => this == AssignTeamStatus.initial;
}

class AssignTeamState extends Equatable {
  const AssignTeamState({
    this.status = AssignTeamStatus.initial,
    this.failure,
    this.message,
  });

  final AssignTeamStatus status;
  final Failures? failure;
  final String? message;

  factory AssignTeamState.initial() => const AssignTeamState();

  AssignTeamState copyWith({
    AssignTeamStatus? status,
    Failures? failure,
    String? message,
  }) {
    return AssignTeamState(
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
