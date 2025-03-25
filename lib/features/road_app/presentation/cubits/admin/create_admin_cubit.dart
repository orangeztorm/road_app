// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:road_app/cores/__cores.dart';

class CreateAdminCubit extends Cubit<CreateAdminFormzState> {
  CreateAdminCubit() : super(const CreateAdminFormzState());

  void updateFirstName(String? name) {
    emit(state.copyWith(firstName: Required.dirty(name ?? '')));
  }

  void updatelastName(String? val) {
    emit(state.copyWith(lastName: Required.dirty(val ?? '')));
  }

  void updatePassword(String? val) {
    emit(state.copyWith(
        password: RequiredLength.dirty(minLength: 4, value: val ?? '')));
  }

  void updateEmail(String? val) {
    emit(state.copyWith(email: Email.dirty(val ?? '')));
  }

  void reset() {
    emit(const CreateAdminFormzState());
  }
}

class CreateAdminFormzState extends RequestParam {
  final Required firstName;
  final Required lastName;
  final Email email;
  final RequiredLength password;

  const CreateAdminFormzState({
    this.firstName = const Required.pure(),
    this.lastName = const Required.pure(),
    this.email = const Email.pure(),
    this.password = const RequiredLength.pure(minLength: 4),
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      "first_name": firstName.value,
      "last_name": lastName.value,
      "email": email.value,
      "password": password.value,
      "role": "ADMIN"
    };
  }

  bool get isValid =>
      firstName.isValid &&
      lastName.isValid &&
      email.isValid &&
      password.isValid;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
      ];

  CreateAdminFormzState copyWith({
    Required? firstName,
    Required? lastName,
    Email? email,
    RequiredLength? password,
  }) {
    return CreateAdminFormzState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
