import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:road_app/cores/__cores.dart';

class PinInputWidget extends StatefulWidget {
  const PinInputWidget({
    super.key,
    this.pinController,
    this.focusNode,
    required this.validator,
    required this.length,
    required this.onChanged,
    this.onCompleted,
  });

  final TextEditingController? pinController;
  final FocusNode? focusNode;
  final int length;
  final Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onCompleted;

  @override
  State<PinInputWidget> createState() => _PinInputWidgetState();
}

class _PinInputWidgetState extends State<PinInputWidget> {
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final focusedBorderColor =
        isDark ? AppColor.color353B47 : AppColor.colorCCCFD6;
    final fillColor =
        context.isDarkMode ? AppColor.colorCCCFD6 : AppColor.colorF2F3F4;
    final borderColor = isDark ? AppColor.color353B47 : AppColor.colorCCCFD6;

    final defaultPinTheme = PinTheme(
      width: 44.w,
      height: 44.h,
      textStyle: TextStyle(
        fontSize: sp(22),
        color: isDark ? Colors.white : AppColor.kcTextColor,
      ),
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColor.colorCCCFD6 : AppColor.colorF2F3F4,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );

    return Pinput(
      controller: widget.pinController,
      focusNode: widget.focusNode,
      // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      // listenForMultipleSmsOnAndroid: true,
      length: widget.length,
      defaultPinTheme: defaultPinTheme,
      separatorBuilder: (index) => const HSpace(15),
      validator: (value) {
        return widget.validator?.call(value);
      },
      // onClipboardFound: (value) {
      //   debugPrint('onClipboardFound: $value');
      //   pinController.setText(value);
      // },
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: focusedBorderColor,
          ),
        ],
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: fillColor,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: Colors.redAccent),
      ),
    );
  }
}
