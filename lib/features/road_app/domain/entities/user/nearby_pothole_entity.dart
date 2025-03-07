import 'package:equatable/equatable.dart';
import 'package:road_app/features/road_app/domain/entities/admin/pothole_detect_entity.dart';

class NearbyPotholesEntity extends Equatable {
  final bool success;
  final List<NearbyPotholeEntity> data;
  final String message;
  final int statusCode;
  final DateTime timestamp;
  final String traceId;
  final String responseTime;

  const NearbyPotholesEntity({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  @override
  List<Object?> get props => [
        success,
        data,
        message,
        statusCode,
        timestamp,
        traceId,
        responseTime,
      ];
}

class NearbyPotholeEntity extends Equatable {
  final String id;
  final GeometryEntity geometry;
  final bool isTeamAssigned;
  final double mlConfidence;
  final int detectionCount;
  final DateTime firstDetected;
  final DateTime lastDetected;
  final String status;
  final String severity;
  final String imageUrl;
  final List<String> images;
  final String address;
  final List<String> notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NearbyPotholeEntity({
    required this.id,
    required this.geometry,
    required this.isTeamAssigned,
    required this.mlConfidence,
    required this.detectionCount,
    required this.firstDetected,
    required this.lastDetected,
    required this.status,
    required this.severity,
    required this.imageUrl,
    required this.images,
    required this.address,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        geometry,
        isTeamAssigned,
        mlConfidence,
        detectionCount,
        firstDetected,
        lastDetected,
        status,
        severity,
        imageUrl,
        images,
        address,
        notes,
        createdAt,
        updatedAt,
      ];
}

