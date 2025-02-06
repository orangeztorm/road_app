// part of 'user_bloc.dart';

// enum UserStatus { initial, loading, success, failure }

// extension UserStatusX on UserStatus {
//   bool get isInitial => this == UserStatus.initial;
//   bool get isLoading => this == UserStatus.loading;
//   bool get isSuccess => this == UserStatus.success;
//   bool get isFailure => this == UserStatus.failure;
// }

// class UserState extends Equatable {
//   const UserState({
//     this.user,
//     this.failures,
//     this.status = UserStatus.initial,
//   });

//   final UserStatus status;
//   final UserEntity? user;
//   final Failures? failures;

//   factory UserState.initial() => const UserState();

//   UserState copyWith({
//     UserStatus? status,
//     UserEntity? user,
//     Failures? failures,
//   }) {
//     return UserState(
//       status: status ?? this.status,
//       user: user ?? this.user,
//       failures: failures ?? this.failures,
//     );
//   }

//   @override
//   List<Object?> get props => [status, user, failures];

//   @override
//   bool get stringify => true;
// }
