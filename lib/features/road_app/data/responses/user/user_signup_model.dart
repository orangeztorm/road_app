import 'package:road_app/features/road_app/domain/entities/user/user_signup_entity.dart';

class UserSignupModel extends UserSignupEntity {
  const UserSignupModel({
    required super.success,
    required super.data,
    required super.message,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
  });

  factory UserSignupModel.fromJson(Map<String, dynamic> json) =>
      UserSignupModel(
        success: json["success"],
        data: UserSignUpDataModel.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["statusCode"],
        timestamp: DateTime.parse(json["timestamp"]),
        traceId: json["traceId"],
        responseTime: json["responseTime"],
      );
}

class UserSignUpDataModel extends UserSignUpDataEntity {
  const UserSignUpDataModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.userType,
    required super.status,
    required super.notificationsEnabled,
    required super.createdAt,
    required super.updatedAt,
    required super.id,
  });

  factory UserSignUpDataModel.fromJson(Map<String, dynamic> json) =>
      UserSignUpDataModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        userType: json["user_type"],
        status: json["status"],
        notificationsEnabled: json["notifications_enabled"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "user_type": userType,
        "status": status,
        "notifications_enabled": notificationsEnabled,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}
