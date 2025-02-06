import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class RoadSurfacePage extends StatelessWidget {
  static const String routeName = '/road_surface_page';
  const RoadSurfacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
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
                    TextWidget.bold(
                      'Surfaces Issues',
                      fontSize: 18,
                      textAlign: TextAlign.left,
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
    );
  }

  Widget _buildRow() {
    return Column(
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
        ),
        const VSpace(5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w(15), vertical: h(10)),
          child: Row(
            children: [
              Expanded(
                child: Button(
                  height: h(30),
                  text: 'Alert Team',
                  textSize: 13,
                  onTap: () {},
                ),
              ),
              const HSpace(35),
              Expanded(
                child: Button(
                  height: h(30),
                  text: 'Alert Team',
                  onTap: () {},
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
