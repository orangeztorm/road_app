part of 'pothole_list_bloc.dart';

enum PotholeListStatus {
  initial,
  loading,
  loadMore,
  success,
  failure;

  bool get isLoading => this == PotholeListStatus.loading;
  bool get isLoadMore => this == PotholeListStatus.loadMore;
  bool get isSuccess => this == PotholeListStatus.success;
  bool get isFailure => this == PotholeListStatus.failure;
}

class PotholeListState extends Equatable {
  const PotholeListState({
    this.status = PotholeListStatus.initial,
    this.failure,
    this.data,
    this.hasMore = false,
  });

  final PotholeListStatus status;
  final Failures? failure;
  final List<PotholeEntity>? data;
  final bool hasMore;

  factory PotholeListState.initial() => const PotholeListState();

  List<PotholeEntity> get loadingList => List.filled(6, PotholeEntity.empty());

  PotholeListState copyWith({
    PotholeListStatus? status,
    Failures? failure,
    List<PotholeEntity>? data,
    bool? hasMore,
  }) {
    return PotholeListState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      data: data ?? this.data,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [status, failure, data, hasMore];
}
