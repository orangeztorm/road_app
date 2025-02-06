import 'package:flutter/material.dart';
import 'package:road_app/cores/__cores.dart';

class FormErrorWidget extends StatelessWidget {
  final String? errorText;
  const FormErrorWidget({
    super.key,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const ImageWidget(
          imageTypes: ImageTypes.svg,
          // imageUrl: Assets.errorIcon,
          width: 3,
        ),
        const HSpace(6),
        TextWidget(
          errorText ?? AppStrings.na,
          fontWeight: FontWeight.w500,
          fontSize: kfsTiny,
          textColor: AppColor.colorD43939,
        ),
      ],
    );
  }
}
