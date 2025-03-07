import 'package:road_app/features/road_app/domain/entities/admin/assign_entity.dart';

class AssignTeamModel extends AssignTeamEntity {
  const AssignTeamModel({
    required super.success,
    required super.message,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
  });

  factory AssignTeamModel.fromJson(Map<String, dynamic> json) =>
      AssignTeamModel(
        success: json["success"],
        message: json["message"],
        statusCode: json["statusCode"],
        timestamp: DateTime.parse(json["timestamp"]),
        traceId: json["traceId"],
        responseTime: json["responseTime"],
      );
}
