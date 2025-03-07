part of 'admin_login_bloc.dart';

sealed class AdminLoginEvent extends Equatable {
  const AdminLoginEvent();

  @override
  List<Object> get props => [];
}

class AdminLogin extends AdminLoginEvent {
  final RequestParam param;

  const AdminLogin(this.param);

  @override
  List<Object> get props => [param];
}
