import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';
import 'package:road_app/features/other_pages/notification_settings_page.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notification_page';
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      bg: AppColor.colorEBEBEB,
      appBar: AppBar(
        centerTitle: false,
        title: const TextWidget.bold(
          'Notification',
          fontSize: 22,
        ),
        actions: [
          InkWell(
            onTap: () {
              AppRouter.instance.navigateTo(NotificationSettingsPage.routeName);
            },
            child: const Icon(
              Icons.settings,
              color: AppColor.kcBlack,
              size: 30,
            ),
          ),
          const HSpace(),
          InkWell(
            onTap: () {
              BottomSheetHelper.show(
                context: context,
                child: const DeleteBottomSheet(),
              );
            },
            child: const Icon(
              Icons.delete,
              color: AppColor.kcBlack,
              size: 30,
            ),
          ),
          const HSpace(),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: h(15)),
        itemCount: 5,
        separatorBuilder: (context, index) => const VSpace(),
        itemBuilder: (context, index) => _buildContainer(),
        shrinkWrap: true,
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(10), vertical: h(20)),
      decoration: BoxDecoration(
        color: AppColor.kcWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextWidget(
              'Pothomes detected on your route',
              fontSize: 18,
              textAlign: TextAlign.left,
            ),
          ),
          HSpace(),
          Icon(
            Icons.location_pin,
            color: AppColor.kcSoftTextColor,
            size: 80,
          ),
        ],
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
            // Cancel Button
            Expanded(
                child: Button(
              text: 'Delete',
              onTap: () {
                AppRouter.instance.goBack();
                Toast.showInfo('Delete Action');
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
