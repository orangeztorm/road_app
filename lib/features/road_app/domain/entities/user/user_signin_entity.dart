import 'package:equatable/equatable.dart';

class UserSignInEntity extends Equatable {
  final bool success;
  final String message;
  final UserSignInDataEntity data;
  final int statusCode;
  final String timestamp;
  final String traceId;
  final String responseTime;

  const UserSignInEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  @override
  List<Object?> get props {
    return [
      success,
      message,
      data,
      statusCode,
      timestamp,
      traceId,
      responseTime,
    ];
  }
}

class UserSignInDataEntity extends Equatable {
  final UserEntity user;
  final String accessToken;
  final String refreshToken;

  const UserSignInDataEntity({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props {
    return [
      user,
      accessToken,
      refreshToken,
    ];
  }
}

class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      createdAt,
    ];
  }
}
