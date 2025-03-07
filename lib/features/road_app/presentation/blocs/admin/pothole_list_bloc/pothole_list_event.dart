part of 'pothole_list_bloc.dart';

sealed class PotholeListEvent extends Equatable {
  const PotholeListEvent();

  @override
  List<Object> get props => [];
}

class GetPotholes extends PotholeListEvent {
  final RequestParam param;

  const GetPotholes(this.param);

  @override
  List<Object> get props => [param];
}

class GetMorePotholes extends PotholeListEvent {
  final RequestParam param;

  const GetMorePotholes(this.param);

  @override
  List<Object> get props => [param];
}
