import 'package:equatable/equatable.dart';

class AdminProfileEntity extends Equatable {
  final bool success;
  final String message;
  final AdminProfileDataEntity data;
  final int statusCode;
  final String timestamp;
  final String traceId;
  final String version;
  final String path;
  final String responseTime;

  const AdminProfileEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.version,
    required this.path,
    required this.responseTime,
  });

  @override
  List<Object?> get props => [
        success,
        message,
        data,
        statusCode,
        timestamp,
        traceId,
        version,
        path,
        responseTime,
      ];
}

class AdminProfileDataEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final List<String> roles;
  final String status;
  final String profilePicture;
  final bool isSuperAdmin;
  final AdminDataMetadataEntity metadata;
  final DateTime lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AdminProfileDataEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roles,
    required this.status,
    required this.profilePicture,
    required this.isSuperAdmin,
    required this.metadata,
    required this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        roles,
        status,
        profilePicture,
        isSuperAdmin,
        metadata,
        lastLogin,
        createdAt,
        updatedAt,
      ];
}

class AdminDataMetadataEntity extends Equatable {
  final String department;

  const AdminDataMetadataEntity({
    required this.department,
  });

  @override
  List<Object?> get props => [
        department,
      ];
}
