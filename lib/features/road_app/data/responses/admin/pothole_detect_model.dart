import 'package:road_app/features/road_app/data/_data.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

class PotholeDetectModel extends PotholeDetectEntity {
  const PotholeDetectModel({
    required super.success,
    required super.data,
    required super.message,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
  });

  factory PotholeDetectModel.fromJson(Map<String, dynamic> json) =>
      PotholeDetectModel(
        success: json["success"] ?? false,
        data: PotholeDetectDataModel.fromJson(json["data"] ?? {}),
        message: json["message"] ?? "",
        statusCode: json["statusCode"] ?? 0,
        timestamp: DateTime.tryParse(json["timestamp"] ?? "") ?? DateTime.now(),
        traceId: json["traceId"] ?? "",
        responseTime: json["responseTime"] ?? "0ms",
      );
}

class PotholeDetectDataModel extends PotholeDetectDataEntity {
  const PotholeDetectDataModel({
    required super.pothole,
    required super.detection,
  });

  factory PotholeDetectDataModel.fromJson(Map<String, dynamic> json) =>
      PotholeDetectDataModel(
        pothole: AdminPotholeModel.fromJson(json["pothole"] ?? {}),
        detection: AdminDetectionModel.fromJson(json["detection"] ?? {}),
      );
}

class AdminDetectionModel extends AdminDetectionEntity {
  const AdminDetectionModel({
    required super.count,
    required super.detections,
  });

  factory AdminDetectionModel.fromJson(Map<String, dynamic> json) =>
      AdminDetectionModel(
        count: json["count"] ?? 0,
        detections:
            (json["detections"] as List<dynamic>?)?.map((x) => x).toList() ??
                [],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "detections": detections,
      };
}

class AdminPotholeModel extends AdminPotholeEntity {
  const AdminPotholeModel({
    required super.geometry,
    required super.mlConfidence,
    required super.detectionCount,
    required super.firstDetected,
    required super.lastDetected,
    required super.status,
    required super.severity,
    required super.imageUrl,
    required super.images,
    required super.address,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
    required super.id,
  });

  factory AdminPotholeModel.fromJson(Map<String, dynamic> json) =>
      AdminPotholeModel(
        geometry: GeometryModel.fromJson(json["geometry"] ?? {}),
        mlConfidence: (json["ml_confidence"] ?? 0).toDouble(),
        detectionCount: json["detection_count"] ?? 0,
        firstDetected:
            DateTime.tryParse(json["first_detected"] ?? "") ?? DateTime.now(),
        lastDetected:
            DateTime.tryParse(json["last_detected"] ?? "") ?? DateTime.now(),
        status: json["status"] ?? "UNKNOWN",
        severity: json["severity"] ?? "LOW",
        imageUrl: json["image_url"] ?? "",
        images: (json["images"] as List<dynamic>?)
                ?.map((x) => x.toString())
                .toList() ??
            [],
        address: json["address"] ?? "No Address",
        notes: (json["notes"] as List<dynamic>?)
                ?.map((x) => x.toString())
                .toList() ??
            [],
        createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
        id: json["id"] ?? "",
      );
}
