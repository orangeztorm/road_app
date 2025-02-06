import 'package:flutter/material.dart';

import '../constants/color.dart';
import 'sizer_utils.dart';

class BottomSheetHelper {
  static Future<dynamic> show({
    required BuildContext context,
    required Widget child,
    bool isDismissible = true,
    Color? bg,
  }) async {
    return await showModalBottomSheet(
      backgroundColor: const Color(0xffFAFAFB),
      // AppColor.kcGrey100.withOpacity(0.05),
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      isDismissible: isDismissible,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: sp(15),
                vertical: sp(20),
              ),
              decoration: BoxDecoration(
                color: bg ??
                    (context.isDarkMode
                        ? const Color(0xff1B1B25)
                        : Theme.of(context).scaffoldBackgroundColor),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sp(15)),
                  topRight: Radius.circular(sp(15)),
                ),
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
