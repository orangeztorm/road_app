// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AllAdminModel {
  final bool success;
  final AllAdminDataModel data;
  final String message;
  final int statusCode;
  final DateTime timestamp;
  final String traceId;
  final String responseTime;

  AllAdminModel({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  factory AllAdminModel.fromJson(Map<String, dynamic> json) => AllAdminModel(
        success: json["success"],
        data: AllAdminDataModel.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["statusCode"],
        timestamp: DateTime.parse(json["timestamp"]),
        traceId: json["traceId"],
        responseTime: json["responseTime"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
        "statusCode": statusCode,
        "timestamp": timestamp.toIso8601String(),
        "traceId": traceId,
        "responseTime": responseTime,
      };
}

class AllAdminDataModel {
  final List<AdminDocModel> docs;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  AllAdminDataModel({
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  factory AllAdminDataModel.fromJson(Map<String, dynamic> json) =>
      AllAdminDataModel(
        docs: List<AdminDocModel>.from(
            json["docs"].map((x) => AdminDocModel.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class AdminDocModel extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final List<dynamic> permissions;
  final List<String> roles;
  final String? userType;
  final String? status;
  final bool isSuperAdmin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  AdminDocModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.permissions,
    required this.roles,
    required this.userType,
    required this.status,
    required this.isSuperAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory AdminDocModel.empty() => AdminDocModel(
        firstName: null,
        lastName: null,
        email: null,
        permissions: const [],
        roles: const [],
        userType: null,
        status: null,
        isSuperAdmin: false,
        createdAt: null,
        updatedAt: null,
        id: null,
      );

  factory AdminDocModel.fromJson(Map<String, dynamic> json) => AdminDocModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        permissions: List<dynamic>.from(json["permissions"].map((x) => x)),
        roles: List<String>.from(json["roles"].map((x) => x)),
        userType: json["user_type"],
        status: json["status"],
        isSuperAdmin: json["is_super_admin"],
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };

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
      createdAt,
      updatedAt,
      id,
    ];
  }
}
