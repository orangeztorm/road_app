import 'package:road_app/features/road_app/data/responses/pothole_list_model.dart';
import 'package:road_app/features/road_app/domain/entities/user/nearby_pothole_entity.dart';

class NearbyPotholesModel extends NearbyPotholesEntity {
  const NearbyPotholesModel({
    required super.success,
    required super.data,
    required super.message,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
  });

  factory NearbyPotholesModel.fromJson(Map<String, dynamic> json) =>
      NearbyPotholesModel(
        success: json["success"] ?? false,
        data: List<NearbyPotholeModel>.from(
          (json["data"]["potholes"] as List<dynamic>)
              .map((x) => NearbyPotholeModel.fromJson(x)),
        ),
        message: json["message"] ?? "",
        statusCode: json["statusCode"] ?? 0,
        timestamp: DateTime.parse(json["timestamp"] ?? ""),
        traceId: json["traceId"] ?? "",
        responseTime: json["responseTime"] ?? "",
      );
}

class NearbyPotholeModel extends NearbyPotholeEntity {
  const NearbyPotholeModel({
    required super.id,
    required super.geometry,
    required super.isTeamAssigned,
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
  });

  factory NearbyPotholeModel.fromJson(Map<String, dynamic> json) =>
      NearbyPotholeModel(
        id: json["id"] ?? "",
        geometry: GeometryModel.fromJson(json["geometry"] ?? {}),
        isTeamAssigned: json["is_team_assigned"] ?? false,
        mlConfidence: (json["ml_confidence"] ?? 0).toDouble(),
        detectionCount: json["detection_count"] ?? 0,
        firstDetected: DateTime.parse(json["first_detected"] ?? ""),
        lastDetected: DateTime.parse(json["last_detected"] ?? ""),
        status: json["status"] ?? "",
        severity: json["severity"] ?? "",
        imageUrl: json["image_url"] ?? "",
        images: List<String>.from(json["images"] ?? []),
        address: json["address"] ?? "",
        notes: List<String>.from(json["notes"] ?? []),
        createdAt: DateTime.parse(json["createdAt"] ?? ""),
        updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
      );
}

