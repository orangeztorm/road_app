import 'package:equatable/equatable.dart';

class BaseEntity extends Equatable {
  final dynamic status;
  final dynamic state;
  final String message;
  final dynamic data;

  const BaseEntity({
    required this.state,
    required this.message,
    required this.status,
    this.data,
  });

  @override
  List<Object?> get props => [state, status, message, data];
}

class PaginationEntity extends Equatable {
  const PaginationEntity({
    required this.hasPrevious,
    required this.prevPage,
    required this.hasNext,
    required this.next,
    required this.currentPage,
    required this.pageSize,
    required this.lastPage,
    required this.total,
  });

  final bool hasPrevious;
  final int prevPage;
  final bool hasNext;
  final int next;
  final int currentPage;
  final int pageSize;
  final int lastPage;
  final int total;

  @override
  List<Object?> get props => [
        hasPrevious,
        prevPage,
        hasNext,
        next,
        currentPage,
        pageSize,
        lastPage,
        total,
      ];
}

///

class BaseModel extends BaseEntity {
  const BaseModel({
    required super.status,
    required super.state,
    required super.message,
    super.data,
  });

  factory BaseModel.fromMap(Map<String, dynamic> json) {
    return BaseModel(
      status: json['status'] ?? 0,
      state: json['state'] ?? "",
      message: json['message'] ?? "",
      data: json['data'],
    );
  }
}

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    required super.hasPrevious,
    required super.prevPage,
    required super.hasNext,
    required super.next,
    required super.currentPage,
    required super.pageSize,
    required super.lastPage,
    required super.total,
  });

  factory PaginationModel.fromMap(Map<String, dynamic> json) {
    return PaginationModel(
      hasPrevious: json['hasPrevious'] ?? false,
      prevPage: json['prevPage'] ?? 0,
      hasNext: json['hasNext'] ?? false,
      next: json['next'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      lastPage: json['lastPage'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}
