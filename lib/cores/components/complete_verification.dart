import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_app/cores/__cores.dart';

class CompleteVerificationBottomSheet extends StatelessWidget {
  final VoidCallback? onUpgrade;
  const CompleteVerificationBottomSheet({super.key, this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VSpace(),
        // const ImageWidget(
        //   imageTypes: ImageTypes.svg,
        //   imageUrl: Assets.checkIconSvg,
        // ),
        const VSpace(24),
        Text(
          'Complete Profile',
          style: GoogleFonts.karla(
            fontSize: kfsSuperHuge,
            fontWeight: FontWeight.w600,
          ),
        ),
        const VSpace(24),
        const TextWidget(
          'Please complete your KYC Verification to gain access to this feature',
          fontSize: kfsMedium,
          fontWeight: FontWeight.w400,
          textColor: AppColor.kcSoftTextColor,
          textAlign: TextAlign.center,
        ),
        const VSpace(48),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Button.withBorderLine(
                onTap: () => AppRouter.instance.goBack(),
                text: 'Cancel',
              ),
            ),
            const HSpace(),
            Expanded(
              child: Button(
                onTap: () {
                  onUpgrade?.call();
                },
                text: 'Upgrade',
              ),
            ),
          ],
        ),
        const VSpace(20),
      ],
    );
  }
}





