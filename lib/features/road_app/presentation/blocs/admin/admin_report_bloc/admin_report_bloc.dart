import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/__road_app.dart';
import 'package:road_app/features/road_app/data/responses/admin/report_model.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/get_all_report_cubit.dart';

part 'admin_report_event.dart';
part 'admin_report_state.dart';

class AdminReportBloc extends Bloc<AdminReportEvent, AdminReportState> {
  final RoadAppRepository roadAppRepository;
  AdminReportBloc({
    required this.roadAppRepository,
  }) : super(AdminReportState.initial()) {
    on<GetAllReport>(_getAllReport);
    on<LoadMoreReport>(_getMoreReport);
  }

  Future<void> _getAllReport(
      GetAllReport event, Emitter<AdminReportState> emit) async {
    emit(state.copyWith(status: AdminReportStatus.loading));
    final failureOrOrders = await roadAppRepository.adminReport(event.param);
    failureOrOrders.fold(
        (failure) => emit(state.copyWith(
              status: AdminReportStatus.failure,
              failures: failure,
              currentPage: 1,
            )), (orders) {
      emit(state.copyWith(
        status: AdminReportStatus.success,
        orders: orders.data.docs,
        currentPage: orders.data.page,
        hasMore: orders.data.hasNextPage,
      ));
    });
  }

  Future<void> _getMoreReport(
      LoadMoreReport event, Emitter<AdminReportState> emit) async {
    if (!state.hasMore) return;
    emit(state.copyWith(status: AdminReportStatus.loadMore));
    final failureOrOrders = await roadAppRepository.adminReport(event.param);
    final param = castParam<GetAllReportsFormState>(event.param);
    if (param == null) return;
    failureOrOrders.fold(
      (failure) => emit(state.copyWith(
        status: AdminReportStatus.failure,
        failures: failure,
        currentPage: param.page.value - 1,
      )),
      (orders) => emit(state.copyWith(
        status: AdminReportStatus.success,
        orders: [...state.orders, ...orders.data.docs],
        currentPage: orders.data.page,
        hasMore: orders.data.hasNextPage,
      )),
    );
  }
}
