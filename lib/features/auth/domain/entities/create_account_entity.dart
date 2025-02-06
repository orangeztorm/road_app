// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CreateAccountEntity extends Equatable {
  final CreateAccountData data;

  const CreateAccountEntity({
    required this.data,
  });

  @override
  List<Object> get props => [data];

  @override
  bool get stringify => true;
}

class CreateAccountData extends Equatable {
  final String? phoneNo;
  final String? nextStep;
  final String? accountNumber;
  final String? accountName;
  final String? hashedBiometricPin;

  const CreateAccountData({
    required this.phoneNo,
    required this.nextStep,
    required this.accountNumber,
    required this.accountName,
    required this.hashedBiometricPin,
  });

  @override
  List<Object?> get props {
    return [
      phoneNo,
      nextStep,
      accountNumber,
      accountName,
      hashedBiometricPin,
    ];
  }

  @override
  bool get stringify => true;
}
