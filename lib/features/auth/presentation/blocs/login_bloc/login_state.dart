// part of 'login_bloc.dart';

// enum LoginStatus { initial, loading, success, failure }

// extension LoginStatusX on LoginStatus {
//   bool get isInitial => this == LoginStatus.initial;
//   bool get isLoading => this == LoginStatus.loading;
//   bool get isSuccess => this == LoginStatus.success;
//   bool get isFailure => this == LoginStatus.failure;
// }

// class LoginState extends Equatable {
//   const LoginState({
//     this.status = LoginStatus.initial,
//     this.failures,
//     this.entity,
//   });

//   final LoginStatus status;
//   final Failures? failures;
//   final LoginEntity? entity;

//   factory LoginState.initial() => const LoginState();

//   @override
//   List<Object?> get props => [status, failures, entity];

//   LoginState copyWith({
//     LoginStatus? status,
//     Failures? failures,
//     LoginEntity? entity,
//   }) {
//     return LoginState(
//       status: status ?? this.status,
//       failures: failures ?? this.failures,
//       entity: entity ?? this.entity,
//     );
//   }

//   @override
//   bool get stringify => true;
// }
