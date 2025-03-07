import 'package:road_app/features/road_app/domain/_domain.dart';

class AdminProfileModel extends AdminProfileEntity {
  const AdminProfileModel({
    required super.success,
    required super.message,
    required super.data,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.version,
    required super.path,
    // required super.metadata,
    required super.responseTime,
  });

  factory AdminProfileModel.fromJson(Map<String, dynamic> json) =>
      AdminProfileModel(
        success: json["success"],
        message: json["message"],
        data: AdminProfileDataModel.fromJson(json["data"]),
        statusCode: json["statusCode"],
        timestamp: json["timestamp"],
        traceId: json["traceId"],
        version: json["version"],
        path: json["path"],
        // metadata: AdminProfileModelMetadata.fromJson(json["metadata"]),
        responseTime: json["responseTime"],
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "message": message,
  //       "data": data.toJson(),
  //       "statusCode": statusCode,
  //       "timestamp": timestamp,
  //       "traceId": traceId,
  //       "version": version,
  //       "path": path,
  //       "metadata": metadata.toJson(),
  //       "responseTime": responseTime,
  //     };
}

class AdminProfileDataModel extends AdminProfileDataEntity {
  const AdminProfileDataModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.roles,
    required super.status,
    required super.profilePicture,
    required super.isSuperAdmin,
    required super.metadata,
    required super.lastLogin,
    required super.createdAt,
    required super.updatedAt,
  });

  factory AdminProfileDataModel.fromJson(Map<String, dynamic> json) =>
      AdminProfileDataModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        status: json["status"],
        profilePicture: json["profile_picture"],
        isSuperAdmin: json["is_super_admin"],
        metadata: AdminDataMetadataModel.fromJson(json["metadata"]),
        lastLogin: DateTime.parse(json["last_login"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "first_name": firstName,
  //       "last_name": lastName,
  //       "email": email,
  //       "roles": List<dynamic>.from(roles.map((x) => x)),
  //       "status": status,
  //       "profile_picture": profilePicture,
  //       "is_super_admin": isSuperAdmin,
  //       "metadata": metadata.toJson(),
  //       "last_login": lastLogin.toIso8601String(),
  //       "createdAt": createdAt.toIso8601String(),
  //       "updatedAt": updatedAt.toIso8601String(),
  //     };
}

class AdminDataMetadataModel extends AdminDataMetadataEntity {
  const AdminDataMetadataModel({
    required super.department,
  });

  factory AdminDataMetadataModel.fromJson(Map<String, dynamic> json) =>
      AdminDataMetadataModel(
        department: json["department"],
      );

  Map<String, dynamic> toJson() => {
        "department": department,
      };
}

class AdminProfileModelMetadata {
  AdminProfileModelMetadata();

  factory AdminProfileModelMetadata.fromJson(Map<String, dynamic> json) =>
      AdminProfileModelMetadata();

  Map<String, dynamic> toJson() => {};
}
