import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class NotificationSettingsPage extends StatelessWidget {
  static const String routeName = '/notification_settings_page';
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const TextWidget.bold(
          'Notification Settings',
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VSpace(70),
          Transform.rotate(
            angle: 30.6, // Angle in radians (approximately 23 degrees)
            child: const Icon(
              Icons.notifications_outlined,
              size: 150,
            ),
          ),
          const VSpace(20),
          const TextWidget(
            'We may occasionally send you important\nupdates about roads conditions and real\n-time alerts to ensure your safety. Stay\ntuned for these official updates,',
            fontSize: 16,
            textAlign: TextAlign.center,
          ),
          const VSpace(15),
          _buildContainer(text: 'Receeive road alerts and updates'),
          const VSpace(),
          _buildContainer(
              text:
                  'Notify  me about upcoming road maintenance and construction zones'),
        ],
      ),
    );
  }

  Widget _buildContainer({
    required String text,
  }) {
    return Container(
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
              text,
              fontSize: 14,
              textAlign: TextAlign.left,
            ),
          ),
          const HSpace(30),
          Switch(
            value: true,
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
