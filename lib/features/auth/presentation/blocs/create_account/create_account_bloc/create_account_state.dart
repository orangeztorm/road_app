// // ignore_for_file: public_member_api_docs, sort_constructors_first
// part of 'create_account_bloc.dart';

// enum CreateAccountStatus {
//   initial,
//   loading,
//   success,
//   failure;

//   bool get isInitial => this == CreateAccountStatus.initial;
//   bool get isLoading => this == CreateAccountStatus.loading;
//   bool get isSuccess => this == CreateAccountStatus.success;
//   bool get isFailure => this == CreateAccountStatus.failure;
// }

// class CreateAccountState extends Equatable {
//   const CreateAccountState({
//     this.status = CreateAccountStatus.initial,
//     this.failures,
//     this.createAccountEntity,
//   });

//   final CreateAccountStatus status;
//   final Failures? failures;
//   final CreateAccountEntity? createAccountEntity;

//   factory CreateAccountState.initial() => const CreateAccountState();

//   @override
//   List<Object?> get props => [status, failures, createAccountEntity];

//   CreateAccountState copyWith({
//     CreateAccountStatus? status,
//     Failures? failures,
//     CreateAccountEntity? createAccountEntity,
//   }) {
//     return CreateAccountState(
//       status: status ?? this.status,
//       failures: failures ?? this.failures,
//       createAccountEntity: createAccountEntity ?? this.createAccountEntity,
//     );
//   }

//   @override
//   bool get stringify => true;
// }
