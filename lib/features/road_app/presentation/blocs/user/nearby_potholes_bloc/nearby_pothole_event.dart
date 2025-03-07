part of 'nearby_pothole_bloc.dart';

sealed class NearbyPotholeEvent extends Equatable {
  const NearbyPotholeEvent();

  @override
  List<Object> get props => [];
}

class FetchNearbyPotholes extends NearbyPotholeEvent {
  final RequestParam param;

  const FetchNearbyPotholes(this.param);

  @override
  List<Object> get props => [param];
}

class FetchMoreNearbyPotholes extends NearbyPotholeEvent {
  final RequestParam param;

  const FetchMoreNearbyPotholes(this.param);

  @override
  List<Object> get props => [param];
}
