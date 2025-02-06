// import 'package:road_app/cores/__cores.dart';
// import 'package:road_app/features/auth/__auth.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'create_account_event.dart';
// part 'create_account_state.dart';

// class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {
//   final AuthRepository authRepository;
//   CreateAccountBloc({
//     required this.authRepository,
//   }) : super(CreateAccountState.initial()) {
//     on<CreateAccount>(_createAccount);
//   }

//   Future<void> _createAccount(
//       CreateAccount event, Emitter<CreateAccountState> emit) async {
//     emit(state.copyWith(status: CreateAccountStatus.loading));
//     final result = await authRepository.createAccount(event.param);
//     result.fold((failure) {
//       emit(state.copyWith(
//         status: CreateAccountStatus.failure,
//         failures: failure,
//       ));
//     }, (account) {
//       emit(state.copyWith(
//           status: CreateAccountStatus.success, createAccountEntity: account));
//     });
//   }
// }
