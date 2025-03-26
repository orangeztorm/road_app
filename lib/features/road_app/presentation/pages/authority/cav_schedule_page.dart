import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/domain/param/complete_pothole_param.dart';
import 'package:road_app/features/road_app/presentation/blocs/admin/complete_pothole_assesment_bloc/complete_pothole_assesment_bloc.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/authority_login_page.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/camera_page.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/road_surface_page.dart';
import 'package:road_app/features/road_app/presentation/pages/authority/teams_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CavSchedulePage extends StatelessWidget {
  static const String routeName = 'cav-schedule-page';
  const CavSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const TextWidget.bold(
          'Schedules',
          fontSize: 22,
        ),
        actions: [
          InkWell(
            onTap: () => BottomSheetHelper.show(
              context: context,
              child: const SettingsBottomSheet(),
            ),
            child: const Icon(
              Icons.settings,
              color: AppColor.kcBlack,
              size: 30,
            ),
          ),
          const HSpace(15),
        ],
      ),
      body: Column(
        children: [
          const VSpace(20),
          const TextWidget.bold(
            'Scheduled For Examination',
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
                      Expanded(
                        child: TextWidget.bold(
                          'Road Details',
                          fontSize: 18,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      HSpace(),
                      TextWidget.bold(
                        'Status',
                        fontSize: 18,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                  VSpace(),
                  Expanded(child: CavSchedulesListEntity()),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          BottomSheetHelper.show(
            context: context,
            child: const ConfirmCameraBottomSheet(),
          );
        },
        child: Container(
          height: h(80),
          width: w(80),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.kcPrimaryColor,
          ),
          child: const Icon(
            Icons.camera_enhance,
            size: 50,
            color: AppColor.kcTextColor,
          ),
        ),
      ),
    );
  }
}

class CavSchedulesListEntity extends StatefulWidget {
  const CavSchedulesListEntity({super.key});

  @override
  State<CavSchedulesListEntity> createState() => _CavSchedulesListEntityState();
}

class _CavSchedulesListEntityState extends State<CavSchedulesListEntity> {
  final CavScheduleCubit _getCavSchedulesListCubit = getIt<CavScheduleCubit>();
  final CavSchedulesBloc _getCavSchedulesListBloc = getIt<CavSchedulesBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    getInitialData();
    _requestLocationPermission();
    _scrollController.addListener(checkIfEndReached);

