import 'package:road_app/features/road_app/domain/entities/user/user_signin_entity.dart';

class UserSignInModel extends UserSignInEntity {
  const UserSignInModel({
    required super.success,
    required super.message,
    required super.data,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
  });

  factory UserSignInModel.fromJson(Map<String, dynamic> json) =>
      UserSignInModel(
        success: json["success"],
        message: json["message"],
        data: UserSignInDataModel.fromJson(json["data"]),
        statusCode: json["statusCode"],
        timestamp: json["timestamp"],
        traceId: json["traceId"],
        responseTime: json["responseTime"],
      );
}

class UserSignInDataModel extends UserSignInDataEntity {
  const UserSignInDataModel({
    required super.user,
    required super.accessToken,
    required super.refreshToken,
  });

  factory UserSignInDataModel.fromJson(Map<String, dynamic> json) =>
      UserSignInDataModel(
        user: UserModel.fromJson(json["user"]),
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );
}

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
      };
}
