import 'package:equatable/equatable.dart';

class ResolveBankEntity extends Equatable {
  const ResolveBankEntity({
    required this.message,
    required this.data,
    required this.status,
    required this.state,
  });

  final String message;
  final ResolveBankDataEntity data;
  final int status;
  final String state;

  @override
  List<Object?> get props => [message, data, status, state];
}

class ResolveBankDataEntity extends Equatable {
  const ResolveBankDataEntity({
    required this.accountNumber,
    required this.accountName,
    required this.bankCode,
  });

  final String accountNumber;
  final String accountName;
  final String bankCode;

  @override
  List<Object?> get props => [accountNumber, accountName, bankCode];
}
