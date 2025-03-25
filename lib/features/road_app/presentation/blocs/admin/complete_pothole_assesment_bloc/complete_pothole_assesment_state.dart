part of 'complete_pothole_assesment_bloc.dart';

enum CompletePotholeAssesmentStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == CompletePotholeAssesmentStatus.initial;
  bool get isLoading => this == CompletePotholeAssesmentStatus.loading;
  bool get isSuccess => this == CompletePotholeAssesmentStatus.success;
  bool get isFailure => this == CompletePotholeAssesmentStatus.failure;
}

class CompletePotholeAssesmentState extends Equatable {
  const CompletePotholeAssesmentState({
    this.status = CompletePotholeAssesmentStatus.initial,
    this.failures,
    this.message,
  });

  final CompletePotholeAssesmentStatus status;
  final Failures? failures;
  final String? message;

  factory CompletePotholeAssesmentState.initial() =>
      const CompletePotholeAssesmentState();

  CompletePotholeAssesmentState copyWith({
    CompletePotholeAssesmentStatus? status,
    Failures? failures,
    String? message,
  }) {
    return CompletePotholeAssesmentState(
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
