
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:road_app/cores/__cores.dart';

class OTPWidget extends StatefulWidget {
  final int length;
  final double? width;
  final bool? obsucreText;
  final Function(String? value)? onChanged;
  final Function(String? value)? onCompleted;
  final TextEditingController? controller;

  const OTPWidget({
    super.key,
    required this.length,
    required this.onChanged,
    this.onCompleted,
    this.obsucreText = false,
    this.width,
    this.controller,
  });

  @override
  _OTPWidgetState createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  late TextEditingController controller;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Request focus automatically when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: widget.width ?? 60,
      height: 63,
      textStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
    );

    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColor.kcSoftTextColor,
            width: 1,
          ),
        ),
        child: ClipRRect(
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Pinput(
              length: widget.length,
              controller: controller,
              focusNode: focusNode,
              obscuringCharacter: '*',
              obscureText: widget.obsucreText ?? false,
              separatorBuilder: (index) => Container(
                  height: 64, width: 1, color: AppColor.kcSoftTextColor),
              defaultPinTheme: defaultPinTheme,
              showCursor: true,
              onChanged: widget.onChanged,
              onCompleted: widget.onCompleted,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
