import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

class CavSchedulesListModel extends CavSchedulesListEntity {
  const CavSchedulesListModel({
    required super.success,
    required super.message,
    required super.data,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
    required super.currentPage,
    required super.limit,
    required super.totalPages,
  });

  factory CavSchedulesListModel.fromJson(Map<String, dynamic> json) =>
      CavSchedulesListModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: (json["data"]["schedules"] as List<dynamic>?)
                ?.map((x) => CavScheduleModel.fromJson(x))
                .toList() ??
            [],
        statusCode: json["statusCode"] ?? 0,
        timestamp: json["timestamp"] ?? "",
        traceId: json["traceId"] ?? "",
        responseTime: json["responseTime"] ?? "",
        currentPage: json["data"]["currentPage"] ?? 1,
        limit: json["data"]["limit"] ?? 10,
        totalPages: json["data"]["totalPages"] ?? 1,
      );
}

class CavScheduleModel extends CavScheduleEntity {
  const CavScheduleModel({
    required super.id,
    required super.pothole,
    required super.status,
    required super.maintenanceEnd,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CavScheduleModel.fromJson(Map<String, dynamic> json) =>
      CavScheduleModel(
        id: json["id"] ?? "",
        pothole: PotholeModel.fromJson(json["pothole"] ?? {}),
        status: json["status"] ?? "",
        maintenanceEnd: DateTime.parse(json["maintenance_end"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pothole": pothole,
        "status": status,
        "maintenance_end": maintenanceEnd.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
