// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:equatable/equatable.dart';

// class PotholeListEntity extends Equatable {
//   final bool success;
//   final PotholeListDataEntity data;
//   final String message;
//   final int statusCode;
//   final DateTime timestamp;
//   final String traceId;
//   final String responseTime;

//   const PotholeListEntity({
//     required this.success,
//     required this.data,
//     required this.message,
//     required this.statusCode,
//     required this.timestamp,
//     required this.traceId,
//     required this.responseTime,
//   });

//   @override
//   List<Object> get props {
//     return [
//       success,
//       data,
//       message,
//       statusCode,
//       timestamp,
//       traceId,
//       responseTime,
//     ];
//   }
// }

// class PotholeListDataEntity extends Equatable {
//   final List<PotholeEntity> docs;
//   final int totalDocs;
//   final int offset;
//   final int limit;
//   final int totalPages;
//   final int page;
//   final int pagingCounter;
//   final bool hasPrevPage;
//   final bool hasNextPage;
//   final dynamic prevPage;
//   final dynamic nextPage;

//   const PotholeListDataEntity({
//     required this.docs,
//     required this.totalDocs,
//     required this.offset,
//     required this.limit,
//     required this.totalPages,
//     required this.page,
//     required this.pagingCounter,
//     required this.hasPrevPage,
//     required this.hasNextPage,
//     required this.prevPage,
//     required this.nextPage,
//   });

//   @override
//   List<Object> get props {
//     return [
//       docs,
//       totalDocs,
//       offset,
//       limit,
//       totalPages,
//       page,
//       pagingCounter,
//       hasPrevPage,
//       hasNextPage,
//       prevPage,
//       nextPage,
//     ];
//   }
// }

// class PotholeEntity extends Equatable {
//   final String id;
//   final String status;
//   final double confidence;
//   final double zumiX;
//   final double zumiY;
//   final double position;
//   final int lane;
//   final String severity;
//   final int detectionCount;
//   final List<String> images;
//   final DateTime firstDetected;
//   final DateTime lastDetected;
//   final String assignedTeam;
//   final DateTime verifiedAt;
//   final PothHoleMetaDataEntity meta;

//   const PotholeEntity({
//     required this.id,
//     required this.status,
//     required this.confidence,
//     required this.zumiX,
//     required this.zumiY,
//     required this.position,
//     required this.lane,
//     required this.severity,
//     required this.detectionCount,
//     required this.images,
//     required this.firstDetected,
//     required this.lastDetected,
//     required this.assignedTeam,
//     required this.verifiedAt,
//     required this.meta,
//   });

//   factory PotholeEntity.empty() => PotholeEntity(
//         id: '',
//         status: '',
//         confidence: 0.0,
//         zumiX: 0.0,
//         zumiY: 0.0,
//         position: 0.0,
//         lane: 0,
//         severity: '',
//         detectionCount: 0,
//         images: const [],
//         firstDetected: DateTime.now(),
//         lastDetected: DateTime.now(),
//         assignedTeam: '',
//         verifiedAt: DateTime.now(),
//         meta: PothHoleMetaDataEntity(
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now(),
//         ),
//       );

//   @override
//   List<Object?> get props => [
//         id,
//         status,
//         confidence,
//         zumiX,
//         zumiY,
//         position,
//         lane,
//         severity,
//         detectionCount,
//         images,
//         firstDetected,
//         lastDetected,
//         assignedTeam,
//         verifiedAt,
//         meta,
//       ];
// }

