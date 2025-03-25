// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AllTeamsModel {
  final bool success;
  final AllTeamsDataModel data;
  final String message;
  final int statusCode;
  final DateTime timestamp;
  final String traceId;
  final String responseTime;

  AllTeamsModel({
    required this.success,
    required this.data,
    required this.message,
    required this.statusCode,
    required this.timestamp,
    required this.traceId,
    required this.responseTime,
  });

  factory AllTeamsModel.fromJson(Map<String, dynamic> json) => AllTeamsModel(
        success: json["success"],
        data: AllTeamsDataModel.fromJson(json["data"]),
        message: json["message"],
        statusCode: json["statusCode"],
        timestamp: DateTime.parse(json["timestamp"]),
        traceId: json["traceId"],
        responseTime: json["responseTime"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
        "statusCode": statusCode,
        "timestamp": timestamp.toIso8601String(),
        "traceId": traceId,
        "responseTime": responseTime,
      };
}

class AllTeamsDataModel {
  final List<AllTeamDocModel> docs;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  AllTeamsDataModel({
    required this.docs,
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  factory AllTeamsDataModel.fromJson(Map<String, dynamic> json) =>
      AllTeamsDataModel(
        docs: List<AllTeamDocModel>.from(
            json["docs"].map((x) => AllTeamDocModel.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<AllTeamDocModel>.from(docs.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class AllTeamDocModel extends Equatable {
  final String? name;
  final String? specialty;
  final String? assignedRegion;
  final List<String> members;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  const AllTeamDocModel({
    required this.name,
    required this.specialty,
    required this.assignedRegion,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  factory AllTeamDocModel.fromJson(Map<String, dynamic> json) =>
      AllTeamDocModel(
        name: json["name"],
        specialty: json["specialty"],
        assignedRegion: json["assigned_region"],
        members: List<String>.from(json["members"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  factory AllTeamDocModel.empty() => const AllTeamDocModel(
      name: null,
      specialty: null,
      assignedRegion: null,
      members: [],
      createdAt: null,
      updatedAt: null,
      id: null);

  Map<String, dynamic> toJson() => {
        "name": name,
        "specialty": specialty,
        "assigned_region": assignedRegion,
        "members": List<dynamic>.from(members.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "id": id,
      };

  @override
  List<Object?> get props {
    return [
      name,
      specialty,
      assignedRegion,
      members,
      createdAt,
      updatedAt,
      id,
    ];
  }
}
