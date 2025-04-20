import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/cores/components/paginated_list.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/admin_report_bloc/admin_report_bloc.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/get_all_report_cubit.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  static GetAllReportsCubit get getAllOrdersCubit =>
      getIt<GetAllReportsCubit>();
  static AdminReportBloc get getAllOrdersBloc => getIt<AdminReportBloc>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const TextWidget.bold(
          'Reports',
          fontSize: 22,
        ),
      ),
      body: BlocBuilder<AdminReportBloc, AdminReportState>(
        bloc: getAllOrdersBloc,
        builder: (_, state) {
          return Expanded(
            child: ReusablePaginatedList(
              dataList: state.orders,
              loadingList: state.loadingList,
              hasMore: state.hasMore,
              isFailure: state.status.isFailure,
              isLoadMore: state.status.isLoadMore,
              isLoading: state.status.isLoading,
              itemBuilder: (item) => InkWell(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget.bold(
                          item.type,
                          fontSize: 16,
                        ),
                        TextWidget.bold(item.total.toString(), fontSize: 16),
                      ],
                    ),
                  ],
                ),
              ),
              seperatorWidget: const VSpace(),
              onInitialLoad: () {
                getAllOrdersCubit.reset();
                getAllOrdersBloc.add(GetAllReport(getAllOrdersCubit.state));
              },
              onRetry: () {
                getAllOrdersBloc.add(GetAllReport(getAllOrdersCubit.state));
              },
              onLoadMore: () {
                if (getAllOrdersBloc.state.hasMore == true) {
                  final nextPage = getAllOrdersCubit.state.page.value + 1;
                  getAllOrdersCubit.onPageChanged(nextPage);
                  getAllOrdersBloc.add(LoadMoreReport(getAllOrdersCubit.state));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
