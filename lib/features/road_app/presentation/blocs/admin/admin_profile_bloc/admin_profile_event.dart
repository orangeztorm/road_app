part of 'admin_profile_bloc.dart';

sealed class AdminProfileEvent extends Equatable {
  const AdminProfileEvent();

  @override
  List<Object> get props => [];
}

class GetAdminProfile extends AdminProfileEvent {
  const GetAdminProfile();

  @override
  List<Object> get props => [];
}
