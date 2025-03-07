

class UserPotholeListModel {
  final List<Datum> data;
  final UserPotholeListModelMeta meta;

  UserPotholeListModel({
    required this.data,
    required this.meta,
  });

  factory UserPotholeListModel.fromJson(Map<String, dynamic> json) =>
      UserPotholeListModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: UserPotholeListModelMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  final String id;
  final String status;
  final double confidence;
  final List<double> location;
  final double position;
  final int lane;
  final String severity;
  final int detectionCount;
  final List<String> images;
  final DateTime firstDetected;
  final DateTime lastDetected;
  final String assignedTeam;
  final DateTime verifiedAt;
  final DatumMeta meta;

  Datum({
    required this.id,
    required this.status,
    required this.confidence,
    required this.location,
    required this.position,
    required this.lane,
    required this.severity,
    required this.detectionCount,
    required this.images,
    required this.firstDetected,
    required this.lastDetected,
    required this.assignedTeam,
    required this.verifiedAt,
    required this.meta,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        status: json["status"],
        confidence: json["confidence"]?.toDouble(),
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        position: json["position"]?.toDouble(),
        lane: json["lane"],
        severity: json["severity"],
        detectionCount: json["detection_count"],
        images: List<String>.from(json["images"].map((x) => x)),
        firstDetected: DateTime.parse(json["first_detected"]),
        lastDetected: DateTime.parse(json["last_detected"]),
        assignedTeam: json["assigned_team"],
        verifiedAt: DateTime.parse(json["verified_at"]),
        meta: DatumMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "confidence": confidence,
        "location": List<dynamic>.from(location.map((x) => x)),
        "position": position,
        "lane": lane,
        "severity": severity,
        "detection_count": detectionCount,
        "images": List<dynamic>.from(images.map((x) => x)),
        "first_detected": firstDetected.toIso8601String(),
        "last_detected": lastDetected.toIso8601String(),
        "assigned_team": assignedTeam,
        "verified_at": verifiedAt.toIso8601String(),
        "meta": meta.toJson(),
      };
}

class DatumMeta {
  final DateTime createdAt;
  final DateTime updatedAt;

  DatumMeta({
    required this.createdAt,
    required this.updatedAt,
  });

  factory DatumMeta.fromJson(Map<String, dynamic> json) => DatumMeta(
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserPotholeListModelMeta {
  final int total;
  final int page;
  final int pages;
  final int limit;

  UserPotholeListModelMeta({
    required this.total,
    required this.page,
    required this.pages,
    required this.limit,
  });

  factory UserPotholeListModelMeta.fromJson(Map<String, dynamic> json) =>
      UserPotholeListModelMeta(
        total: json["total"],
        page: json["page"],
        pages: json["pages"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "pages": pages,
        "limit": limit,
      };
}
