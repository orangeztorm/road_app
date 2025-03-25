import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/data/responses/admin/all_teams_model.dart';
import 'package:road_app/features/road_app/presentation/cubits/admin/assign_team_cubit.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/cav_schedule_page.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/teams_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RoadSurfacePage extends StatelessWidget {
  static const String routeName = '/road_surface_page';
  const RoadSurfacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      appBar: AppBar(
        centerTitle: true,
        title: const TextWidget.bold(
          'Road Surface Problems',
          fontSize: 22,
        ),
        actions: const [
          Icon(
            Icons.settings,
            color: AppColor.kcBlack,
            size: 30,
          ),
          HSpace(15),
        ],
      ),
      body: Column(
        children: [
          const VSpace(20),
          const TextWidget.bold(
            'Key Issues Detected',
            fontSize: 22,
            textAlign: TextAlign.center,
          ),
          const VSpace(15),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(25)),
              decoration: BoxDecoration(
                color: AppColor.kcWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      TextWidget.bold(
                        'Surfaces Issues',
                        fontSize: 18,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  VSpace(),
                  Expanded(child: PotholeList())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PotholeList extends StatefulWidget {
  const PotholeList({super.key});

  @override
  State<PotholeList> createState() => _PotholeListState();
}

class _PotholeListState extends State<PotholeList> {
  final PotholeListCubit _potholeCubit = getIt<PotholeListCubit>();
  final PotholeListBloc _potholeListBloc = getIt<PotholeListBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getInitialData();
    _scrollController.addListener(checkIfEndReached);

    super.initState();
  }

  void checkIfEndReached() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0 &&
          _potholeListBloc.state.hasMore) {
        // We are at the bottom of the list
        if (_potholeListBloc.state.hasMore) {
          _potholeCubit.getMoreList(_potholeListBloc);
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getInitialData() {
    _potholeCubit.getInitialList(_potholeListBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PotholeListBloc, PotholeListState>(
      bloc: _potholeListBloc,
      builder: (context, state) {
        final loadingList = state.loadingList;
        final scheduleList = state.data ?? [];
        return state.status.isLoading && scheduleList.isEmpty
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
                        return _buildRow(scheduleList[index]);
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
                                  ? state.failure?.message ??
                                      AppStrings.somethingWentWrong
                                  : state.hasMore == true
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
                        message: state.failure?.message ??
                            AppStrings.somethingWentWrong,
                        useFlex: false,
                      )
                    : scheduleList.isEmpty
                        ? const TextWidget(
                            'No Issues Detected',
                            fontSize: 18,
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox();
      },
    );
  }

  Widget _buildRow(PotholeEntity? entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          entity?.address ?? 'No Address',
          textAlign: TextAlign.left,
        ),
        TextWidget(
          DateTimeHelper.formatDateMMMMDYATHMMA(
            entity?.firstDetected ?? DateTime.now(),
          ),
          textColor: AppColor.kcGrey400,
          fontSize: 13,
        ),
        Row(
          children: [
            const TextWidget(
              'Status: ',
              textColor: AppColor.kcGrey400,
              fontSize: 13,
            ),
            const HSpace(10),
            TextWidget(
              entity?.status ?? 'Unknown',
              textColor: AppColor.kcGrey400,
              fontSize: 13,
            ),
            const HSpace(),
          ],
        ),
        const VSpace(5),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w(15),
            vertical: h(10),
          ),
          child: Row(
            children: [
              // Expanded(
              //   child: Button(
              //     height: h(30),
              //     text: 'Alert Team',
              //     textSize: 13,
              //     onTap: () {},
              //   ),
              // ),
              // const HSpace(35),
              Expanded(
                child: Button(
                  height: h(30),
                  text: 'View Details',
                  onTap: () {
                    BottomSheetHelper.show(
                      context: context,
                      child: ViewImageBottomSheet(
                        imageUrl: entity?.imageUrl,
                        entity: entity,
                      ),
                    );
                  },
                  textSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ViewImageBottomSheet extends StatelessWidget {
  final String? imageUrl;
  final PotholeEntity? entity;
  const ViewImageBottomSheet({
    super.key,
    this.imageUrl,
    this.entity,
  });

  static AssignTeamBloc assignTeamBloc = getIt<AssignTeamBloc>();
  static AddToScheduleBloc addToScheduleBloc = getIt<AddToScheduleBloc>();
  static AssignTeamCubit assignTeamCubit = getIt<AssignTeamCubit>();

  @override
  Widget build(BuildContext context) {
    final isAssigned = entity?.isTeamAssigned;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageWidget(
          imageTypes: ImageTypes.network,
          imageUrl: imageUrl,
          width: sw(100),
          height: h(300),
        ),
        const VSpace(20),
        TextWidget(
          entity?.address ?? 'No Address',
          textAlign: TextAlign.left,
        ),
        TextWidget(
          'lat: ${entity?.geometry.coordinates.first} lng: ${entity?.geometry.coordinates.last}',
        ),
        TextWidget(
          DateTimeHelper.formatDateMMMMDYATHMMA(
            entity?.firstDetected ?? DateTime.now(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextWidget(
              'Status: ',
            ),
            const HSpace(10),
            TextWidget(
              entity?.status ?? 'Unknown',
            ),
            const HSpace(),
          ],
        ),
        const VSpace(20),
        isAssigned ?? false
            ? const TextWidget(
                'Team Assigned',
              )
            : Visibility(
                visible:
                    entity?.status.toLowerCase() == 'DETECTED'.toLowerCase(),
                child: BlocConsumer<AssignTeamBloc, AssignTeamState>(
                  bloc: assignTeamBloc,
                  listener: _assignTeamListener,
                  builder: (context, assignState) {
                    return BlocConsumer<AddToScheduleBloc, AddToScheduleState>(
                      bloc: addToScheduleBloc,
                      listener: _addToScheduleListener,
                      builder: (context, addScheduleState) {
                        return addScheduleState.status.isLoading ||
                                assignState.status.isLoading
                            ? const Button.loading()
                            : Button(
                                text: entity?.status.toLowerCase() ==
                                        'ASSIGNED'.toLowerCase()
                                    ? 'Schedule'
                                    : 'Assign Team',
                                onTap: () {
                                  BottomSheetHelper.show(
                                    context: context,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxHeight: sh(50), minWidth: sw(100)),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const TextWidget.bold('Select Team'),
                                          const VSpace(),
                                          TeamsPage(
                                            returnBloc: true,
                                            onTap: (AllTeamDocModel? doc) {
                                              assignTeamCubit.reset();
                                              assignTeamCubit
                                                  .updateTeamId(doc?.id);
                                              assignTeamCubit
                                                  .updatePotholeId(entity?.id);
                                              assignTeamBloc.add(AssignTeam(
                                                  assignTeamCubit.state));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  // if (entity?.status.toLowerCase() ==
                                  //     'ASSIGNED'.toLowerCase()) {
                                  //   addToScheduleBloc.add(
                                  //     AddToSchedule(
                                  //       AssignTeamParam(entity?.id ?? '', ''),
                                  //     ),
                                  //   );
                                  // } else {
                                  //   assignTeamBloc.add(
                                  //     AssignTeam(
                                  //       AssignTeamParam(entity?.id ?? '', ''),
                                  //     ),
                                  //   );
                                  // }
                                },
                              );
                      },
                    );
                  },
                ),
              ),
      ],
    );
  }

  void _assignTeamListener(BuildContext context, AssignTeamState state) {
    if (state.status.isFailure) {
      Toast.useContext(
        context: context,
        message: state.failure?.message ?? AppStrings.somethingWentWrong,
      );
    } else if (state.status.isSuccess) {
      BottomSheetHelper.show(
        context: context,
        child: const SuccessBottomSheet(),
      );
      // addToScheduleBloc.add(
      //   AddToSchedule(
      //     AssignTeamParam(entity?.id ?? ''),
      //   ),
      // );
    }
  }

  void _addToScheduleListener(BuildContext context, AddToScheduleState state) {
    if (state.status.isFailure) {
      Toast.useContext(
          context: context,
          message: state.failure?.message ?? AppStrings.somethingWentWrong);
    } else if (state.status.isSuccess) {
      BottomSheetHelper.show(
        context: context,
        child: const SuccessBottomSheet(),
      );
    }
  }
}

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sw(100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 80,
          ),
          const SizedBox(height: 10),
          const Text(
            "Success!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            "Team successfully assigned to the pothole.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              AppRouter.instance.clearRouteAndPush(CavSchedulePage.routeName);
              getIt<PotholeListCubit>()
                  .getInitialList(getIt<PotholeListBloc>());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Text("OK",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
