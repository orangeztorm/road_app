import 'package:road_app/features/__features.dart';

class AdminLoginModel extends AdminLoginEntity {
  const AdminLoginModel({
    required super.success,
    required super.data,
    required super.message,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
  });

  factory AdminLoginModel.fromJson(Map<String, dynamic> json) =>
      AdminLoginModel(
        success: json["success"],
        data: AdminDataModel.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["statusCode"],
        timestamp: DateTime.parse(json["timestamp"]),
        traceId: json["traceId"],
        responseTime: json["responseTime"],
      );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "data": data.toJson(),
  //       "message": message,
  //       "statusCode": statusCode,
  //       "timestamp": timestamp.toIso8601String(),
  //       "traceId": traceId,
  //       "responseTime": responseTime,
  //     };
}

class AdminDataModel extends AdminDataEntity {
  const AdminDataModel({
    required super.admin,
    required super.accessToken,
    required super.refreshToken,
  });

  factory AdminDataModel.fromJson(Map<String, dynamic> json) => AdminDataModel(
        admin: AdminDetailsModel.fromJson(json["admin"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  // Map<String, dynamic> toJson() => {
  //       "admin": admin.toJson(),
  //       "accessToken": accessToken,
  //       "refreshToken": refreshToken,
  //     };
}

class AdminDetailsModel extends AdminDetailsEntity {
  const AdminDetailsModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.permissions,
    required super.roles,
    required super.userType,
    required super.status,
    required super.isSuperAdmin,
    required super.metadata,
    required super.createdAt,
    required super.updatedAt,
    required super.id,
  });

  factory AdminDetailsModel.fromJson(Map<String, dynamic> json) =>
      AdminDetailsModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
        roles: List<String>.from(json["roles"].map((x) => x)),
        userType: json["user_type"],
        status: json["status"],
        isSuperAdmin: json["is_super_admin"],
        metadata: Metadata.fromJson(json["metadata"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "user_type": userType,
        "status": status,
        "is_super_admin": isSuperAdmin,
        "metadata": metadata.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}

// class Metadata {
//   Metadata();

//   factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

//   Map<String, dynamic> toJson() => {};
// }
