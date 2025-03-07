import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:road_app/cores/__cores.dart';

class UserSignUpCubit extends Cubit<UserSignUpFormzState> {
  UserSignUpCubit() : super(UserSignUpFormzState.initial());

  // fuction call

  // void UserSignUpUser(UserSignUpBloc bloc) {
  //   bloc.add(UserSignUp(state));
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

  void onFirstnameChanged(String firstname) {
    emit(
      state.copyWith(
        firstname: Required.dirty(
          firstname,
        ),
      ),
    );
  }

  void onLastnameChanged(String lastname) {
    emit(
      state.copyWith(
        lastname: Required.dirty(
          lastname,
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
    emit(UserSignUpFormzState.initial());
  }
}

class UserSignUpFormzState extends RequestParam with FormzMixin {
  final Email email;
  final Required password;
  final Required firstname;
  final Required lastname;

  UserSignUpFormzState({
    this.email = const Email.pure(''),
    this.password = const Required.pure(''),
    this.firstname = const Required.pure(''),
    this.lastname = const Required.pure(),
  });

  factory UserSignUpFormzState.initial() {
    return UserSignUpFormzState();
  }

  UserSignUpFormzState copyWith({
    Email? email,
    Required? password,
    Required? firstname,
    Required? lastname,
  }) {
    return UserSignUpFormzState(
      email: email ?? this.email,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
    );
  }

  @override
  bool get isValid =>
      email.isValid &&
      password.isValid &&
      firstname.isValid &&
      lastname.isValid;

  @override
  Map<String, dynamic> toMap() {
    return {
      "first_name": firstname.value,
      "last_name": lastname.value,
      "email": email.value,
      "password": password.value,
    };
  }

  @override
  List<FormzInput> get inputs => [
        email,
        password,
        firstname,
        lastname,
      ];

  @override
  List<Object?> get props => [email, password, firstname, lastname];
}
