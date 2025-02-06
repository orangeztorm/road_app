part of 'resolve_bank_account_bloc.dart';

abstract class ResolveBankAccountState extends Equatable {
  const ResolveBankAccountState();

  @override
  List<Object> get props => [];
}

class ResolveBankAccountInitial extends ResolveBankAccountState {}

class ResolveBankAccountLoading extends ResolveBankAccountState {}

class ResolveBankAccountError extends ResolveBankAccountState {
  final String message;

  const ResolveBankAccountError(this.message);
}

class ResolveBankAccountSuccess extends ResolveBankAccountState {
  final ResolveBankEntity bankEntity;

  const ResolveBankAccountSuccess(this.bankEntity);
}
