part of 'detect_pothole_bloc.dart';

enum DetectPotholeStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == DetectPotholeStatus.loading;
  bool get isSuccess => this == DetectPotholeStatus.success;
  bool get isFailure => this == DetectPotholeStatus.failure;
  bool get isInitial => this == DetectPotholeStatus.initial;
}

class DetectPotholeState extends Equatable {
  const DetectPotholeState({
    this.status = DetectPotholeStatus.initial,
    this.data,
    this.failure,
  });

  final DetectPotholeStatus status;
  final PotholeDetectEntity? data;
  final Failures? failure;

  factory DetectPotholeState.initial() => const DetectPotholeState();

  DetectPotholeState copyWith({
    DetectPotholeStatus? status,
    PotholeDetectEntity? data,
    Failures? failure,
  }) {
    return DetectPotholeState(
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
