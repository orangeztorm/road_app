// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  final ResetPasswordData data;

  const ResetPasswordEntity({
    required this.data,
  });

  @override
  List<Object?> get props => [data];

  @override
  bool get stringify => true;
}

class ResetPasswordData extends Equatable {
  final String? hashedBiometricPin;

  const ResetPasswordData({
    required this.hashedBiometricPin,
  });

  @override
  List<Object?> get props => [hashedBiometricPin];

  @override
  bool get stringify => true;
}
