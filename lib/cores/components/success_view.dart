import 'package:flutter/material.dart';

import '../constants/color.dart';
import '../utils/sizer_utils.dart';
import 'custom_button.dart';
import 'custom_scaffold_widget.dart';
import 'custom_text_widget.dart';
import 'image_widget.dart';

class SuccessViewData {
  final String title;
  final String buttonText;
  final String text;
  final String otherText;
  final VoidCallback onTap;

  const SuccessViewData({
    required this.text,
    required this.onTap,
    this.buttonText = 'Continue',
    this.title = 'Successful!',
    this.otherText = '',
  });
}

class SuccessView extends StatelessWidget {
  static const String route = '/success-view';

  final SuccessViewData data;

  const SuccessView(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      useSingleScroll: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const HSpace(double.infinity),
          const VSpace(40),
          SizedBox(
            width: sp(246),
            height: sp(246),
            child: const ImageWidget(
              imageUrl: 'assets/images/success_image.png',
              imageTypes: ImageTypes.asset,
            ),
          ),
          const VSpace(20),
          SizedBox(
            width: sw(70),
            child: TextWidget(
              data.title,
              fontSize: sp(24),
              fontWeight: FontWeight.w700,
              textColor: AppColor.kcPrimaryColor,
              textAlign: TextAlign.center,
            ),
          ),
          const VSpace(),
          SizedBox(
            width: sw(70),
            child: TextWidget(
              data.text,
              fontSize: sp(14),
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: sw(70),
            child: TextWidget(
              data.otherText,
              fontSize: sp(14),
              fontWeight: FontWeight.w300,
              textAlign: TextAlign.center,
            ),
          ),
          const VSpace(),
          Button(text: data.buttonText, onTap: data.onTap),
          const VSpace(20),
        ],
      ),
    );
  }
}
