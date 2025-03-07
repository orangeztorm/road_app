import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:road_app/cores/__cores.dart';

class UserSignInCubit extends Cubit<UserSignInFormzState> {
  UserSignInCubit() : super(UserSignInFormzState.initial());

  // fuction call

  // void UserSignInUser(UserSignInBloc bloc) {
  //   bloc.add(UserSignIn(state));
  // }

  void onPasswordChanged(String password) {
    emit(
      state.copyWith(
        password: Required.dirty(
          password,
        ),
      ),
    );
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
    emit(UserSignInFormzState.initial());
  }
}

class UserSignInFormzState extends RequestParam with FormzMixin {
  final Email email;
  final Required password;

  UserSignInFormzState({
    this.email = const Email.pure('taiwokenny45@gmail.com'),
    this.password = const Required.pure('taiwokenny'),
  });

  factory UserSignInFormzState.initial() {
    return UserSignInFormzState();
  }

  UserSignInFormzState copyWith({
    Email? email,
    Required? password,
  }) {
    return UserSignInFormzState(
      email: email ?? this.email,
      password: password ?? this.password,
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
  List<Object?> get props => [email, password];
}
