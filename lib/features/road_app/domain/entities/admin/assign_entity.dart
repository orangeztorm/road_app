// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AssignTeamEntity extends Equatable {
  final bool? success;
  final String? message;
  final num? statusCode;
  final DateTime? timestamp;
  final String? traceId;
  final String? responseTime;

  const AssignTeamEntity({
    required this.success,
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
      message,
      statusCode,
      timestamp,
      traceId,
      responseTime,
    ];
  }
}