    super.initState();
  }

  void checkIfEndReached() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0 &&
          _getCavSchedulesListBloc.state.hasNext == true) {
        // We are at the bottom of the list
        _getCavSchedulesListCubit.getMoreList(_getCavSchedulesListBloc);
      }
    }
  }

  /// 🔥 Request location permissions
  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationPermissionDialog();
      return false;
    }

    return true;
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission"),
        content: const Text("Please enable location access in app settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Geolocator.openAppSettings(),
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getInitialData() {
    _getCavSchedulesListCubit.getInitialList(_getCavSchedulesListBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CavSchedulesBloc, CavSchedulesState>(
      bloc: _getCavSchedulesListBloc,
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
                                  : state.hasNext == true
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
                        message: state.failure?.message ??
                            AppStrings.somethingWentWrong,
                      )
                    : scheduleList.isEmpty
                        ? const TextWidget(
                            'No Schedlues Found',
                            fontSize: 18,
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox();
      },
    );
  }

  Widget _buildRow(CavScheduleEntity? schedule) {
    return InkWell(
      onTap: () {
        if (schedule != null) {
          _showCompletePotholeBottomSheet(schedule);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  schedule?.pothole?.address ?? '',
                  textAlign: TextAlign.left,
                ),
                TextWidget(
                  'Maintenance End: ${DateTimeHelper.formatDateMMMMDYATHMMA(schedule?.maintenanceEnd ?? DateTime.now())}',
                  textColor: AppColor.kcGrey400,
                  fontSize: 13,
                )
              ],
            ),
          ),
          const HSpace(15),
          SizedBox(
            child: TextWidget.bold(
              schedule?.status ?? 'SCHEDULED',
              textAlign: TextAlign.end,
              textColor: AppColor.color6E8BF5,
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletePotholeBottomSheet(CavScheduleEntity schedule) {
    BottomSheetHelper.show(
      context: context,
      child: CompletePotholeBottomSheet(schedule: schedule),
    );
  }
}

class CompletePotholeBottomSheet extends StatelessWidget {
  final CavScheduleEntity schedule;

  const CompletePotholeBottomSheet({super.key, required this.schedule});

  static CompletePotholeAssesmentBloc get completePotholeAssesmentBloc =>
      getIt<CompletePotholeAssesmentBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Complete Pothole Reconstruction",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const VSpace(10),
        ImageWidget(
          imageTypes: ImageTypes.network,
          imageUrl: schedule.pothole?.imageUrl ?? '',
          width: 200,
          height: 200,
        ),
        const VSpace(),
        const TextWidget(
          "Are you sure you want to mark this pothole reconstruction as complete?",
          fontSize: 16,
          textAlign: TextAlign.center,
        ),
        const VSpace(5),
        TextWidget.light('Ml confidence: ${schedule.pothole?.confidence ?? 0}'),
        TextWidget.light(
            'Detection count: ${schedule.pothole?.detectionCount ?? 0}'),
        const VSpace(20),
        Visibility(
          visible: schedule.status == 'SCHEDULED',
          child: BlocConsumer<CompletePotholeAssesmentBloc,
              CompletePotholeAssesmentState>(
            bloc: completePotholeAssesmentBloc,
            listener: (context, state) {
              if (state.status.isFailure) {
                Toast.useContext(
                    context: context,
                    message: state.failures?.message ??
                        AppStrings.somethingWentWrong);
              } else if (state.status.isSuccess) {
                AppRouter.instance.goBack();
                Toast.showSuccess('Completed');
                final CavScheduleCubit getCavSchedulesListCubit =
                    getIt<CavScheduleCubit>();
                final CavSchedulesBloc getCavSchedulesListBloc =
                    getIt<CavSchedulesBloc>();

                getCavSchedulesListCubit
                    .getInitialList(getCavSchedulesListBloc);
              }
            },
            builder: (context, state) {
              return state.status.isLoading
                  ? const Button.loading()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Button(
                            text: 'Cancel',
                            onTap: () {
                              AppRouter.instance.goBack();
                            },
                          ),
                        ),
                        const HSpace(10),
                        Expanded(
                          child: Button(
                            text: 'Complete',
                            onTap: () {
                              completePotholeAssesmentBloc.add(
                                CompletePotholeAssesment(
                                  CompletePotholeParam(
                                    schedule.pothole?.id ?? '',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        const VSpace(20),
      ],
    );
  }
}

class ConfirmCameraBottomSheet extends StatelessWidget {
  const ConfirmCameraBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Open up Camera",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const VSpace(20),
        const TextWidget(
          "Do you want to continue this action?",
          fontSize: 18,
          textAlign: TextAlign.center,
        ),
        const VSpace(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Cancel Button
            Expanded(
                child: Button(
              text: 'Continue',
              onTap: () {
                AppRouter.instance.navigateTo(CameraCapturePage.routeName);
              },
            )),
            const HSpace(),
            // Continue Button
            Expanded(
                child: Button(
              text: 'Cancel',
              onTap: () {
                AppRouter.instance.goBack();
              },
            ))
          ],
        ),
        const VSpace(20),
      ],
    );
  }
}

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Settings",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const VSpace(20),
        _buildOption(
          icon: Icons.construction,
          title: "Road Surface Problems",
          onTap: () {
            AppRouter.instance.goBack();
            AppRouter.instance.navigateTo(RoadSurfacePage.routeName);
            Toast.showInfo('Navigating to Road Surface Problems');
          },
        ),
        const VSpace(20),
        _buildOption(
          icon: Icons.group,
          title: "Create Teams",
          onTap: () {
            AppRouter.instance.goBack();
            AppRouter.instance.navigateTo(TeamsPage.routeName);
            Toast.showInfo('Navigating to Teams');
          },
        ),
        const VSpace(20),
        _buildOption(
          icon: Icons.logout,
          title: "Logout",
          onTap: () {
            AppRouter.instance.goBack();
            SessionManager.instance.clearToken();
            AppRouter.instance.clearRouteAndPush(AuthorityLoginPage.routeName);
          },
        ),
        const VSpace(10),
      ],
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const HSpace(15),
            Expanded(
              child: TextWidget(
                title,
                fontSize: 18,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
