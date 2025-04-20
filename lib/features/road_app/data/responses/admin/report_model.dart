// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ReportModel {
  final bool success;
  final String message;
  final Data data;
  final DateTime timestamp;
  final String responseTime;

  ReportModel({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
    required this.responseTime,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        timestamp: DateTime.parse(json["timestamp"]),
        responseTime: json["responseTime"],
      );
}

class Data {
  final List<Report> docs;
  final int totalDocs;
  final int total;
  final int offset;
  final int limit;
  final int page;
  final int totalPages;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  Data({
    required this.docs,
    required this.totalDocs,
    required this.total,
    required this.offset,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        docs: List<Report>.from(json["docs"].map((x) => Report.fromJson(x))),
        totalDocs: json["totalDocs"],
        total: json["total"],
        offset: json["offset"],
        limit: json["limit"],
        page: json["page"],
        totalPages: json["totalPages"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );
}

class Report extends Equatable {
  final int total;
  final int completed;
  final String type;

  Report({
    required this.total,
    required this.completed,
    required this.type,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        total: json["total"],
        completed: json["completed"],
        type: json["type"],
      );

  factory Report.empty() => Report(total: 0, completed: 0, type: '');

  @override
  List<Object> get props => [total, completed, type];
}
