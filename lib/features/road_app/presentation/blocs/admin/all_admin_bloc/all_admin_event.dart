part of 'all_admin_bloc.dart';

sealed class AllAdminEvent extends Equatable {
  const AllAdminEvent();

  @override
  List<Object> get props => [];
}

class FetchAllAdmins extends AllAdminEvent {
  final RequestParam param;
  const FetchAllAdmins(this.param);

  @override
  List<Object> get props => [param];
}

class FetchMoreAllAdmins extends AllAdminEvent {
  final RequestParam param;
  const FetchMoreAllAdmins(this.param);

  @override
  List<Object> get props => [param];
}
