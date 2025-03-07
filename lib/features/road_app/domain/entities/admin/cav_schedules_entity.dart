import 'package:equatable/equatable.dart';
import 'package:road_app/features/__features.dart';

class CavSchedulesListEntity extends Equatable {
  final bool success;
  final String message;
  final List<CavScheduleEntity> data;
  final int statusCode;
  final String timestamp;
  final String traceId;
  final String responseTime;
  final int currentPage;
  final int limit;
  final int totalPages;

  const CavSchedulesListEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
    required this.currentPage,
    required this.limit,
    required this.totalPages,
  });

  @override
  List<Object?> get props => [
        success,
        message,
        data,
        statusCode,
        timestamp,
        traceId,
        responseTime,
        currentPage,
        limit,
        totalPages,
      ];
}

class CavScheduleEntity extends Equatable {
  final String id;
  final PotholeEntity? pothole;
  final String status;
  final DateTime maintenanceEnd;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CavScheduleEntity({
    required this.id,
    required this.pothole,
    required this.status,
    required this.maintenanceEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CavScheduleEntity.empty() => CavScheduleEntity(
        id: '',
        pothole: null,
        status: '',
        maintenanceEnd: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        id,
        pothole,
        status,
        maintenanceEnd,
        createdAt,
        updatedAt,
      ];
}
