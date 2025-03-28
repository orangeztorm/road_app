// import 'package:road_app/features/road_app/domain/_domain.dart';

// class PotholeListModel extends PotholeListEntity {
//   const PotholeListModel({
//     required super.success,
//     required super.data,
//     required super.message,
//     required super.statusCode,
//     required super.timestamp,
//     required super.traceId,
//     required super.responseTime,
//   });

//   factory PotholeListModel.fromJson(Map<String, dynamic> json) =>
//       PotholeListModel(
//         success: json["success"],
//         data: PotholeListDataModel.fromJson(json["data"]["potholes"]),
//         message: json["message"],
//         statusCode: json["statusCode"],
//         timestamp: DateTime.parse(json["timestamp"]),
//         traceId: json["traceId"],
//         responseTime: json["responseTime"],
//       );
// }

// class PotholeListDataModel extends PotholeListDataEntity {
//   const PotholeListDataModel({
//     required super.docs,
//     required super.totalDocs,
//     required super.offset,
//     required super.limit,
//     required super.totalPages,
//     required super.page,
//     required super.pagingCounter,
//     required super.hasPrevPage,
//     required super.hasNextPage,
//     required super.prevPage,
//     required super.nextPage,
//   });

//   factory PotholeListDataModel.fromJson(Map<String, dynamic> json) =>
//       PotholeListDataModel(
//         docs: List<PotholeModel>.from(json["docs"].map((x) => x)),
//         totalDocs: json["totalDocs"],
//         offset: json["offset"],
//         limit: json["limit"],
//         totalPages: json["totalPages"],
//         page: json["page"],
//         pagingCounter: json["pagingCounter"],
//         hasPrevPage: json["hasPrevPage"],
//         hasNextPage: json["hasNextPage"],
//         prevPage: json["prevPage"],
//         nextPage: json["nextPage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "docs": List<PotholeModel>.from(docs.map((x) => x)),
//         "totalDocs": totalDocs,
//         "offset": offset,
//         "limit": limit,
//         "totalPages": totalPages,
//         "page": page,
//         "pagingCounter": pagingCounter,
//         "hasPrevPage": hasPrevPage,
//         "hasNextPage": hasNextPage,
//         "prevPage": prevPage,
//         "nextPage": nextPage,
//       };
// }

// class PotholeModel extends PotholeEntity {
//   const PotholeModel({
//     required super.id,
//     required super.status,
//     required super.confidence,
//     required super.zumiX,
//     required super.zumiY,
//     required super.position,
//     required super.lane,
//     required super.severity,
//     required super.detectionCount,
//     required super.images,
//     required super.firstDetected,
//     required super.lastDetected,
//     required super.assignedTeam,
//     required super.verifiedAt,
//     required super.meta,
//   });

//   factory PotholeModel.fromJson(Map<String, dynamic> json) => PotholeModel(
//         id: json["id"],
//         status: json["status"],
//         confidence: json["confidence"]?.toDouble(),
//         zumiX: json["zumi_x"]?.toDouble(),
//         zumiY: json["zumi_y"]?.toDouble(),
//         position: json["position"]?.toDouble(),
//         lane: json["lane"],
//         severity: json["severity"],
//         detectionCount: json["detection_count"],
//         images: List<String>.from(json["images"].map((x) => x)),
//         firstDetected: DateTime.parse(json["first_detected"]),
//         lastDetected: DateTime.parse(json["last_detected"]),
//         assignedTeam: json["assigned_team"],
//         verifiedAt: DateTime.parse(json["verified_at"]),
//         meta: PothHoleMetaDataModel.fromJson(json["meta"]),
//       );
// }

// class PothHoleMetaDataModel extends PothHoleMetaDataEntity {
//   const PothHoleMetaDataModel({
//     required super.createdAt,
//     required super.updatedAt,
//   });

//   factory PothHoleMetaDataModel.fromJson(Map<String, dynamic> json) =>
//       PothHoleMetaDataModel(
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

import 'package:road_app/features/road_app/domain/_domain.dart';

class PotholeListModel extends PotholeListEntity {
  const PotholeListModel({
    required super.success,
    required super.data,
    required super.message,
    required super.statusCode,
    required super.timestamp,
    required super.traceId,
    required super.responseTime,
  });

  factory PotholeListModel.fromJson(Map<String, dynamic> json) =>
      PotholeListModel(
        success: json["success"] ?? false,
        data: PotholeListDataModel.fromJson(json["data"]["potholes"] ?? {}),
        // data: List<PotholeModel>.from(
        //         (json["data"]["potholes"] as List<dynamic>?)
        //                 ?.map((x) => PotholeModel.fromJson(x))
        //                 .toList() ??
        //             [])
        //     .toList(),
        message: json["message"] ?? "",
        statusCode: json["statusCode"] ?? 0,
        timestamp: DateTime.tryParse(json["timestamp"] ?? "") ?? DateTime.now(),
        traceId: json["traceId"] ?? "",
        responseTime: json["responseTime"] ?? "0ms",
      );
}

