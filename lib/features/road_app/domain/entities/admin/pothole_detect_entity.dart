import 'package:equatable/equatable.dart';

class PotholeDetectEntity extends Equatable {
  final bool success;
  final PotholeDetectDataEntity data;
  final String message;
  final int statusCode;
  final DateTime timestamp;
  final String traceId;
  final String responseTime;

  const PotholeDetectEntity({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  @override
  List<Object?> get props {
    return [
      success,
      data,
      message,
      statusCode,
      timestamp,
      traceId,
      responseTime,
    ];
  }
}

class PotholeDetectDataEntity extends Equatable {
  final AdminPotholeEntity pothole;
  final AdminDetectionEntity detection;

  const PotholeDetectDataEntity({
    required this.pothole,
    required this.detection,
  });

  @override
  List<Object?> get props {
    return [
      pothole,
      detection,
    ];
  }
}

class AdminDetectionEntity extends Equatable {
  final num count;
  final List<dynamic> detections;

  const AdminDetectionEntity({
    required this.count,
    required this.detections,
  });

  @override
  List<Object?> get props {
    return [
      count,
      detections,
    ];
  }
}

class AdminPotholeEntity extends Equatable {
  final GeometryEntity geometry;
  final num mlConfidence;
  final num detectionCount;
  final DateTime firstDetected;
  final DateTime lastDetected;
  final String status;
  final String severity;
  final String imageUrl;
  final List<dynamic> images;
  final String address;
  final List<dynamic> notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  const AdminPotholeEntity({
    required this.geometry,
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
    required this.id,
  });

  @override
  List<Object?> get props {
    return [
      geometry,
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
      id,
    ];
  }
}

class GeometryEntity extends Equatable {
  final String type;
  final List<double> coordinates;

  const GeometryEntity({
    required this.type,
    required this.coordinates,
  });

  factory GeometryEntity.empty() {
    return const GeometryEntity(
      type: 'Point',
      coordinates: [0.0, 0.0],
    );
  }

  @override
  List<Object?> get props {
    return [
      type,
      coordinates,
    ];
  }
}
