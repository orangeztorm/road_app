part of 'create_admin_bloc.dart';

sealed class CreateAdminEvent extends Equatable {
  const CreateAdminEvent();

  @override
  List<Object> get props => [];
}

class CreateAdmin extends CreateAdminEvent {
  final RequestParam param;
  const CreateAdmin(this.param);

  @override
  List<Object> get props => [param];
}