class PotholeListDataModel extends PotholeListDataEntity {
  const PotholeListDataModel({
    required super.docs,
    required super.totalDocs,
    required super.offset,
    required super.limit,
    required super.totalPages,
    required super.page,
    required super.pagingCounter,
    required super.hasPrevPage,
    required super.hasNextPage,
    required super.prevPage,
    required super.nextPage,
  });

  factory PotholeListDataModel.fromJson(Map<String, dynamic> json) =>
      PotholeListDataModel(
        docs: (json["docs"] as List<dynamic>?)
                ?.map((x) => PotholeModel.fromJson(x))
                .toList() ??
            [],
        totalDocs: json["totalDocs"] ?? 0,
        offset: json["offset"] ?? 0,
        limit: json["limit"] ?? 10,
        totalPages: json["totalPages"] ?? 1,
        page: json["page"] ?? 1,
        pagingCounter: json["pagingCounter"] ?? 1,
        hasPrevPage: json["hasPrevPage"] ?? false,
        hasNextPage: json["hasNextPage"] ?? false,
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  // Map<String, dynamic> toJson() => {
  //       "docs": docs.map((x) => x.toJson()).toList(),
  //       "totalDocs": totalDocs,
  //       "offset": offset,
  //       "limit": limit,
  //       "totalPages": totalPages,
  //       "page": page,
  //       "pagingCounter": pagingCounter,
  //       "hasPrevPage": hasPrevPage,
  //       "hasNextPage": hasNextPage,
  //       "prevPage": prevPage,
  //       "nextPage": nextPage,
  //     };
}

class PotholeModel extends PotholeEntity {
  const PotholeModel({
    required super.id,
    required super.status,
    required super.isTeamAssigned,
    required super.detectionData,
    required super.confidence,
    required super.imageUrl,
    required super.geometry,
    required super.severity,
    required super.detectionCount,
    required super.images,
    required super.firstDetected,
    required super.lastDetected,
    required super.address,
    required super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory PotholeModel.fromJson(Map<String, dynamic> json) => PotholeModel(
        id: json["id"] ?? "",
        status: json["status"] ?? "UNKNOWN",
        isTeamAssigned: json['is_team_assigned'] ?? false,
        detectionData:
            json["detection_data"] == null || json["detection_data"] == []
                ? null
                : List<DetectionDataModel>.from(json["detection_data"]
                    .map((x) => DetectionDataModel.fromJson(x))),
        confidence: (json["ml_confidence"] ?? 0).toDouble(),
        geometry: GeometryModel.fromJson(json["geometry"] ?? {}),
        severity: json["severity"] ?? "LOW",
        imageUrl: json["image_url"] ?? "",
        detectionCount: json["detection_count"] ?? 0,
        images: (json["images"] as List<dynamic>?)
                ?.map((x) => x.toString())
                .toList() ??
            [],
        firstDetected:
            DateTime.tryParse(json["first_detected"] ?? "") ?? DateTime.now(),
        lastDetected:
            DateTime.tryParse(json["last_detected"] ?? "") ?? DateTime.now(),
        address: json["address"] ?? "No Address",
        notes: (json["notes"] as List<dynamic>?)
                ?.map((x) => x.toString())
                .toList() ??
            [],
        createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
        updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      );
}

class DetectionDataModel extends DetectionDataEntity {
  const DetectionDataModel({
    required super.type,
    required super.confidence,
    required super.id,
    required super.detectionDatumId,
  });

  factory DetectionDataModel.fromJson(Map<String, dynamic> json) =>
      DetectionDataModel(
        type: json["type"],
        confidence: json["confidence"]?.toDouble(),
        id: json["_id"],
        detectionDatumId: json["id"],
      );
}

class GeometryModel extends GeometryEntity {
  const GeometryModel({
    required super.type,
    required super.coordinates,
  });

  factory GeometryModel.fromJson(Map<String, dynamic> json) => GeometryModel(
        type: json["type"] ?? "Point",
        coordinates: (json["coordinates"] as List<dynamic>?)
                ?.map((x) => (x as num).toDouble())
                .toList() ??
            [0.0, 0.0],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates,
      };
}

class PothHoleMetaDataModel extends PothHoleMetaDataEntity {
  const PothHoleMetaDataModel({
    required super.createdAt,
    required super.updatedAt,
  });

  factory PothHoleMetaDataModel.fromJson(Map<String, dynamic> json) =>
      PothHoleMetaDataModel(
        createdAt:
            DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