// class PothHoleMetaDataEntity extends Equatable {
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   const PothHoleMetaDataEntity({
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   @override
//   List<Object?> get props => [
//         createdAt,
//         updatedAt,
//       ];
// }

// class PaginationEntity extends Equatable {
//   final int total;
//   final int page;
//   final int pages;
//   final int limit;

//   const PaginationEntity({
//     required this.total,
//     required this.page,
//     required this.pages,
//     required this.limit,
//   });

//   @override
//   List<Object?> get props => [
//         total,
//         page,
//         pages,
//         limit,
//       ];
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:road_app/features/road_app/domain/_domain.dart';

class PotholeListEntity extends Equatable {
  final bool success;
  final PotholeListDataEntity data;
  final String message;
  final int statusCode;
  final DateTime timestamp;
  final String traceId;
  final String responseTime;

  const PotholeListEntity({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  factory PotholeListEntity.empty() => PotholeListEntity(
        success: false,
        data: PotholeListDataEntity.empty(),
        message: '',
        statusCode: 0,
        timestamp: DateTime.now(),
        traceId: '',
        responseTime: '',
      );

  @override
  List<Object> get props {
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

class PotholeListDataEntity extends Equatable {
  final List<PotholeEntity> docs;
  final int totalDocs;
  final int offset;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  const PotholeListDataEntity({
    required this.docs,
    required this.totalDocs,
    required this.offset,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  factory PotholeListDataEntity.empty() => const PotholeListDataEntity(
        docs: [],
        totalDocs: 0,
        offset: 0,
        limit: 10,
        totalPages: 1,
        page: 1,
        pagingCounter: 1,
        hasPrevPage: false,
        hasNextPage: false,
        prevPage: null,
        nextPage: null,
      );

  @override
  List<Object?> get props {
    return [
      docs,
      totalDocs,
      offset,
      limit,
      totalPages,
      page,
      pagingCounter,
      hasPrevPage,
      hasNextPage,
      prevPage,
      nextPage,
    ];
  }
}

class PotholeEntity extends Equatable {
  final String id;
  final String status;
  final bool isTeamAssigned;
  final double confidence;
  final GeometryEntity geometry;
  final List<DetectionDataEntity>? detectionData;
  final String severity;
  final int detectionCount;
  final String? imageUrl;
  final List<String> images;
  final DateTime firstDetected;
  final DateTime lastDetected;
  final String address;
  final List<String> notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PotholeEntity({
    required this.id,
    required this.status,
    required this.isTeamAssigned,
    required this.detectionData,
    required this.confidence,
    required this.geometry,
    required this.severity,
    required this.imageUrl,
    required this.detectionCount,
    required this.images,
    required this.firstDetected,
    required this.lastDetected,
    required this.address,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PotholeEntity.empty() => PotholeEntity(
        id: '',
        status: 'UNKNOWN',
        isTeamAssigned: false,
        confidence: 0.0,
        geometry: GeometryEntity.empty(),
        detectionData: const [],
        severity: 'LOW',
        detectionCount: 0,
        imageUrl: null,
        images: const [],
        firstDetected: DateTime.now(),
        lastDetected: DateTime.now(),
        address: 'No Address',
        notes: const [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [
        id,
        status,
        confidence,
        geometry,
        severity,
        detectionCount,
        images,
        firstDetected,
        lastDetected,
        address,
        notes,
        createdAt,
        updatedAt,
      ];
}

class DetectionDataEntity extends Equatable {
  final String? type;
  final double? confidence;
  final String? id;
  final String? detectionDatumId;

  const DetectionDataEntity({
    required this.type,
    required this.confidence,
    required this.id,
    required this.detectionDatumId,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "confidence": confidence,
        "_id": id,
        "id": detectionDatumId,
      };

  @override
  List<Object?> get props => [type, confidence, id, detectionDatumId];
}

class PothHoleMetaDataEntity extends Equatable {
  final DateTime createdAt;
  final DateTime updatedAt;

  const PothHoleMetaDataEntity({
    required this.createdAt,
    required this.updatedAt,
  });

  factory PothHoleMetaDataEntity.empty() => PothHoleMetaDataEntity(
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  @override
  List<Object?> get props => [createdAt, updatedAt];
}

class PaginationEntity extends Equatable {
  final int total;
  final int page;
  final int pages;
  final int limit;

  const PaginationEntity({
    required this.total,
    required this.page,
    required this.pages,
    required this.limit,
  });

  factory PaginationEntity.empty() => const PaginationEntity(
        total: 0,
        page: 1,
        pages: 1,
        limit: 10,
      );

  @override
  List<Object?> get props => [total, page, pages, limit];
}
