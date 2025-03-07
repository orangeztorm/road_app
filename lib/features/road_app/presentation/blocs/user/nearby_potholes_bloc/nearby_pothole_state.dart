part of 'nearby_pothole_bloc.dart';

enum NearbyPotholeStatus {
  initial,
  loading,
  loadMore,
  success,
  failure;

  bool get isInitial => this == NearbyPotholeStatus.initial;
  bool get isLoading => this == NearbyPotholeStatus.loading;
  bool get isLoadMore => this == NearbyPotholeStatus.loadMore;
  bool get isSuccess => this == NearbyPotholeStatus.success;
  bool get isFailure => this == NearbyPotholeStatus.failure;
}

class NearbyPotholeState extends Equatable {
  const NearbyPotholeState({
    this.status = NearbyPotholeStatus.initial,
    this.potholes = const [],
    this.hasMore,
    this.failure,
  });

  final NearbyPotholeStatus status;
  final List<NearbyPotholeEntity> potholes;
  final bool? hasMore;
  final Failures? failure;

  factory NearbyPotholeState.initial() {
    return const NearbyPotholeState();
  }

  NearbyPotholeState copyWith({
    NearbyPotholeStatus? status,
    List<NearbyPotholeEntity>? potholes,
    bool? hasMore,
    Failures? failure,
  }) {
    return NearbyPotholeState(
      status: status ?? this.status,
      potholes: potholes ?? this.potholes,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
    );
  }

  List<dynamic> get loadingList => List.filled(14, null);

  @override
  List<Object?> get props => [
        status,
        potholes,
        hasMore,
        failure,
      ];
}
