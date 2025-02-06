import 'package:equatable/equatable.dart';

class GetNigeriaBankEntity extends Equatable {
  const GetNigeriaBankEntity({
    required this.message,
    required this.banks,
    required this.status,
    required this.state,
  });

  final String message;
  final List<NigeriaBankEntity> banks;
  final int status;
  final String state;

  @override
  List<Object?> get props => [message, banks, status, state];
}

class NigeriaBankEntity extends Equatable {
  const NigeriaBankEntity({
    required this.bankName,
    required this.bankCode,
    required this.image,
  });

  final String bankName;
  final String bankCode;
  final String image;

  @override
  List<Object?> get props => [bankName, bankCode, image];
}
