// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final LoginDataEntity data;

  const LoginEntity({
    required this.data,
  });

  @override
  List<Object?> get props => [data];

  @override
  bool get stringify => true;
}

class LoginDataEntity extends Equatable {
  final int? id;
  final String? email;
  final String? phoneNumber;
  final bool? onboarded;
  final TokenEntity? tokens;

  const LoginDataEntity({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.onboarded,
    required this.tokens,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      phoneNumber,
      onboarded,
      tokens,
    ];
  }

  @override
  bool get stringify => true;
}

class TokenEntity extends Equatable {
  final String? accessToken;
  final String? refreshToken;

  const TokenEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];

  @override
  bool get stringify => true;
}
