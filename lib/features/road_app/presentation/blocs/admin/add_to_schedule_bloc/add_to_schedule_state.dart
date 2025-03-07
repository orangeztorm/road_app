part of 'add_to_schedule_bloc.dart';

enum AddToScheduleStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == AddToScheduleStatus.loading;
  bool get isSuccess => this == AddToScheduleStatus.success;
  bool get isFailure => this == AddToScheduleStatus.failure;
  bool get isInitial => this == AddToScheduleStatus.initial;
}

class AddToScheduleState extends Equatable {
  const AddToScheduleState({
    this.status = AddToScheduleStatus.initial,
    this.failure,
    this.message,
  });

  final AddToScheduleStatus status;
  final Failures? failure;
  final String? message;

  factory AddToScheduleState.initial() => const AddToScheduleState();

  AddToScheduleState copyWith({
    AddToScheduleStatus? status,
    Failures? failure,
    String? message,
  }) {
    return AddToScheduleState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, failure, message];
}
