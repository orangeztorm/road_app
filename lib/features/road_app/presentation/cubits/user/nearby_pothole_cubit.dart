import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

class NearbyPotholeCubit extends Cubit<NearbyPotholeFormzState> {
  NearbyPotholeCubit() : super(const NearbyPotholeFormzState());

  void getInitialList(NearbyPotholeBloc bloc) {
    bloc.add(FetchNearbyPotholes(state));
  }

  void getMoreList(NearbyPotholeBloc bloc) {
    updateCurrentPage(state.currentPage + 1);
    bloc.add(FetchMoreNearbyPotholes(state));
  }

  void updateLatLng(RequiredNum lat, RequiredNum lng) {
    emit(state.copyWith(lat: lat, lng: lng));
  }

  void updateCurrentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void resetPage() {
    emit(const NearbyPotholeFormzState());
  }
}

class NearbyPotholeFormzState extends RequestParam {
  final RequiredNum lng;
  final RequiredNum lat;
  final RequiredNum radius;
  final int currentPage;

  const NearbyPotholeFormzState({
    this.lng = const RequiredNum.pure(),
    this.lat = const RequiredNum.pure(),
    this.radius = const RequiredNum.pure(5000),
    this.currentPage = 1,
  });

  NearbyPotholeFormzState copyWith({
    RequiredNum? lng,
    RequiredNum? lat,
    RequiredNum? radius,
    int? currentPage,
  }) {
    return NearbyPotholeFormzState(
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
      radius: radius ?? this.radius,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [lng, lat, radius, currentPage];

  @override
  Map<String, dynamic> toMap() {
    return {
      'longitude': lng.value,
      'latitude': lat.value,
      'radius': radius.value,
      'page': currentPage,
    };
  }
}
