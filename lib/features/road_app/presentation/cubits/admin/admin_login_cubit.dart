import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';

class AdminLoginCubit extends Cubit<AdminLoginFormzState> {
  AdminLoginCubit() : super(AdminLoginFormzState.initial());

  // fuction call

  void adminLoginUser(AdminLoginBloc bloc) {
    bloc.add(AdminLogin(state));
  }

  void onPasswordChanged(String password) {
    emit(
      state.copyWith(
        password: Required.dirty(
          password,
        ),
      ),
    );
  }

  void onRememberMeChanged(bool? rememberMe) {
    emit(state.copyWith(rememberMe: rememberMe));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: Email.dirty(email)));
  }

  void navigateToDashBoard() {
    // userProfileManager.clearUserProfile();
    // Future.delayed(const Duration(seconds: 1), () {
    //   AppRouter.instance.clearRouteAndPush(DashboardPage.routeName);
    //   userBloc.add(const GetUser());
    // });
    // reset();
  }

  void navigateToLoginOnError() {
    // userProfileManager.clearUserProfile();
    // AppRouter.instance.clearRouteAndPush(LoginPhoneScreen.routeName);
    // Toast.showError("An error occured");
  }

  void navigateToPinScreen() {
    // state.copyWith(pin: const RequiredLength.pure(minLength: 6));
    // AppRouter.instance.navigateTo(LoginPinScreen.routeName);
  }

  void reset() {
    emit(AdminLoginFormzState.initial());
  }
}

class AdminLoginFormzState extends RequestParam with FormzMixin {
  final Email email;
  final Required password;
  final bool rememberMe;

  AdminLoginFormzState({
    this.email = const Email.pure('oluwaloni@admin.com'),
    this.password = const Required.pure('password123'),
    this.rememberMe = false,
  });

  factory AdminLoginFormzState.initial() {
    return AdminLoginFormzState();
  }

  AdminLoginFormzState copyWith({
    Email? email,
    Required? password,
    bool? rememberMe,
  }) {
    return AdminLoginFormzState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  bool get isValid => email.isValid && password.isValid;

  @override
  Map<String, dynamic> toMap() {
    return {
      "email": email.value,
      "password": password.value,
    };
  }

  @override
  List<FormzInput> get inputs => [
        email,
        password,
      ];

  @override
  List<Object?> get props => [email, password, rememberMe];
}
