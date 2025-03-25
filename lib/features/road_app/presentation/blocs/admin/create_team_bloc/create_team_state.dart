part of 'create_team_bloc.dart';

enum CreateTeamStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == CreateTeamStatus.initial;
  bool get isLoading => this == CreateTeamStatus.loading;
  bool get isSuccess => this == CreateTeamStatus.success;
  bool get isFailure => this == CreateTeamStatus.failure;
}

class CreateTeamState extends Equatable {
  const CreateTeamState({
    this.status = CreateTeamStatus.initial,
    this.failures,
    this.message,
  });

  final CreateTeamStatus status;
  final Failures? failures;
  final String? message;

  factory CreateTeamState.initial() => const CreateTeamState();

  CreateTeamState copyWith({
    CreateTeamStatus? status,
    Failures? failures,
    String? message,
  }) {
    return CreateTeamState(
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
