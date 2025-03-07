import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:road_app/app/__app.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/__features.dart';
import 'package:road_app/features/road_app/presentation/pages/user/map_page.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notification_page';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      bg: AppColor.colorEBEBEB,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const TextWidget.bold(
          'Notification',
          fontSize: 22,
        ),
        actions: const [
          // InkWell(
          //   onTap: () {
          //     AppRouter.instance.navigateTo(NotificationSettingsPage.routeName);
          //   },
          //   child: const Icon(
          //     Icons.settings,
          //     color: AppColor.kcBlack,
          //     size: 30,
          //   ),
          // ),
          // const HSpace(),
          // InkWell(
          //   onTap: () {
          //     BottomSheetHelper.show(
          //       context: context,
          //       child: const DeleteBottomSheet(),
          //     );
          //   },
          //   child: const Icon(
          //     Icons.delete,
          //     color: AppColor.kcBlack,
          //     size: 30,
          //   ),
          // ),
          const HSpace(),
        ],
      ),
      body: const UserPotholeList(),
      // map fab
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.instance.navigateTo(MapPage.routeName);
        },
        backgroundColor: AppColor.kcPrimaryColor,
        child: const Icon(
          Icons.map,
          color: AppColor.kcWhite,
        ),
      ),
    );
  }
}

class UserPotholeList extends StatefulWidget {
  const UserPotholeList({super.key});

  @override
  State<UserPotholeList> createState() => _UserPotholeListState();
}

class _UserPotholeListState extends State<UserPotholeList> {
  final NearbyPotholeCubit _nearbyPotholeCubit = getIt<NearbyPotholeCubit>();
  final NearbyPotholeBloc _nearbyPotholeBloc = getIt<NearbyPotholeBloc>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _getUserLocation();
    _scrollController.addListener(checkIfEndReached);

    super.initState();
  }

  Future<void> _getUserLocation() async {
    bool hasPermission = await _requestLocationPermission();
    if (!hasPermission) return;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _nearbyPotholeCubit.updateLatLng(
          RequiredNum.dirty(position.latitude),
          RequiredNum.dirty(position.longitude),
        );
        getInitialData();
      });
    } catch (e) {
      Toast.showError("Error getting location: $e");
    }
  }

  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Toast.showError('Location permission denied');
        return false;
      }
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

  void checkIfEndReached() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        // We are at the bottom of the list
        _nearbyPotholeCubit.getMoreList(_nearbyPotholeBloc);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void getInitialData() {
    _nearbyPotholeCubit.getInitialList(_nearbyPotholeBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyPotholeBloc, NearbyPotholeState>(
      bloc: _nearbyPotholeBloc,
      builder: (context, state) {
        final loadingList = state.loadingList;
        final potholeList = state.potholes;
        return state.status.isLoading || state.status.isInitial
            ? Skeletonizer(
                child: ListView.separated(
                  padding: EdgeInsets.only(top: h(15)),
                  itemBuilder: (context, index) => Skeletonizer(
                    enabled: state.status.isLoading,
                    child: _buildContainer(loadingList[index]),
                  ),
                  separatorBuilder: (context, index) => const VSpace(10),
                  itemCount: loadingList.length,
                  shrinkWrap: true,
                ),
              )
            : state.status.isSuccess && potholeList.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      Future.value();
                      getInitialData();
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      padding: EdgeInsets.only(top: h(15)),
                      itemBuilder: (context, index) {
                        if (index < (potholeList.length)) {
                          return _buildContainer(potholeList[index]);
                        } else if (index == potholeList.length) {
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
                      itemCount: potholeList.length + 2,
                      shrinkWrap: true,
                    ),
                  )
                : state.status.isFailure
                    ? CustomErrorWidget(
                        callback: getInitialData,
                        useFlex: false,
                        message: state.failure?.message ??
                            AppStrings.somethingWentWrong,
                      )
                    : potholeList.isEmpty
                        ? const Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                VSpace(50),
                                ImageWidget(
                                  imageTypes: ImageTypes.asset,
                                  imageUrl: "assets/logo.png",
                                  width: 200,
                                  height: 200,
                                ),
                                VSpace(30),
                                TextWidget(
                                  'No Potholes Found',
                                  fontSize: 18,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )
                        : const SizedBox();
      },
    );
  }

  Widget _buildContainer(NearbyPotholeEntity? pothole) {
    return InkWell(
      onTap: () {
        BottomSheetHelper.show(
          context: context,
          child: ViewImageBottomSheet(
            imageUrl: pothole?.imageUrl,
            entity: pothole,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(20)),
        decoration: BoxDecoration(
          color: AppColor.kcWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextWidget(
                'Potholes detected at ${pothole?.address ?? AppStrings.na}',
                fontSize: 18,
                textAlign: TextAlign.left,
              ),
            ),
            const HSpace(),
            const Icon(
              Icons.location_pin,
              color: AppColor.kcSoftTextColor,
              size: 80,
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteBottomSheet extends StatelessWidget {
  const DeleteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Are you sure?",
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
            Expanded(
                child: Button(
              text: 'Delete',
              onTap: () {
                AppRouter.instance.goBack();
                Toast.showInfo('Delete Action');
              },
            )),
            const HSpace(),
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

class ViewImageBottomSheet extends StatelessWidget {
  final String? imageUrl;
  final NearbyPotholeEntity? entity;
  const ViewImageBottomSheet({
    super.key,
    this.imageUrl,
    this.entity,
  });

  static AssignTeamBloc assignTeamBloc = getIt<AssignTeamBloc>();
  static AddToScheduleBloc addToScheduleBloc = getIt<AddToScheduleBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
            entity?.status ?? 'No Status',
          ),
        ],
      ),
      const VSpace(20),
    ]);
  }
}
