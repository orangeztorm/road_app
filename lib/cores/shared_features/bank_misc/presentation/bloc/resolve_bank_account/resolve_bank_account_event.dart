part of 'resolve_bank_account_bloc.dart';

class ResolveBankAccountEvent extends Equatable {
  final RequestParam requestParam;

  const ResolveBankAccountEvent(this.requestParam);

  @override
  List<Object> get props => [requestParam];
}
