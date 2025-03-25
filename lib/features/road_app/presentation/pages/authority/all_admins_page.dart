import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_admin_model.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/all_admin_bloc/all_admin_bloc.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/all_admin_list_cubit.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/create_teams_cubit.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/create_admin_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllAdminsPage extends StatefulWidget {
  const AllAdminsPage({super.key});

  @override
  State<AllAdminsPage> createState() => _AllAdminsPageState();
}

class _AllAdminsPageState extends State<AllAdminsPage> {
  final AllAdminBloc _allAdminsBloc = getIt<AllAdminBloc>();
  final AllAdminsListCubit _allAdminsListCubit = getIt<AllAdminsListCubit>();
  final CreateTeamsCubit _createTeamsCubit = getIt<CreateTeamsCubit>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getInitialData();
    _scrollController.addListener(checkIfEndReached);

    super.initState();
  }

  void checkIfEndReached() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        // We are at the bottom of the list
        _allAdminsListCubit.getMoreList(_allAdminsBloc);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getInitialData() {
    _allAdminsListCubit.getInitialList(_allAdminsBloc);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const TextWidget.bold('All Admins'),
            const Spacer(),
            InkWell(
              onTap: () {
                AppRouter.instance.goBack();
                BottomSheetHelper.show(
                  context: context,
                  child: const CreateAdminPage(),
                );
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.group_add,
                    color: AppColor.kcPrimaryColor,
                  ),
                  HSpace(5),
                  TextWidget(
                    'Add Admin',
                  ),
                ],
              ),
            ),
          ],
        ),
        BlocBuilder<AllAdminBloc, AllAdminState>(
          bloc: _allAdminsBloc,
          builder: (context, state) {
            final loadingList = state.loadingList;
            final scheduleList = state.admins;
            return state.status.isLoading
                ? ListView.separated(
                    padding: EdgeInsets.only(top: h(15)),
                    itemBuilder: (context, index) => Skeletonizer(
                      enabled: state.status.isLoading,
                      child: _buildRow(loadingList[index]),
                    ),
                    separatorBuilder: (context, index) => const VSpace(10),
                    itemCount: loadingList.length,
                    shrinkWrap: true,
                  )
                : state.status.isSuccess && scheduleList.isNotEmpty
                    ? ListView.separated(
                        controller: _scrollController,
                        padding: EdgeInsets.only(top: h(15)),
                        itemBuilder: (context, index) {
                          if (index < (scheduleList.length)) {
                            return InkWell(
                              onTap: () => _createTeamsCubit
                                  .addOrRemoveMember(scheduleList[index]),
                              child: _buildRow(scheduleList[index]),
                            );
                          } else if (index == scheduleList.length) {
                            return state.status.isLoadMore
                                ? Padding(
                                    padding: EdgeInsets.only(bottom: h(20)),
                                    child: const Center(
                                      child: LoadingIndicatorWidget(),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(bottom: h(20)),
                              child: Center(
                                child: TextWidget(
                                  state.status.isFailure
                                      ? state.failures?.message ??
                                          AppStrings.somethingWentWrong
                                      : state.hasReachedMax == false
                                          ? 'Pull To Load More'
                                          : 'No more data',
                                  fontSize: 10,
                                  textColor: AppColor.kcGrey800,
                                ),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) => const VSpace(10),
                        itemCount: scheduleList.length + 2,
                        shrinkWrap: true,
                      )
                    : state.status.isFailure
                        ? CustomErrorWidget(
                            callback: getInitialData,
                            useFlex: false,
                            message: state.failures?.message ??
                                AppStrings.somethingWentWrong,
                          )
                        : scheduleList.isEmpty
                            ? const Column(
                                children: [
                                  TextWidget.bold('No Admins'),
                                ],
                              )
                            : const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _buildRow(AdminDocModel doc) {
    return BlocBuilder<CreateTeamsCubit, CreateTeamsFormzState>(
      bloc: _createTeamsCubit,
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Checkbox(
              value: state.containAdmin(doc),
              onChanged: (val) {
                _createTeamsCubit.addOrRemoveMember(doc);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const HSpace(),
            TextWidget.light(doc.firstName ?? AppStrings.na),
            const Spacer(),
            TextWidget(doc.email ?? AppStrings.na)
          ],
        );
      },
    );
  }
}
