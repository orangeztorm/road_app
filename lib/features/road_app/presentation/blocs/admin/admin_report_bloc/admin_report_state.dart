part of 'admin_report_bloc.dart';

enum AdminReportStatus {
  initial,
  loading,
  loadMore,
  success,
  failure;

  bool get isLoading => this == AdminReportStatus.loading;
  bool get isLoadMore => this == AdminReportStatus.loadMore;
  bool get isSuccess => this == AdminReportStatus.success;
  bool get isFailure => this == AdminReportStatus.failure;
  bool get isInitial => this == AdminReportStatus.initial;
}

 class AdminReportState extends Equatable {
 const AdminReportState({
    this.status = AdminReportStatus.initial,
    this.failures,
    this.orders = const [],
    this.hasMore = false,
    this.currentPage = 1,
  });

  final AdminReportStatus status;
  final Failures? failures;
  final List<Report> orders;
  final bool hasMore;
  final num currentPage;

  factory AdminReportState.initial() => const AdminReportState();

  List<Report> get loadingList => List.generate(
        7,
        (index) => Report.empty(),
      );

  AdminReportState copyWith({
    AdminReportStatus? status,
    Failures? failures,
    List<Report>? orders,
    bool? hasMore,
    num? currentPage,
  }) {
    return AdminReportState(
      status: status ?? this.status,
      failures: failures ?? this.failures,
      orders: orders ?? this.orders,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [status, failures, orders, hasMore, currentPage];
}
