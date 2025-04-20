part of 'admin_report_bloc.dart';

sealed class AdminReportEvent extends Equatable {
  const AdminReportEvent();

  @override
  List<Object> get props => [];
}

class GetAllReport extends AdminReportEvent {
  final RequestParam param;

  const GetAllReport(this.param);

  @override
  List<Object> get props => [param];
}

class LoadMoreReport extends AdminReportEvent {
  final RequestParam param;

  const LoadMoreReport(this.param);

  @override
  List<Object> get props => [param];
}
