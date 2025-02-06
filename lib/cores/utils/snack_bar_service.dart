import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:road_app/cores/__cores.dart';

class Toast {
  Toast._();

  static final GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? show(
    String message,
  ) =>
      key.currentState
          ?.showSnackBar(_getSnackBar(message, SnackbarType.normal));

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      showByContext({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Color? color,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      _getSnackBar(message, type, color: color),
    );
  }

  static void useContext({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
    Color? color,
  }) {
    Flushbar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
      // icon: icon != null ? Icon(icon, color: Colors.white) : null,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: getBackgroundColor(type),
      margin: const EdgeInsets.all(8.0),
      borderRadius: BorderRadius.circular(8.0),
      flushbarPosition: FlushbarPosition.TOP, // Shows at the top
    ).show(context);
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showInfo(
    String message, {
    Color? color,
  }) {
    return key.currentState?.showSnackBar(
      _getSnackBar(message, SnackbarType.info, color: color),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showError(
    String message,
  ) =>
      key.currentState?.showSnackBar(_getSnackBar(message, SnackbarType.error));

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSuccess(
    String message,
  ) =>
      key.currentState
          ?.showSnackBar(_getSnackBar(message, SnackbarType.success));

  static SnackBar _getSnackBar(
    String message,
    SnackbarType type, {
    Color? color,
  }) {
    return SnackBar(
      shape: const RoundedRectangleBorder(),
      content: SizedBox(
        width: 1.0.w,
        child: Row(children: [
          if (_getIcon(type) != null) ...[
            _getIcon(type)!,
            const HSpace(8.0),
          ],
          Expanded(
            child: TextWidget(
              message,
              textColor: AppColor.kcWhite,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ),
        ]),
      ),
      backgroundColor: color ?? getBackgroundColor(type),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14.0),
      margin: EdgeInsets.zero,
    );
  }

  static Color getBackgroundColor(SnackbarType type) {
    switch (type) {
      case SnackbarType.error:
        return AppColor.colorDB2438;
      case SnackbarType.success:
        return AppColor.color41AA67;
      case SnackbarType.info:
        return AppColor.kcPrimaryColor;
      default:
        return AppColor.kcPrimaryColor;
    }
  }

  static Widget? _getIcon(SnackbarType type) {
    switch (type) {
      case SnackbarType.error:
        return GestureDetector(
          onTap: () => key.currentState?.hideCurrentSnackBar(),
          child: ClipOval(
            child: ImageWidget(
              imageUrl: Images.beamLogo,
              color: AppColor.kcWhite,
              imageTypes: ImageTypes.asset,
              height: h(30),
              width: w(30),
            ),
          ),
        );
      case SnackbarType.success:
        return const Icon(Icons.done, color: AppColor.kcWhite);
      case SnackbarType.info:
        return ClipOval(
          child: ImageWidget(
            imageUrl: Images.beamLogo,
            color: AppColor.kcWhite,
            imageTypes: ImageTypes.asset,
            height: h(30),
            width: w(30),
          ),
        );
      default:
        return null;
    }
  }

  static void hide() => key.currentState?.hideCurrentSnackBar();
}

enum SnackbarType { error, success, info, normal }
