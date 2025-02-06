import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_app/cores/__cores.dart';

class BeamBackButton extends StatelessWidget {
  const BeamBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.instance.goBack(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.kcPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: AppColor.kcPrimaryColor,
                size: 18,
              ),
              TextWidget(
                'Back',
                textColor: AppColor.kcPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.instance.goBack(),
      child: Container(
        height: h(37),
        width: w(37),
        decoration: BoxDecoration(
          color: AppColor.kcPrimaryColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.kcPrimaryColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
