import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:road_app/cores/__cores.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? bg;
  final double extraHeight;
  final double? fontSize;
  final Widget? bottomWidget;
  final List<Widget>? trailing;
  final EdgeInsetsGeometry? padding;
  final bool isSub;
  final double _height;
  final bool clearBg;

  const CustomAppBar({
    super.key,
    required this.title,
    this.extraHeight = 0,
    this.bg,
    this.fontSize,
    this.trailing,
    this.bottomWidget,
    this.padding,
    this.clearBg = false,
  })  : isSub = false,
        _height = 35;

  const CustomAppBar.sub({
    super.key,
    required this.title,
    this.fontSize,
    this.bg,
    this.extraHeight = 0,
    this.bottomWidget,
    this.trailing,
    this.padding,
    this.clearBg = false,
  })  : isSub = true,
        _height = -1;

  @override
  Widget build(BuildContext context) {
    final pad =
        padding ?? EdgeInsets.symmetric(vertical: h(10), horizontal: w(20));

    return Container(
      decoration: BoxDecoration(
        color: clearBg
            ? Colors.transparent
            : context.isDarkMode
                ? const Color(0xff1B1B25)
                : const Color(0xffECF0FE),
      ),
      child: PreferredSize(
        preferredSize: Size.fromHeight(_height + extraHeight),
        child: Stack(children: [
          Visibility(
            visible: clearBg == false,
            child: Opacity(
              opacity: context.isDarkMode ? 0.1 : 1,
              child: ImageWidget(
                imageTypes: ImageTypes.asset,
                imageUrl: "assets/images/app_bar/new_app_bar_bg.png",
                fit: BoxFit.fill,
                width: sw(100),
                height: h(200),
              ),
            ),
          ),
          Padding(
            padding: pad,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VSpace(kToolbarHeight - 10),
                buildIconAndText(fontSize),
                if (bottomWidget != null) bottomWidget!,
              ],
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Size get preferredSize {
    if (Platform.isAndroid) {
      return Size.fromHeight(kToolbarHeight + _height + extraHeight + 30);
    }

    return Size.fromHeight(kToolbarHeight + _height + extraHeight);
    // return Size.fromHeight(kToolbarHeight);
  }

  Widget buildIconAndText(fontSize) {
    if (isSub) {
      return Row(mainAxisSize: MainAxisSize.min, children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: AppRouter.instance.goBack,
          child: Icon(Icons.arrow_back, size: sp(25), weight: 0.5),
        ),
        const HSpace(8),
        Expanded(
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Text(
              title,
              style: GoogleFonts.karla(
                fontSize: sp(fontSize ?? 20),
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            if (trailing != null) ...trailing!,
          ]),
        ),
      ]);
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: AppRouter.instance.goBack,
          child: Icon(Icons.arrow_back, size: sp(25), weight: 0.5),
        ),
        const VSpace(4),
        Row(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.karla(
                fontSize: sp(fontSize ?? 20),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const HSpace(),
          if (trailing != null) ...trailing!,
        ]),
      ]);
    }
  }
}
