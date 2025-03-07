import 'package:equatable/equatable.dart';

class AdminLoginEntity extends Equatable {
  final bool? success;
  final AdminDataEntity? data;
  final String? message;
  final int? statusCode;
  final DateTime? timestamp;
  final String? traceId;
  final String? responseTime;

  const AdminLoginEntity({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  @override
  List<Object?> get props {
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

class AdminDataEntity extends Equatable {
  final AdminDetailsEntity? admin;
  final String? accessToken;
  final String? refreshToken;

  const AdminDataEntity({
    required this.admin,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props {
    return [
      admin,
      accessToken,
      refreshToken,
    ];
  }
}

class AdminDetailsEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final List<dynamic> permissions;
  final List<String> roles;
  final String userType;
  final String status;
  final bool isSuperAdmin;
  final Metadata metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  const AdminDetailsEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.permissions,
    required this.roles,
    required this.userType,
    required this.status,
    required this.isSuperAdmin,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      email,
      permissions,
      roles,
      userType,
      status,
      isSuperAdmin,
      metadata,
      createdAt,
      updatedAt,
      id,
    ];
  }
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
