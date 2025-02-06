import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/auth/presentation/pages/authority/camera_page.dart';
import 'package:road_app/features/auth/presentation/pages/authority/road_surface_page.dart';

class CavSchedulePage extends StatelessWidget {
  static const String routeName = 'cav-schedule-page';
  const CavSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const TextWidget.bold(
          'CAV Schedules',
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
            'Scheduled For Examination\nof CAV',
            fontSize: 22,
            textAlign: TextAlign.center,
          ),
          const VSpace(15),
          Container(
            padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(25)),
            decoration: BoxDecoration(
              color: AppColor.kcWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const Row(
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
                const VSpace(),
                ListView.separated(
                  padding: EdgeInsets.only(top: h(15)),
                  itemBuilder: (context, index) => _buildRow(),
                  separatorBuilder: (context, index) => const VSpace(10),
                  itemCount: 5,
                  shrinkWrap: true,
                )
              ],
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

  Widget _buildRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                'E311',
                textAlign: TextAlign.left,
              ),
              TextWidget(
                'Toaday at 12:00PM',
                textColor: AppColor.kcGrey400,
                fontSize: 13,
              )
            ],
          ),
        ),
        HSpace(15),
        SizedBox(
          child: TextWidget.bold(
            'Scheduled',
            textAlign: TextAlign.end,
            textColor: AppColor.color6E8BF5,
          ),
        ),
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
        _buildOption(
          icon: Icons.map,
          title: "Maps",
          onTap: () {
            AppRouter.instance.goBack();
            Toast.showInfo('Opening Maps');
          },
        ),
        _buildOption(
          icon: Icons.logout,
          title: "Logout",
          onTap: () {
            AppRouter.instance.goBack();
            Toast.showInfo('Logging Out...');
          },
        ),
        const VSpace(10),
      ],
    );
  }

  Widget _buildOption(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
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
