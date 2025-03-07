// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserSignupEntity extends Equatable {
  final bool success;
  final UserSignUpDataEntity data;
  final String message;
  final int statusCode;
  final DateTime timestamp;
  final String traceId;
  final String responseTime;

  const UserSignupEntity({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  @override
  List<Object> get props {
    return [
      success,
      data,
      message,
      statusCode,
      timestamp,
      traceId,
      responseTime,
    ];
  }
}

class UserSignUpDataEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String userType;
  final String status;
  final bool notificationsEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  const UserSignUpDataEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.userType,
    required this.status,
    required this.notificationsEnabled,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      email,
      userType,
      status,
      notificationsEnabled,
      createdAt,
      updatedAt,
      id,
    ];
  }
}
