import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_app/cores/__cores.dart';

class ImageInfoWidget extends StatelessWidget {
  const ImageInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.info_rounded,
          color: AppColor.kcPrimaryColor,
        ),
        const HSpace(10),
        TextWidget(
          'Max size: 1.5MB, Format: JPEG',
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          textColor: AppColor.color444B59,
        ),
      ],
    );
  }
}
