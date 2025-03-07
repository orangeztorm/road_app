part of 'user_pothole_list_bloc.dart';

enum UserPotholeListStatus {
  initial,
  loading,
  success,
  failure,
  loadMore;

  bool get isInitial => this == UserPotholeListStatus.initial;
  bool get isLoading => this == UserPotholeListStatus.loading;
  bool get isSuccess => this == UserPotholeListStatus.success;
  bool get isFailure => this == UserPotholeListStatus.failure;
  bool get isLoadMore => this == UserPotholeListStatus.loadMore;
}

class UserPotholeListState extends Equatable {
  const UserPotholeListState({
    this.status = UserPotholeListStatus.initial,
    this.potholes = const [],
    this.hasMore,
    this.failure,
  });

  final UserPotholeListStatus status;
  final List<dynamic> potholes;
  final bool? hasMore;
  final Failures? failure;

  factory UserPotholeListState.initial() {
    return const UserPotholeListState();
  }

  UserPotholeListState copyWith({
    UserPotholeListStatus? status,
    List<dynamic>? potholes,
    bool? hasMore,
    Failures? failure,
  }) {
    return UserPotholeListState(
      status: status ?? this.status,
      potholes: potholes ?? this.potholes,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
        status,
        potholes,
        hasMore,
        failure,
      ];
}
