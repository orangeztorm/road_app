part of 'user_pothole_list_bloc.dart';

sealed class UserPotholeListEvent extends Equatable {
  const UserPotholeListEvent();

  @override
  List<Object> get props => [];
}

class FetchUserPotholes extends UserPotholeListEvent {
  final RequestParam param;

  const FetchUserPotholes(this.param);

  @override
  List<Object> get props => [param];
}

class FetchMoreUserPotholes extends UserPotholeListEvent {
  final RequestParam param;

  const FetchMoreUserPotholes(this.param);

  @override
  List<Object> get props => [param];
}
