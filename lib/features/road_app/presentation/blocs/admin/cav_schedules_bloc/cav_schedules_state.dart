part of 'cav_schedules_bloc.dart';

enum CavSchedulesStatus {
  initial,
  loading,
  loadMore,
  success,
  failure;

  bool get isLoading => this == CavSchedulesStatus.loading;
  bool get isLoadMore => this == CavSchedulesStatus.loadMore;
  bool get isSuccess => this == CavSchedulesStatus.success;
  bool get isFailure => this == CavSchedulesStatus.failure;
  bool get isInitial => this == CavSchedulesStatus.initial;
}

class CavSchedulesState extends Equatable {
  const CavSchedulesState({
    this.status = CavSchedulesStatus.initial,
    this.data,
    this.hasNext,
    this.failure,
  });

  final CavSchedulesStatus status;
  final List<CavScheduleEntity>? data;
  final bool? hasNext;
  final Failures? failure;

  factory CavSchedulesState.initial() => const CavSchedulesState();

  List<CavScheduleEntity> get loadingList =>
      List.filled(6, CavScheduleEntity.empty());

  CavSchedulesState copyWith({
    CavSchedulesStatus? status,
    List<CavScheduleEntity>? data,
    bool? hasNext,
    Failures? failure,
  }) {
    return CavSchedulesState(
      status: status ?? this.status,
      data: data ?? this.data,
      hasNext: hasNext ?? this.hasNext,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        data,
        hasNext,
        failure,
      ];
}
